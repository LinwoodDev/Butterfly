// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ElementConstraint {

 double get size; double get length; bool get includeArea;
/// Create a copy of ElementConstraint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElementConstraintCopyWith<ElementConstraint> get copyWith => _$ElementConstraintCopyWithImpl<ElementConstraint>(this as ElementConstraint, _$identity);

  /// Serializes this ElementConstraint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementConstraint&&(identical(other.size, size) || other.size == size)&&(identical(other.length, length) || other.length == length)&&(identical(other.includeArea, includeArea) || other.includeArea == includeArea));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,size,length,includeArea);

@override
String toString() {
  return 'ElementConstraint(size: $size, length: $length, includeArea: $includeArea)';
}


}

/// @nodoc
abstract mixin class $ElementConstraintCopyWith<$Res>  {
  factory $ElementConstraintCopyWith(ElementConstraint value, $Res Function(ElementConstraint) _then) = _$ElementConstraintCopyWithImpl;
@useResult
$Res call({
 double size, double length, bool includeArea
});




}
/// @nodoc
class _$ElementConstraintCopyWithImpl<$Res>
    implements $ElementConstraintCopyWith<$Res> {
  _$ElementConstraintCopyWithImpl(this._self, this._then);

  final ElementConstraint _self;
  final $Res Function(ElementConstraint) _then;

/// Create a copy of ElementConstraint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? size = null,Object? length = null,Object? includeArea = null,}) {
  return _then(_self.copyWith(
size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,includeArea: null == includeArea ? _self.includeArea : includeArea // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _ElementConstraint implements ElementConstraint {
  const _ElementConstraint({this.size = 0, this.length = 0, this.includeArea = true});
  factory _ElementConstraint.fromJson(Map<String, dynamic> json) => _$ElementConstraintFromJson(json);

@override@JsonKey() final  double size;
@override@JsonKey() final  double length;
@override@JsonKey() final  bool includeArea;

/// Create a copy of ElementConstraint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElementConstraintCopyWith<_ElementConstraint> get copyWith => __$ElementConstraintCopyWithImpl<_ElementConstraint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElementConstraintToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElementConstraint&&(identical(other.size, size) || other.size == size)&&(identical(other.length, length) || other.length == length)&&(identical(other.includeArea, includeArea) || other.includeArea == includeArea));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,size,length,includeArea);

@override
String toString() {
  return 'ElementConstraint(size: $size, length: $length, includeArea: $includeArea)';
}


}

/// @nodoc
abstract mixin class _$ElementConstraintCopyWith<$Res> implements $ElementConstraintCopyWith<$Res> {
  factory _$ElementConstraintCopyWith(_ElementConstraint value, $Res Function(_ElementConstraint) _then) = __$ElementConstraintCopyWithImpl;
@override @useResult
$Res call({
 double size, double length, bool includeArea
});




}
/// @nodoc
class __$ElementConstraintCopyWithImpl<$Res>
    implements _$ElementConstraintCopyWith<$Res> {
  __$ElementConstraintCopyWithImpl(this._self, this._then);

  final _ElementConstraint _self;
  final $Res Function(_ElementConstraint) _then;

/// Create a copy of ElementConstraint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? size = null,Object? length = null,Object? includeArea = null,}) {
  return _then(_ElementConstraint(
size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,includeArea: null == includeArea ? _self.includeArea : includeArea // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

ElementConstraints _$ElementConstraintsFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'scaled':
          return ScaledElementConstraints.fromJson(
            json
          );
                case 'fixed':
          return FixedElementConstraints.fromJson(
            json
          );
                case 'dynamic':
          return DynamicElementConstraints.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'ElementConstraints',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$ElementConstraints {



  /// Serializes this ElementConstraints to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElementConstraints);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ElementConstraints()';
}


}

/// @nodoc
class $ElementConstraintsCopyWith<$Res>  {
$ElementConstraintsCopyWith(ElementConstraints _, $Res Function(ElementConstraints) __);
}



/// @nodoc
@JsonSerializable()

class ScaledElementConstraints implements ElementConstraints {
  const ScaledElementConstraints({this.scaleX = 1, this.scaleY = 1, final  String? $type}): $type = $type ?? 'scaled';
  factory ScaledElementConstraints.fromJson(Map<String, dynamic> json) => _$ScaledElementConstraintsFromJson(json);

@JsonKey() final  double scaleX;
@JsonKey() final  double scaleY;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ElementConstraints
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScaledElementConstraintsCopyWith<ScaledElementConstraints> get copyWith => _$ScaledElementConstraintsCopyWithImpl<ScaledElementConstraints>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScaledElementConstraintsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScaledElementConstraints&&(identical(other.scaleX, scaleX) || other.scaleX == scaleX)&&(identical(other.scaleY, scaleY) || other.scaleY == scaleY));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scaleX,scaleY);

@override
String toString() {
  return 'ElementConstraints.scaled(scaleX: $scaleX, scaleY: $scaleY)';
}


}

/// @nodoc
abstract mixin class $ScaledElementConstraintsCopyWith<$Res> implements $ElementConstraintsCopyWith<$Res> {
  factory $ScaledElementConstraintsCopyWith(ScaledElementConstraints value, $Res Function(ScaledElementConstraints) _then) = _$ScaledElementConstraintsCopyWithImpl;
@useResult
$Res call({
 double scaleX, double scaleY
});




}
/// @nodoc
class _$ScaledElementConstraintsCopyWithImpl<$Res>
    implements $ScaledElementConstraintsCopyWith<$Res> {
  _$ScaledElementConstraintsCopyWithImpl(this._self, this._then);

  final ScaledElementConstraints _self;
  final $Res Function(ScaledElementConstraints) _then;

/// Create a copy of ElementConstraints
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? scaleX = null,Object? scaleY = null,}) {
  return _then(ScaledElementConstraints(
scaleX: null == scaleX ? _self.scaleX : scaleX // ignore: cast_nullable_to_non_nullable
as double,scaleY: null == scaleY ? _self.scaleY : scaleY // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FixedElementConstraints implements ElementConstraints {
  const FixedElementConstraints(this.height, this.width, {final  String? $type}): $type = $type ?? 'fixed';
  factory FixedElementConstraints.fromJson(Map<String, dynamic> json) => _$FixedElementConstraintsFromJson(json);

 final  double height;
 final  double width;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ElementConstraints
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FixedElementConstraintsCopyWith<FixedElementConstraints> get copyWith => _$FixedElementConstraintsCopyWithImpl<FixedElementConstraints>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FixedElementConstraintsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FixedElementConstraints&&(identical(other.height, height) || other.height == height)&&(identical(other.width, width) || other.width == width));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,height,width);

@override
String toString() {
  return 'ElementConstraints.fixed(height: $height, width: $width)';
}


}

/// @nodoc
abstract mixin class $FixedElementConstraintsCopyWith<$Res> implements $ElementConstraintsCopyWith<$Res> {
  factory $FixedElementConstraintsCopyWith(FixedElementConstraints value, $Res Function(FixedElementConstraints) _then) = _$FixedElementConstraintsCopyWithImpl;
@useResult
$Res call({
 double height, double width
});




}
/// @nodoc
class _$FixedElementConstraintsCopyWithImpl<$Res>
    implements $FixedElementConstraintsCopyWith<$Res> {
  _$FixedElementConstraintsCopyWithImpl(this._self, this._then);

  final FixedElementConstraints _self;
  final $Res Function(FixedElementConstraints) _then;

/// Create a copy of ElementConstraints
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? height = null,Object? width = null,}) {
  return _then(FixedElementConstraints(
null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
@JsonSerializable()

class DynamicElementConstraints implements ElementConstraints {
  const DynamicElementConstraints({this.height = 0, this.width = 0, this.aspectRatio = 0, this.includeArea = true, final  String? $type}): $type = $type ?? 'dynamic';
  factory DynamicElementConstraints.fromJson(Map<String, dynamic> json) => _$DynamicElementConstraintsFromJson(json);

@JsonKey() final  double height;
@JsonKey() final  double width;
@JsonKey() final  double aspectRatio;
@JsonKey() final  bool includeArea;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ElementConstraints
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DynamicElementConstraintsCopyWith<DynamicElementConstraints> get copyWith => _$DynamicElementConstraintsCopyWithImpl<DynamicElementConstraints>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DynamicElementConstraintsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DynamicElementConstraints&&(identical(other.height, height) || other.height == height)&&(identical(other.width, width) || other.width == width)&&(identical(other.aspectRatio, aspectRatio) || other.aspectRatio == aspectRatio)&&(identical(other.includeArea, includeArea) || other.includeArea == includeArea));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,height,width,aspectRatio,includeArea);

@override
String toString() {
  return 'ElementConstraints.dynamic(height: $height, width: $width, aspectRatio: $aspectRatio, includeArea: $includeArea)';
}


}

/// @nodoc
abstract mixin class $DynamicElementConstraintsCopyWith<$Res> implements $ElementConstraintsCopyWith<$Res> {
  factory $DynamicElementConstraintsCopyWith(DynamicElementConstraints value, $Res Function(DynamicElementConstraints) _then) = _$DynamicElementConstraintsCopyWithImpl;
@useResult
$Res call({
 double height, double width, double aspectRatio, bool includeArea
});




}
/// @nodoc
class _$DynamicElementConstraintsCopyWithImpl<$Res>
    implements $DynamicElementConstraintsCopyWith<$Res> {
  _$DynamicElementConstraintsCopyWithImpl(this._self, this._then);

  final DynamicElementConstraints _self;
  final $Res Function(DynamicElementConstraints) _then;

/// Create a copy of ElementConstraints
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? height = null,Object? width = null,Object? aspectRatio = null,Object? includeArea = null,}) {
  return _then(DynamicElementConstraints(
height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,aspectRatio: null == aspectRatio ? _self.aspectRatio : aspectRatio // ignore: cast_nullable_to_non_nullable
as double,includeArea: null == includeArea ? _self.includeArea : includeArea // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

PadElement _$PadElementFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'pen':
          return PenElement.fromJson(
            json
          );
                case 'text':
          return TextElement.fromJson(
            json
          );
                case 'markdown':
          return MarkdownElement.fromJson(
            json
          );
                case 'image':
          return ImageElement.fromJson(
            json
          );
                case 'pdf':
          return PdfElement.fromJson(
            json
          );
                case 'svg':
          return SvgElement.fromJson(
            json
          );
                case 'shape':
          return ShapeElement.fromJson(
            json
          );
                case 'texture':
          return TextureElement.fromJson(
            json
          );
                case 'polygon':
          return PolygonElement.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'PadElement',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$PadElement {

 double get rotation; String get collection;@IdJsonConverter() String? get id; Map<String, dynamic> get extra;
/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PadElementCopyWith<PadElement> get copyWith => _$PadElementCopyWithImpl<PadElement>(this as PadElement, _$identity);

  /// Serializes this PadElement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PadElement&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.extra, extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rotation,collection,id,const DeepCollectionEquality().hash(extra));

@override
String toString() {
  return 'PadElement(rotation: $rotation, collection: $collection, id: $id, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $PadElementCopyWith<$Res>  {
  factory $PadElementCopyWith(PadElement value, $Res Function(PadElement) _then) = _$PadElementCopyWithImpl;
@useResult
$Res call({
 double rotation, String collection,@IdJsonConverter() String? id, Map<String, dynamic> extra
});




}
/// @nodoc
class _$PadElementCopyWithImpl<$Res>
    implements $PadElementCopyWith<$Res> {
  _$PadElementCopyWithImpl(this._self, this._then);

  final PadElement _self;
  final $Res Function(PadElement) _then;

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rotation = null,Object? collection = null,Object? id = freezed,Object? extra = null,}) {
  return _then(_self.copyWith(
rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,extra: null == extra ? _self.extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}



/// @nodoc
@JsonSerializable()

class PenElement extends PadElement implements PathElement {
   PenElement({this.rotation = 0, this.collection = '', @IdJsonConverter() this.id, this.zoom, final  List<PathPoint> points = const [], this.property = const PenProperty(), final  Map<String, dynamic> extra = const {}, final  String? $type}): _points = points,_extra = extra,$type = $type ?? 'pen',super._();
  factory PenElement.fromJson(Map<String, dynamic> json) => _$PenElementFromJson(json);

@override@JsonKey() final  double rotation;
@override@JsonKey() final  String collection;
@override@IdJsonConverter() final  String? id;
 final  double? zoom;
 final  List<PathPoint> _points;
@JsonKey() List<PathPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

@JsonKey() final  PenProperty property;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PenElementCopyWith<PenElement> get copyWith => _$PenElementCopyWithImpl<PenElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PenElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PenElement&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.id, id) || other.id == id)&&(identical(other.zoom, zoom) || other.zoom == zoom)&&const DeepCollectionEquality().equals(other._points, _points)&&const DeepCollectionEquality().equals(other.property, property)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rotation,collection,id,zoom,const DeepCollectionEquality().hash(_points),const DeepCollectionEquality().hash(property),const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'PadElement.pen(rotation: $rotation, collection: $collection, id: $id, zoom: $zoom, points: $points, property: $property, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $PenElementCopyWith<$Res> implements $PadElementCopyWith<$Res> {
  factory $PenElementCopyWith(PenElement value, $Res Function(PenElement) _then) = _$PenElementCopyWithImpl;
@override @useResult
$Res call({
 double rotation, String collection,@IdJsonConverter() String? id, double? zoom, List<PathPoint> points, PenProperty property, Map<String, dynamic> extra
});




}
/// @nodoc
class _$PenElementCopyWithImpl<$Res>
    implements $PenElementCopyWith<$Res> {
  _$PenElementCopyWithImpl(this._self, this._then);

  final PenElement _self;
  final $Res Function(PenElement) _then;

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotation = null,Object? collection = null,Object? id = freezed,Object? zoom = freezed,Object? points = null,Object? property = freezed,Object? extra = null,}) {
  return _then(PenElement(
rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,zoom: freezed == zoom ? _self.zoom : zoom // ignore: cast_nullable_to_non_nullable
as double?,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<PathPoint>,property: freezed == property ? _self.property : property // ignore: cast_nullable_to_non_nullable
as PenProperty,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TextElement extends PadElement with LabelElement {
   TextElement({this.rotation = 0, this.collection = '', @IdJsonConverter() this.id, @DoublePointJsonConverter() this.position = const Point(0.0, 0.0), this.scale = 1.0, this.styleSheet, required this.area, this.constraint = const ElementConstraint(size: 1000), @ColorJsonConverter() this.foreground = SRGBColor.black, final  Map<String, dynamic> extra = const {}, final  String? $type}): _extra = extra,$type = $type ?? 'text',super._();
  factory TextElement.fromJson(Map<String, dynamic> json) => _$TextElementFromJson(json);

@override@JsonKey() final  double rotation;
@override@JsonKey() final  String collection;
@override@IdJsonConverter() final  String? id;
@JsonKey()@DoublePointJsonConverter() final  Point<double> position;
@JsonKey() final  double scale;
 final  NamedItem<TextStyleSheet>? styleSheet;
 final  TextArea area;
@JsonKey() final  ElementConstraint constraint;
@JsonKey()@ColorJsonConverter() final  SRGBColor foreground;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextElementCopyWith<TextElement> get copyWith => _$TextElementCopyWithImpl<TextElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextElement&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.styleSheet, styleSheet) || other.styleSheet == styleSheet)&&(identical(other.area, area) || other.area == area)&&(identical(other.constraint, constraint) || other.constraint == constraint)&&(identical(other.foreground, foreground) || other.foreground == foreground)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rotation,collection,id,position,scale,styleSheet,area,constraint,foreground,const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'PadElement.text(rotation: $rotation, collection: $collection, id: $id, position: $position, scale: $scale, styleSheet: $styleSheet, area: $area, constraint: $constraint, foreground: $foreground, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $TextElementCopyWith<$Res> implements $PadElementCopyWith<$Res> {
  factory $TextElementCopyWith(TextElement value, $Res Function(TextElement) _then) = _$TextElementCopyWithImpl;
@override @useResult
$Res call({
 double rotation, String collection,@IdJsonConverter() String? id,@DoublePointJsonConverter() Point<double> position, double scale, NamedItem<TextStyleSheet>? styleSheet, TextArea area, ElementConstraint constraint,@ColorJsonConverter() SRGBColor foreground, Map<String, dynamic> extra
});


$NamedItemCopyWith<TextStyleSheet, $Res>? get styleSheet;$TextAreaCopyWith<$Res> get area;$ElementConstraintCopyWith<$Res> get constraint;

}
/// @nodoc
class _$TextElementCopyWithImpl<$Res>
    implements $TextElementCopyWith<$Res> {
  _$TextElementCopyWithImpl(this._self, this._then);

  final TextElement _self;
  final $Res Function(TextElement) _then;

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotation = null,Object? collection = null,Object? id = freezed,Object? position = null,Object? scale = null,Object? styleSheet = freezed,Object? area = null,Object? constraint = null,Object? foreground = null,Object? extra = null,}) {
  return _then(TextElement(
rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Point<double>,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,styleSheet: freezed == styleSheet ? _self.styleSheet : styleSheet // ignore: cast_nullable_to_non_nullable
as NamedItem<TextStyleSheet>?,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as TextArea,constraint: null == constraint ? _self.constraint : constraint // ignore: cast_nullable_to_non_nullable
as ElementConstraint,foreground: null == foreground ? _self.foreground : foreground // ignore: cast_nullable_to_non_nullable
as SRGBColor,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedItemCopyWith<TextStyleSheet, $Res>? get styleSheet {
    if (_self.styleSheet == null) {
    return null;
  }

  return $NamedItemCopyWith<TextStyleSheet, $Res>(_self.styleSheet!, (value) {
    return _then(_self.copyWith(styleSheet: value));
  });
}/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextAreaCopyWith<$Res> get area {
  
  return $TextAreaCopyWith<$Res>(_self.area, (value) {
    return _then(_self.copyWith(area: value));
  });
}/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementConstraintCopyWith<$Res> get constraint {
  
  return $ElementConstraintCopyWith<$Res>(_self.constraint, (value) {
    return _then(_self.copyWith(constraint: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class MarkdownElement extends PadElement with LabelElement {
   MarkdownElement({this.rotation = 0, this.collection = '', @IdJsonConverter() this.id, @DoublePointJsonConverter() this.position = const Point(0.0, 0.0), this.scale = 1.0, this.styleSheet, this.areaProperty = const AreaProperty(), required this.text, this.constraint = const ElementConstraint(size: 1000), @ColorJsonConverter() this.foreground = SRGBColor.black, final  Map<String, dynamic> extra = const {}, final  String? $type}): _extra = extra,$type = $type ?? 'markdown',super._();
  factory MarkdownElement.fromJson(Map<String, dynamic> json) => _$MarkdownElementFromJson(json);

@override@JsonKey() final  double rotation;
@override@JsonKey() final  String collection;
@override@IdJsonConverter() final  String? id;
@JsonKey()@DoublePointJsonConverter() final  Point<double> position;
@JsonKey() final  double scale;
 final  NamedItem<TextStyleSheet>? styleSheet;
@JsonKey() final  AreaProperty areaProperty;
 final  String text;
@JsonKey() final  ElementConstraint constraint;
@JsonKey()@ColorJsonConverter() final  SRGBColor foreground;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkdownElementCopyWith<MarkdownElement> get copyWith => _$MarkdownElementCopyWithImpl<MarkdownElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarkdownElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkdownElement&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.styleSheet, styleSheet) || other.styleSheet == styleSheet)&&(identical(other.areaProperty, areaProperty) || other.areaProperty == areaProperty)&&(identical(other.text, text) || other.text == text)&&(identical(other.constraint, constraint) || other.constraint == constraint)&&(identical(other.foreground, foreground) || other.foreground == foreground)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rotation,collection,id,position,scale,styleSheet,areaProperty,text,constraint,foreground,const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'PadElement.markdown(rotation: $rotation, collection: $collection, id: $id, position: $position, scale: $scale, styleSheet: $styleSheet, areaProperty: $areaProperty, text: $text, constraint: $constraint, foreground: $foreground, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $MarkdownElementCopyWith<$Res> implements $PadElementCopyWith<$Res> {
  factory $MarkdownElementCopyWith(MarkdownElement value, $Res Function(MarkdownElement) _then) = _$MarkdownElementCopyWithImpl;
@override @useResult
$Res call({
 double rotation, String collection,@IdJsonConverter() String? id,@DoublePointJsonConverter() Point<double> position, double scale, NamedItem<TextStyleSheet>? styleSheet, AreaProperty areaProperty, String text, ElementConstraint constraint,@ColorJsonConverter() SRGBColor foreground, Map<String, dynamic> extra
});


$NamedItemCopyWith<TextStyleSheet, $Res>? get styleSheet;$AreaPropertyCopyWith<$Res> get areaProperty;$ElementConstraintCopyWith<$Res> get constraint;

}
/// @nodoc
class _$MarkdownElementCopyWithImpl<$Res>
    implements $MarkdownElementCopyWith<$Res> {
  _$MarkdownElementCopyWithImpl(this._self, this._then);

  final MarkdownElement _self;
  final $Res Function(MarkdownElement) _then;

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotation = null,Object? collection = null,Object? id = freezed,Object? position = null,Object? scale = null,Object? styleSheet = freezed,Object? areaProperty = null,Object? text = null,Object? constraint = null,Object? foreground = null,Object? extra = null,}) {
  return _then(MarkdownElement(
rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Point<double>,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,styleSheet: freezed == styleSheet ? _self.styleSheet : styleSheet // ignore: cast_nullable_to_non_nullable
as NamedItem<TextStyleSheet>?,areaProperty: null == areaProperty ? _self.areaProperty : areaProperty // ignore: cast_nullable_to_non_nullable
as AreaProperty,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,constraint: null == constraint ? _self.constraint : constraint // ignore: cast_nullable_to_non_nullable
as ElementConstraint,foreground: null == foreground ? _self.foreground : foreground // ignore: cast_nullable_to_non_nullable
as SRGBColor,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NamedItemCopyWith<TextStyleSheet, $Res>? get styleSheet {
    if (_self.styleSheet == null) {
    return null;
  }

  return $NamedItemCopyWith<TextStyleSheet, $Res>(_self.styleSheet!, (value) {
    return _then(_self.copyWith(styleSheet: value));
  });
}/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AreaPropertyCopyWith<$Res> get areaProperty {
  
  return $AreaPropertyCopyWith<$Res>(_self.areaProperty, (value) {
    return _then(_self.copyWith(areaProperty: value));
  });
}/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementConstraintCopyWith<$Res> get constraint {
  
  return $ElementConstraintCopyWith<$Res>(_self.constraint, (value) {
    return _then(_self.copyWith(constraint: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ImageElement extends PadElement implements SourcedElement {
   ImageElement({this.rotation = 0, this.collection = '', @IdJsonConverter() this.id, @DoublePointJsonConverter() this.position = const Point(0.0, 0.0), this.constraints = const ScaledElementConstraints(scaleX: 1, scaleY: 1), required this.source, required this.width, required this.height, final  Map<String, dynamic> extra = const {}, final  String? $type}): _extra = extra,$type = $type ?? 'image',super._();
  factory ImageElement.fromJson(Map<String, dynamic> json) => _$ImageElementFromJson(json);

@override@JsonKey() final  double rotation;
@override@JsonKey() final  String collection;
@override@IdJsonConverter() final  String? id;
@JsonKey()@DoublePointJsonConverter() final  Point<double> position;
@JsonKey() final  ElementConstraints? constraints;
 final  String source;
 final  double width;
 final  double height;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageElementCopyWith<ImageElement> get copyWith => _$ImageElementCopyWithImpl<ImageElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageElement&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.constraints, constraints) || other.constraints == constraints)&&(identical(other.source, source) || other.source == source)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rotation,collection,id,position,constraints,source,width,height,const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'PadElement.image(rotation: $rotation, collection: $collection, id: $id, position: $position, constraints: $constraints, source: $source, width: $width, height: $height, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $ImageElementCopyWith<$Res> implements $PadElementCopyWith<$Res> {
  factory $ImageElementCopyWith(ImageElement value, $Res Function(ImageElement) _then) = _$ImageElementCopyWithImpl;
@override @useResult
$Res call({
 double rotation, String collection,@IdJsonConverter() String? id,@DoublePointJsonConverter() Point<double> position, ElementConstraints? constraints, String source, double width, double height, Map<String, dynamic> extra
});


$ElementConstraintsCopyWith<$Res>? get constraints;

}
/// @nodoc
class _$ImageElementCopyWithImpl<$Res>
    implements $ImageElementCopyWith<$Res> {
  _$ImageElementCopyWithImpl(this._self, this._then);

  final ImageElement _self;
  final $Res Function(ImageElement) _then;

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotation = null,Object? collection = null,Object? id = freezed,Object? position = null,Object? constraints = freezed,Object? source = null,Object? width = null,Object? height = null,Object? extra = null,}) {
  return _then(ImageElement(
rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Point<double>,constraints: freezed == constraints ? _self.constraints : constraints // ignore: cast_nullable_to_non_nullable
as ElementConstraints?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementConstraintsCopyWith<$Res>? get constraints {
    if (_self.constraints == null) {
    return null;
  }

  return $ElementConstraintsCopyWith<$Res>(_self.constraints!, (value) {
    return _then(_self.copyWith(constraints: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class PdfElement extends PadElement implements SourcedElement {
   PdfElement({this.rotation = 0, this.collection = '', @IdJsonConverter() this.id, @DoublePointJsonConverter() this.position = const Point(0.0, 0.0), this.constraints = const ScaledElementConstraints(scaleX: 1, scaleY: 1), required this.source, this.page = 0, required this.width, required this.height, this.invert = false, @ColorJsonConverter() this.background = SRGBColor.transparent, final  Map<String, dynamic> extra = const {}, final  String? $type}): _extra = extra,$type = $type ?? 'pdf',super._();
  factory PdfElement.fromJson(Map<String, dynamic> json) => _$PdfElementFromJson(json);

@override@JsonKey() final  double rotation;
@override@JsonKey() final  String collection;
@override@IdJsonConverter() final  String? id;
@JsonKey()@DoublePointJsonConverter() final  Point<double> position;
@JsonKey() final  ElementConstraints? constraints;
 final  String source;
@JsonKey() final  int page;
 final  double width;
 final  double height;
@JsonKey() final  bool invert;
@JsonKey()@ColorJsonConverter() final  SRGBColor background;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PdfElementCopyWith<PdfElement> get copyWith => _$PdfElementCopyWithImpl<PdfElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PdfElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PdfElement&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.constraints, constraints) || other.constraints == constraints)&&(identical(other.source, source) || other.source == source)&&(identical(other.page, page) || other.page == page)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.invert, invert) || other.invert == invert)&&(identical(other.background, background) || other.background == background)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rotation,collection,id,position,constraints,source,page,width,height,invert,background,const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'PadElement.pdf(rotation: $rotation, collection: $collection, id: $id, position: $position, constraints: $constraints, source: $source, page: $page, width: $width, height: $height, invert: $invert, background: $background, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $PdfElementCopyWith<$Res> implements $PadElementCopyWith<$Res> {
  factory $PdfElementCopyWith(PdfElement value, $Res Function(PdfElement) _then) = _$PdfElementCopyWithImpl;
@override @useResult
$Res call({
 double rotation, String collection,@IdJsonConverter() String? id,@DoublePointJsonConverter() Point<double> position, ElementConstraints? constraints, String source, int page, double width, double height, bool invert,@ColorJsonConverter() SRGBColor background, Map<String, dynamic> extra
});


$ElementConstraintsCopyWith<$Res>? get constraints;

}
/// @nodoc
class _$PdfElementCopyWithImpl<$Res>
    implements $PdfElementCopyWith<$Res> {
  _$PdfElementCopyWithImpl(this._self, this._then);

  final PdfElement _self;
  final $Res Function(PdfElement) _then;

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotation = null,Object? collection = null,Object? id = freezed,Object? position = null,Object? constraints = freezed,Object? source = null,Object? page = null,Object? width = null,Object? height = null,Object? invert = null,Object? background = null,Object? extra = null,}) {
  return _then(PdfElement(
rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Point<double>,constraints: freezed == constraints ? _self.constraints : constraints // ignore: cast_nullable_to_non_nullable
as ElementConstraints?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,invert: null == invert ? _self.invert : invert // ignore: cast_nullable_to_non_nullable
as bool,background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as SRGBColor,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementConstraintsCopyWith<$Res>? get constraints {
    if (_self.constraints == null) {
    return null;
  }

  return $ElementConstraintsCopyWith<$Res>(_self.constraints!, (value) {
    return _then(_self.copyWith(constraints: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class SvgElement extends PadElement implements SourcedElement {
   SvgElement({this.rotation = 0, this.collection = '', @IdJsonConverter() this.id, @DoublePointJsonConverter() this.position = const Point(0.0, 0.0), this.constraints = const ScaledElementConstraints(scaleX: 1, scaleY: 1), required this.source, required this.width, required this.height, final  Map<String, dynamic> extra = const {}, final  String? $type}): _extra = extra,$type = $type ?? 'svg',super._();
  factory SvgElement.fromJson(Map<String, dynamic> json) => _$SvgElementFromJson(json);

@override@JsonKey() final  double rotation;
@override@JsonKey() final  String collection;
@override@IdJsonConverter() final  String? id;
@JsonKey()@DoublePointJsonConverter() final  Point<double> position;
@JsonKey() final  ElementConstraints? constraints;
 final  String source;
 final  double width;
 final  double height;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SvgElementCopyWith<SvgElement> get copyWith => _$SvgElementCopyWithImpl<SvgElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SvgElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SvgElement&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.id, id) || other.id == id)&&(identical(other.position, position) || other.position == position)&&(identical(other.constraints, constraints) || other.constraints == constraints)&&(identical(other.source, source) || other.source == source)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rotation,collection,id,position,constraints,source,width,height,const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'PadElement.svg(rotation: $rotation, collection: $collection, id: $id, position: $position, constraints: $constraints, source: $source, width: $width, height: $height, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $SvgElementCopyWith<$Res> implements $PadElementCopyWith<$Res> {
  factory $SvgElementCopyWith(SvgElement value, $Res Function(SvgElement) _then) = _$SvgElementCopyWithImpl;
@override @useResult
$Res call({
 double rotation, String collection,@IdJsonConverter() String? id,@DoublePointJsonConverter() Point<double> position, ElementConstraints? constraints, String source, double width, double height, Map<String, dynamic> extra
});


$ElementConstraintsCopyWith<$Res>? get constraints;

}
/// @nodoc
class _$SvgElementCopyWithImpl<$Res>
    implements $SvgElementCopyWith<$Res> {
  _$SvgElementCopyWithImpl(this._self, this._then);

  final SvgElement _self;
  final $Res Function(SvgElement) _then;

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotation = null,Object? collection = null,Object? id = freezed,Object? position = null,Object? constraints = freezed,Object? source = null,Object? width = null,Object? height = null,Object? extra = null,}) {
  return _then(SvgElement(
rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Point<double>,constraints: freezed == constraints ? _self.constraints : constraints // ignore: cast_nullable_to_non_nullable
as ElementConstraints?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ElementConstraintsCopyWith<$Res>? get constraints {
    if (_self.constraints == null) {
    return null;
  }

  return $ElementConstraintsCopyWith<$Res>(_self.constraints!, (value) {
    return _then(_self.copyWith(constraints: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class ShapeElement extends PadElement {
   ShapeElement({this.rotation = 0, this.collection = '', @IdJsonConverter() this.id, @DoublePointJsonConverter() this.firstPosition = const Point(0.0, 0.0), @DoublePointJsonConverter() this.secondPosition = const Point(0.0, 0.0), this.property = const ShapeProperty(shape: RectangleShape()), final  Map<String, dynamic> extra = const {}, final  String? $type}): _extra = extra,$type = $type ?? 'shape',super._();
  factory ShapeElement.fromJson(Map<String, dynamic> json) => _$ShapeElementFromJson(json);

@override@JsonKey() final  double rotation;
@override@JsonKey() final  String collection;
@override@IdJsonConverter() final  String? id;
@JsonKey()@DoublePointJsonConverter() final  Point<double> firstPosition;
@JsonKey()@DoublePointJsonConverter() final  Point<double> secondPosition;
@JsonKey() final  ShapeProperty property;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShapeElementCopyWith<ShapeElement> get copyWith => _$ShapeElementCopyWithImpl<ShapeElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShapeElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShapeElement&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.id, id) || other.id == id)&&(identical(other.firstPosition, firstPosition) || other.firstPosition == firstPosition)&&(identical(other.secondPosition, secondPosition) || other.secondPosition == secondPosition)&&const DeepCollectionEquality().equals(other.property, property)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rotation,collection,id,firstPosition,secondPosition,const DeepCollectionEquality().hash(property),const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'PadElement.shape(rotation: $rotation, collection: $collection, id: $id, firstPosition: $firstPosition, secondPosition: $secondPosition, property: $property, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $ShapeElementCopyWith<$Res> implements $PadElementCopyWith<$Res> {
  factory $ShapeElementCopyWith(ShapeElement value, $Res Function(ShapeElement) _then) = _$ShapeElementCopyWithImpl;
@override @useResult
$Res call({
 double rotation, String collection,@IdJsonConverter() String? id,@DoublePointJsonConverter() Point<double> firstPosition,@DoublePointJsonConverter() Point<double> secondPosition, ShapeProperty property, Map<String, dynamic> extra
});




}
/// @nodoc
class _$ShapeElementCopyWithImpl<$Res>
    implements $ShapeElementCopyWith<$Res> {
  _$ShapeElementCopyWithImpl(this._self, this._then);

  final ShapeElement _self;
  final $Res Function(ShapeElement) _then;

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotation = null,Object? collection = null,Object? id = freezed,Object? firstPosition = null,Object? secondPosition = null,Object? property = freezed,Object? extra = null,}) {
  return _then(ShapeElement(
rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,firstPosition: null == firstPosition ? _self.firstPosition : firstPosition // ignore: cast_nullable_to_non_nullable
as Point<double>,secondPosition: null == secondPosition ? _self.secondPosition : secondPosition // ignore: cast_nullable_to_non_nullable
as Point<double>,property: freezed == property ? _self.property : property // ignore: cast_nullable_to_non_nullable
as ShapeProperty,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TextureElement extends PadElement {
   TextureElement({this.rotation = 0, this.collection = '', @IdJsonConverter() this.id, this.texture = const SurfaceTexture.pattern(), @DoublePointJsonConverter() this.firstPosition = const Point(0.0, 0.0), @DoublePointJsonConverter() this.secondPosition = const Point(0.0, 0.0), final  Map<String, dynamic> extra = const {}, final  String? $type}): _extra = extra,$type = $type ?? 'texture',super._();
  factory TextureElement.fromJson(Map<String, dynamic> json) => _$TextureElementFromJson(json);

@override@JsonKey() final  double rotation;
@override@JsonKey() final  String collection;
@override@IdJsonConverter() final  String? id;
@JsonKey() final  SurfaceTexture texture;
@JsonKey()@DoublePointJsonConverter() final  Point<double> firstPosition;
@JsonKey()@DoublePointJsonConverter() final  Point<double> secondPosition;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextureElementCopyWith<TextureElement> get copyWith => _$TextureElementCopyWithImpl<TextureElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextureElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextureElement&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.id, id) || other.id == id)&&(identical(other.texture, texture) || other.texture == texture)&&(identical(other.firstPosition, firstPosition) || other.firstPosition == firstPosition)&&(identical(other.secondPosition, secondPosition) || other.secondPosition == secondPosition)&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rotation,collection,id,texture,firstPosition,secondPosition,const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'PadElement.texture(rotation: $rotation, collection: $collection, id: $id, texture: $texture, firstPosition: $firstPosition, secondPosition: $secondPosition, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $TextureElementCopyWith<$Res> implements $PadElementCopyWith<$Res> {
  factory $TextureElementCopyWith(TextureElement value, $Res Function(TextureElement) _then) = _$TextureElementCopyWithImpl;
@override @useResult
$Res call({
 double rotation, String collection,@IdJsonConverter() String? id, SurfaceTexture texture,@DoublePointJsonConverter() Point<double> firstPosition,@DoublePointJsonConverter() Point<double> secondPosition, Map<String, dynamic> extra
});


$SurfaceTextureCopyWith<$Res> get texture;

}
/// @nodoc
class _$TextureElementCopyWithImpl<$Res>
    implements $TextureElementCopyWith<$Res> {
  _$TextureElementCopyWithImpl(this._self, this._then);

  final TextureElement _self;
  final $Res Function(TextureElement) _then;

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotation = null,Object? collection = null,Object? id = freezed,Object? texture = null,Object? firstPosition = null,Object? secondPosition = null,Object? extra = null,}) {
  return _then(TextureElement(
rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,texture: null == texture ? _self.texture : texture // ignore: cast_nullable_to_non_nullable
as SurfaceTexture,firstPosition: null == firstPosition ? _self.firstPosition : firstPosition // ignore: cast_nullable_to_non_nullable
as Point<double>,secondPosition: null == secondPosition ? _self.secondPosition : secondPosition // ignore: cast_nullable_to_non_nullable
as Point<double>,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurfaceTextureCopyWith<$Res> get texture {
  
  return $SurfaceTextureCopyWith<$Res>(_self.texture, (value) {
    return _then(_self.copyWith(texture: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class PolygonElement extends PadElement {
   PolygonElement({this.rotation = 0, this.collection = '', @IdJsonConverter() this.id, final  List<PolygonPoint> points = const [], final  Map<String, dynamic> extra = const {}, this.property = const PolygonProperty(), final  String? $type}): _points = points,_extra = extra,$type = $type ?? 'polygon',super._();
  factory PolygonElement.fromJson(Map<String, dynamic> json) => _$PolygonElementFromJson(json);

@override@JsonKey() final  double rotation;
@override@JsonKey() final  String collection;
@override@IdJsonConverter() final  String? id;
 final  List<PolygonPoint> _points;
@JsonKey() List<PolygonPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}

@JsonKey() final  PolygonProperty property;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PolygonElementCopyWith<PolygonElement> get copyWith => _$PolygonElementCopyWithImpl<PolygonElement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PolygonElementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PolygonElement&&(identical(other.rotation, rotation) || other.rotation == rotation)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._points, _points)&&const DeepCollectionEquality().equals(other._extra, _extra)&&const DeepCollectionEquality().equals(other.property, property));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rotation,collection,id,const DeepCollectionEquality().hash(_points),const DeepCollectionEquality().hash(_extra),const DeepCollectionEquality().hash(property));

@override
String toString() {
  return 'PadElement.polygon(rotation: $rotation, collection: $collection, id: $id, points: $points, extra: $extra, property: $property)';
}


}

/// @nodoc
abstract mixin class $PolygonElementCopyWith<$Res> implements $PadElementCopyWith<$Res> {
  factory $PolygonElementCopyWith(PolygonElement value, $Res Function(PolygonElement) _then) = _$PolygonElementCopyWithImpl;
@override @useResult
$Res call({
 double rotation, String collection,@IdJsonConverter() String? id, List<PolygonPoint> points, Map<String, dynamic> extra, PolygonProperty property
});




}
/// @nodoc
class _$PolygonElementCopyWithImpl<$Res>
    implements $PolygonElementCopyWith<$Res> {
  _$PolygonElementCopyWithImpl(this._self, this._then);

  final PolygonElement _self;
  final $Res Function(PolygonElement) _then;

/// Create a copy of PadElement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rotation = null,Object? collection = null,Object? id = freezed,Object? points = null,Object? extra = null,Object? property = freezed,}) {
  return _then(PolygonElement(
rotation: null == rotation ? _self.rotation : rotation // ignore: cast_nullable_to_non_nullable
as double,collection: null == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<PolygonPoint>,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,property: freezed == property ? _self.property : property // ignore: cast_nullable_to_non_nullable
as PolygonProperty,
  ));
}


}

// dart format on
