import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/common/base/base_builder.dart';
import 'package:testapp/common/extensions/theme_extensions.dart';
import 'package:testapp/common/gen/assets.gen.dart';
import 'package:testapp/common/gen/strings.dart';
import 'package:testapp/common/router/app_router.dart';
import 'package:testapp/common/utils/fixed_csv_asset_loader.dart';
import 'package:testapp/common/widgets/display/display_widget.dart';
import 'package:testapp/presentation/main/backgroundService/lifecycle_listener.dart';
import 'package:testapp/presentation/main/cubit/main_cubit.dart';
import 'package:testapp/presentation/main/cubit/main_state.dart';

import 'common/di/injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
        (value) => runApp(
      EasyLocalization(
        supportedLocales: Strings.supportedLocales,
        path: Assets.localization.translations,
        fallbackLocale: Strings.supportedLocales.first,
        startLocale: Strings.supportedLocales.first,
        assetLoader: FixedCsvAssetLoader(),
        child: const MyApp(),
      ),
    ),
  );

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MainCubit>(),
      child: BaseBuilder<MainCubit, MainBuildable, MainListenable>(
        properties: (buildable) => [buildable.themeMode],
        builder: (context, state) {
          return DisplayWidget(
            child: MaterialApp.router(
              title: 'TestApp',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              routerConfig: getIt<AppRouter>().config(),
              color: context.colors.primary,
              locale: context.locale,
              theme: context.lightTheme,
              darkTheme: context.darkTheme,
              themeMode: ThemeMode.dark,//state.themeMode ? ThemeMode.light : ThemeMode.dark,
              builder: (context,child){
                return LifecycleListener(child: child!);
              },
            ),
          );
        },
      ),
    );
  }
}
