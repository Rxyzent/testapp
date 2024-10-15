
import 'dart:async';

import 'package:testapp/domain/model/user/user_model.dart';

class DataStream {
  static final DataStream _instance = DataStream._internal();

  factory DataStream() {
    return _instance;
  }

  DataStream._internal(){
    print('DataStream instance created'); // Лог для отладки
  }


  static final StreamController<UserModel> _controller = StreamController<UserModel>.broadcast();

  static Stream<UserModel> get stream => _controller.stream;

  static void sendData(UserModel data) {
    _controller.add(data);
  }
}