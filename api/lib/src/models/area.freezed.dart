// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'area.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Area {

 String get name; double get width; double get height;@DoublePointJsonConverter() Point<double> get position; bool get isInitial;@ColorJsonConverter() SRGBColor? get color;
/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaCopyWith<Area> get copyWith => _$AreaCopyWithImpl<Area>(this as Area, _$identity);

  /// Serializes this Area to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Area;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Area&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.height, _this.height) || other.height == _this.height)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.isInitial, _this.isInitial) || other.isInitial == _this.isInitial)&&(identical(other.color, _this.color) || other.color == _this.color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Area;
  return Object.hash(runtimeType,_this.name,_this.width,_this.height,_this.position,_this.isInitial,_this.color);
}

@override
String toString() {
  final _this = this as Area;
  return 'Area(name: ${_this.name}, width: ${_this.width}, height: ${_this.height}, position: ${_this.position}, isInitial: ${_this.isInitial}, color: ${_this.color})';
}


}

/// @nodoc
abstract mixin class $AreaCopyWith<$Res>  {
  factory $AreaCopyWith(Area value, $Res Function(Area) _then) = _$AreaCopyWithImpl;
@useResult
$Res call({
 String name, double width, double height,@DoublePointJsonConverter() Point<double> position, bool isInitial,@ColorJsonConverter() SRGBColor? color
});




}
/// @nodoc
class _$AreaCopyWithImpl<$Res>
    implements $AreaCopyWith<$Res> {
  _$AreaCopyWithImpl(this._self, this._then);

  final Area _self;
  final $Res Function(Area) _then;

/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? width = null,Object? height = null,Object? position = null,Object? isInitial = null,Object? color = freezed,}) {
  return _then(Area(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Point<double>,isInitial: null == isInitial ? _self.isInitial : isInitial // ignore: cast_nullable_to_non_nullable
as bool,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as SRGBColor?,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _Area extends Area {
  const _Area({this.name = '', required this.width, required this.height, @DoublePointJsonConverter() required this.position, this.isInitial = false, @ColorJsonConverter() this.color}): super._();
  factory _Area.fromJson(Map<String, dynamic> json) => _$AreaFromJson(json);

@override@JsonKey() final  String name;
@override final  double width;
@override final  double height;
@override@DoublePointJsonConverter() final  Point<double> position;
@override@JsonKey() final  bool isInitial;
@override@ColorJsonConverter() final  SRGBColor? color;

/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AreaCopyWith<_Area> get copyWith => __$AreaCopyWithImpl<_Area>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Area&&(identical(other.name, name) || other.name == name)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.position, position) || other.position == position)&&(identical(other.isInitial, isInitial) || other.isInitial == isInitial)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,width,height,position,isInitial,color);
}

@override
String toString() {
    return 'Area(name: $name, width: $width, height: $height, position: $position, isInitial: $isInitial, color: $color)';
}


}

/// @nodoc
abstract mixin class _$AreaCopyWith<$Res> implements $AreaCopyWith<$Res> {
  factory _$AreaCopyWith(_Area value, $Res Function(_Area) _then) = __$AreaCopyWithImpl;
@override @useResult
$Res call({
 String name, double width, double height,@DoublePointJsonConverter() Point<double> position, bool isInitial,@ColorJsonConverter() SRGBColor? color
});




}
/// @nodoc
class __$AreaCopyWithImpl<$Res>
    implements _$AreaCopyWith<$Res> {
  __$AreaCopyWithImpl(this._self, this._then);

  final _Area _self;
  final $Res Function(_Area) _then;

/// Create a copy of Area
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? width = null,Object? height = null,Object? position = null,Object? isInitial = null,Object? color = freezed,}) {
  return _then(_Area(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Point<double>,isInitial: null == isInitial ? _self.isInitial : isInitial // ignore: cast_nullable_to_non_nullable
as bool,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as SRGBColor?,
  ));
}


}

// dart format on
