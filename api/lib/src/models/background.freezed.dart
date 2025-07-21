// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'background.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Background _$BackgroundFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'texture':
          return TextureBackground.fromJson(
            json
          );
                case 'image':
          return ImageBackground.fromJson(
            json
          );
                case 'svg':
          return SvgBackground.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'Background',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$Background {

 Map<String, dynamic> get extra;
/// Create a copy of Background
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackgroundCopyWith<Background> get copyWith => _$BackgroundCopyWithImpl<Background>(this as Background, _$identity);

  /// Serializes this Background to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'Background(extra: $extra)';
}


}

/// @nodoc
abstract mixin class $BackgroundCopyWith<$Res>  {
  factory $BackgroundCopyWith(Background value, $Res Function(Background) _then) = _$BackgroundCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> extra
});




}
/// @nodoc
class _$BackgroundCopyWithImpl<$Res>
    implements $BackgroundCopyWith<$Res> {
  _$BackgroundCopyWithImpl(this._self, this._then);

  final Background _self;
  final $Res Function(Background) _then;

/// Create a copy of Background
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? extra = null,}) {
  return _then(_self.copyWith(
extra: null == extra ? _self.extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}



/// @nodoc
@JsonSerializable()

class TextureBackground extends Background {
   TextureBackground({required this.texture, final  Map<String, dynamic> extra = const {}, final  String? $type}): _extra = extra,$type = $type ?? 'texture',super._();
  factory TextureBackground.fromJson(Map<String, dynamic> json) => _$TextureBackgroundFromJson(json);

 final  SurfaceTexture texture;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of Background
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextureBackgroundCopyWith<TextureBackground> get copyWith => _$TextureBackgroundCopyWithImpl<TextureBackground>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextureBackgroundToJson(this, );
}



@override
String toString() {
  return 'Background.texture(texture: $texture, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $TextureBackgroundCopyWith<$Res> implements $BackgroundCopyWith<$Res> {
  factory $TextureBackgroundCopyWith(TextureBackground value, $Res Function(TextureBackground) _then) = _$TextureBackgroundCopyWithImpl;
@override @useResult
$Res call({
 SurfaceTexture texture, Map<String, dynamic> extra
});


$SurfaceTextureCopyWith<$Res> get texture;

}
/// @nodoc
class _$TextureBackgroundCopyWithImpl<$Res>
    implements $TextureBackgroundCopyWith<$Res> {
  _$TextureBackgroundCopyWithImpl(this._self, this._then);

  final TextureBackground _self;
  final $Res Function(TextureBackground) _then;

/// Create a copy of Background
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? texture = null,Object? extra = null,}) {
  return _then(TextureBackground(
texture: null == texture ? _self.texture : texture // ignore: cast_nullable_to_non_nullable
as SurfaceTexture,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of Background
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

class ImageBackground extends Background implements SourcedElement {
   ImageBackground({required this.source, required this.width, required this.height, this.scaleX = 1, this.scaleY = 1, final  Map<String, dynamic> extra = const {}, final  String? $type}): _extra = extra,$type = $type ?? 'image',super._();
  factory ImageBackground.fromJson(Map<String, dynamic> json) => _$ImageBackgroundFromJson(json);

 final  String source;
 final  double width;
 final  double height;
@JsonKey() final  double scaleX;
@JsonKey() final  double scaleY;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of Background
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageBackgroundCopyWith<ImageBackground> get copyWith => _$ImageBackgroundCopyWithImpl<ImageBackground>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageBackgroundToJson(this, );
}



@override
String toString() {
  return 'Background.image(source: $source, width: $width, height: $height, scaleX: $scaleX, scaleY: $scaleY, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $ImageBackgroundCopyWith<$Res> implements $BackgroundCopyWith<$Res> {
  factory $ImageBackgroundCopyWith(ImageBackground value, $Res Function(ImageBackground) _then) = _$ImageBackgroundCopyWithImpl;
@override @useResult
$Res call({
 String source, double width, double height, double scaleX, double scaleY, Map<String, dynamic> extra
});




}
/// @nodoc
class _$ImageBackgroundCopyWithImpl<$Res>
    implements $ImageBackgroundCopyWith<$Res> {
  _$ImageBackgroundCopyWithImpl(this._self, this._then);

  final ImageBackground _self;
  final $Res Function(ImageBackground) _then;

/// Create a copy of Background
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? width = null,Object? height = null,Object? scaleX = null,Object? scaleY = null,Object? extra = null,}) {
  return _then(ImageBackground(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,scaleX: null == scaleX ? _self.scaleX : scaleX // ignore: cast_nullable_to_non_nullable
as double,scaleY: null == scaleY ? _self.scaleY : scaleY // ignore: cast_nullable_to_non_nullable
as double,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SvgBackground extends Background implements SourcedElement {
   SvgBackground({required this.source, required this.width, required this.height, this.scaleX = 1, this.scaleY = 1, final  Map<String, dynamic> extra = const {}, final  String? $type}): _extra = extra,$type = $type ?? 'svg',super._();
  factory SvgBackground.fromJson(Map<String, dynamic> json) => _$SvgBackgroundFromJson(json);

 final  String source;
 final  double width;
 final  double height;
@JsonKey() final  double scaleX;
@JsonKey() final  double scaleY;
 final  Map<String, dynamic> _extra;
@override@JsonKey() Map<String, dynamic> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of Background
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SvgBackgroundCopyWith<SvgBackground> get copyWith => _$SvgBackgroundCopyWithImpl<SvgBackground>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SvgBackgroundToJson(this, );
}



@override
String toString() {
  return 'Background.svg(source: $source, width: $width, height: $height, scaleX: $scaleX, scaleY: $scaleY, extra: $extra)';
}


}

/// @nodoc
abstract mixin class $SvgBackgroundCopyWith<$Res> implements $BackgroundCopyWith<$Res> {
  factory $SvgBackgroundCopyWith(SvgBackground value, $Res Function(SvgBackground) _then) = _$SvgBackgroundCopyWithImpl;
@override @useResult
$Res call({
 String source, double width, double height, double scaleX, double scaleY, Map<String, dynamic> extra
});




}
/// @nodoc
class _$SvgBackgroundCopyWithImpl<$Res>
    implements $SvgBackgroundCopyWith<$Res> {
  _$SvgBackgroundCopyWithImpl(this._self, this._then);

  final SvgBackground _self;
  final $Res Function(SvgBackground) _then;

/// Create a copy of Background
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? width = null,Object? height = null,Object? scaleX = null,Object? scaleY = null,Object? extra = null,}) {
  return _then(SvgBackground(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,scaleX: null == scaleX ? _self.scaleX : scaleX // ignore: cast_nullable_to_non_nullable
as double,scaleY: null == scaleY ? _self.scaleY : scaleY // ignore: cast_nullable_to_non_nullable
as double,extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
