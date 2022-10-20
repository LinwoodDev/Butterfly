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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PathPoint _$PathPointFromJson(Map<String, dynamic> json) {
  return _PathPoint.fromJson(json);
}

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
      _$PathPointCopyWithImpl<$Res, PathPoint>;
  @useResult
  $Res call({double x, double y, double pressure});
}

/// @nodoc
class _$PathPointCopyWithImpl<$Res, $Val extends PathPoint>
    implements $PathPointCopyWith<$Res> {
  _$PathPointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? pressure = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      pressure: null == pressure
          ? _value.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PathPointCopyWith<$Res> implements $PathPointCopyWith<$Res> {
  factory _$$_PathPointCopyWith(
          _$_PathPoint value, $Res Function(_$_PathPoint) then) =
      __$$_PathPointCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x, double y, double pressure});
}

/// @nodoc
class __$$_PathPointCopyWithImpl<$Res>
    extends _$PathPointCopyWithImpl<$Res, _$_PathPoint>
    implements _$$_PathPointCopyWith<$Res> {
  __$$_PathPointCopyWithImpl(
      _$_PathPoint _value, $Res Function(_$_PathPoint) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
    Object? pressure = null,
  }) {
    return _then(_$_PathPoint(
      null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
      null == pressure
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
  @override
  @JsonKey()
  final double pressure;

  @override
  String toString() {
    return 'PathPoint(x: $x, y: $y, pressure: $pressure)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PathPoint &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y) &&
            (identical(other.pressure, pressure) ||
                other.pressure == pressure));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y, pressure);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PathPointCopyWith<_$_PathPoint> get copyWith =>
      __$$_PathPointCopyWithImpl<_$_PathPoint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PathPointToJson(
      this,
    );
  }
}

abstract class _PathPoint extends PathPoint {
  const factory _PathPoint(final double x, final double y,
      [final double pressure]) = _$_PathPoint;
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
  _$$_PathPointCopyWith<_$_PathPoint> get copyWith =>
      throw _privateConstructorUsedError;
}
