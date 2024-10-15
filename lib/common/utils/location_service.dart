// import 'package:location/location.dart';
//
// class LocationService {
//   final Location _location = Location();
//   late bool _serviceEnabled;
//   late PermissionStatus _permissionGranted;
//
//   Future<LocationData?> getLocation() async {
//     await _checkServiceStatus();
//     if (_serviceEnabled && _permissionGranted == PermissionStatus.granted) {
//       try {
//         final locationData = await _location.getLocation();
//         return locationData;
//       } catch (e) {
//         print('Ошибка при получении местоположения: $e');
//         return null;
//       }
//     }
//     return null;
//   }
//
//   Future<void> _checkServiceStatus() async {
//     _serviceEnabled = await _location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await _location.requestService();
//       if (!_serviceEnabled) {
//         throw LocationException(LocationExceptionType.service);
//       }
//     }
//
//     _permissionGranted = await _location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         throw LocationException(LocationExceptionType.access);
//       }
//     }
//   }
// }
// enum LocationExceptionType { service, access }
//
//
// class LocationException implements Exception {
//   final LocationExceptionType type;
//
//   LocationException(this.type);
// }