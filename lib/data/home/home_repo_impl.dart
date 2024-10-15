import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:testapp/domain/model/storage/storage.dart';
import 'package:testapp/domain/model/user/user_model.dart';
import 'package:testapp/domain/repo/home_repo.dart';
import 'package:testapp/presentation/main/backgroundService/background_service.dart';
import 'package:testapp/presentation/main/backgroundService/data_stream.dart';

@Injectable(as: HomeRepo)
class HomeRepoImpl extends HomeRepo {
  HomeRepoImpl(this._storage);

  final Storage _storage;

  @override
  Stream<UserModel?> getUser() async*{
    yield* _storage.userData.watch();
  }

  @override
  UserModel? getUserData() {
    return _storage.userData.call();
  }

  @override
  Future<void> setUser(UserModel user) {
    return _storage.userData.set(user);
  }

}