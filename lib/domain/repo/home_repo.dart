import 'package:testapp/domain/model/user/user_model.dart';

abstract class HomeRepo{
  Stream<UserModel?> getUser();

  UserModel? getUserData();

  Future<void> setUser(UserModel user);

}