// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
SpanProperty _$SpanPropertyFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'defined':
          return DefinedSpanProperty.fromJson(
            json
          );
                case 'named':
          return NamedSpanProperty.fromJson(
            json
          );
                case 'undefined':
          return UndefinedSpanProperty.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'SpanProperty',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$SpanProperty {



  /// Serializes this SpanProperty to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpanProperty);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpanProperty()';
}


}

/// @nodoc
class $SpanPropertyCopyWith<$Res>  {
$SpanPropertyCopyWith(SpanProperty _, $Res Function(SpanProperty) __);
}



/// @nodoc
@JsonSerializable()

class DefinedSpanProperty implements SpanProperty {
  const DefinedSpanProperty({this.size, @ColorJsonConverter() this.color, this.fontWeight, this.lineThrough, this.underline, this.overline, this.italic, this.letterSpacing, @ColorJsonConverter() this.decorationColor, this.decorationStyle, this.decorationThickness, @ColorJsonConverter() this.backgroundColor, final  String? $type}): $type = $type ?? 'defined';
  factory DefinedSpanProperty.fromJson(Map<String, dynamic> json) => _$DefinedSpanPropertyFromJson(json);

 final  double? size;
@ColorJsonConverter() final  SRGBColor? color;
 final  int? fontWeight;
 final  bool? lineThrough;
 final  bool? underline;
 final  bool? overline;
 final  bool? italic;
 final  double? letterSpacing;
@ColorJsonConverter() final  SRGBColor? decorationColor;
 final  TextDecorationStyle? decorationStyle;
 final  double? decorationThickness;
@ColorJsonConverter() final  SRGBColor? backgroundColor;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SpanProperty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DefinedSpanPropertyCopyWith<DefinedSpanProperty> get copyWith => _$DefinedSpanPropertyCopyWithImpl<DefinedSpanProperty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DefinedSpanPropertyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DefinedSpanProperty&&(identical(other.size, size) || other.size == size)&&(identical(other.color, color) || other.color == color)&&(identical(other.fontWeight, fontWeight) || other.fontWeight == fontWeight)&&(identical(other.lineThrough, lineThrough) || other.lineThrough == lineThrough)&&(identical(other.underline, underline) || other.underline == underline)&&(identical(other.overline, overline) || other.overline == overline)&&(identical(other.italic, italic) || other.italic == italic)&&(identical(other.letterSpacing, letterSpacing) || other.letterSpacing == letterSpacing)&&(identical(other.decorationColor, decorationColor) || other.decorationColor == decorationColor)&&(identical(other.decorationStyle, decorationStyle) || other.decorationStyle == decorationStyle)&&(identical(other.decorationThickness, decorationThickness) || other.decorationThickness == decorationThickness)&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,size,color,fontWeight,lineThrough,underline,overline,italic,letterSpacing,decorationColor,decorationStyle,decorationThickness,backgroundColor);

@override
String toString() {
  return 'SpanProperty.defined(size: $size, color: $color, fontWeight: $fontWeight, lineThrough: $lineThrough, underline: $underline, overline: $overline, italic: $italic, letterSpacing: $letterSpacing, decorationColor: $decorationColor, decorationStyle: $decorationStyle, decorationThickness: $decorationThickness, backgroundColor: $backgroundColor)';
}


}

/// @nodoc
abstract mixin class $DefinedSpanPropertyCopyWith<$Res> implements $SpanPropertyCopyWith<$Res> {
  factory $DefinedSpanPropertyCopyWith(DefinedSpanProperty value, $Res Function(DefinedSpanProperty) _then) = _$DefinedSpanPropertyCopyWithImpl;
@useResult
$Res call({
 double? size,@ColorJsonConverter() SRGBColor? color, int? fontWeight, bool? lineThrough, bool? underline, bool? overline, bool? italic, double? letterSpacing,@ColorJsonConverter() SRGBColor? decorationColor, TextDecorationStyle? decorationStyle, double? decorationThickness,@ColorJsonConverter() SRGBColor? backgroundColor
});




}
/// @nodoc
class _$DefinedSpanPropertyCopyWithImpl<$Res>
    implements $DefinedSpanPropertyCopyWith<$Res> {
  _$DefinedSpanPropertyCopyWithImpl(this._self, this._then);

  final DefinedSpanProperty _self;
  final $Res Function(DefinedSpanProperty) _then;

/// Create a copy of SpanProperty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? size = freezed,Object? color = freezed,Object? fontWeight = freezed,Object? lineThrough = freezed,Object? underline = freezed,Object? overline = freezed,Object? italic = freezed,Object? letterSpacing = freezed,Object? decorationColor = freezed,Object? decorationStyle = freezed,Object? decorationThickness = freezed,Object? backgroundColor = freezed,}) {
  return _then(DefinedSpanProperty(
size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as SRGBColor?,fontWeight: freezed == fontWeight ? _self.fontWeight : fontWeight // ignore: cast_nullable_to_non_nullable
as int?,lineThrough: freezed == lineThrough ? _self.lineThrough : lineThrough // ignore: cast_nullable_to_non_nullable
as bool?,underline: freezed == underline ? _self.underline : underline // ignore: cast_nullable_to_non_nullable
as bool?,overline: freezed == overline ? _self.overline : overline // ignore: cast_nullable_to_non_nullable
as bool?,italic: freezed == italic ? _self.italic : italic // ignore: cast_nullable_to_non_nullable
as bool?,letterSpacing: freezed == letterSpacing ? _self.letterSpacing : letterSpacing // ignore: cast_nullable_to_non_nullable
as double?,decorationColor: freezed == decorationColor ? _self.decorationColor : decorationColor // ignore: cast_nullable_to_non_nullable
as SRGBColor?,decorationStyle: freezed == decorationStyle ? _self.decorationStyle : decorationStyle // ignore: cast_nullable_to_non_nullable
as TextDecorationStyle?,decorationThickness: freezed == decorationThickness ? _self.decorationThickness : decorationThickness // ignore: cast_nullable_to_non_nullable
as double?,backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as SRGBColor?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NamedSpanProperty implements SpanProperty {
  const NamedSpanProperty(this.name, {final  String? $type}): $type = $type ?? 'named';
  factory NamedSpanProperty.fromJson(Map<String, dynamic> json) => _$NamedSpanPropertyFromJson(json);

 final  String name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of SpanProperty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NamedSpanPropertyCopyWith<NamedSpanProperty> get copyWith => _$NamedSpanPropertyCopyWithImpl<NamedSpanProperty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NamedSpanPropertyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NamedSpanProperty&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'SpanProperty.named(name: $name)';
}


}

/// @nodoc
abstract mixin class $NamedSpanPropertyCopyWith<$Res> implements $SpanPropertyCopyWith<$Res> {
  factory $NamedSpanPropertyCopyWith(NamedSpanProperty value, $Res Function(NamedSpanProperty) _then) = _$NamedSpanPropertyCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$NamedSpanPropertyCopyWithImpl<$Res>
    implements $NamedSpanPropertyCopyWith<$Res> {
  _$NamedSpanPropertyCopyWithImpl(this._self, this._then);

  final NamedSpanProperty _self;
  final $Res Function(NamedSpanProperty) _then;

/// Create a copy of SpanProperty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(NamedSpanProperty(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UndefinedSpanProperty implements SpanProperty {
  const UndefinedSpanProperty({final  String? $type}): $type = $type ?? 'undefined';
  factory UndefinedSpanProperty.fromJson(Map<String, dynamic> json) => _$UndefinedSpanPropertyFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$UndefinedSpanPropertyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UndefinedSpanProperty);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SpanProperty.undefined()';
}


}




ParagraphProperty _$ParagraphPropertyFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'defined':
          return DefinedParagraphProperty.fromJson(
            json
          );
                case 'named':
          return NamedParagraphProperty.fromJson(
            json
          );
                case 'undefined':
          return UndefinedParagraphProperty.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'ParagraphProperty',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$ParagraphProperty {



  /// Serializes this ParagraphProperty to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParagraphProperty);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParagraphProperty()';
}


}

/// @nodoc
class $ParagraphPropertyCopyWith<$Res>  {
$ParagraphPropertyCopyWith(ParagraphProperty _, $Res Function(ParagraphProperty) __);
}



/// @nodoc
@JsonSerializable()

class DefinedParagraphProperty implements ParagraphProperty {
  const DefinedParagraphProperty({this.span = const DefinedSpanProperty(), this.alignment = HorizontalAlignment.left, final  String? $type}): $type = $type ?? 'defined';
  factory DefinedParagraphProperty.fromJson(Map<String, dynamic> json) => _$DefinedParagraphPropertyFromJson(json);

@JsonKey() final  DefinedSpanProperty span;
@JsonKey() final  HorizontalAlignment alignment;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ParagraphProperty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DefinedParagraphPropertyCopyWith<DefinedParagraphProperty> get copyWith => _$DefinedParagraphPropertyCopyWithImpl<DefinedParagraphProperty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DefinedParagraphPropertyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DefinedParagraphProperty&&const DeepCollectionEquality().equals(other.span, span)&&(identical(other.alignment, alignment) || other.alignment == alignment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(span),alignment);

@override
String toString() {
  return 'ParagraphProperty.defined(span: $span, alignment: $alignment)';
}


}

/// @nodoc
abstract mixin class $DefinedParagraphPropertyCopyWith<$Res> implements $ParagraphPropertyCopyWith<$Res> {
  factory $DefinedParagraphPropertyCopyWith(DefinedParagraphProperty value, $Res Function(DefinedParagraphProperty) _then) = _$DefinedParagraphPropertyCopyWithImpl;
@useResult
$Res call({
 DefinedSpanProperty span, HorizontalAlignment alignment
});




}
/// @nodoc
class _$DefinedParagraphPropertyCopyWithImpl<$Res>
    implements $DefinedParagraphPropertyCopyWith<$Res> {
  _$DefinedParagraphPropertyCopyWithImpl(this._self, this._then);

  final DefinedParagraphProperty _self;
  final $Res Function(DefinedParagraphProperty) _then;

/// Create a copy of ParagraphProperty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? span = freezed,Object? alignment = null,}) {
  return _then(DefinedParagraphProperty(
span: freezed == span ? _self.span : span // ignore: cast_nullable_to_non_nullable
as DefinedSpanProperty,alignment: null == alignment ? _self.alignment : alignment // ignore: cast_nullable_to_non_nullable
as HorizontalAlignment,
  ));
}


}

/// @nodoc
@JsonSerializable()

class NamedParagraphProperty implements ParagraphProperty {
  const NamedParagraphProperty(this.name, {final  String? $type}): $type = $type ?? 'named';
  factory NamedParagraphProperty.fromJson(Map<String, dynamic> json) => _$NamedParagraphPropertyFromJson(json);

 final  String name;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ParagraphProperty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NamedParagraphPropertyCopyWith<NamedParagraphProperty> get copyWith => _$NamedParagraphPropertyCopyWithImpl<NamedParagraphProperty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NamedParagraphPropertyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NamedParagraphProperty&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'ParagraphProperty.named(name: $name)';
}


}

/// @nodoc
abstract mixin class $NamedParagraphPropertyCopyWith<$Res> implements $ParagraphPropertyCopyWith<$Res> {
  factory $NamedParagraphPropertyCopyWith(NamedParagraphProperty value, $Res Function(NamedParagraphProperty) _then) = _$NamedParagraphPropertyCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$NamedParagraphPropertyCopyWithImpl<$Res>
    implements $NamedParagraphPropertyCopyWith<$Res> {
  _$NamedParagraphPropertyCopyWithImpl(this._self, this._then);

  final NamedParagraphProperty _self;
  final $Res Function(NamedParagraphProperty) _then;

/// Create a copy of ParagraphProperty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(NamedParagraphProperty(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UndefinedParagraphProperty implements ParagraphProperty {
  const UndefinedParagraphProperty({final  String? $type}): $type = $type ?? 'undefined';
  factory UndefinedParagraphProperty.fromJson(Map<String, dynamic> json) => _$UndefinedParagraphPropertyFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$UndefinedParagraphPropertyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UndefinedParagraphProperty);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ParagraphProperty.undefined()';
}


}





/// @nodoc
mixin _$AreaProperty {

 VerticalAlignment get alignment;
/// Create a copy of AreaProperty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaPropertyCopyWith<AreaProperty> get copyWith => _$AreaPropertyCopyWithImpl<AreaProperty>(this as AreaProperty, _$identity);

  /// Serializes this AreaProperty to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AreaProperty&&(identical(other.alignment, alignment) || other.alignment == alignment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,alignment);

@override
String toString() {
  return 'AreaProperty(alignment: $alignment)';
}


}

/// @nodoc
abstract mixin class $AreaPropertyCopyWith<$Res>  {
  factory $AreaPropertyCopyWith(AreaProperty value, $Res Function(AreaProperty) _then) = _$AreaPropertyCopyWithImpl;
@useResult
$Res call({
 VerticalAlignment alignment
});




}
/// @nodoc
class _$AreaPropertyCopyWithImpl<$Res>
    implements $AreaPropertyCopyWith<$Res> {
  _$AreaPropertyCopyWithImpl(this._self, this._then);

  final AreaProperty _self;
  final $Res Function(AreaProperty) _then;

/// Create a copy of AreaProperty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? alignment = null,}) {
  return _then(_self.copyWith(
alignment: null == alignment ? _self.alignment : alignment // ignore: cast_nullable_to_non_nullable
as VerticalAlignment,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _AreaProperty implements AreaProperty {
  const _AreaProperty({this.alignment = VerticalAlignment.top});
  factory _AreaProperty.fromJson(Map<String, dynamic> json) => _$AreaPropertyFromJson(json);

@override@JsonKey() final  VerticalAlignment alignment;

/// Create a copy of AreaProperty
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AreaPropertyCopyWith<_AreaProperty> get copyWith => __$AreaPropertyCopyWithImpl<_AreaProperty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaPropertyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AreaProperty&&(identical(other.alignment, alignment) || other.alignment == alignment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,alignment);

@override
String toString() {
  return 'AreaProperty(alignment: $alignment)';
}


}

/// @nodoc
abstract mixin class _$AreaPropertyCopyWith<$Res> implements $AreaPropertyCopyWith<$Res> {
  factory _$AreaPropertyCopyWith(_AreaProperty value, $Res Function(_AreaProperty) _then) = __$AreaPropertyCopyWithImpl;
@override @useResult
$Res call({
 VerticalAlignment alignment
});




}
/// @nodoc
class __$AreaPropertyCopyWithImpl<$Res>
    implements _$AreaPropertyCopyWith<$Res> {
  __$AreaPropertyCopyWithImpl(this._self, this._then);

  final _AreaProperty _self;
  final $Res Function(_AreaProperty) _then;

/// Create a copy of AreaProperty
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? alignment = null,}) {
  return _then(_AreaProperty(
alignment: null == alignment ? _self.alignment : alignment // ignore: cast_nullable_to_non_nullable
as VerticalAlignment,
  ));
}


}


/// @nodoc
mixin _$TextSpan {

 String get text; SpanProperty get property;
/// Create a copy of TextSpan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextSpanCopyWith<TextSpan> get copyWith => _$TextSpanCopyWithImpl<TextSpan>(this as TextSpan, _$identity);

  /// Serializes this TextSpan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextSpan&&(identical(other.text, text) || other.text == text)&&(identical(other.property, property) || other.property == property));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,property);

@override
String toString() {
  return 'TextSpan(text: $text, property: $property)';
}


}

/// @nodoc
abstract mixin class $TextSpanCopyWith<$Res>  {
  factory $TextSpanCopyWith(TextSpan value, $Res Function(TextSpan) _then) = _$TextSpanCopyWithImpl;
@useResult
$Res call({
 String text, SpanProperty property
});


$SpanPropertyCopyWith<$Res> get property;

}
/// @nodoc
class _$TextSpanCopyWithImpl<$Res>
    implements $TextSpanCopyWith<$Res> {
  _$TextSpanCopyWithImpl(this._self, this._then);

  final TextSpan _self;
  final $Res Function(TextSpan) _then;

/// Create a copy of TextSpan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? property = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,property: null == property ? _self.property : property // ignore: cast_nullable_to_non_nullable
as SpanProperty,
  ));
}
/// Create a copy of TextSpan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpanPropertyCopyWith<$Res> get property {
  
  return $SpanPropertyCopyWith<$Res>(_self.property, (value) {
    return _then(_self.copyWith(property: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _TextSpan extends TextSpan {
  const _TextSpan({this.text = '', this.property = const SpanProperty.undefined()}): super._();
  factory _TextSpan.fromJson(Map<String, dynamic> json) => _$TextSpanFromJson(json);

@override@JsonKey() final  String text;
@override@JsonKey() final  SpanProperty property;

/// Create a copy of TextSpan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextSpanCopyWith<_TextSpan> get copyWith => __$TextSpanCopyWithImpl<_TextSpan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextSpanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextSpan&&(identical(other.text, text) || other.text == text)&&(identical(other.property, property) || other.property == property));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,property);

@override
String toString() {
  return 'TextSpan.text(text: $text, property: $property)';
}


}

/// @nodoc
abstract mixin class _$TextSpanCopyWith<$Res> implements $TextSpanCopyWith<$Res> {
  factory _$TextSpanCopyWith(_TextSpan value, $Res Function(_TextSpan) _then) = __$TextSpanCopyWithImpl;
@override @useResult
$Res call({
 String text, SpanProperty property
});


@override $SpanPropertyCopyWith<$Res> get property;

}
/// @nodoc
class __$TextSpanCopyWithImpl<$Res>
    implements _$TextSpanCopyWith<$Res> {
  __$TextSpanCopyWithImpl(this._self, this._then);

  final _TextSpan _self;
  final $Res Function(_TextSpan) _then;

/// Create a copy of TextSpan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? property = null,}) {
  return _then(_TextSpan(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,property: null == property ? _self.property : property // ignore: cast_nullable_to_non_nullable
as SpanProperty,
  ));
}

/// Create a copy of TextSpan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SpanPropertyCopyWith<$Res> get property {
  
  return $SpanPropertyCopyWith<$Res>(_self.property, (value) {
    return _then(_self.copyWith(property: value));
  });
}
}

/// @nodoc
mixin _$IndexedModel<T> {

 int get index; T get model;
/// Create a copy of IndexedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndexedModelCopyWith<T, IndexedModel<T>> get copyWith => _$IndexedModelCopyWithImpl<T, IndexedModel<T>>(this as IndexedModel<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndexedModel<T>&&(identical(other.index, index) || other.index == index)&&const DeepCollectionEquality().equals(other.model, model));
}


@override
int get hashCode => Object.hash(runtimeType,index,const DeepCollectionEquality().hash(model));

@override
String toString() {
  return 'IndexedModel<$T>(index: $index, model: $model)';
}


}

/// @nodoc
abstract mixin class $IndexedModelCopyWith<T,$Res>  {
  factory $IndexedModelCopyWith(IndexedModel<T> value, $Res Function(IndexedModel<T>) _then) = _$IndexedModelCopyWithImpl;
@useResult
$Res call({
 int index, T model
});




}
/// @nodoc
class _$IndexedModelCopyWithImpl<T,$Res>
    implements $IndexedModelCopyWith<T, $Res> {
  _$IndexedModelCopyWithImpl(this._self, this._then);

  final IndexedModel<T> _self;
  final $Res Function(IndexedModel<T>) _then;

/// Create a copy of IndexedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? model = freezed,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,model: freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as T,
  ));
}

}



/// @nodoc


class _IndexedModel<T> implements IndexedModel<T> {
  const _IndexedModel(this.index, this.model);
  

@override final  int index;
@override final  T model;

/// Create a copy of IndexedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IndexedModelCopyWith<T, _IndexedModel<T>> get copyWith => __$IndexedModelCopyWithImpl<T, _IndexedModel<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IndexedModel<T>&&(identical(other.index, index) || other.index == index)&&const DeepCollectionEquality().equals(other.model, model));
}


@override
int get hashCode => Object.hash(runtimeType,index,const DeepCollectionEquality().hash(model));

@override
String toString() {
  return 'IndexedModel<$T>(index: $index, model: $model)';
}


}

/// @nodoc
abstract mixin class _$IndexedModelCopyWith<T,$Res> implements $IndexedModelCopyWith<T, $Res> {
  factory _$IndexedModelCopyWith(_IndexedModel<T> value, $Res Function(_IndexedModel<T>) _then) = __$IndexedModelCopyWithImpl;
@override @useResult
$Res call({
 int index, T model
});




}
/// @nodoc
class __$IndexedModelCopyWithImpl<T,$Res>
    implements _$IndexedModelCopyWith<T, $Res> {
  __$IndexedModelCopyWithImpl(this._self, this._then);

  final _IndexedModel<T> _self;
  final $Res Function(_IndexedModel<T>) _then;

/// Create a copy of IndexedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? model = freezed,}) {
  return _then(_IndexedModel<T>(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,freezed == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}


/// @nodoc
mixin _$TextParagraph {

 ParagraphProperty get property; List<TextSpan> get textSpans;
/// Create a copy of TextParagraph
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextParagraphCopyWith<TextParagraph> get copyWith => _$TextParagraphCopyWithImpl<TextParagraph>(this as TextParagraph, _$identity);

  /// Serializes this TextParagraph to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextParagraph&&(identical(other.property, property) || other.property == property)&&const DeepCollectionEquality().equals(other.textSpans, textSpans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,property,const DeepCollectionEquality().hash(textSpans));

@override
String toString() {
  return 'TextParagraph(property: $property, textSpans: $textSpans)';
}


}

/// @nodoc
abstract mixin class $TextParagraphCopyWith<$Res>  {
  factory $TextParagraphCopyWith(TextParagraph value, $Res Function(TextParagraph) _then) = _$TextParagraphCopyWithImpl;
@useResult
$Res call({
 ParagraphProperty property, List<TextSpan> textSpans
});


$ParagraphPropertyCopyWith<$Res> get property;

}
/// @nodoc
class _$TextParagraphCopyWithImpl<$Res>
    implements $TextParagraphCopyWith<$Res> {
  _$TextParagraphCopyWithImpl(this._self, this._then);

  final TextParagraph _self;
  final $Res Function(TextParagraph) _then;

/// Create a copy of TextParagraph
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? property = null,Object? textSpans = null,}) {
  return _then(_self.copyWith(
property: null == property ? _self.property : property // ignore: cast_nullable_to_non_nullable
as ParagraphProperty,textSpans: null == textSpans ? _self.textSpans : textSpans // ignore: cast_nullable_to_non_nullable
as List<TextSpan>,
  ));
}
/// Create a copy of TextParagraph
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParagraphPropertyCopyWith<$Res> get property {
  
  return $ParagraphPropertyCopyWith<$Res>(_self.property, (value) {
    return _then(_self.copyWith(property: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _TextParagraph extends TextParagraph {
  const _TextParagraph({this.property = const ParagraphProperty.undefined(), final  List<TextSpan> textSpans = const []}): _textSpans = textSpans,super._();
  factory _TextParagraph.fromJson(Map<String, dynamic> json) => _$TextParagraphFromJson(json);

@override@JsonKey() final  ParagraphProperty property;
 final  List<TextSpan> _textSpans;
@override@JsonKey() List<TextSpan> get textSpans {
  if (_textSpans is EqualUnmodifiableListView) return _textSpans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_textSpans);
}


/// Create a copy of TextParagraph
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextParagraphCopyWith<_TextParagraph> get copyWith => __$TextParagraphCopyWithImpl<_TextParagraph>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextParagraphToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextParagraph&&(identical(other.property, property) || other.property == property)&&const DeepCollectionEquality().equals(other._textSpans, _textSpans));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,property,const DeepCollectionEquality().hash(_textSpans));

@override
String toString() {
  return 'TextParagraph(property: $property, textSpans: $textSpans)';
}


}

/// @nodoc
abstract mixin class _$TextParagraphCopyWith<$Res> implements $TextParagraphCopyWith<$Res> {
  factory _$TextParagraphCopyWith(_TextParagraph value, $Res Function(_TextParagraph) _then) = __$TextParagraphCopyWithImpl;
@override @useResult
$Res call({
 ParagraphProperty property, List<TextSpan> textSpans
});


@override $ParagraphPropertyCopyWith<$Res> get property;

}
/// @nodoc
class __$TextParagraphCopyWithImpl<$Res>
    implements _$TextParagraphCopyWith<$Res> {
  __$TextParagraphCopyWithImpl(this._self, this._then);

  final _TextParagraph _self;
  final $Res Function(_TextParagraph) _then;

/// Create a copy of TextParagraph
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? property = null,Object? textSpans = null,}) {
  return _then(_TextParagraph(
property: null == property ? _self.property : property // ignore: cast_nullable_to_non_nullable
as ParagraphProperty,textSpans: null == textSpans ? _self._textSpans : textSpans // ignore: cast_nullable_to_non_nullable
as List<TextSpan>,
  ));
}

/// Create a copy of TextParagraph
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParagraphPropertyCopyWith<$Res> get property {
  
  return $ParagraphPropertyCopyWith<$Res>(_self.property, (value) {
    return _then(_self.copyWith(property: value));
  });
}
}


/// @nodoc
mixin _$TextArea {

 AreaProperty get areaProperty; TextParagraph get paragraph;
/// Create a copy of TextArea
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextAreaCopyWith<TextArea> get copyWith => _$TextAreaCopyWithImpl<TextArea>(this as TextArea, _$identity);

  /// Serializes this TextArea to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextArea&&(identical(other.areaProperty, areaProperty) || other.areaProperty == areaProperty)&&(identical(other.paragraph, paragraph) || other.paragraph == paragraph));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,areaProperty,paragraph);

@override
String toString() {
  return 'TextArea(areaProperty: $areaProperty, paragraph: $paragraph)';
}


}

/// @nodoc
abstract mixin class $TextAreaCopyWith<$Res>  {
  factory $TextAreaCopyWith(TextArea value, $Res Function(TextArea) _then) = _$TextAreaCopyWithImpl;
@useResult
$Res call({
 AreaProperty areaProperty, TextParagraph paragraph
});


$AreaPropertyCopyWith<$Res> get areaProperty;$TextParagraphCopyWith<$Res> get paragraph;

}
/// @nodoc
class _$TextAreaCopyWithImpl<$Res>
    implements $TextAreaCopyWith<$Res> {
  _$TextAreaCopyWithImpl(this._self, this._then);

  final TextArea _self;
  final $Res Function(TextArea) _then;

/// Create a copy of TextArea
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? areaProperty = null,Object? paragraph = null,}) {
  return _then(_self.copyWith(
areaProperty: null == areaProperty ? _self.areaProperty : areaProperty // ignore: cast_nullable_to_non_nullable
as AreaProperty,paragraph: null == paragraph ? _self.paragraph : paragraph // ignore: cast_nullable_to_non_nullable
as TextParagraph,
  ));
}
/// Create a copy of TextArea
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AreaPropertyCopyWith<$Res> get areaProperty {
  
  return $AreaPropertyCopyWith<$Res>(_self.areaProperty, (value) {
    return _then(_self.copyWith(areaProperty: value));
  });
}/// Create a copy of TextArea
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextParagraphCopyWith<$Res> get paragraph {
  
  return $TextParagraphCopyWith<$Res>(_self.paragraph, (value) {
    return _then(_self.copyWith(paragraph: value));
  });
}
}



/// @nodoc
@JsonSerializable()

class _TextArea extends TextArea {
  const _TextArea({this.areaProperty = const AreaProperty(), required this.paragraph}): super._();
  factory _TextArea.fromJson(Map<String, dynamic> json) => _$TextAreaFromJson(json);

@override@JsonKey() final  AreaProperty areaProperty;
@override final  TextParagraph paragraph;

/// Create a copy of TextArea
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextAreaCopyWith<_TextArea> get copyWith => __$TextAreaCopyWithImpl<_TextArea>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextAreaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextArea&&(identical(other.areaProperty, areaProperty) || other.areaProperty == areaProperty)&&(identical(other.paragraph, paragraph) || other.paragraph == paragraph));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,areaProperty,paragraph);

@override
String toString() {
  return 'TextArea(areaProperty: $areaProperty, paragraph: $paragraph)';
}


}

/// @nodoc
abstract mixin class _$TextAreaCopyWith<$Res> implements $TextAreaCopyWith<$Res> {
  factory _$TextAreaCopyWith(_TextArea value, $Res Function(_TextArea) _then) = __$TextAreaCopyWithImpl;
@override @useResult
$Res call({
 AreaProperty areaProperty, TextParagraph paragraph
});


@override $AreaPropertyCopyWith<$Res> get areaProperty;@override $TextParagraphCopyWith<$Res> get paragraph;

}
/// @nodoc
class __$TextAreaCopyWithImpl<$Res>
    implements _$TextAreaCopyWith<$Res> {
  __$TextAreaCopyWithImpl(this._self, this._then);

  final _TextArea _self;
  final $Res Function(_TextArea) _then;

/// Create a copy of TextArea
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? areaProperty = null,Object? paragraph = null,}) {
  return _then(_TextArea(
areaProperty: null == areaProperty ? _self.areaProperty : areaProperty // ignore: cast_nullable_to_non_nullable
as AreaProperty,paragraph: null == paragraph ? _self.paragraph : paragraph // ignore: cast_nullable_to_non_nullable
as TextParagraph,
  ));
}

/// Create a copy of TextArea
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AreaPropertyCopyWith<$Res> get areaProperty {
  
  return $AreaPropertyCopyWith<$Res>(_self.areaProperty, (value) {
    return _then(_self.copyWith(areaProperty: value));
  });
}/// Create a copy of TextArea
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TextParagraphCopyWith<$Res> get paragraph {
  
  return $TextParagraphCopyWith<$Res>(_self.paragraph, (value) {
    return _then(_self.copyWith(paragraph: value));
  });
}
}


/// @nodoc
mixin _$TextStyleSheet {

 String get name; Map<String, DefinedSpanProperty> get spanProperties; Map<String, DefinedParagraphProperty> get paragraphProperties;
/// Create a copy of TextStyleSheet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextStyleSheetCopyWith<TextStyleSheet> get copyWith => _$TextStyleSheetCopyWithImpl<TextStyleSheet>(this as TextStyleSheet, _$identity);

  /// Serializes this TextStyleSheet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextStyleSheet&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.spanProperties, spanProperties)&&const DeepCollectionEquality().equals(other.paragraphProperties, paragraphProperties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(spanProperties),const DeepCollectionEquality().hash(paragraphProperties));

@override
String toString() {
  return 'TextStyleSheet(name: $name, spanProperties: $spanProperties, paragraphProperties: $paragraphProperties)';
}


}

/// @nodoc
abstract mixin class $TextStyleSheetCopyWith<$Res>  {
  factory $TextStyleSheetCopyWith(TextStyleSheet value, $Res Function(TextStyleSheet) _then) = _$TextStyleSheetCopyWithImpl;
@useResult
$Res call({
 String name, Map<String, DefinedSpanProperty> spanProperties, Map<String, DefinedParagraphProperty> paragraphProperties
});




}
/// @nodoc
class _$TextStyleSheetCopyWithImpl<$Res>
    implements $TextStyleSheetCopyWith<$Res> {
  _$TextStyleSheetCopyWithImpl(this._self, this._then);

  final TextStyleSheet _self;
  final $Res Function(TextStyleSheet) _then;

/// Create a copy of TextStyleSheet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? spanProperties = null,Object? paragraphProperties = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,spanProperties: null == spanProperties ? _self.spanProperties : spanProperties // ignore: cast_nullable_to_non_nullable
as Map<String, DefinedSpanProperty>,paragraphProperties: null == paragraphProperties ? _self.paragraphProperties : paragraphProperties // ignore: cast_nullable_to_non_nullable
as Map<String, DefinedParagraphProperty>,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _TextStyleSheet extends TextStyleSheet {
  const _TextStyleSheet({this.name = '', final  Map<String, DefinedSpanProperty> spanProperties = const {}, final  Map<String, DefinedParagraphProperty> paragraphProperties = const {}}): _spanProperties = spanProperties,_paragraphProperties = paragraphProperties,super._();
  factory _TextStyleSheet.fromJson(Map<String, dynamic> json) => _$TextStyleSheetFromJson(json);

@override@JsonKey() final  String name;
 final  Map<String, DefinedSpanProperty> _spanProperties;
@override@JsonKey() Map<String, DefinedSpanProperty> get spanProperties {
  if (_spanProperties is EqualUnmodifiableMapView) return _spanProperties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_spanProperties);
}

 final  Map<String, DefinedParagraphProperty> _paragraphProperties;
@override@JsonKey() Map<String, DefinedParagraphProperty> get paragraphProperties {
  if (_paragraphProperties is EqualUnmodifiableMapView) return _paragraphProperties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_paragraphProperties);
}


/// Create a copy of TextStyleSheet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TextStyleSheetCopyWith<_TextStyleSheet> get copyWith => __$TextStyleSheetCopyWithImpl<_TextStyleSheet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextStyleSheetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TextStyleSheet&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._spanProperties, _spanProperties)&&const DeepCollectionEquality().equals(other._paragraphProperties, _paragraphProperties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_spanProperties),const DeepCollectionEquality().hash(_paragraphProperties));

@override
String toString() {
  return 'TextStyleSheet(name: $name, spanProperties: $spanProperties, paragraphProperties: $paragraphProperties)';
}


}

/// @nodoc
abstract mixin class _$TextStyleSheetCopyWith<$Res> implements $TextStyleSheetCopyWith<$Res> {
  factory _$TextStyleSheetCopyWith(_TextStyleSheet value, $Res Function(_TextStyleSheet) _then) = __$TextStyleSheetCopyWithImpl;
@override @useResult
$Res call({
 String name, Map<String, DefinedSpanProperty> spanProperties, Map<String, DefinedParagraphProperty> paragraphProperties
});




}
/// @nodoc
class __$TextStyleSheetCopyWithImpl<$Res>
    implements _$TextStyleSheetCopyWith<$Res> {
  __$TextStyleSheetCopyWithImpl(this._self, this._then);

  final _TextStyleSheet _self;
  final $Res Function(_TextStyleSheet) _then;

/// Create a copy of TextStyleSheet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? spanProperties = null,Object? paragraphProperties = null,}) {
  return _then(_TextStyleSheet(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,spanProperties: null == spanProperties ? _self._spanProperties : spanProperties // ignore: cast_nullable_to_non_nullable
as Map<String, DefinedSpanProperty>,paragraphProperties: null == paragraphProperties ? _self._paragraphProperties : paragraphProperties // ignore: cast_nullable_to_non_nullable
as Map<String, DefinedParagraphProperty>,
  ));
}


}

// dart format on
