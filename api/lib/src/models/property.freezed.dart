// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
ElementPaint _$ElementPaintFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'solid':
          return SolidElementPaint.fromJson(
            json
          );
                case 'image':
          return ImageElementPaint.fromJson(
            json
          );
                case 'svg':
          return SvgElementPaint.fromJson(
            json
          );
                case 'gradient':
          return GradientElementPaint.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'ElementPaint',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$ElementPaint {

 double get blur;
/// Create a copy of ElementPaint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementPaintCopyWith<ElementPaint> get copyWith => _$ElementPaintCopyWithImpl<ElementPaint>(this as ElementPaint, _$identity);

  /// Serializes this ElementPaint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementPaint&&(identical(other.blur, blur) || other.blur == blur));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,blur);

@override
String toString() {
  return 'ElementPaint(blur: $blur)';
}


}

/// @nodoc
abstract mixin class $ElementPaintCopyWith<$Res>  {
  factory $ElementPaintCopyWith(ElementPaint value, $Res Function(ElementPaint) _then) = _$ElementPaintCopyWithImpl;
@useResult
$Res call({
 double blur
});




}
/// @nodoc
class _$ElementPaintCopyWithImpl<$Res>
    implements $ElementPaintCopyWith<$Res> {
  _$ElementPaintCopyWithImpl(this._self, this._then);

  final ElementPaint _self;
  final $Res Function(ElementPaint) _then;

/// Create a copy of ElementPaint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? blur = null,}) {
  return _then(_self.copyWith(
blur: null == blur ? _self.blur : blur // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}



/// @nodoc
@JsonSerializable()

class SolidElementPaint extends ElementPaint {
  const SolidElementPaint({@ColorJsonConverter() this.color = SRGBColor.black, this.blur = 0, final  String? $type}): $type = $type ?? 'solid',super._();
  factory SolidElementPaint.fromJson(Map<String, dynamic> json) => _$SolidElementPaintFromJson(json);

@JsonKey()@ColorJsonConverter() final  SRGBColor color;
@override@JsonKey() final  double blur;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ElementPaint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SolidElementPaintCopyWith<SolidElementPaint> get copyWith => _$SolidElementPaintCopyWithImpl<SolidElementPaint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SolidElementPaintToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SolidElementPaint&&(identical(other.color, color) || other.color == color)&&(identical(other.blur, blur) || other.blur == blur));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,blur);

@override
String toString() {
  return 'ElementPaint.solid(color: $color, blur: $blur)';
}


}

/// @nodoc
abstract mixin class $SolidElementPaintCopyWith<$Res> implements $ElementPaintCopyWith<$Res> {
  factory $SolidElementPaintCopyWith(SolidElementPaint value, $Res Function(SolidElementPaint) _then) = _$SolidElementPaintCopyWithImpl;
@override @useResult
$Res call({
@ColorJsonConverter() SRGBColor color, double blur
});




}
/// @nodoc
class _$SolidElementPaintCopyWithImpl<$Res>
    implements $SolidElementPaintCopyWith<$Res> {
  _$SolidElementPaintCopyWithImpl(this._self, this._then);

  final SolidElementPaint _self;
  final $Res Function(SolidElementPaint) _then;

/// Create a copy of ElementPaint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? color = null,Object? blur = null,}) {
  return _then(SolidElementPaint(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as SRGBColor,blur: null == blur ? _self.blur : blur // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ImageElementPaint extends ElementPaint {
  const ImageElementPaint({required this.source, @ColorJsonConverter() this.tint = SRGBColor.white, this.scale = 0.25, this.blur = 0, final  String? $type}): $type = $type ?? 'image',super._();
  factory ImageElementPaint.fromJson(Map<String, dynamic> json) => _$ImageElementPaintFromJson(json);

 final  String source;
@JsonKey()@ColorJsonConverter() final  SRGBColor tint;
@JsonKey() final  double scale;
@override@JsonKey() final  double blur;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ElementPaint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageElementPaintCopyWith<ImageElementPaint> get copyWith => _$ImageElementPaintCopyWithImpl<ImageElementPaint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageElementPaintToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageElementPaint&&(identical(other.source, source) || other.source == source)&&(identical(other.tint, tint) || other.tint == tint)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.blur, blur) || other.blur == blur));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,tint,scale,blur);

@override
String toString() {
  return 'ElementPaint.image(source: $source, tint: $tint, scale: $scale, blur: $blur)';
}


}

/// @nodoc
abstract mixin class $ImageElementPaintCopyWith<$Res> implements $ElementPaintCopyWith<$Res> {
  factory $ImageElementPaintCopyWith(ImageElementPaint value, $Res Function(ImageElementPaint) _then) = _$ImageElementPaintCopyWithImpl;
@override @useResult
$Res call({
 String source,@ColorJsonConverter() SRGBColor tint, double scale, double blur
});




}
/// @nodoc
class _$ImageElementPaintCopyWithImpl<$Res>
    implements $ImageElementPaintCopyWith<$Res> {
  _$ImageElementPaintCopyWithImpl(this._self, this._then);

  final ImageElementPaint _self;
  final $Res Function(ImageElementPaint) _then;

/// Create a copy of ElementPaint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? tint = null,Object? scale = null,Object? blur = null,}) {
  return _then(ImageElementPaint(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,tint: null == tint ? _self.tint : tint // ignore: cast_nullable_to_non_nullable
as SRGBColor,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,blur: null == blur ? _self.blur : blur // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SvgElementPaint extends ElementPaint {
  const SvgElementPaint({required this.source, @ColorJsonConverter() this.tint = SRGBColor.white, this.scale = 0.25, this.blur = 0, final  String? $type}): $type = $type ?? 'svg',super._();
  factory SvgElementPaint.fromJson(Map<String, dynamic> json) => _$SvgElementPaintFromJson(json);

 final  String source;
@JsonKey()@ColorJsonConverter() final  SRGBColor tint;
@JsonKey() final  double scale;
@override@JsonKey() final  double blur;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ElementPaint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SvgElementPaintCopyWith<SvgElementPaint> get copyWith => _$SvgElementPaintCopyWithImpl<SvgElementPaint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SvgElementPaintToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SvgElementPaint&&(identical(other.source, source) || other.source == source)&&(identical(other.tint, tint) || other.tint == tint)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.blur, blur) || other.blur == blur));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,tint,scale,blur);

@override
String toString() {
  return 'ElementPaint.svg(source: $source, tint: $tint, scale: $scale, blur: $blur)';
}


}

/// @nodoc
abstract mixin class $SvgElementPaintCopyWith<$Res> implements $ElementPaintCopyWith<$Res> {
  factory $SvgElementPaintCopyWith(SvgElementPaint value, $Res Function(SvgElementPaint) _then) = _$SvgElementPaintCopyWithImpl;
@override @useResult
$Res call({
 String source,@ColorJsonConverter() SRGBColor tint, double scale, double blur
});




}
/// @nodoc
class _$SvgElementPaintCopyWithImpl<$Res>
    implements $SvgElementPaintCopyWith<$Res> {
  _$SvgElementPaintCopyWithImpl(this._self, this._then);

  final SvgElementPaint _self;
  final $Res Function(SvgElementPaint) _then;

/// Create a copy of ElementPaint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? tint = null,Object? scale = null,Object? blur = null,}) {
  return _then(SvgElementPaint(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,tint: null == tint ? _self.tint : tint // ignore: cast_nullable_to_non_nullable
as SRGBColor,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,blur: null == blur ? _self.blur : blur // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
@JsonSerializable()

class GradientElementPaint extends ElementPaint {
  const GradientElementPaint({this.gradient = const ElementGradient.linear(), this.blur = 0, final  String? $type}): $type = $type ?? 'gradient',super._();
  factory GradientElementPaint.fromJson(Map<String, dynamic> json) => _$GradientElementPaintFromJson(json);

@JsonKey() final  ElementGradient gradient;
@override@JsonKey() final  double blur;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ElementPaint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradientElementPaintCopyWith<GradientElementPaint> get copyWith => _$GradientElementPaintCopyWithImpl<GradientElementPaint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradientElementPaintToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradientElementPaint&&(identical(other.gradient, gradient) || other.gradient == gradient)&&(identical(other.blur, blur) || other.blur == blur));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gradient,blur);

@override
String toString() {
  return 'ElementPaint.gradient(gradient: $gradient, blur: $blur)';
}


}

/// @nodoc
abstract mixin class $GradientElementPaintCopyWith<$Res> implements $ElementPaintCopyWith<$Res> {
  factory $GradientElementPaintCopyWith(GradientElementPaint value, $Res Function(GradientElementPaint) _then) = _$GradientElementPaintCopyWithImpl;
@override @useResult
$Res call({
 ElementGradient gradient, double blur
});


$ElementGradientCopyWith<$Res> get gradient;

}
/// @nodoc
class _$GradientElementPaintCopyWithImpl<$Res>
    implements $GradientElementPaintCopyWith<$Res> {
  _$GradientElementPaintCopyWithImpl(this._self, this._then);

  final GradientElementPaint _self;
  final $Res Function(GradientElementPaint) _then;

/// Create a copy of ElementPaint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gradient = null,Object? blur = null,}) {
  return _then(GradientElementPaint(
gradient: null == gradient ? _self.gradient : gradient // ignore: cast_nullable_to_non_nullable
as ElementGradient,blur: null == blur ? _self.blur : blur // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of ElementPaint
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementGradientCopyWith<$Res> get gradient {
  
  return $ElementGradientCopyWith<$Res>(_self.gradient, (value) {
    return _then(_self.copyWith(gradient: value));
  });
}
}

ElementGradient _$ElementGradientFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'linear':
          return LinearElementGradient.fromJson(
            json
          );
                case 'radial':
          return RadialElementGradient.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'ElementGradient',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$ElementGradient {

 List<ElementGradientStop> get stops;
/// Create a copy of ElementGradient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementGradientCopyWith<ElementGradient> get copyWith => _$ElementGradientCopyWithImpl<ElementGradient>(this as ElementGradient, _$identity);

  /// Serializes this ElementGradient to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementGradient&&const DeepCollectionEquality().equals(other.stops, stops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(stops));

@override
String toString() {
  return 'ElementGradient(stops: $stops)';
}


}

/// @nodoc
abstract mixin class $ElementGradientCopyWith<$Res>  {
  factory $ElementGradientCopyWith(ElementGradient value, $Res Function(ElementGradient) _then) = _$ElementGradientCopyWithImpl;
@useResult
$Res call({
 List<ElementGradientStop> stops
});




}
/// @nodoc
class _$ElementGradientCopyWithImpl<$Res>
    implements $ElementGradientCopyWith<$Res> {
  _$ElementGradientCopyWithImpl(this._self, this._then);

  final ElementGradient _self;
  final $Res Function(ElementGradient) _then;

/// Create a copy of ElementGradient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stops = null,}) {
  return _then(_self.copyWith(
stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<ElementGradientStop>,
  ));
}

}



/// @nodoc
@JsonSerializable()

class LinearElementGradient implements ElementGradient {
  const LinearElementGradient({@DoublePointJsonConverter() this.start = const Point(0, 0), @DoublePointJsonConverter() this.end = const Point(1, 0), final  List<ElementGradientStop> stops = defaultGradientStops, final  String? $type}): _stops = stops,$type = $type ?? 'linear';
  factory LinearElementGradient.fromJson(Map<String, dynamic> json) => _$LinearElementGradientFromJson(json);

@JsonKey()@DoublePointJsonConverter() final  Point<double> start;
@JsonKey()@DoublePointJsonConverter() final  Point<double> end;
 final  List<ElementGradientStop> _stops;
@override@JsonKey() List<ElementGradientStop> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of ElementGradient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinearElementGradientCopyWith<LinearElementGradient> get copyWith => _$LinearElementGradientCopyWithImpl<LinearElementGradient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LinearElementGradientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinearElementGradient&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&const DeepCollectionEquality().equals(other._stops, _stops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,start,end,const DeepCollectionEquality().hash(_stops));

@override
String toString() {
  return 'ElementGradient.linear(start: $start, end: $end, stops: $stops)';
}


}

/// @nodoc
abstract mixin class $LinearElementGradientCopyWith<$Res> implements $ElementGradientCopyWith<$Res> {
  factory $LinearElementGradientCopyWith(LinearElementGradient value, $Res Function(LinearElementGradient) _then) = _$LinearElementGradientCopyWithImpl;
@override @useResult
$Res call({
@DoublePointJsonConverter() Point<double> start,@DoublePointJsonConverter() Point<double> end, List<ElementGradientStop> stops
});




}
/// @nodoc
class _$LinearElementGradientCopyWithImpl<$Res>
    implements $LinearElementGradientCopyWith<$Res> {
  _$LinearElementGradientCopyWithImpl(this._self, this._then);

  final LinearElementGradient _self;
  final $Res Function(LinearElementGradient) _then;

/// Create a copy of ElementGradient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,Object? stops = null,}) {
  return _then(LinearElementGradient(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Point<double>,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as Point<double>,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<ElementGradientStop>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RadialElementGradient implements ElementGradient {
  const RadialElementGradient({@DoublePointJsonConverter() this.center = const Point(0.5, 0.5), this.radius = 0.5, @DoublePointJsonConverter() this.focal, this.focalRadius, final  List<ElementGradientStop> stops = defaultGradientStops, final  String? $type}): _stops = stops,$type = $type ?? 'radial';
  factory RadialElementGradient.fromJson(Map<String, dynamic> json) => _$RadialElementGradientFromJson(json);

@JsonKey()@DoublePointJsonConverter() final  Point<double> center;
@JsonKey() final  double radius;
@DoublePointJsonConverter() final  Point<double>? focal;
 final  double? focalRadius;
 final  List<ElementGradientStop> _stops;
@override@JsonKey() List<ElementGradientStop> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of ElementGradient
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RadialElementGradientCopyWith<RadialElementGradient> get copyWith => _$RadialElementGradientCopyWithImpl<RadialElementGradient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RadialElementGradientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RadialElementGradient&&(identical(other.center, center) || other.center == center)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.focal, focal) || other.focal == focal)&&(identical(other.focalRadius, focalRadius) || other.focalRadius == focalRadius)&&const DeepCollectionEquality().equals(other._stops, _stops));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,center,radius,focal,focalRadius,const DeepCollectionEquality().hash(_stops));

@override
String toString() {
  return 'ElementGradient.radial(center: $center, radius: $radius, focal: $focal, focalRadius: $focalRadius, stops: $stops)';
}


}

/// @nodoc
abstract mixin class $RadialElementGradientCopyWith<$Res> implements $ElementGradientCopyWith<$Res> {
  factory $RadialElementGradientCopyWith(RadialElementGradient value, $Res Function(RadialElementGradient) _then) = _$RadialElementGradientCopyWithImpl;
@override @useResult
$Res call({
@DoublePointJsonConverter() Point<double> center, double radius,@DoublePointJsonConverter() Point<double>? focal, double? focalRadius, List<ElementGradientStop> stops
});




}
/// @nodoc
class _$RadialElementGradientCopyWithImpl<$Res>
    implements $RadialElementGradientCopyWith<$Res> {
  _$RadialElementGradientCopyWithImpl(this._self, this._then);

  final RadialElementGradient _self;
  final $Res Function(RadialElementGradient) _then;

/// Create a copy of ElementGradient
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? center = null,Object? radius = null,Object? focal = freezed,Object? focalRadius = freezed,Object? stops = null,}) {
  return _then(RadialElementGradient(
center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as Point<double>,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,focal: freezed == focal ? _self.focal : focal // ignore: cast_nullable_to_non_nullable
as Point<double>?,focalRadius: freezed == focalRadius ? _self.focalRadius : focalRadius // ignore: cast_nullable_to_non_nullable
as double?,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<ElementGradientStop>,
  ));
}


}


/// @nodoc
mixin _$ElementGradientStop {

 double get offset;@ColorJsonConverter() SRGBColor get color;
/// Create a copy of ElementGradientStop
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementGradientStopCopyWith<ElementGradientStop> get copyWith => _$ElementGradientStopCopyWithImpl<ElementGradientStop>(this as ElementGradientStop, _$identity);

  /// Serializes this ElementGradientStop to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementGradientStop&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offset,color);

@override
String toString() {
  return 'ElementGradientStop(offset: $offset, color: $color)';
}


}

/// @nodoc
abstract mixin class $ElementGradientStopCopyWith<$Res>  {
  factory $ElementGradientStopCopyWith(ElementGradientStop value, $Res Function(ElementGradientStop) _then) = _$ElementGradientStopCopyWithImpl;
@useResult
$Res call({
 double offset,@ColorJsonConverter() SRGBColor color
});




}
/// @nodoc
class _$ElementGradientStopCopyWithImpl<$Res>
    implements $ElementGradientStopCopyWith<$Res> {
  _$ElementGradientStopCopyWithImpl(this._self, this._then);

  final ElementGradientStop _self;
  final $Res Function(ElementGradientStop) _then;

/// Create a copy of ElementGradientStop
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? offset = null,Object? color = null,}) {
  return _then(_self.copyWith(
offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as double,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as SRGBColor,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _ElementGradientStop implements ElementGradientStop {
  const _ElementGradientStop({this.offset = 0, @ColorJsonConverter() this.color = SRGBColor.black});
  factory _ElementGradientStop.fromJson(Map<String, dynamic> json) => _$ElementGradientStopFromJson(json);

@override@JsonKey() final  double offset;
@override@JsonKey()@ColorJsonConverter() final  SRGBColor color;

/// Create a copy of ElementGradientStop
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElementGradientStopCopyWith<_ElementGradientStop> get copyWith => __$ElementGradientStopCopyWithImpl<_ElementGradientStop>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElementGradientStopToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElementGradientStop&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offset,color);

@override
String toString() {
  return 'ElementGradientStop(offset: $offset, color: $color)';
}


}

/// @nodoc
abstract mixin class _$ElementGradientStopCopyWith<$Res> implements $ElementGradientStopCopyWith<$Res> {
  factory _$ElementGradientStopCopyWith(_ElementGradientStop value, $Res Function(_ElementGradientStop) _then) = __$ElementGradientStopCopyWithImpl;
@override @useResult
$Res call({
 double offset,@ColorJsonConverter() SRGBColor color
});




}
/// @nodoc
class __$ElementGradientStopCopyWithImpl<$Res>
    implements _$ElementGradientStopCopyWith<$Res> {
  __$ElementGradientStopCopyWithImpl(this._self, this._then);

  final _ElementGradientStop _self;
  final $Res Function(_ElementGradientStop) _then;

/// Create a copy of ElementGradientStop
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? offset = null,Object? color = null,}) {
  return _then(_ElementGradientStop(
offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as double,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as SRGBColor,
  ));
}


}

Property _$PropertyFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'pen':
          return PenProperty.fromJson(
            json
          );
                case 'shape':
          return ShapeProperty.fromJson(
            json
          );
                case 'polygon':
          return PolygonProperty.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'Property',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$Property {

 double get strokeWidth; ElementPaint get paint;
/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PropertyCopyWith<Property> get copyWith => _$PropertyCopyWithImpl<Property>(this as Property, _$identity);

  /// Serializes this Property to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Property&&(identical(other.strokeWidth, strokeWidth) || other.strokeWidth == strokeWidth)&&(identical(other.paint, paint) || other.paint == paint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strokeWidth,paint);

@override
String toString() {
  return 'Property(strokeWidth: $strokeWidth, paint: $paint)';
}


}

/// @nodoc
abstract mixin class $PropertyCopyWith<$Res>  {
  factory $PropertyCopyWith(Property value, $Res Function(Property) _then) = _$PropertyCopyWithImpl;
@useResult
$Res call({
 double strokeWidth, ElementPaint paint
});


$ElementPaintCopyWith<$Res> get paint;

}
/// @nodoc
class _$PropertyCopyWithImpl<$Res>
    implements $PropertyCopyWith<$Res> {
  _$PropertyCopyWithImpl(this._self, this._then);

  final Property _self;
  final $Res Function(Property) _then;

/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? strokeWidth = null,Object? paint = null,}) {
  return _then(_self.copyWith(
strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,paint: null == paint ? _self.paint : paint // ignore: cast_nullable_to_non_nullable
as ElementPaint,
  ));
}
/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementPaintCopyWith<$Res> get paint {
  
  return $ElementPaintCopyWith<$Res>(_self.paint, (value) {
    return _then(_self.copyWith(paint: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class PenProperty implements Property, PathProperty {
  const PenProperty({this.strokeWidth = 5, this.thinning = 0.4, this.paint = const ElementPaint.solid(), this.fillPaint = const ElementPaint.solid(color: SRGBColor.transparent), this.smoothing = 0.5, this.streamline = 0.3, final  String? $type}): $type = $type ?? 'pen';
  factory PenProperty.fromJson(Map<String, dynamic> json) => _$PenPropertyFromJson(json);

@override@JsonKey() final  double strokeWidth;
@JsonKey() final  double thinning;
@override@JsonKey() final  ElementPaint paint;
@JsonKey() final  ElementPaint fillPaint;
@JsonKey() final  double smoothing;
@JsonKey() final  double streamline;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PenPropertyCopyWith<PenProperty> get copyWith => _$PenPropertyCopyWithImpl<PenProperty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PenPropertyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PenProperty&&(identical(other.strokeWidth, strokeWidth) || other.strokeWidth == strokeWidth)&&(identical(other.thinning, thinning) || other.thinning == thinning)&&(identical(other.paint, paint) || other.paint == paint)&&(identical(other.fillPaint, fillPaint) || other.fillPaint == fillPaint)&&(identical(other.smoothing, smoothing) || other.smoothing == smoothing)&&(identical(other.streamline, streamline) || other.streamline == streamline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strokeWidth,thinning,paint,fillPaint,smoothing,streamline);

@override
String toString() {
  return 'Property.pen(strokeWidth: $strokeWidth, thinning: $thinning, paint: $paint, fillPaint: $fillPaint, smoothing: $smoothing, streamline: $streamline)';
}


}

/// @nodoc
abstract mixin class $PenPropertyCopyWith<$Res> implements $PropertyCopyWith<$Res> {
  factory $PenPropertyCopyWith(PenProperty value, $Res Function(PenProperty) _then) = _$PenPropertyCopyWithImpl;
@override @useResult
$Res call({
 double strokeWidth, double thinning, ElementPaint paint, ElementPaint fillPaint, double smoothing, double streamline
});


@override $ElementPaintCopyWith<$Res> get paint;$ElementPaintCopyWith<$Res> get fillPaint;

}
/// @nodoc
class _$PenPropertyCopyWithImpl<$Res>
    implements $PenPropertyCopyWith<$Res> {
  _$PenPropertyCopyWithImpl(this._self, this._then);

  final PenProperty _self;
  final $Res Function(PenProperty) _then;

/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? strokeWidth = null,Object? thinning = null,Object? paint = null,Object? fillPaint = null,Object? smoothing = null,Object? streamline = null,}) {
  return _then(PenProperty(
strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,thinning: null == thinning ? _self.thinning : thinning // ignore: cast_nullable_to_non_nullable
as double,paint: null == paint ? _self.paint : paint // ignore: cast_nullable_to_non_nullable
as ElementPaint,fillPaint: null == fillPaint ? _self.fillPaint : fillPaint // ignore: cast_nullable_to_non_nullable
as ElementPaint,smoothing: null == smoothing ? _self.smoothing : smoothing // ignore: cast_nullable_to_non_nullable
as double,streamline: null == streamline ? _self.streamline : streamline // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementPaintCopyWith<$Res> get paint {
  
  return $ElementPaintCopyWith<$Res>(_self.paint, (value) {
    return _then(_self.copyWith(paint: value));
  });
}/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementPaintCopyWith<$Res> get fillPaint {
  
  return $ElementPaintCopyWith<$Res>(_self.fillPaint, (value) {
    return _then(_self.copyWith(fillPaint: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ShapeProperty implements Property {
  const ShapeProperty({this.strokeWidth = 5, required this.shape, this.paint = const ElementPaint.solid(), this.strokeStyle = StrokeStyle.solid, this.dashMultiplier = 1.0, this.gapMultiplier = 1.0, final  String? $type}): $type = $type ?? 'shape';
  factory ShapeProperty.fromJson(Map<String, dynamic> json) => _$ShapePropertyFromJson(json);

@override@JsonKey() final  double strokeWidth;
 final  PathShape shape;
@override@JsonKey() final  ElementPaint paint;
@JsonKey() final  StrokeStyle strokeStyle;
@JsonKey() final  double dashMultiplier;
@JsonKey() final  double gapMultiplier;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShapePropertyCopyWith<ShapeProperty> get copyWith => _$ShapePropertyCopyWithImpl<ShapeProperty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShapePropertyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShapeProperty&&(identical(other.strokeWidth, strokeWidth) || other.strokeWidth == strokeWidth)&&(identical(other.shape, shape) || other.shape == shape)&&(identical(other.paint, paint) || other.paint == paint)&&(identical(other.strokeStyle, strokeStyle) || other.strokeStyle == strokeStyle)&&(identical(other.dashMultiplier, dashMultiplier) || other.dashMultiplier == dashMultiplier)&&(identical(other.gapMultiplier, gapMultiplier) || other.gapMultiplier == gapMultiplier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strokeWidth,shape,paint,strokeStyle,dashMultiplier,gapMultiplier);

@override
String toString() {
  return 'Property.shape(strokeWidth: $strokeWidth, shape: $shape, paint: $paint, strokeStyle: $strokeStyle, dashMultiplier: $dashMultiplier, gapMultiplier: $gapMultiplier)';
}


}

/// @nodoc
abstract mixin class $ShapePropertyCopyWith<$Res> implements $PropertyCopyWith<$Res> {
  factory $ShapePropertyCopyWith(ShapeProperty value, $Res Function(ShapeProperty) _then) = _$ShapePropertyCopyWithImpl;
@override @useResult
$Res call({
 double strokeWidth, PathShape shape, ElementPaint paint, StrokeStyle strokeStyle, double dashMultiplier, double gapMultiplier
});


$PathShapeCopyWith<$Res> get shape;@override $ElementPaintCopyWith<$Res> get paint;

}
/// @nodoc
class _$ShapePropertyCopyWithImpl<$Res>
    implements $ShapePropertyCopyWith<$Res> {
  _$ShapePropertyCopyWithImpl(this._self, this._then);

  final ShapeProperty _self;
  final $Res Function(ShapeProperty) _then;

/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? strokeWidth = null,Object? shape = null,Object? paint = null,Object? strokeStyle = null,Object? dashMultiplier = null,Object? gapMultiplier = null,}) {
  return _then(ShapeProperty(
strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,shape: null == shape ? _self.shape : shape // ignore: cast_nullable_to_non_nullable
as PathShape,paint: null == paint ? _self.paint : paint // ignore: cast_nullable_to_non_nullable
as ElementPaint,strokeStyle: null == strokeStyle ? _self.strokeStyle : strokeStyle // ignore: cast_nullable_to_non_nullable
as StrokeStyle,dashMultiplier: null == dashMultiplier ? _self.dashMultiplier : dashMultiplier // ignore: cast_nullable_to_non_nullable
as double,gapMultiplier: null == gapMultiplier ? _self.gapMultiplier : gapMultiplier // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PathShapeCopyWith<$Res> get shape {
  
  return $PathShapeCopyWith<$Res>(_self.shape, (value) {
    return _then(_self.copyWith(shape: value));
  });
}/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementPaintCopyWith<$Res> get paint {
  
  return $ElementPaintCopyWith<$Res>(_self.paint, (value) {
    return _then(_self.copyWith(paint: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class PolygonProperty implements Property {
  const PolygonProperty({this.strokeWidth = 5, this.paint = const ElementPaint.solid(), this.fillPaint = const ElementPaint.solid(color: SRGBColor.transparent), final  String? $type}): $type = $type ?? 'polygon';
  factory PolygonProperty.fromJson(Map<String, dynamic> json) => _$PolygonPropertyFromJson(json);

@override@JsonKey() final  double strokeWidth;
@override@JsonKey() final  ElementPaint paint;
@JsonKey() final  ElementPaint fillPaint;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PolygonPropertyCopyWith<PolygonProperty> get copyWith => _$PolygonPropertyCopyWithImpl<PolygonProperty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PolygonPropertyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PolygonProperty&&(identical(other.strokeWidth, strokeWidth) || other.strokeWidth == strokeWidth)&&(identical(other.paint, paint) || other.paint == paint)&&(identical(other.fillPaint, fillPaint) || other.fillPaint == fillPaint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strokeWidth,paint,fillPaint);

@override
String toString() {
  return 'Property.polygon(strokeWidth: $strokeWidth, paint: $paint, fillPaint: $fillPaint)';
}


}

/// @nodoc
abstract mixin class $PolygonPropertyCopyWith<$Res> implements $PropertyCopyWith<$Res> {
  factory $PolygonPropertyCopyWith(PolygonProperty value, $Res Function(PolygonProperty) _then) = _$PolygonPropertyCopyWithImpl;
@override @useResult
$Res call({
 double strokeWidth, ElementPaint paint, ElementPaint fillPaint
});


@override $ElementPaintCopyWith<$Res> get paint;$ElementPaintCopyWith<$Res> get fillPaint;

}
/// @nodoc
class _$PolygonPropertyCopyWithImpl<$Res>
    implements $PolygonPropertyCopyWith<$Res> {
  _$PolygonPropertyCopyWithImpl(this._self, this._then);

  final PolygonProperty _self;
  final $Res Function(PolygonProperty) _then;

/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? strokeWidth = null,Object? paint = null,Object? fillPaint = null,}) {
  return _then(PolygonProperty(
strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,paint: null == paint ? _self.paint : paint // ignore: cast_nullable_to_non_nullable
as ElementPaint,fillPaint: null == fillPaint ? _self.fillPaint : fillPaint // ignore: cast_nullable_to_non_nullable
as ElementPaint,
  ));
}

/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementPaintCopyWith<$Res> get paint {
  
  return $ElementPaintCopyWith<$Res>(_self.paint, (value) {
    return _then(_self.copyWith(paint: value));
  });
}/// Create a copy of Property
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementPaintCopyWith<$Res> get fillPaint {
  
  return $ElementPaintCopyWith<$Res>(_self.fillPaint, (value) {
    return _then(_self.copyWith(fillPaint: value));
  });
}
}

PathShape _$PathShapeFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'circle':
          return CircleShape.fromJson(
            json
          );
                case 'rectangle':
          return RectangleShape.fromJson(
            json
          );
                case 'line':
          return LineShape.fromJson(
            json
          );
                case 'triangle':
          return TriangleShape.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'PathShape',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$PathShape {



  /// Serializes this PathShape to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PathShape);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PathShape()';
}


}

/// @nodoc
class $PathShapeCopyWith<$Res>  {
$PathShapeCopyWith(PathShape _, $Res Function(PathShape) __);
}



/// @nodoc
@JsonSerializable()

class CircleShape extends PathShape {
  const CircleShape({this.fillPaint = const ElementPaint.solid(color: SRGBColor.transparent), final  String? $type}): $type = $type ?? 'circle',super._();
  factory CircleShape.fromJson(Map<String, dynamic> json) => _$CircleShapeFromJson(json);

@JsonKey() final  ElementPaint fillPaint;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of PathShape
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CircleShapeCopyWith<CircleShape> get copyWith => _$CircleShapeCopyWithImpl<CircleShape>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CircleShapeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CircleShape&&(identical(other.fillPaint, fillPaint) || other.fillPaint == fillPaint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fillPaint);

@override
String toString() {
  return 'PathShape.circle(fillPaint: $fillPaint)';
}


}

/// @nodoc
abstract mixin class $CircleShapeCopyWith<$Res> implements $PathShapeCopyWith<$Res> {
  factory $CircleShapeCopyWith(CircleShape value, $Res Function(CircleShape) _then) = _$CircleShapeCopyWithImpl;
@useResult
$Res call({
 ElementPaint fillPaint
});


$ElementPaintCopyWith<$Res> get fillPaint;

}
/// @nodoc
class _$CircleShapeCopyWithImpl<$Res>
    implements $CircleShapeCopyWith<$Res> {
  _$CircleShapeCopyWithImpl(this._self, this._then);

  final CircleShape _self;
  final $Res Function(CircleShape) _then;

/// Create a copy of PathShape
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fillPaint = null,}) {
  return _then(CircleShape(
fillPaint: null == fillPaint ? _self.fillPaint : fillPaint // ignore: cast_nullable_to_non_nullable
as ElementPaint,
  ));
}

/// Create a copy of PathShape
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementPaintCopyWith<$Res> get fillPaint {
  
  return $ElementPaintCopyWith<$Res>(_self.fillPaint, (value) {
    return _then(_self.copyWith(fillPaint: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class RectangleShape extends PathShape {
  const RectangleShape({this.fillPaint = const ElementPaint.solid(color: SRGBColor.transparent), this.topLeftCornerRadius = 0, this.topRightCornerRadius = 0, this.bottomLeftCornerRadius = 0, this.bottomRightCornerRadius = 0, final  String? $type}): $type = $type ?? 'rectangle',super._();
  factory RectangleShape.fromJson(Map<String, dynamic> json) => _$RectangleShapeFromJson(json);

@JsonKey() final  ElementPaint fillPaint;
@JsonKey() final  double topLeftCornerRadius;
@JsonKey() final  double topRightCornerRadius;
@JsonKey() final  double bottomLeftCornerRadius;
@JsonKey() final  double bottomRightCornerRadius;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of PathShape
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RectangleShapeCopyWith<RectangleShape> get copyWith => _$RectangleShapeCopyWithImpl<RectangleShape>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RectangleShapeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RectangleShape&&(identical(other.fillPaint, fillPaint) || other.fillPaint == fillPaint)&&(identical(other.topLeftCornerRadius, topLeftCornerRadius) || other.topLeftCornerRadius == topLeftCornerRadius)&&(identical(other.topRightCornerRadius, topRightCornerRadius) || other.topRightCornerRadius == topRightCornerRadius)&&(identical(other.bottomLeftCornerRadius, bottomLeftCornerRadius) || other.bottomLeftCornerRadius == bottomLeftCornerRadius)&&(identical(other.bottomRightCornerRadius, bottomRightCornerRadius) || other.bottomRightCornerRadius == bottomRightCornerRadius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fillPaint,topLeftCornerRadius,topRightCornerRadius,bottomLeftCornerRadius,bottomRightCornerRadius);

@override
String toString() {
  return 'PathShape.rectangle(fillPaint: $fillPaint, topLeftCornerRadius: $topLeftCornerRadius, topRightCornerRadius: $topRightCornerRadius, bottomLeftCornerRadius: $bottomLeftCornerRadius, bottomRightCornerRadius: $bottomRightCornerRadius)';
}


}

/// @nodoc
abstract mixin class $RectangleShapeCopyWith<$Res> implements $PathShapeCopyWith<$Res> {
  factory $RectangleShapeCopyWith(RectangleShape value, $Res Function(RectangleShape) _then) = _$RectangleShapeCopyWithImpl;
@useResult
$Res call({
 ElementPaint fillPaint, double topLeftCornerRadius, double topRightCornerRadius, double bottomLeftCornerRadius, double bottomRightCornerRadius
});


$ElementPaintCopyWith<$Res> get fillPaint;

}
/// @nodoc
class _$RectangleShapeCopyWithImpl<$Res>
    implements $RectangleShapeCopyWith<$Res> {
  _$RectangleShapeCopyWithImpl(this._self, this._then);

  final RectangleShape _self;
  final $Res Function(RectangleShape) _then;

/// Create a copy of PathShape
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fillPaint = null,Object? topLeftCornerRadius = null,Object? topRightCornerRadius = null,Object? bottomLeftCornerRadius = null,Object? bottomRightCornerRadius = null,}) {
  return _then(RectangleShape(
fillPaint: null == fillPaint ? _self.fillPaint : fillPaint // ignore: cast_nullable_to_non_nullable
as ElementPaint,topLeftCornerRadius: null == topLeftCornerRadius ? _self.topLeftCornerRadius : topLeftCornerRadius // ignore: cast_nullable_to_non_nullable
as double,topRightCornerRadius: null == topRightCornerRadius ? _self.topRightCornerRadius : topRightCornerRadius // ignore: cast_nullable_to_non_nullable
as double,bottomLeftCornerRadius: null == bottomLeftCornerRadius ? _self.bottomLeftCornerRadius : bottomLeftCornerRadius // ignore: cast_nullable_to_non_nullable
as double,bottomRightCornerRadius: null == bottomRightCornerRadius ? _self.bottomRightCornerRadius : bottomRightCornerRadius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of PathShape
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementPaintCopyWith<$Res> get fillPaint {
  
  return $ElementPaintCopyWith<$Res>(_self.fillPaint, (value) {
    return _then(_self.copyWith(fillPaint: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class LineShape extends PathShape {
  const LineShape({final  String? $type}): $type = $type ?? 'line',super._();
  factory LineShape.fromJson(Map<String, dynamic> json) => _$LineShapeFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$LineShapeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineShape);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PathShape.line()';
}


}




/// @nodoc
@JsonSerializable()

class TriangleShape extends PathShape {
  const TriangleShape({this.fillPaint = const ElementPaint.solid(color: SRGBColor.transparent), final  String? $type}): $type = $type ?? 'triangle',super._();
  factory TriangleShape.fromJson(Map<String, dynamic> json) => _$TriangleShapeFromJson(json);

@JsonKey() final  ElementPaint fillPaint;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of PathShape
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TriangleShapeCopyWith<TriangleShape> get copyWith => _$TriangleShapeCopyWithImpl<TriangleShape>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TriangleShapeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TriangleShape&&(identical(other.fillPaint, fillPaint) || other.fillPaint == fillPaint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fillPaint);

@override
String toString() {
  return 'PathShape.triangle(fillPaint: $fillPaint)';
}


}

/// @nodoc
abstract mixin class $TriangleShapeCopyWith<$Res> implements $PathShapeCopyWith<$Res> {
  factory $TriangleShapeCopyWith(TriangleShape value, $Res Function(TriangleShape) _then) = _$TriangleShapeCopyWithImpl;
@useResult
$Res call({
 ElementPaint fillPaint
});


$ElementPaintCopyWith<$Res> get fillPaint;

}
/// @nodoc
class _$TriangleShapeCopyWithImpl<$Res>
    implements $TriangleShapeCopyWith<$Res> {
  _$TriangleShapeCopyWithImpl(this._self, this._then);

  final TriangleShape _self;
  final $Res Function(TriangleShape) _then;

/// Create a copy of PathShape
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fillPaint = null,}) {
  return _then(TriangleShape(
fillPaint: null == fillPaint ? _self.fillPaint : fillPaint // ignore: cast_nullable_to_non_nullable
as ElementPaint,
  ));
}

/// Create a copy of PathShape
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementPaintCopyWith<$Res> get fillPaint {
  
  return $ElementPaintCopyWith<$Res>(_self.fillPaint, (value) {
    return _then(_self.copyWith(fillPaint: value));
  });
}
}

// dart format on
