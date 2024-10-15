import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:testapp/domain/model/user/user_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeBuildable with _$HomeBuildable {
  const factory HomeBuildable({
    @Default(false) bool loading,
    @Default(false) bool error,
    @Default(false) bool isServiceRunning,
    @Default(false) bool isTimerRunning,
    int? timer,
    UserModel? user,
}) = _HomeBuildable;
}

@freezed
class HomeListenable with _$HomeListenable {
  const factory HomeListenable() = _HomeListenable;
}