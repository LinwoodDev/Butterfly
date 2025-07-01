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
mixin _$SimplePoint {

 double get x; double get y;
/// Create a copy of SimplePoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimplePointCopyWith<SimplePoint> get copyWith => _$SimplePointCopyWithImpl<SimplePoint>(this as SimplePoint, _$identity);

  /// Serializes this SimplePoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimplePoint&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y);

@override
String toString() {
  return 'SimplePoint(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $SimplePointCopyWith<$Res>  {
  factory $SimplePointCopyWith(SimplePoint value, $Res Function(SimplePoint) _then) = _$SimplePointCopyWithImpl;
@useResult
$Res call({
 double x, double y
});




}
/// @nodoc
class _$SimplePointCopyWithImpl<$Res>
    implements $SimplePointCopyWith<$Res> {
  _$SimplePointCopyWithImpl(this._self, this._then);

  final SimplePoint _self;
  final $Res Function(SimplePoint) _then;

/// Create a copy of SimplePoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SimplePoint extends SimplePoint {
  const _SimplePoint(this.x, this.y): super._();
  factory _SimplePoint.fromJson(Map<String, dynamic> json) => _$SimplePointFromJson(json);

@override final  double x;
@override final  double y;

/// Create a copy of SimplePoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimplePointCopyWith<_SimplePoint> get copyWith => __$SimplePointCopyWithImpl<_SimplePoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SimplePointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimplePoint&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y);

@override
String toString() {
  return 'SimplePoint(x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class _$SimplePointCopyWith<$Res> implements $SimplePointCopyWith<$Res> {
  factory _$SimplePointCopyWith(_SimplePoint value, $Res Function(_SimplePoint) _then) = __$SimplePointCopyWithImpl;
@override @useResult
$Res call({
 double x, double y
});




}
/// @nodoc
class __$SimplePointCopyWithImpl<$Res>
    implements _$SimplePointCopyWith<$Res> {
  __$SimplePointCopyWithImpl(this._self, this._then);

  final _SimplePoint _self;
  final $Res Function(_SimplePoint) _then;

/// Create a copy of SimplePoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,}) {
  return _then(_SimplePoint(
null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


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
abstract mixin class $PathPointCopyWith<$Res> implements $SimplePointCopyWith<$Res> {
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


/// @nodoc
mixin _$PolygonPoint {

 double get x; double get y; SimplePoint? get handleIn; SimplePoint? get handleOut;
/// Create a copy of PolygonPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PolygonPointCopyWith<PolygonPoint> get copyWith => _$PolygonPointCopyWithImpl<PolygonPoint>(this as PolygonPoint, _$identity);

  /// Serializes this PolygonPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PolygonPoint&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.handleIn, handleIn) || other.handleIn == handleIn)&&(identical(other.handleOut, handleOut) || other.handleOut == handleOut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y,handleIn,handleOut);

@override
String toString() {
  return 'PolygonPoint(x: $x, y: $y, handleIn: $handleIn, handleOut: $handleOut)';
}


}

/// @nodoc
abstract mixin class $PolygonPointCopyWith<$Res> implements $SimplePointCopyWith<$Res> {
  factory $PolygonPointCopyWith(PolygonPoint value, $Res Function(PolygonPoint) _then) = _$PolygonPointCopyWithImpl;
@useResult
$Res call({
 double x, double y, SimplePoint? handleIn, SimplePoint? handleOut
});


$SimplePointCopyWith<$Res>? get handleIn;$SimplePointCopyWith<$Res>? get handleOut;

}
/// @nodoc
class _$PolygonPointCopyWithImpl<$Res>
    implements $PolygonPointCopyWith<$Res> {
  _$PolygonPointCopyWithImpl(this._self, this._then);

  final PolygonPoint _self;
  final $Res Function(PolygonPoint) _then;

/// Create a copy of PolygonPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,Object? handleIn = freezed,Object? handleOut = freezed,}) {
  return _then(_self.copyWith(
x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,handleIn: freezed == handleIn ? _self.handleIn : handleIn // ignore: cast_nullable_to_non_nullable
as SimplePoint?,handleOut: freezed == handleOut ? _self.handleOut : handleOut // ignore: cast_nullable_to_non_nullable
as SimplePoint?,
  ));
}
/// Create a copy of PolygonPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SimplePointCopyWith<$Res>? get handleIn {
    if (_self.handleIn == null) {
    return null;
  }

  return $SimplePointCopyWith<$Res>(_self.handleIn!, (value) {
    return _then(_self.copyWith(handleIn: value));
  });
}/// Create a copy of PolygonPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SimplePointCopyWith<$Res>? get handleOut {
    if (_self.handleOut == null) {
    return null;
  }

  return $SimplePointCopyWith<$Res>(_self.handleOut!, (value) {
    return _then(_self.copyWith(handleOut: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _PolygonPoint extends PolygonPoint {
  const _PolygonPoint(this.x, this.y, {this.handleIn, this.handleOut}): super._();
  factory _PolygonPoint.fromJson(Map<String, dynamic> json) => _$PolygonPointFromJson(json);

@override final  double x;
@override final  double y;
@override final  SimplePoint? handleIn;
@override final  SimplePoint? handleOut;

/// Create a copy of PolygonPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PolygonPointCopyWith<_PolygonPoint> get copyWith => __$PolygonPointCopyWithImpl<_PolygonPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PolygonPointToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PolygonPoint&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.handleIn, handleIn) || other.handleIn == handleIn)&&(identical(other.handleOut, handleOut) || other.handleOut == handleOut));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,x,y,handleIn,handleOut);

@override
String toString() {
  return 'PolygonPoint(x: $x, y: $y, handleIn: $handleIn, handleOut: $handleOut)';
}


}

/// @nodoc
abstract mixin class _$PolygonPointCopyWith<$Res> implements $PolygonPointCopyWith<$Res> {
  factory _$PolygonPointCopyWith(_PolygonPoint value, $Res Function(_PolygonPoint) _then) = __$PolygonPointCopyWithImpl;
@override @useResult
$Res call({
 double x, double y, SimplePoint? handleIn, SimplePoint? handleOut
});


@override $SimplePointCopyWith<$Res>? get handleIn;@override $SimplePointCopyWith<$Res>? get handleOut;

}
/// @nodoc
class __$PolygonPointCopyWithImpl<$Res>
    implements _$PolygonPointCopyWith<$Res> {
  __$PolygonPointCopyWithImpl(this._self, this._then);

  final _PolygonPoint _self;
  final $Res Function(_PolygonPoint) _then;

/// Create a copy of PolygonPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,Object? handleIn = freezed,Object? handleOut = freezed,}) {
  return _then(_PolygonPoint(
null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,handleIn: freezed == handleIn ? _self.handleIn : handleIn // ignore: cast_nullable_to_non_nullable
as SimplePoint?,handleOut: freezed == handleOut ? _self.handleOut : handleOut // ignore: cast_nullable_to_non_nullable
as SimplePoint?,
  ));
}

/// Create a copy of PolygonPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SimplePointCopyWith<$Res>? get handleIn {
    if (_self.handleIn == null) {
    return null;
  }

  return $SimplePointCopyWith<$Res>(_self.handleIn!, (value) {
    return _then(_self.copyWith(handleIn: value));
  });
}/// Create a copy of PolygonPoint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SimplePointCopyWith<$Res>? get handleOut {
    if (_self.handleOut == null) {
    return null;
  }

  return $SimplePointCopyWith<$Res>(_self.handleOut!, (value) {
    return _then(_self.copyWith(handleOut: value));
  });
}
}

// dart format on
