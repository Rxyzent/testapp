// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  @HiveField(0)
  double? get lat => throw _privateConstructorUsedError;
  @HiveField(1)
  double? get lon => throw _privateConstructorUsedError;
  @HiveField(2)
  int? get inactiveDuration => throw _privateConstructorUsedError;
  @HiveField(3)
  double? get distance => throw _privateConstructorUsedError;
  @HiveField(4)
  double? get speed => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime? get lastUpdate => throw _privateConstructorUsedError;
  @HiveField(6)
  bool? get isTimerRunning => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {@HiveField(0) double? lat,
      @HiveField(1) double? lon,
      @HiveField(2) int? inactiveDuration,
      @HiveField(3) double? distance,
      @HiveField(4) double? speed,
      @HiveField(5) DateTime? lastUpdate,
      @HiveField(6) bool? isTimerRunning});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = freezed,
    Object? lon = freezed,
    Object? inactiveDuration = freezed,
    Object? distance = freezed,
    Object? speed = freezed,
    Object? lastUpdate = freezed,
    Object? isTimerRunning = freezed,
  }) {
    return _then(_value.copyWith(
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lon: freezed == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double?,
      inactiveDuration: freezed == inactiveDuration
          ? _value.inactiveDuration
          : inactiveDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      speed: freezed == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isTimerRunning: freezed == isTimerRunning
          ? _value.isTimerRunning
          : isTimerRunning // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) double? lat,
      @HiveField(1) double? lon,
      @HiveField(2) int? inactiveDuration,
      @HiveField(3) double? distance,
      @HiveField(4) double? speed,
      @HiveField(5) DateTime? lastUpdate,
      @HiveField(6) bool? isTimerRunning});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lat = freezed,
    Object? lon = freezed,
    Object? inactiveDuration = freezed,
    Object? distance = freezed,
    Object? speed = freezed,
    Object? lastUpdate = freezed,
    Object? isTimerRunning = freezed,
  }) {
    return _then(_$UserModelImpl(
      lat: freezed == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double?,
      lon: freezed == lon
          ? _value.lon
          : lon // ignore: cast_nullable_to_non_nullable
              as double?,
      inactiveDuration: freezed == inactiveDuration
          ? _value.inactiveDuration
          : inactiveDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      speed: freezed == speed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdate: freezed == lastUpdate
          ? _value.lastUpdate
          : lastUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isTimerRunning: freezed == isTimerRunning
          ? _value.isTimerRunning
          : isTimerRunning // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
@HiveType(typeId: 0)
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {@HiveField(0) this.lat,
      @HiveField(1) this.lon,
      @HiveField(2) this.inactiveDuration,
      @HiveField(3) this.distance,
      @HiveField(4) this.speed,
      @HiveField(5) this.lastUpdate,
      @HiveField(6) this.isTimerRunning});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  @HiveField(0)
  final double? lat;
  @override
  @HiveField(1)
  final double? lon;
  @override
  @HiveField(2)
  final int? inactiveDuration;
  @override
  @HiveField(3)
  final double? distance;
  @override
  @HiveField(4)
  final double? speed;
  @override
  @HiveField(5)
  final DateTime? lastUpdate;
  @override
  @HiveField(6)
  final bool? isTimerRunning;

  @override
  String toString() {
    return 'UserModel(lat: $lat, lon: $lon, inactiveDuration: $inactiveDuration, distance: $distance, speed: $speed, lastUpdate: $lastUpdate, isTimerRunning: $isTimerRunning)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon) &&
            (identical(other.inactiveDuration, inactiveDuration) ||
                other.inactiveDuration == inactiveDuration) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate) &&
            (identical(other.isTimerRunning, isTimerRunning) ||
                other.isTimerRunning == isTimerRunning));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lon, inactiveDuration,
      distance, speed, lastUpdate, isTimerRunning);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {@HiveField(0) final double? lat,
      @HiveField(1) final double? lon,
      @HiveField(2) final int? inactiveDuration,
      @HiveField(3) final double? distance,
      @HiveField(4) final double? speed,
      @HiveField(5) final DateTime? lastUpdate,
      @HiveField(6) final bool? isTimerRunning}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  @HiveField(0)
  double? get lat;
  @override
  @HiveField(1)
  double? get lon;
  @override
  @HiveField(2)
  int? get inactiveDuration;
  @override
  @HiveField(3)
  double? get distance;
  @override
  @HiveField(4)
  double? get speed;
  @override
  @HiveField(5)
  DateTime? get lastUpdate;
  @override
  @HiveField(6)
  bool? get isTimerRunning;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
