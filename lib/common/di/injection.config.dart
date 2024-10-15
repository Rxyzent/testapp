// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:testapp/common/di/app_module.dart' as _i270;
import 'package:testapp/common/di/network_module.dart' as _i121;
import 'package:testapp/common/widgets/display/display.dart' as _i620;
import 'package:testapp/common/widgets/display/display_impl.dart' as _i996;
import 'package:testapp/data/home/home_repo_impl.dart' as _i968;
import 'package:testapp/data/main/main_repo_impl.dart' as _i689;
import 'package:testapp/domain/model/colors/dark_theme_colors.dart' as _i70;
import 'package:testapp/domain/model/colors/theme_colors.dart' as _i77;
import 'package:testapp/domain/model/dio_interceptor/dio_interceptor.dart'
    as _i1027;
import 'package:testapp/domain/model/storage/storage.dart' as _i882;
import 'package:testapp/domain/repo/home_repo.dart' as _i416;
import 'package:testapp/domain/repo/main_repo.dart' as _i918;
import 'package:testapp/presentation/home/cubit/home_cubit.dart' as _i395;
import 'package:testapp/presentation/main/cubit/main_cubit.dart' as _i333;
import 'package:testapp/presentation/splash/cubit/splash_cubit.dart' as _i839;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    final networkModule = _$NetworkModule();
    gh.factory<_i839.SplashCubit>(() => _i839.SplashCubit());
    gh.singleton<_i70.DarkThemeColors>(() => _i70.DarkThemeColors());
    gh.lazySingleton<_i974.Logger>(() => appModule.logger);
    gh.lazySingleton<_i77.ThemeColors>(() => _i77.ThemeColors());
    await gh.lazySingletonAsync<_i882.Storage>(
      () => _i882.Storage.create(),
      preResolve: true,
    );
    gh.singleton<_i620.Display>(() => _i996.DisplayImpl());
    gh.factory<_i918.MainRepo>(() => _i689.MainRepoImpl(gh<_i882.Storage>()));
    gh.factory<_i416.HomeRepo>(() => _i968.HomeRepoImpl(gh<_i882.Storage>()));
    gh.factory<_i333.MainCubit>(() => _i333.MainCubit(gh<_i918.MainRepo>()));
    gh.lazySingleton<_i1027.DioInterceptor>(
        () => _i1027.DioInterceptor(gh<_i882.Storage>()));
    gh.factory<_i361.Dio>(() => networkModule.dio(gh<_i1027.DioInterceptor>()));
    gh.factory<_i395.HomeCubit>(() => _i395.HomeCubit(gh<_i416.HomeRepo>()));
    return this;
  }
}

class _$AppModule extends _i270.AppModule {}

class _$NetworkModule extends _i121.NetworkModule {}
