import 'package:get_it/get_it.dart';
import 'package:testapp/common/di/injection.config.dart';
import 'package:testapp/common/router/app_router.dart';
import 'package:injectable/injectable.dart';
import 'package:testapp/domain/model/storage/storage.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
  getIt.registerLazySingleton(() => AppRouter());

  if (!getIt.isRegistered<Storage>()) {
    final storageInstance = await Storage.create();
    getIt.registerLazySingleton<Storage>(() => storageInstance);
  }
}
