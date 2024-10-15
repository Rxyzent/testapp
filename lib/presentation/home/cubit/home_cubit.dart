import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:injectable/injectable.dart';
import 'package:testapp/common/base/base_cubit.dart';
import 'package:testapp/domain/model/user/user_model.dart';
import 'package:testapp/domain/repo/home_repo.dart';
import 'package:testapp/presentation/home/cubit/home_state.dart';

@injectable
class HomeCubit extends BaseCubit<HomeBuildable, HomeListenable> {
  HomeCubit(this._repo) : super(const HomeBuildable()) {
    _init();
  }

  final HomeRepo _repo;

  void _init() async {
    _initUserData();
    getUserData();
    await checkServiceStatus();
  }

  Future<void> checkServiceStatus() async {
    build((buildable) => buildable.copyWith(loading: true));
    await Future.delayed(Duration(seconds: 2));
    final isServiceRunning = await FlutterBackgroundService().isRunning();
    build((buildable) =>
        buildable.copyWith(isServiceRunning: isServiceRunning, loading: false));
  }

  void _initUserData() {
    FlutterBackgroundService().invoke(
      'lifecycle',
      {'resumed': true},
    );
    final userData = _repo.getUserData();
    if (userData == null) {
      final newUserData = UserModel(
        inactiveDuration: 0,
        distance: 0.0,
        speed: 0.0,
        isTimerRunning: false,
      );
      _repo.setUser(newUserData);
      build((buildable) => buildable.copyWith(user: newUserData));
    }
  }

  void getUserData() {
    final data = _repo.getUserData();
    //print('new data: $data');
    if (data != null) {
      if (data.speed! >= 30) {
        FlutterBackgroundService().invoke('controlTimer', {'command': 'stop'});
      }
    }
    build((buildable) => buildable.copyWith(user: data));
  }

  void updateUserData(Object message) {
    final userData = UserModel.fromJson(message as Map<String, dynamic>);
    if (userData.speed! >= 30) {
      FlutterBackgroundService().invoke('controlTimer', {'command': 'stop'});
    }
    print('userData: $userData');
    build((buildable) => buildable.copyWith(user: userData));
  }

  void startRunningTimer() {
    build((buildable) => buildable.copyWith(isTimerRunning: true));
  }
}
