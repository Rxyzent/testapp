import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testapp/common/base/base_page.dart';
import 'package:testapp/common/gen/assets.gen.dart';
import 'package:testapp/common/router/app_router.dart';
import 'package:testapp/presentation/splash/cubit/splash_cubit.dart';
import 'package:testapp/presentation/splash/cubit/splash_state.dart';

@RoutePage()
class SplashPage extends BasePage<SplashCubit,SplashBuildable,SplashListenable>{
  const SplashPage({super.key});

  @override
  void listener(BuildContext context, SplashListenable state) {
    super.listener(context, state);
    switch (state.effect) {
      case SplashEffect.home:
        context.router.replace( HomeRoute());
        break;

    }
  }

  @override
  Widget builder(BuildContext context, SplashBuildable state) {
   return Scaffold(
     body: SafeArea(
       child: Center(
         child: Assets.icons.logo.image(height: 100,width: 100),
       ),
     ),
   );
  }

}