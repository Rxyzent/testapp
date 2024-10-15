import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:injectable/injectable.dart';
import 'package:testapp/common/base/base_cubit.dart';
import 'package:testapp/presentation/splash/cubit/splash_state.dart';

@injectable
class SplashCubit extends BaseCubit<SplashBuildable, SplashListenable> {
  SplashCubit() : super(const SplashBuildable()) {
    _init();
  }

  void _init() {
    Timer(
      const Duration(milliseconds: 300),
      () {
        invoke(const SplashListenable(effect: SplashEffect.home));
      },
    );
  }
}
