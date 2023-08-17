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
    case 'motif':
      return MotifBackground.fromJson(json);
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
    required TResult Function(Motif motif) motif,
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
    TResult? Function(Motif motif)? motif,
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
    TResult Function(Motif motif)? motif,
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
    required TResult Function(MotifBackground value) motif,
    required TResult Function(ImageBackground value) image,
    required TResult Function(SvgBackground value) svg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MotifBackground value)? motif,
    TResult? Function(ImageBackground value)? image,
    TResult? Function(SvgBackground value)? svg,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MotifBackground value)? motif,
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
abstract class _$$MotifBackgroundCopyWith<$Res> {
  factory _$$MotifBackgroundCopyWith(
          _$MotifBackground value, $Res Function(_$MotifBackground) then) =
      __$$MotifBackgroundCopyWithImpl<$Res>;
  @useResult
  $Res call({Motif motif});

  $MotifCopyWith<$Res> get motif;
}

/// @nodoc
class __$$MotifBackgroundCopyWithImpl<$Res>
    extends _$BackgroundCopyWithImpl<$Res, _$MotifBackground>
    implements _$$MotifBackgroundCopyWith<$Res> {
  __$$MotifBackgroundCopyWithImpl(
      _$MotifBackground _value, $Res Function(_$MotifBackground) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? motif = null,
  }) {
    return _then(_$MotifBackground(
      motif: null == motif
          ? _value.motif
          : motif // ignore: cast_nullable_to_non_nullable
              as Motif,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $MotifCopyWith<$Res> get motif {
    return $MotifCopyWith<$Res>(_value.motif, (value) {
      return _then(_value.copyWith(motif: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$MotifBackground implements MotifBackground {
  _$MotifBackground({required this.motif, final String? $type})
      : $type = $type ?? 'motif';

  factory _$MotifBackground.fromJson(Map<String, dynamic> json) =>
      _$$MotifBackgroundFromJson(json);

  @override
  final Motif motif;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Background.motif(motif: $motif)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MotifBackgroundCopyWith<_$MotifBackground> get copyWith =>
      __$$MotifBackgroundCopyWithImpl<_$MotifBackground>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Motif motif) motif,
    required TResult Function(String source, double width, double height,
            double scaleX, double scaleY)
        image,
    required TResult Function(String source, double width, double height,
            double scaleX, double scaleY)
        svg,
  }) {
    return motif(this.motif);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Motif motif)? motif,
    TResult? Function(String source, double width, double height, double scaleX,
            double scaleY)?
        image,
    TResult? Function(String source, double width, double height, double scaleX,
            double scaleY)?
        svg,
  }) {
    return motif?.call(this.motif);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Motif motif)? motif,
    TResult Function(String source, double width, double height, double scaleX,
            double scaleY)?
        image,
    TResult Function(String source, double width, double height, double scaleX,
            double scaleY)?
        svg,
    required TResult orElse(),
  }) {
    if (motif != null) {
      return motif(this.motif);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(MotifBackground value) motif,
    required TResult Function(ImageBackground value) image,
    required TResult Function(SvgBackground value) svg,
  }) {
    return motif(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MotifBackground value)? motif,
    TResult? Function(ImageBackground value)? image,
    TResult? Function(SvgBackground value)? svg,
  }) {
    return motif?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MotifBackground value)? motif,
    TResult Function(ImageBackground value)? image,
    TResult Function(SvgBackground value)? svg,
    required TResult orElse(),
  }) {
    if (motif != null) {
      return motif(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MotifBackgroundToJson(
      this,
    );
  }
}

abstract class MotifBackground implements Background {
  factory MotifBackground({required final Motif motif}) = _$MotifBackground;

  factory MotifBackground.fromJson(Map<String, dynamic> json) =
      _$MotifBackground.fromJson;

  Motif get motif;
  @JsonKey(ignore: true)
  _$$MotifBackgroundCopyWith<_$MotifBackground> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImageBackgroundCopyWith<$Res> {
  factory _$$ImageBackgroundCopyWith(
          _$ImageBackground value, $Res Function(_$ImageBackground) then) =
      __$$ImageBackgroundCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String source,
      double width,
      double height,
      double scaleX,
      double scaleY});
}

/// @nodoc
class __$$ImageBackgroundCopyWithImpl<$Res>
    extends _$BackgroundCopyWithImpl<$Res, _$ImageBackground>
    implements _$$ImageBackgroundCopyWith<$Res> {
  __$$ImageBackgroundCopyWithImpl(
      _$ImageBackground _value, $Res Function(_$ImageBackground) _then)
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
    return _then(_$ImageBackground(
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
class _$ImageBackground implements ImageBackground {
  _$ImageBackground(
      {required this.source,
      required this.width,
      required this.height,
      this.scaleX = 1,
      this.scaleY = 1,
      final String? $type})
      : $type = $type ?? 'image';

  factory _$ImageBackground.fromJson(Map<String, dynamic> json) =>
      _$$ImageBackgroundFromJson(json);

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
  _$$ImageBackgroundCopyWith<_$ImageBackground> get copyWith =>
      __$$ImageBackgroundCopyWithImpl<_$ImageBackground>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Motif motif) motif,
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
    TResult? Function(Motif motif)? motif,
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
    TResult Function(Motif motif)? motif,
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
    required TResult Function(MotifBackground value) motif,
    required TResult Function(ImageBackground value) image,
    required TResult Function(SvgBackground value) svg,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MotifBackground value)? motif,
    TResult? Function(ImageBackground value)? image,
    TResult? Function(SvgBackground value)? svg,
  }) {
    return image?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MotifBackground value)? motif,
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
    return _$$ImageBackgroundToJson(
      this,
    );
  }
}

abstract class ImageBackground implements Background {
  factory ImageBackground(
      {required final String source,
      required final double width,
      required final double height,
      final double scaleX,
      final double scaleY}) = _$ImageBackground;

  factory ImageBackground.fromJson(Map<String, dynamic> json) =
      _$ImageBackground.fromJson;

  String get source;
  double get width;
  double get height;
  double get scaleX;
  double get scaleY;
  @JsonKey(ignore: true)
  _$$ImageBackgroundCopyWith<_$ImageBackground> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SvgBackgroundCopyWith<$Res> {
  factory _$$SvgBackgroundCopyWith(
          _$SvgBackground value, $Res Function(_$SvgBackground) then) =
      __$$SvgBackgroundCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String source,
      double width,
      double height,
      double scaleX,
      double scaleY});
}

/// @nodoc
class __$$SvgBackgroundCopyWithImpl<$Res>
    extends _$BackgroundCopyWithImpl<$Res, _$SvgBackground>
    implements _$$SvgBackgroundCopyWith<$Res> {
  __$$SvgBackgroundCopyWithImpl(
      _$SvgBackground _value, $Res Function(_$SvgBackground) _then)
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
    return _then(_$SvgBackground(
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
class _$SvgBackground implements SvgBackground {
  _$SvgBackground(
      {required this.source,
      required this.width,
      required this.height,
      this.scaleX = 1,
      this.scaleY = 1,
      final String? $type})
      : $type = $type ?? 'svg';

  factory _$SvgBackground.fromJson(Map<String, dynamic> json) =>
      _$$SvgBackgroundFromJson(json);

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
  _$$SvgBackgroundCopyWith<_$SvgBackground> get copyWith =>
      __$$SvgBackgroundCopyWithImpl<_$SvgBackground>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Motif motif) motif,
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
    TResult? Function(Motif motif)? motif,
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
    TResult Function(Motif motif)? motif,
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
    required TResult Function(MotifBackground value) motif,
    required TResult Function(ImageBackground value) image,
    required TResult Function(SvgBackground value) svg,
  }) {
    return svg(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(MotifBackground value)? motif,
    TResult? Function(ImageBackground value)? image,
    TResult? Function(SvgBackground value)? svg,
  }) {
    return svg?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(MotifBackground value)? motif,
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
    return _$$SvgBackgroundToJson(
      this,
    );
  }
}

abstract class SvgBackground implements Background {
  factory SvgBackground(
      {required final String source,
      required final double width,
      required final double height,
      final double scaleX,
      final double scaleY}) = _$SvgBackground;

  factory SvgBackground.fromJson(Map<String, dynamic> json) =
      _$SvgBackground.fromJson;

  String get source;
  double get width;
  double get height;
  double get scaleX;
  double get scaleY;
  @JsonKey(ignore: true)
  _$$SvgBackgroundCopyWith<_$SvgBackground> get copyWith =>
      throw _privateConstructorUsedError;
}
