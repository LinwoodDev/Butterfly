// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'path_point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PathPoint _$PathPointFromJson(Map<String, dynamic> json) {
  return _PathPoint.fromJson(json);
}

/// @nodoc
class _$PathPointTearOff {
  const _$PathPointTearOff();

  _PathPoint call(double x, double y, [double pressure = 1]) {
    return _PathPoint(
      x,
      y,
      pressure,
    );
  }

  PathPoint fromJson(Map<String, Object?> json) {
    return PathPoint.fromJson(json);
  }
}

/// @nodoc
const $PathPoint = _$PathPointTearOff();

/// @nodoc
mixin _$PathPoint {
  double get x => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  double get pressure => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PathPointCopyWith<PathPoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PathPointCopyWith<$Res> {
  factory $PathPointCopyWith(PathPoint value, $Res Function(PathPoint) then) =
      _$PathPointCopyWithImpl<$Res>;
  $Res call({double x, double y, double pressure});
}

/// @nodoc
class _$PathPointCopyWithImpl<$Res> implements $PathPointCopyWith<$Res> {
  _$PathPointCopyWithImpl(this._value, this._then);

  final PathPoint _value;
  // ignore: unused_field
  final $Res Function(PathPoint) _then;

  @override
  $Res call({
    Object? x = freezed,
    Object? y = freezed,
    Object? pressure = freezed,
  }) {
    return _then(_value.copyWith(
      x: x == freezed
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: y == freezed
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      pressure: pressure == freezed
          ? _value.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$PathPointCopyWith<$Res> implements $PathPointCopyWith<$Res> {
  factory _$PathPointCopyWith(
          _PathPoint value, $Res Function(_PathPoint) then) =
      __$PathPointCopyWithImpl<$Res>;
  @override
  $Res call({double x, double y, double pressure});
}

/// @nodoc
class __$PathPointCopyWithImpl<$Res> extends _$PathPointCopyWithImpl<$Res>
    implements _$PathPointCopyWith<$Res> {
  __$PathPointCopyWithImpl(_PathPoint _value, $Res Function(_PathPoint) _then)
      : super(_value, (v) => _then(v as _PathPoint));

  @override
  _PathPoint get _value => super._value as _PathPoint;

  @override
  $Res call({
    Object? x = freezed,
    Object? y = freezed,
    Object? pressure = freezed,
  }) {
    return _then(_PathPoint(
      x == freezed
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y == freezed
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      pressure == freezed
          ? _value.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PathPoint extends _PathPoint {
  const _$_PathPoint(this.x, this.y, [this.pressure = 1]) : super._();

  factory _$_PathPoint.fromJson(Map<String, dynamic> json) =>
      _$$_PathPointFromJson(json);

  @override
  final double x;
  @override
  final double y;
  @JsonKey()
  @override
  final double pressure;

  @override
  String toString() {
    return 'PathPoint(x: $x, y: $y, pressure: $pressure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PathPoint &&
            const DeepCollectionEquality().equals(other.x, x) &&
            const DeepCollectionEquality().equals(other.y, y) &&
            const DeepCollectionEquality().equals(other.pressure, pressure));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(x),
      const DeepCollectionEquality().hash(y),
      const DeepCollectionEquality().hash(pressure));

  @JsonKey(ignore: true)
  @override
  _$PathPointCopyWith<_PathPoint> get copyWith =>
      __$PathPointCopyWithImpl<_PathPoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PathPointToJson(this);
  }
}

abstract class _PathPoint extends PathPoint {
  const factory _PathPoint(double x, double y, [double pressure]) =
      _$_PathPoint;
  const _PathPoint._() : super._();

  factory _PathPoint.fromJson(Map<String, dynamic> json) =
      _$_PathPoint.fromJson;

  @override
  double get x;
  @override
  double get y;
  @override
  double get pressure;
  @override
  @JsonKey(ignore: true)
  _$PathPointCopyWith<_PathPoint> get copyWith =>
      throw _privateConstructorUsedError;
}
