// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'texture.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
SurfaceTexture _$SurfaceTextureFromJson(
  Map<String, dynamic> json
) {
    return PatternTexture.fromJson(
      json
    );
}

/// @nodoc
mixin _$SurfaceTexture {

 double get boxWidth; double get boxHeight; int get boxXCount; int get boxYCount; double get boxXSpace; double get boxYSpace;@ColorJsonConverter() SRGBColor get boxXColor;@ColorJsonConverter() SRGBColor get boxYColor;@ColorJsonConverter() SRGBColor get boxColor; double get boxXStroke; double get boxYStroke;
/// Create a copy of SurfaceTexture
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurfaceTextureCopyWith<SurfaceTexture> get copyWith => _$SurfaceTextureCopyWithImpl<SurfaceTexture>(this as SurfaceTexture, _$identity);

  /// Serializes this SurfaceTexture to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SurfaceTexture;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurfaceTexture&&(identical(other.boxWidth, _this.boxWidth) || other.boxWidth == _this.boxWidth)&&(identical(other.boxHeight, _this.boxHeight) || other.boxHeight == _this.boxHeight)&&(identical(other.boxXCount, _this.boxXCount) || other.boxXCount == _this.boxXCount)&&(identical(other.boxYCount, _this.boxYCount) || other.boxYCount == _this.boxYCount)&&(identical(other.boxXSpace, _this.boxXSpace) || other.boxXSpace == _this.boxXSpace)&&(identical(other.boxYSpace, _this.boxYSpace) || other.boxYSpace == _this.boxYSpace)&&(identical(other.boxXColor, _this.boxXColor) || other.boxXColor == _this.boxXColor)&&(identical(other.boxYColor, _this.boxYColor) || other.boxYColor == _this.boxYColor)&&(identical(other.boxColor, _this.boxColor) || other.boxColor == _this.boxColor)&&(identical(other.boxXStroke, _this.boxXStroke) || other.boxXStroke == _this.boxXStroke)&&(identical(other.boxYStroke, _this.boxYStroke) || other.boxYStroke == _this.boxYStroke));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SurfaceTexture;
  return Object.hash(runtimeType,_this.boxWidth,_this.boxHeight,_this.boxXCount,_this.boxYCount,_this.boxXSpace,_this.boxYSpace,_this.boxXColor,_this.boxYColor,_this.boxColor,_this.boxXStroke,_this.boxYStroke);
}

@override
String toString() {
  final _this = this as SurfaceTexture;
  return 'SurfaceTexture(boxWidth: ${_this.boxWidth}, boxHeight: ${_this.boxHeight}, boxXCount: ${_this.boxXCount}, boxYCount: ${_this.boxYCount}, boxXSpace: ${_this.boxXSpace}, boxYSpace: ${_this.boxYSpace}, boxXColor: ${_this.boxXColor}, boxYColor: ${_this.boxYColor}, boxColor: ${_this.boxColor}, boxXStroke: ${_this.boxXStroke}, boxYStroke: ${_this.boxYStroke})';
}


}

/// @nodoc
abstract mixin class $SurfaceTextureCopyWith<$Res>  {
  factory $SurfaceTextureCopyWith(SurfaceTexture value, $Res Function(SurfaceTexture) _then) = _$SurfaceTextureCopyWithImpl;
@useResult
$Res call({
 double boxWidth, double boxHeight, int boxXCount, int boxYCount, double boxXSpace, double boxYSpace,@ColorJsonConverter() SRGBColor boxXColor,@ColorJsonConverter() SRGBColor boxYColor,@ColorJsonConverter() SRGBColor boxColor, double boxXStroke, double boxYStroke
});




}
/// @nodoc
class _$SurfaceTextureCopyWithImpl<$Res>
    implements $SurfaceTextureCopyWith<$Res> {
  _$SurfaceTextureCopyWithImpl(this._self, this._then);

  final SurfaceTexture _self;
  final $Res Function(SurfaceTexture) _then;

/// Create a copy of SurfaceTexture
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? boxWidth = null,Object? boxHeight = null,Object? boxXCount = null,Object? boxYCount = null,Object? boxXSpace = null,Object? boxYSpace = null,Object? boxXColor = null,Object? boxYColor = null,Object? boxColor = null,Object? boxXStroke = null,Object? boxYStroke = null,}) {
  return _then(SurfaceTexture.pattern(
boxWidth: null == boxWidth ? _self.boxWidth : boxWidth // ignore: cast_nullable_to_non_nullable
as double,boxHeight: null == boxHeight ? _self.boxHeight : boxHeight // ignore: cast_nullable_to_non_nullable
as double,boxXCount: null == boxXCount ? _self.boxXCount : boxXCount // ignore: cast_nullable_to_non_nullable
as int,boxYCount: null == boxYCount ? _self.boxYCount : boxYCount // ignore: cast_nullable_to_non_nullable
as int,boxXSpace: null == boxXSpace ? _self.boxXSpace : boxXSpace // ignore: cast_nullable_to_non_nullable
as double,boxYSpace: null == boxYSpace ? _self.boxYSpace : boxYSpace // ignore: cast_nullable_to_non_nullable
as double,boxXColor: null == boxXColor ? _self.boxXColor : boxXColor // ignore: cast_nullable_to_non_nullable
as SRGBColor,boxYColor: null == boxYColor ? _self.boxYColor : boxYColor // ignore: cast_nullable_to_non_nullable
as SRGBColor,boxColor: null == boxColor ? _self.boxColor : boxColor // ignore: cast_nullable_to_non_nullable
as SRGBColor,boxXStroke: null == boxXStroke ? _self.boxXStroke : boxXStroke // ignore: cast_nullable_to_non_nullable
as double,boxYStroke: null == boxYStroke ? _self.boxYStroke : boxYStroke // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}



/// @nodoc
@JsonSerializable()

class PatternTexture implements SurfaceTexture {
  const PatternTexture({this.boxWidth = 0, this.boxHeight = 0, this.boxXCount = 1, this.boxYCount = 1, this.boxXSpace = 0, this.boxYSpace = 0, @ColorJsonConverter() this.boxXColor = BasicColors.blue, @ColorJsonConverter() this.boxYColor = BasicColors.red, @ColorJsonConverter() this.boxColor = SRGBColor.white, this.boxXStroke = 0.5, this.boxYStroke = 0.5});
  factory PatternTexture.fromJson(Map<String, dynamic> json) => _$PatternTextureFromJson(json);

@override@JsonKey() final  double boxWidth;
@override@JsonKey() final  double boxHeight;
@override@JsonKey() final  int boxXCount;
@override@JsonKey() final  int boxYCount;
@override@JsonKey() final  double boxXSpace;
@override@JsonKey() final  double boxYSpace;
@override@JsonKey()@ColorJsonConverter() final  SRGBColor boxXColor;
@override@JsonKey()@ColorJsonConverter() final  SRGBColor boxYColor;
@override@JsonKey()@ColorJsonConverter() final  SRGBColor boxColor;
@override@JsonKey() final  double boxXStroke;
@override@JsonKey() final  double boxYStroke;

/// Create a copy of SurfaceTexture
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PatternTextureCopyWith<PatternTexture> get copyWith => _$PatternTextureCopyWithImpl<PatternTexture>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PatternTextureToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PatternTexture&&(identical(other.boxWidth, boxWidth) || other.boxWidth == boxWidth)&&(identical(other.boxHeight, boxHeight) || other.boxHeight == boxHeight)&&(identical(other.boxXCount, boxXCount) || other.boxXCount == boxXCount)&&(identical(other.boxYCount, boxYCount) || other.boxYCount == boxYCount)&&(identical(other.boxXSpace, boxXSpace) || other.boxXSpace == boxXSpace)&&(identical(other.boxYSpace, boxYSpace) || other.boxYSpace == boxYSpace)&&(identical(other.boxXColor, boxXColor) || other.boxXColor == boxXColor)&&(identical(other.boxYColor, boxYColor) || other.boxYColor == boxYColor)&&(identical(other.boxColor, boxColor) || other.boxColor == boxColor)&&(identical(other.boxXStroke, boxXStroke) || other.boxXStroke == boxXStroke)&&(identical(other.boxYStroke, boxYStroke) || other.boxYStroke == boxYStroke));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,boxWidth,boxHeight,boxXCount,boxYCount,boxXSpace,boxYSpace,boxXColor,boxYColor,boxColor,boxXStroke,boxYStroke);
}

@override
String toString() {
    return 'SurfaceTexture.pattern(boxWidth: $boxWidth, boxHeight: $boxHeight, boxXCount: $boxXCount, boxYCount: $boxYCount, boxXSpace: $boxXSpace, boxYSpace: $boxYSpace, boxXColor: $boxXColor, boxYColor: $boxYColor, boxColor: $boxColor, boxXStroke: $boxXStroke, boxYStroke: $boxYStroke)';
}


}

/// @nodoc
abstract mixin class $PatternTextureCopyWith<$Res> implements $SurfaceTextureCopyWith<$Res> {
  factory $PatternTextureCopyWith(PatternTexture value, $Res Function(PatternTexture) _then) = _$PatternTextureCopyWithImpl;
@override @useResult
$Res call({
 double boxWidth, double boxHeight, int boxXCount, int boxYCount, double boxXSpace, double boxYSpace,@ColorJsonConverter() SRGBColor boxXColor,@ColorJsonConverter() SRGBColor boxYColor,@ColorJsonConverter() SRGBColor boxColor, double boxXStroke, double boxYStroke
});




}
/// @nodoc
class _$PatternTextureCopyWithImpl<$Res>
    implements $PatternTextureCopyWith<$Res> {
  _$PatternTextureCopyWithImpl(this._self, this._then);

  final PatternTexture _self;
  final $Res Function(PatternTexture) _then;

/// Create a copy of SurfaceTexture
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? boxWidth = null,Object? boxHeight = null,Object? boxXCount = null,Object? boxYCount = null,Object? boxXSpace = null,Object? boxYSpace = null,Object? boxXColor = null,Object? boxYColor = null,Object? boxColor = null,Object? boxXStroke = null,Object? boxYStroke = null,}) {
  return _then(PatternTexture(
boxWidth: null == boxWidth ? _self.boxWidth : boxWidth // ignore: cast_nullable_to_non_nullable
as double,boxHeight: null == boxHeight ? _self.boxHeight : boxHeight // ignore: cast_nullable_to_non_nullable
as double,boxXCount: null == boxXCount ? _self.boxXCount : boxXCount // ignore: cast_nullable_to_non_nullable
as int,boxYCount: null == boxYCount ? _self.boxYCount : boxYCount // ignore: cast_nullable_to_non_nullable
as int,boxXSpace: null == boxXSpace ? _self.boxXSpace : boxXSpace // ignore: cast_nullable_to_non_nullable
as double,boxYSpace: null == boxYSpace ? _self.boxYSpace : boxYSpace // ignore: cast_nullable_to_non_nullable
as double,boxXColor: null == boxXColor ? _self.boxXColor : boxXColor // ignore: cast_nullable_to_non_nullable
as SRGBColor,boxYColor: null == boxYColor ? _self.boxYColor : boxYColor // ignore: cast_nullable_to_non_nullable
as SRGBColor,boxColor: null == boxColor ? _self.boxColor : boxColor // ignore: cast_nullable_to_non_nullable
as SRGBColor,boxXStroke: null == boxXStroke ? _self.boxXStroke : boxXStroke // ignore: cast_nullable_to_non_nullable
as double,boxYStroke: null == boxYStroke ? _self.boxYStroke : boxYStroke // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
