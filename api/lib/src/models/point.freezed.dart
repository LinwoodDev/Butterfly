// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PathPoint {

 double get x; double get y; double get pressure;
/// Create a copy of PathPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PathPointCopyWith<PathPoint> get copyWith => _$PathPointCopyWithImpl<PathPoint>(this as PathPoint, _$identity);

  /// Serializes this PathPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PathPoint&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.pressure, pressure) || other.pressure == pressure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y,pressure);

@override
String toString() {
  return 'PathPoint(x: $x, y: $y, pressure: $pressure)';
}


}

/// @nodoc
abstract mixin class $PathPointCopyWith<$Res>  {
  factory $PathPointCopyWith(PathPoint value, $Res Function(PathPoint) _then) = _$PathPointCopyWithImpl;
@useResult
$Res call({
 double x, double y, double pressure
});




}
/// @nodoc
class _$PathPointCopyWithImpl<$Res>
    implements $PathPointCopyWith<$Res> {
  _$PathPointCopyWithImpl(this._self, this._then);

  final PathPoint _self;
  final $Res Function(PathPoint) _then;

/// Create a copy of PathPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,Object? pressure = null,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,pressure: null == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PathPoint extends PathPoint {
  const _PathPoint(this.x, this.y, [this.pressure = 1]): super._();
  factory _PathPoint.fromJson(Map<String, dynamic> json) => _$PathPointFromJson(json);

@override final  double x;
@override final  double y;
@override@JsonKey() final  double pressure;

/// Create a copy of PathPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PathPointCopyWith<_PathPoint> get copyWith => __$PathPointCopyWithImpl<_PathPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PathPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PathPoint&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.pressure, pressure) || other.pressure == pressure));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y,pressure);

@override
String toString() {
  return 'PathPoint(x: $x, y: $y, pressure: $pressure)';
}


}

/// @nodoc
abstract mixin class _$PathPointCopyWith<$Res> implements $PathPointCopyWith<$Res> {
  factory _$PathPointCopyWith(_PathPoint value, $Res Function(_PathPoint) _then) = __$PathPointCopyWithImpl;
@override @useResult
$Res call({
 double x, double y, double pressure
});




}
/// @nodoc
class __$PathPointCopyWithImpl<$Res>
    implements _$PathPointCopyWith<$Res> {
  __$PathPointCopyWithImpl(this._self, this._then);

  final _PathPoint _self;
  final $Res Function(_PathPoint) _then;

/// Create a copy of PathPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,Object? pressure = null,}) {
  return _then(_PathPoint(
null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,null == pressure ? _self.pressure : pressure // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
