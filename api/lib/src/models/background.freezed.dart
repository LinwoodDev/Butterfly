// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'background.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Background _$BackgroundFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'texture':
      return TextureBackground.fromJson(json);
    case 'image':
      return ImageBackground.fromJson(json);
    case 'svg':
      return SvgBackground.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'Background', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$Background {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SurfaceTexture texture) texture,
    required TResult Function(String source, double width, double height,
            double scaleX, double scaleY)
        image,
    required TResult Function(String source, double width, double height,
            double scaleX, double scaleY)
        svg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SurfaceTexture texture)? texture,
    TResult? Function(String source, double width, double height, double scaleX,
            double scaleY)?
        image,
    TResult? Function(String source, double width, double height, double scaleX,
            double scaleY)?
        svg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SurfaceTexture texture)? texture,
    TResult Function(String source, double width, double height, double scaleX,
            double scaleY)?
        image,
    TResult Function(String source, double width, double height, double scaleX,
            double scaleY)?
        svg,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextureBackground value) texture,
    required TResult Function(ImageBackground value) image,
    required TResult Function(SvgBackground value) svg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextureBackground value)? texture,
    TResult? Function(ImageBackground value)? image,
    TResult? Function(SvgBackground value)? svg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextureBackground value)? texture,
    TResult Function(ImageBackground value)? image,
    TResult Function(SvgBackground value)? svg,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackgroundCopyWith<$Res> {
  factory $BackgroundCopyWith(
          Background value, $Res Function(Background) then) =
      _$BackgroundCopyWithImpl<$Res, Background>;
}

/// @nodoc
class _$BackgroundCopyWithImpl<$Res, $Val extends Background>
    implements $BackgroundCopyWith<$Res> {
  _$BackgroundCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TextureBackgroundImplCopyWith<$Res> {
  factory _$$TextureBackgroundImplCopyWith(_$TextureBackgroundImpl value,
          $Res Function(_$TextureBackgroundImpl) then) =
      __$$TextureBackgroundImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SurfaceTexture texture});

  $SurfaceTextureCopyWith<$Res> get texture;
}

/// @nodoc
class __$$TextureBackgroundImplCopyWithImpl<$Res>
    extends _$BackgroundCopyWithImpl<$Res, _$TextureBackgroundImpl>
    implements _$$TextureBackgroundImplCopyWith<$Res> {
  __$$TextureBackgroundImplCopyWithImpl(_$TextureBackgroundImpl _value,
      $Res Function(_$TextureBackgroundImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? texture = null,
  }) {
    return _then(_$TextureBackgroundImpl(
      texture: null == texture
          ? _value.texture
          : texture // ignore: cast_nullable_to_non_nullable
              as SurfaceTexture,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SurfaceTextureCopyWith<$Res> get texture {
    return $SurfaceTextureCopyWith<$Res>(_value.texture, (value) {
      return _then(_value.copyWith(texture: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TextureBackgroundImpl extends TextureBackground {
  _$TextureBackgroundImpl({required this.texture, final String? $type})
      : $type = $type ?? 'texture',
        super._();

  factory _$TextureBackgroundImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextureBackgroundImplFromJson(json);

  @override
  final SurfaceTexture texture;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Background.texture(texture: $texture)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextureBackgroundImplCopyWith<_$TextureBackgroundImpl> get copyWith =>
      __$$TextureBackgroundImplCopyWithImpl<_$TextureBackgroundImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SurfaceTexture texture) texture,
    required TResult Function(String source, double width, double height,
            double scaleX, double scaleY)
        image,
    required TResult Function(String source, double width, double height,
            double scaleX, double scaleY)
        svg,
  }) {
    return texture(this.texture);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SurfaceTexture texture)? texture,
    TResult? Function(String source, double width, double height, double scaleX,
            double scaleY)?
        image,
    TResult? Function(String source, double width, double height, double scaleX,
            double scaleY)?
        svg,
  }) {
    return texture?.call(this.texture);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SurfaceTexture texture)? texture,
    TResult Function(String source, double width, double height, double scaleX,
            double scaleY)?
        image,
    TResult Function(String source, double width, double height, double scaleX,
            double scaleY)?
        svg,
    required TResult orElse(),
  }) {
    if (texture != null) {
      return texture(this.texture);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextureBackground value) texture,
    required TResult Function(ImageBackground value) image,
    required TResult Function(SvgBackground value) svg,
  }) {
    return texture(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextureBackground value)? texture,
    TResult? Function(ImageBackground value)? image,
    TResult? Function(SvgBackground value)? svg,
  }) {
    return texture?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextureBackground value)? texture,
    TResult Function(ImageBackground value)? image,
    TResult Function(SvgBackground value)? svg,
    required TResult orElse(),
  }) {
    if (texture != null) {
      return texture(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TextureBackgroundImplToJson(
      this,
    );
  }
}

abstract class TextureBackground extends Background {
  factory TextureBackground({required final SurfaceTexture texture}) =
      _$TextureBackgroundImpl;
  TextureBackground._() : super._();

  factory TextureBackground.fromJson(Map<String, dynamic> json) =
      _$TextureBackgroundImpl.fromJson;

  SurfaceTexture get texture;
  @JsonKey(ignore: true)
  _$$TextureBackgroundImplCopyWith<_$TextureBackgroundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImageBackgroundImplCopyWith<$Res> {
  factory _$$ImageBackgroundImplCopyWith(_$ImageBackgroundImpl value,
          $Res Function(_$ImageBackgroundImpl) then) =
      __$$ImageBackgroundImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String source,
      double width,
      double height,
      double scaleX,
      double scaleY});
}

/// @nodoc
class __$$ImageBackgroundImplCopyWithImpl<$Res>
    extends _$BackgroundCopyWithImpl<$Res, _$ImageBackgroundImpl>
    implements _$$ImageBackgroundImplCopyWith<$Res> {
  __$$ImageBackgroundImplCopyWithImpl(
      _$ImageBackgroundImpl _value, $Res Function(_$ImageBackgroundImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? width = null,
    Object? height = null,
    Object? scaleX = null,
    Object? scaleY = null,
  }) {
    return _then(_$ImageBackgroundImpl(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      scaleX: null == scaleX
          ? _value.scaleX
          : scaleX // ignore: cast_nullable_to_non_nullable
              as double,
      scaleY: null == scaleY
          ? _value.scaleY
          : scaleY // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageBackgroundImpl extends ImageBackground {
  _$ImageBackgroundImpl(
      {required this.source,
      required this.width,
      required this.height,
      this.scaleX = 1,
      this.scaleY = 1,
      final String? $type})
      : $type = $type ?? 'image',
        super._();

  factory _$ImageBackgroundImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageBackgroundImplFromJson(json);

  @override
  final String source;
  @override
  final double width;
  @override
  final double height;
  @override
  @JsonKey()
  final double scaleX;
  @override
  @JsonKey()
  final double scaleY;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Background.image(source: $source, width: $width, height: $height, scaleX: $scaleX, scaleY: $scaleY)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageBackgroundImplCopyWith<_$ImageBackgroundImpl> get copyWith =>
      __$$ImageBackgroundImplCopyWithImpl<_$ImageBackgroundImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SurfaceTexture texture) texture,
    required TResult Function(String source, double width, double height,
            double scaleX, double scaleY)
        image,
    required TResult Function(String source, double width, double height,
            double scaleX, double scaleY)
        svg,
  }) {
    return image(source, width, height, scaleX, scaleY);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SurfaceTexture texture)? texture,
    TResult? Function(String source, double width, double height, double scaleX,
            double scaleY)?
        image,
    TResult? Function(String source, double width, double height, double scaleX,
            double scaleY)?
        svg,
  }) {
    return image?.call(source, width, height, scaleX, scaleY);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SurfaceTexture texture)? texture,
    TResult Function(String source, double width, double height, double scaleX,
            double scaleY)?
        image,
    TResult Function(String source, double width, double height, double scaleX,
            double scaleY)?
        svg,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(source, width, height, scaleX, scaleY);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextureBackground value) texture,
    required TResult Function(ImageBackground value) image,
    required TResult Function(SvgBackground value) svg,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextureBackground value)? texture,
    TResult? Function(ImageBackground value)? image,
    TResult? Function(SvgBackground value)? svg,
  }) {
    return image?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextureBackground value)? texture,
    TResult Function(ImageBackground value)? image,
    TResult Function(SvgBackground value)? svg,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageBackgroundImplToJson(
      this,
    );
  }
}

abstract class ImageBackground extends Background {
  factory ImageBackground(
      {required final String source,
      required final double width,
      required final double height,
      final double scaleX,
      final double scaleY}) = _$ImageBackgroundImpl;
  ImageBackground._() : super._();

  factory ImageBackground.fromJson(Map<String, dynamic> json) =
      _$ImageBackgroundImpl.fromJson;

  String get source;
  double get width;
  double get height;
  double get scaleX;
  double get scaleY;
  @JsonKey(ignore: true)
  _$$ImageBackgroundImplCopyWith<_$ImageBackgroundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SvgBackgroundImplCopyWith<$Res> {
  factory _$$SvgBackgroundImplCopyWith(
          _$SvgBackgroundImpl value, $Res Function(_$SvgBackgroundImpl) then) =
      __$$SvgBackgroundImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String source,
      double width,
      double height,
      double scaleX,
      double scaleY});
}

/// @nodoc
class __$$SvgBackgroundImplCopyWithImpl<$Res>
    extends _$BackgroundCopyWithImpl<$Res, _$SvgBackgroundImpl>
    implements _$$SvgBackgroundImplCopyWith<$Res> {
  __$$SvgBackgroundImplCopyWithImpl(
      _$SvgBackgroundImpl _value, $Res Function(_$SvgBackgroundImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? source = null,
    Object? width = null,
    Object? height = null,
    Object? scaleX = null,
    Object? scaleY = null,
  }) {
    return _then(_$SvgBackgroundImpl(
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      scaleX: null == scaleX
          ? _value.scaleX
          : scaleX // ignore: cast_nullable_to_non_nullable
              as double,
      scaleY: null == scaleY
          ? _value.scaleY
          : scaleY // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SvgBackgroundImpl extends SvgBackground {
  _$SvgBackgroundImpl(
      {required this.source,
      required this.width,
      required this.height,
      this.scaleX = 1,
      this.scaleY = 1,
      final String? $type})
      : $type = $type ?? 'svg',
        super._();

  factory _$SvgBackgroundImpl.fromJson(Map<String, dynamic> json) =>
      _$$SvgBackgroundImplFromJson(json);

  @override
  final String source;
  @override
  final double width;
  @override
  final double height;
  @override
  @JsonKey()
  final double scaleX;
  @override
  @JsonKey()
  final double scaleY;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Background.svg(source: $source, width: $width, height: $height, scaleX: $scaleX, scaleY: $scaleY)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SvgBackgroundImplCopyWith<_$SvgBackgroundImpl> get copyWith =>
      __$$SvgBackgroundImplCopyWithImpl<_$SvgBackgroundImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SurfaceTexture texture) texture,
    required TResult Function(String source, double width, double height,
            double scaleX, double scaleY)
        image,
    required TResult Function(String source, double width, double height,
            double scaleX, double scaleY)
        svg,
  }) {
    return svg(source, width, height, scaleX, scaleY);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SurfaceTexture texture)? texture,
    TResult? Function(String source, double width, double height, double scaleX,
            double scaleY)?
        image,
    TResult? Function(String source, double width, double height, double scaleX,
            double scaleY)?
        svg,
  }) {
    return svg?.call(source, width, height, scaleX, scaleY);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SurfaceTexture texture)? texture,
    TResult Function(String source, double width, double height, double scaleX,
            double scaleY)?
        image,
    TResult Function(String source, double width, double height, double scaleX,
            double scaleY)?
        svg,
    required TResult orElse(),
  }) {
    if (svg != null) {
      return svg(source, width, height, scaleX, scaleY);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TextureBackground value) texture,
    required TResult Function(ImageBackground value) image,
    required TResult Function(SvgBackground value) svg,
  }) {
    return svg(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TextureBackground value)? texture,
    TResult? Function(ImageBackground value)? image,
    TResult? Function(SvgBackground value)? svg,
  }) {
    return svg?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TextureBackground value)? texture,
    TResult Function(ImageBackground value)? image,
    TResult Function(SvgBackground value)? svg,
    required TResult orElse(),
  }) {
    if (svg != null) {
      return svg(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SvgBackgroundImplToJson(
      this,
    );
  }
}

abstract class SvgBackground extends Background {
  factory SvgBackground(
      {required final String source,
      required final double width,
      required final double height,
      final double scaleX,
      final double scaleY}) = _$SvgBackgroundImpl;
  SvgBackground._() : super._();

  factory SvgBackground.fromJson(Map<String, dynamic> json) =
      _$SvgBackgroundImpl.fromJson;

  String get source;
  double get width;
  double get height;
  double get scaleX;
  double get scaleY;
  @JsonKey(ignore: true)
  _$$SvgBackgroundImplCopyWith<_$SvgBackgroundImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
