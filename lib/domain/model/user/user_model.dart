// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  @HiveType(typeId: 0)
  const factory UserModel({
    @HiveField(0) double? lat,
    @HiveField(1) double? lon,
    @HiveField(2) int? inactiveDuration,
    @HiveField(3) double? distance,
    @HiveField(4) double? speed,
    @HiveField(5) DateTime? lastUpdate,
    @HiveField(6) bool? isTimerRunning,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
