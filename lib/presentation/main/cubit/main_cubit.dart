import 'dart:ui';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:testapp/common/base/base_cubit.dart';
import 'package:testapp/domain/model/user/user_model.dart';
import 'package:testapp/domain/repo/main_repo.dart';
import 'package:testapp/presentation/main/backgroundService/background_service.dart';
import 'package:testapp/presentation/main/cubit/main_state.dart';

@injectable
class MainCubit extends BaseCubit<MainBuildable, MainListenable> {
  MainCubit(this._repo) : super(const MainBuildable()){
    _init();
  }

  final MainRepo _repo;

  void _init() async{
    _getUserData();
    getThemeMode();
  }

  void _getUserData() {
    if (_repo.getUser() == null) {
      final newUserData = UserModel(
        inactiveDuration: 0,
        distance: 0.0,
        speed: 0.0,
        isTimerRunning: false,
      );
      _repo.setUser(newUserData);
    }
  }

  void select(String language) {
    build((buildable) => buildable.copyWith(language: language));
  }

  void changeTheme(bool value) async{
    build((buildable) => buildable.copyWith(themeMode: value));
    await _repo.setThemeMode(value);
  }

  void getThemeMode() async {
    final themeMode = _repo.getThemeMode();
    final currentThemeMode = PlatformDispatcher.instance.platformBrightness == Brightness.light;
    if(themeMode == null){
      _repo.setThemeMode(currentThemeMode);
    }
    build((buildable) => buildable.copyWith(themeMode: themeMode ?? currentThemeMode));
  }

}