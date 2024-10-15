import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testapp/common/di/injection.dart';
import 'package:testapp/domain/model/storage/storage.dart';
import 'package:testapp/domain/model/user/user_model.dart';

const channelId = 'location_service';
const channelName = 'Location Service';
const channelDescription = 'This channel is used for location tracking.';

void startService() {
  FlutterBackgroundService().startService();
}

void stopService() {
  FlutterBackgroundService().invoke('stopService');
}

Future<bool> isBackgroundServiceRunning() async {
  return await FlutterBackgroundService().isRunning();
}

void startTimer() {
  FlutterBackgroundService().invoke('controlTimer', {'command': 'start'});
}

void stopTimer() {
  FlutterBackgroundService().invoke('controlTimer', {'command': 'stop'});
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    channelId,
    channelName,
    description: channelDescription,
    importance: Importance.max,
  );

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_notification'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      notificationChannelId: channelId,
      initialNotificationTitle: 'Testapp',
      initialNotificationContent: 'Tracking location in background',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onStart,
    ),
  );
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  await configureDependencies();
  final storage = getIt<Storage>();
  final user = storage.userData.call();
  Timer? timer;

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  bool foreground = true;

  service.on('lifecycle').listen((event) {
    foreground = event!['resumed'];
  });


  final currentPosition = await Geolocator.getCurrentPosition();
  final now = DateTime.now();
  final newUserData = user?.copyWith(
    lat: currentPosition.latitude,
    lon: currentPosition.longitude,
    lastUpdate: now,
  );
  await storage.userData.set(newUserData);

  Timer.periodic(const Duration(seconds: 5), (callback) async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      await Geolocator.openLocationSettings();
    }
  });

  Geolocator.getPositionStream(locationSettings: locationSettings)
      .listen((Position? position) async{
    final user = storage.userData.call();
    final now = DateTime.now();
    if (user != null && position != null) {
      final newDistance = Geolocator.distanceBetween(
        user.lat!,
        user.lon!,
        position.latitude,
        position.longitude,
      );

      final timeDifference = now.difference(user.lastUpdate!);
      final newSpeed = newDistance / timeDifference.inSeconds;
      final newUserData = user.copyWith(
        lat: position.latitude,
        lon: position.longitude,
        distance: user.distance! + newDistance,
        lastUpdate: now,
        speed: 3.6 * newSpeed,
      );
      await storage.userData.set(newUserData);
    }
  });

  bool isTimerRunning = user?.isTimerRunning ?? false;

  service.on('controlTimer').listen((event) {
    String command = event?['command'];

    switch (command) {
      case 'start':
        final user = storage.userData.call();
        if (!isTimerRunning) {
          isTimerRunning = true;
          storage.userData.set(user?.copyWith(isTimerRunning: true));
          timer = Timer.periodic(const Duration(seconds: 1), (t) {
            final user = storage.userData.call();
            final waitingTime = user?.inactiveDuration;
            storage.userData
                .set(user?.copyWith(inactiveDuration: waitingTime! + 1));
          });
        }
        break;
      case 'stop':
        final user = storage.userData.call();
        if (isTimerRunning) {
          timer?.cancel();
          isTimerRunning = false;
          storage.userData.set(user?.copyWith(isTimerRunning: false));
        }
        break;
    }
  });

  storage.userData.watch().listen((userData){
    if(userData != null && foreground){
      sendDataToMainThread(userData);
    }
  });
}
void sendDataToMainThread(UserModel userData) {
  final sendPort = IsolateNameServer.lookupPortByName('main_thread_port');
  if (sendPort != null) {
    print('sending data: $userData');
    sendPort.send(userData.toJson());
  } else {
    print('main_thread_port не найден');
  }
}

LocationSettings get locationSettings {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return AndroidSettings(intervalDuration: const Duration(seconds: 1));
  }
  if (defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS) {
    return AppleSettings(
      showBackgroundLocationIndicator: true,
    );
  }
  return const LocationSettings(accuracy: LocationAccuracy.high);
}

Future<void> initializePermissions() async {
  if (Platform.isIOS) {
    bool serviceEnabled;

    serviceEnabled = await Permission.location.serviceStatus.isEnabled;
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    if (await Permission.location.isDenied) {
      final location = await Permission.location.request();
      if (location.isDenied) {
        return Future.error('Location permissions are denied');
      }
      await Permission.locationAlways.request();
    }

    if (await Permission.location.isPermanentlyDenied) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions();
  }

  if (Platform.isAndroid) {
    bool serviceEnabled;

    serviceEnabled = await Permission.location.serviceStatus.isEnabled;
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    if (await Permission.location.isDenied) {
      final location = await Permission.location.request();
      if (location.isDenied) {
        return Future.error('Location permissions are denied');
      }
      await Permission.locationAlways.request();
    }

    if (await Permission.location.isPermanentlyDenied) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }
}
