import 'package:testapp/common/base/base_storage.dart';
import 'package:testapp/domain/model/user/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class Storage {
  Storage(this._box);

  final Box _box;

  @FactoryMethod(preResolve: true)
  static Future<Storage> create() async {
    await Hive.initFlutter();
    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(UserModelImplAdapter());
    }
    final box = await Hive.openBox('storage');
    return Storage(box);
  }

  BaseStorage<String> get token => BaseStorage(_box, 'token');

  BaseStorage<UserModel> get userData => BaseStorage(_box,'user_info');

  BaseStorage<bool> get theme => BaseStorage(_box, 'theme');
}
