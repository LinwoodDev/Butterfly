// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SpanProperty _$SpanPropertyFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'defined':
      return DefinedSpanProperty.fromJson(json);
    case 'named':
      return NamedSpanProperty.fromJson(json);
    case 'undefined':
      return UndefinedSpanProperty.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'SpanProperty',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$SpanProperty {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double? size,
            int? color,
            int? fontWeight,
            bool? lineThrough,
            bool? underline,
            bool? overline,
            bool? italic,
            double? letterSpacing,
            int? decorationColor,
            TextDecorationStyle? decorationStyle,
            double? decorationThickness,
            int? backgroundColor)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double? size,
            int? color,
            int? fontWeight,
            bool? lineThrough,
            bool? underline,
            bool? overline,
            bool? italic,
            double? letterSpacing,
            int? decorationColor,
            TextDecorationStyle? decorationStyle,
            double? decorationThickness,
            int? backgroundColor)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double? size,
            int? color,
            int? fontWeight,
            bool? lineThrough,
            bool? underline,
            bool? overline,
            bool? italic,
            double? letterSpacing,
            int? decorationColor,
            TextDecorationStyle? decorationStyle,
            double? decorationThickness,
            int? backgroundColor)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DefinedSpanProperty value) defined,
    required TResult Function(NamedSpanProperty value) named,
    required TResult Function(UndefinedSpanProperty value) undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DefinedSpanProperty value)? defined,
    TResult? Function(NamedSpanProperty value)? named,
    TResult? Function(UndefinedSpanProperty value)? undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedSpanProperty value)? defined,
    TResult Function(NamedSpanProperty value)? named,
    TResult Function(UndefinedSpanProperty value)? undefined,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpanPropertyCopyWith<$Res> {
  factory $SpanPropertyCopyWith(
          SpanProperty value, $Res Function(SpanProperty) then) =
      _$SpanPropertyCopyWithImpl<$Res, SpanProperty>;
}

/// @nodoc
class _$SpanPropertyCopyWithImpl<$Res, $Val extends SpanProperty>
    implements $SpanPropertyCopyWith<$Res> {
  _$SpanPropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$DefinedSpanPropertyImplCopyWith<$Res> {
  factory _$$DefinedSpanPropertyImplCopyWith(_$DefinedSpanPropertyImpl value,
          $Res Function(_$DefinedSpanPropertyImpl) then) =
      __$$DefinedSpanPropertyImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {double? size,
      int? color,
      int? fontWeight,
      bool? lineThrough,
      bool? underline,
      bool? overline,
      bool? italic,
      double? letterSpacing,
      int? decorationColor,
      TextDecorationStyle? decorationStyle,
      double? decorationThickness,
      int? backgroundColor});
}

/// @nodoc
class __$$DefinedSpanPropertyImplCopyWithImpl<$Res>
    extends _$SpanPropertyCopyWithImpl<$Res, _$DefinedSpanPropertyImpl>
    implements _$$DefinedSpanPropertyImplCopyWith<$Res> {
  __$$DefinedSpanPropertyImplCopyWithImpl(_$DefinedSpanPropertyImpl _value,
      $Res Function(_$DefinedSpanPropertyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? size = freezed,
    Object? color = freezed,
    Object? fontWeight = freezed,
    Object? lineThrough = freezed,
    Object? underline = freezed,
    Object? overline = freezed,
    Object? italic = freezed,
    Object? letterSpacing = freezed,
    Object? decorationColor = freezed,
    Object? decorationStyle = freezed,
    Object? decorationThickness = freezed,
    Object? backgroundColor = freezed,
  }) {
    return _then(_$DefinedSpanPropertyImpl(
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
      fontWeight: freezed == fontWeight
          ? _value.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as int?,
      lineThrough: freezed == lineThrough
          ? _value.lineThrough
          : lineThrough // ignore: cast_nullable_to_non_nullable
              as bool?,
      underline: freezed == underline
          ? _value.underline
          : underline // ignore: cast_nullable_to_non_nullable
              as bool?,
      overline: freezed == overline
          ? _value.overline
          : overline // ignore: cast_nullable_to_non_nullable
              as bool?,
      italic: freezed == italic
          ? _value.italic
          : italic // ignore: cast_nullable_to_non_nullable
              as bool?,
      letterSpacing: freezed == letterSpacing
          ? _value.letterSpacing
          : letterSpacing // ignore: cast_nullable_to_non_nullable
              as double?,
      decorationColor: freezed == decorationColor
          ? _value.decorationColor
          : decorationColor // ignore: cast_nullable_to_non_nullable
              as int?,
      decorationStyle: freezed == decorationStyle
          ? _value.decorationStyle
          : decorationStyle // ignore: cast_nullable_to_non_nullable
              as TextDecorationStyle?,
      decorationThickness: freezed == decorationThickness
          ? _value.decorationThickness
          : decorationThickness // ignore: cast_nullable_to_non_nullable
              as double?,
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DefinedSpanPropertyImpl implements DefinedSpanProperty {
  const _$DefinedSpanPropertyImpl(
      {this.size,
      this.color,
      this.fontWeight,
      this.lineThrough,
      this.underline,
      this.overline,
      this.italic,
      this.letterSpacing,
      this.decorationColor,
      this.decorationStyle,
      this.decorationThickness,
      this.backgroundColor,
      final String? $type})
      : $type = $type ?? 'defined';

  factory _$DefinedSpanPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$DefinedSpanPropertyImplFromJson(json);

  @override
  final double? size;
  @override
  final int? color;
  @override
  final int? fontWeight;
  @override
  final bool? lineThrough;
  @override
  final bool? underline;
  @override
  final bool? overline;
  @override
  final bool? italic;
  @override
  final double? letterSpacing;
  @override
  final int? decorationColor;
  @override
  final TextDecorationStyle? decorationStyle;
  @override
  final double? decorationThickness;
  @override
  final int? backgroundColor;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'SpanProperty.defined(size: $size, color: $color, fontWeight: $fontWeight, lineThrough: $lineThrough, underline: $underline, overline: $overline, italic: $italic, letterSpacing: $letterSpacing, decorationColor: $decorationColor, decorationStyle: $decorationStyle, decorationThickness: $decorationThickness, backgroundColor: $backgroundColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DefinedSpanPropertyImpl &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.fontWeight, fontWeight) ||
                other.fontWeight == fontWeight) &&
            (identical(other.lineThrough, lineThrough) ||
                other.lineThrough == lineThrough) &&
            (identical(other.underline, underline) ||
                other.underline == underline) &&
            (identical(other.overline, overline) ||
                other.overline == overline) &&
            (identical(other.italic, italic) || other.italic == italic) &&
            (identical(other.letterSpacing, letterSpacing) ||
                other.letterSpacing == letterSpacing) &&
            (identical(other.decorationColor, decorationColor) ||
                other.decorationColor == decorationColor) &&
            (identical(other.decorationStyle, decorationStyle) ||
                other.decorationStyle == decorationStyle) &&
            (identical(other.decorationThickness, decorationThickness) ||
                other.decorationThickness == decorationThickness) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      size,
      color,
      fontWeight,
      lineThrough,
      underline,
      overline,
      italic,
      letterSpacing,
      decorationColor,
      decorationStyle,
      decorationThickness,
      backgroundColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DefinedSpanPropertyImplCopyWith<_$DefinedSpanPropertyImpl> get copyWith =>
      __$$DefinedSpanPropertyImplCopyWithImpl<_$DefinedSpanPropertyImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double? size,
            int? color,
            int? fontWeight,
            bool? lineThrough,
            bool? underline,
            bool? overline,
            bool? italic,
            double? letterSpacing,
            int? decorationColor,
            TextDecorationStyle? decorationStyle,
            double? decorationThickness,
            int? backgroundColor)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) {
    return defined(
        size,
        color,
        fontWeight,
        lineThrough,
        underline,
        overline,
        italic,
        letterSpacing,
        decorationColor,
        decorationStyle,
        decorationThickness,
        backgroundColor);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double? size,
            int? color,
            int? fontWeight,
            bool? lineThrough,
            bool? underline,
            bool? overline,
            bool? italic,
            double? letterSpacing,
            int? decorationColor,
            TextDecorationStyle? decorationStyle,
            double? decorationThickness,
            int? backgroundColor)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) {
    return defined?.call(
        size,
        color,
        fontWeight,
        lineThrough,
        underline,
        overline,
        italic,
        letterSpacing,
        decorationColor,
        decorationStyle,
        decorationThickness,
        backgroundColor);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double? size,
            int? color,
            int? fontWeight,
            bool? lineThrough,
            bool? underline,
            bool? overline,
            bool? italic,
            double? letterSpacing,
            int? decorationColor,
            TextDecorationStyle? decorationStyle,
            double? decorationThickness,
            int? backgroundColor)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (defined != null) {
      return defined(
          size,
          color,
          fontWeight,
          lineThrough,
          underline,
          overline,
          italic,
          letterSpacing,
          decorationColor,
          decorationStyle,
          decorationThickness,
          backgroundColor);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DefinedSpanProperty value) defined,
    required TResult Function(NamedSpanProperty value) named,
    required TResult Function(UndefinedSpanProperty value) undefined,
  }) {
    return defined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DefinedSpanProperty value)? defined,
    TResult? Function(NamedSpanProperty value)? named,
    TResult? Function(UndefinedSpanProperty value)? undefined,
  }) {
    return defined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedSpanProperty value)? defined,
    TResult Function(NamedSpanProperty value)? named,
    TResult Function(UndefinedSpanProperty value)? undefined,
    required TResult orElse(),
  }) {
    if (defined != null) {
      return defined(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DefinedSpanPropertyImplToJson(
      this,
    );
  }
}

abstract class DefinedSpanProperty implements SpanProperty {
  const factory DefinedSpanProperty(
      {final double? size,
      final int? color,
      final int? fontWeight,
      final bool? lineThrough,
      final bool? underline,
      final bool? overline,
      final bool? italic,
      final double? letterSpacing,
      final int? decorationColor,
      final TextDecorationStyle? decorationStyle,
      final double? decorationThickness,
      final int? backgroundColor}) = _$DefinedSpanPropertyImpl;

  factory DefinedSpanProperty.fromJson(Map<String, dynamic> json) =
      _$DefinedSpanPropertyImpl.fromJson;

  double? get size;
  int? get color;
  int? get fontWeight;
  bool? get lineThrough;
  bool? get underline;
  bool? get overline;
  bool? get italic;
  double? get letterSpacing;
  int? get decorationColor;
  TextDecorationStyle? get decorationStyle;
  double? get decorationThickness;
  int? get backgroundColor;
  @JsonKey(ignore: true)
  _$$DefinedSpanPropertyImplCopyWith<_$DefinedSpanPropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NamedSpanPropertyImplCopyWith<$Res> {
  factory _$$NamedSpanPropertyImplCopyWith(_$NamedSpanPropertyImpl value,
          $Res Function(_$NamedSpanPropertyImpl) then) =
      __$$NamedSpanPropertyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$NamedSpanPropertyImplCopyWithImpl<$Res>
    extends _$SpanPropertyCopyWithImpl<$Res, _$NamedSpanPropertyImpl>
    implements _$$NamedSpanPropertyImplCopyWith<$Res> {
  __$$NamedSpanPropertyImplCopyWithImpl(_$NamedSpanPropertyImpl _value,
      $Res Function(_$NamedSpanPropertyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$NamedSpanPropertyImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NamedSpanPropertyImpl implements NamedSpanProperty {
  const _$NamedSpanPropertyImpl(this.name, {final String? $type})
      : $type = $type ?? 'named';

  factory _$NamedSpanPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$NamedSpanPropertyImplFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'SpanProperty.named(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NamedSpanPropertyImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NamedSpanPropertyImplCopyWith<_$NamedSpanPropertyImpl> get copyWith =>
      __$$NamedSpanPropertyImplCopyWithImpl<_$NamedSpanPropertyImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double? size,
            int? color,
            int? fontWeight,
            bool? lineThrough,
            bool? underline,
            bool? overline,
            bool? italic,
            double? letterSpacing,
            int? decorationColor,
            TextDecorationStyle? decorationStyle,
            double? decorationThickness,
            int? backgroundColor)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) {
    return named(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double? size,
            int? color,
            int? fontWeight,
            bool? lineThrough,
            bool? underline,
            bool? overline,
            bool? italic,
            double? letterSpacing,
            int? decorationColor,
            TextDecorationStyle? decorationStyle,
            double? decorationThickness,
            int? backgroundColor)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) {
    return named?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double? size,
            int? color,
            int? fontWeight,
            bool? lineThrough,
            bool? underline,
            bool? overline,
            bool? italic,
            double? letterSpacing,
            int? decorationColor,
            TextDecorationStyle? decorationStyle,
            double? decorationThickness,
            int? backgroundColor)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (named != null) {
      return named(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DefinedSpanProperty value) defined,
    required TResult Function(NamedSpanProperty value) named,
    required TResult Function(UndefinedSpanProperty value) undefined,
  }) {
    return named(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DefinedSpanProperty value)? defined,
    TResult? Function(NamedSpanProperty value)? named,
    TResult? Function(UndefinedSpanProperty value)? undefined,
  }) {
    return named?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedSpanProperty value)? defined,
    TResult Function(NamedSpanProperty value)? named,
    TResult Function(UndefinedSpanProperty value)? undefined,
    required TResult orElse(),
  }) {
    if (named != null) {
      return named(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NamedSpanPropertyImplToJson(
      this,
    );
  }
}

abstract class NamedSpanProperty implements SpanProperty {
  const factory NamedSpanProperty(final String name) = _$NamedSpanPropertyImpl;

  factory NamedSpanProperty.fromJson(Map<String, dynamic> json) =
      _$NamedSpanPropertyImpl.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$NamedSpanPropertyImplCopyWith<_$NamedSpanPropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UndefinedSpanPropertyImplCopyWith<$Res> {
  factory _$$UndefinedSpanPropertyImplCopyWith(
          _$UndefinedSpanPropertyImpl value,
          $Res Function(_$UndefinedSpanPropertyImpl) then) =
      __$$UndefinedSpanPropertyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UndefinedSpanPropertyImplCopyWithImpl<$Res>
    extends _$SpanPropertyCopyWithImpl<$Res, _$UndefinedSpanPropertyImpl>
    implements _$$UndefinedSpanPropertyImplCopyWith<$Res> {
  __$$UndefinedSpanPropertyImplCopyWithImpl(_$UndefinedSpanPropertyImpl _value,
      $Res Function(_$UndefinedSpanPropertyImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$UndefinedSpanPropertyImpl implements UndefinedSpanProperty {
  const _$UndefinedSpanPropertyImpl({final String? $type})
      : $type = $type ?? 'undefined';

  factory _$UndefinedSpanPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$UndefinedSpanPropertyImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'SpanProperty.undefined()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UndefinedSpanPropertyImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            double? size,
            int? color,
            int? fontWeight,
            bool? lineThrough,
            bool? underline,
            bool? overline,
            bool? italic,
            double? letterSpacing,
            int? decorationColor,
            TextDecorationStyle? decorationStyle,
            double? decorationThickness,
            int? backgroundColor)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) {
    return undefined();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double? size,
            int? color,
            int? fontWeight,
            bool? lineThrough,
            bool? underline,
            bool? overline,
            bool? italic,
            double? letterSpacing,
            int? decorationColor,
            TextDecorationStyle? decorationStyle,
            double? decorationThickness,
            int? backgroundColor)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) {
    return undefined?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double? size,
            int? color,
            int? fontWeight,
            bool? lineThrough,
            bool? underline,
            bool? overline,
            bool? italic,
            double? letterSpacing,
            int? decorationColor,
            TextDecorationStyle? decorationStyle,
            double? decorationThickness,
            int? backgroundColor)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (undefined != null) {
      return undefined();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DefinedSpanProperty value) defined,
    required TResult Function(NamedSpanProperty value) named,
    required TResult Function(UndefinedSpanProperty value) undefined,
  }) {
    return undefined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DefinedSpanProperty value)? defined,
    TResult? Function(NamedSpanProperty value)? named,
    TResult? Function(UndefinedSpanProperty value)? undefined,
  }) {
    return undefined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedSpanProperty value)? defined,
    TResult Function(NamedSpanProperty value)? named,
    TResult Function(UndefinedSpanProperty value)? undefined,
    required TResult orElse(),
  }) {
    if (undefined != null) {
      return undefined(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UndefinedSpanPropertyImplToJson(
      this,
    );
  }
}

abstract class UndefinedSpanProperty implements SpanProperty {
  const factory UndefinedSpanProperty() = _$UndefinedSpanPropertyImpl;

  factory UndefinedSpanProperty.fromJson(Map<String, dynamic> json) =
      _$UndefinedSpanPropertyImpl.fromJson;
}

ParagraphProperty _$ParagraphPropertyFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'defined':
      return DefinedParagraphProperty.fromJson(json);
    case 'named':
      return NamedParagraphProperty.fromJson(json);
    case 'undefined':
      return UndefinedParagraphProperty.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'ParagraphProperty',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$ParagraphProperty {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DefinedSpanProperty span, HorizontalAlignment alignment)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DefinedSpanProperty span, HorizontalAlignment alignment)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DefinedSpanProperty span, HorizontalAlignment alignment)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DefinedParagraphProperty value) defined,
    required TResult Function(NamedParagraphProperty value) named,
    required TResult Function(UndefinedParagraphProperty value) undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DefinedParagraphProperty value)? defined,
    TResult? Function(NamedParagraphProperty value)? named,
    TResult? Function(UndefinedParagraphProperty value)? undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedParagraphProperty value)? defined,
    TResult Function(NamedParagraphProperty value)? named,
    TResult Function(UndefinedParagraphProperty value)? undefined,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParagraphPropertyCopyWith<$Res> {
  factory $ParagraphPropertyCopyWith(
          ParagraphProperty value, $Res Function(ParagraphProperty) then) =
      _$ParagraphPropertyCopyWithImpl<$Res, ParagraphProperty>;
}

/// @nodoc
class _$ParagraphPropertyCopyWithImpl<$Res, $Val extends ParagraphProperty>
    implements $ParagraphPropertyCopyWith<$Res> {
  _$ParagraphPropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$DefinedParagraphPropertyImplCopyWith<$Res> {
  factory _$$DefinedParagraphPropertyImplCopyWith(
          _$DefinedParagraphPropertyImpl value,
          $Res Function(_$DefinedParagraphPropertyImpl) then) =
      __$$DefinedParagraphPropertyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DefinedSpanProperty span, HorizontalAlignment alignment});
}

/// @nodoc
class __$$DefinedParagraphPropertyImplCopyWithImpl<$Res>
    extends _$ParagraphPropertyCopyWithImpl<$Res,
        _$DefinedParagraphPropertyImpl>
    implements _$$DefinedParagraphPropertyImplCopyWith<$Res> {
  __$$DefinedParagraphPropertyImplCopyWithImpl(
      _$DefinedParagraphPropertyImpl _value,
      $Res Function(_$DefinedParagraphPropertyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? span = freezed,
    Object? alignment = null,
  }) {
    return _then(_$DefinedParagraphPropertyImpl(
      span: freezed == span
          ? _value.span
          : span // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
      alignment: null == alignment
          ? _value.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as HorizontalAlignment,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DefinedParagraphPropertyImpl implements DefinedParagraphProperty {
  const _$DefinedParagraphPropertyImpl(
      {this.span = const DefinedSpanProperty(),
      this.alignment = HorizontalAlignment.left,
      final String? $type})
      : $type = $type ?? 'defined';

  factory _$DefinedParagraphPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$DefinedParagraphPropertyImplFromJson(json);

  @override
  @JsonKey()
  final DefinedSpanProperty span;
  @override
  @JsonKey()
  final HorizontalAlignment alignment;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ParagraphProperty.defined(span: $span, alignment: $alignment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DefinedParagraphPropertyImpl &&
            const DeepCollectionEquality().equals(other.span, span) &&
            (identical(other.alignment, alignment) ||
                other.alignment == alignment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(span), alignment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DefinedParagraphPropertyImplCopyWith<_$DefinedParagraphPropertyImpl>
      get copyWith => __$$DefinedParagraphPropertyImplCopyWithImpl<
          _$DefinedParagraphPropertyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DefinedSpanProperty span, HorizontalAlignment alignment)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) {
    return defined(span, alignment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DefinedSpanProperty span, HorizontalAlignment alignment)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) {
    return defined?.call(span, alignment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DefinedSpanProperty span, HorizontalAlignment alignment)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (defined != null) {
      return defined(span, alignment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DefinedParagraphProperty value) defined,
    required TResult Function(NamedParagraphProperty value) named,
    required TResult Function(UndefinedParagraphProperty value) undefined,
  }) {
    return defined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DefinedParagraphProperty value)? defined,
    TResult? Function(NamedParagraphProperty value)? named,
    TResult? Function(UndefinedParagraphProperty value)? undefined,
  }) {
    return defined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedParagraphProperty value)? defined,
    TResult Function(NamedParagraphProperty value)? named,
    TResult Function(UndefinedParagraphProperty value)? undefined,
    required TResult orElse(),
  }) {
    if (defined != null) {
      return defined(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DefinedParagraphPropertyImplToJson(
      this,
    );
  }
}

abstract class DefinedParagraphProperty implements ParagraphProperty {
  const factory DefinedParagraphProperty(
      {final DefinedSpanProperty span,
      final HorizontalAlignment alignment}) = _$DefinedParagraphPropertyImpl;

  factory DefinedParagraphProperty.fromJson(Map<String, dynamic> json) =
      _$DefinedParagraphPropertyImpl.fromJson;

  DefinedSpanProperty get span;
  HorizontalAlignment get alignment;
  @JsonKey(ignore: true)
  _$$DefinedParagraphPropertyImplCopyWith<_$DefinedParagraphPropertyImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NamedParagraphPropertyImplCopyWith<$Res> {
  factory _$$NamedParagraphPropertyImplCopyWith(
          _$NamedParagraphPropertyImpl value,
          $Res Function(_$NamedParagraphPropertyImpl) then) =
      __$$NamedParagraphPropertyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$NamedParagraphPropertyImplCopyWithImpl<$Res>
    extends _$ParagraphPropertyCopyWithImpl<$Res, _$NamedParagraphPropertyImpl>
    implements _$$NamedParagraphPropertyImplCopyWith<$Res> {
  __$$NamedParagraphPropertyImplCopyWithImpl(
      _$NamedParagraphPropertyImpl _value,
      $Res Function(_$NamedParagraphPropertyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$NamedParagraphPropertyImpl(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NamedParagraphPropertyImpl implements NamedParagraphProperty {
  const _$NamedParagraphPropertyImpl(this.name, {final String? $type})
      : $type = $type ?? 'named';

  factory _$NamedParagraphPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$NamedParagraphPropertyImplFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ParagraphProperty.named(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NamedParagraphPropertyImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NamedParagraphPropertyImplCopyWith<_$NamedParagraphPropertyImpl>
      get copyWith => __$$NamedParagraphPropertyImplCopyWithImpl<
          _$NamedParagraphPropertyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DefinedSpanProperty span, HorizontalAlignment alignment)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) {
    return named(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DefinedSpanProperty span, HorizontalAlignment alignment)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) {
    return named?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DefinedSpanProperty span, HorizontalAlignment alignment)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (named != null) {
      return named(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DefinedParagraphProperty value) defined,
    required TResult Function(NamedParagraphProperty value) named,
    required TResult Function(UndefinedParagraphProperty value) undefined,
  }) {
    return named(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DefinedParagraphProperty value)? defined,
    TResult? Function(NamedParagraphProperty value)? named,
    TResult? Function(UndefinedParagraphProperty value)? undefined,
  }) {
    return named?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedParagraphProperty value)? defined,
    TResult Function(NamedParagraphProperty value)? named,
    TResult Function(UndefinedParagraphProperty value)? undefined,
    required TResult orElse(),
  }) {
    if (named != null) {
      return named(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NamedParagraphPropertyImplToJson(
      this,
    );
  }
}

abstract class NamedParagraphProperty implements ParagraphProperty {
  const factory NamedParagraphProperty(final String name) =
      _$NamedParagraphPropertyImpl;

  factory NamedParagraphProperty.fromJson(Map<String, dynamic> json) =
      _$NamedParagraphPropertyImpl.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$NamedParagraphPropertyImplCopyWith<_$NamedParagraphPropertyImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UndefinedParagraphPropertyImplCopyWith<$Res> {
  factory _$$UndefinedParagraphPropertyImplCopyWith(
          _$UndefinedParagraphPropertyImpl value,
          $Res Function(_$UndefinedParagraphPropertyImpl) then) =
      __$$UndefinedParagraphPropertyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UndefinedParagraphPropertyImplCopyWithImpl<$Res>
    extends _$ParagraphPropertyCopyWithImpl<$Res,
        _$UndefinedParagraphPropertyImpl>
    implements _$$UndefinedParagraphPropertyImplCopyWith<$Res> {
  __$$UndefinedParagraphPropertyImplCopyWithImpl(
      _$UndefinedParagraphPropertyImpl _value,
      $Res Function(_$UndefinedParagraphPropertyImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$UndefinedParagraphPropertyImpl implements UndefinedParagraphProperty {
  const _$UndefinedParagraphPropertyImpl({final String? $type})
      : $type = $type ?? 'undefined';

  factory _$UndefinedParagraphPropertyImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$UndefinedParagraphPropertyImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ParagraphProperty.undefined()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UndefinedParagraphPropertyImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            DefinedSpanProperty span, HorizontalAlignment alignment)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) {
    return undefined();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DefinedSpanProperty span, HorizontalAlignment alignment)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) {
    return undefined?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DefinedSpanProperty span, HorizontalAlignment alignment)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (undefined != null) {
      return undefined();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DefinedParagraphProperty value) defined,
    required TResult Function(NamedParagraphProperty value) named,
    required TResult Function(UndefinedParagraphProperty value) undefined,
  }) {
    return undefined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DefinedParagraphProperty value)? defined,
    TResult? Function(NamedParagraphProperty value)? named,
    TResult? Function(UndefinedParagraphProperty value)? undefined,
  }) {
    return undefined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedParagraphProperty value)? defined,
    TResult Function(NamedParagraphProperty value)? named,
    TResult Function(UndefinedParagraphProperty value)? undefined,
    required TResult orElse(),
  }) {
    if (undefined != null) {
      return undefined(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UndefinedParagraphPropertyImplToJson(
      this,
    );
  }
}

abstract class UndefinedParagraphProperty implements ParagraphProperty {
  const factory UndefinedParagraphProperty() = _$UndefinedParagraphPropertyImpl;

  factory UndefinedParagraphProperty.fromJson(Map<String, dynamic> json) =
      _$UndefinedParagraphPropertyImpl.fromJson;
}

AreaProperty _$AreaPropertyFromJson(Map<String, dynamic> json) {
  return _AreaProperty.fromJson(json);
}

/// @nodoc
mixin _$AreaProperty {
  VerticalAlignment get alignment => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AreaPropertyCopyWith<AreaProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreaPropertyCopyWith<$Res> {
  factory $AreaPropertyCopyWith(
          AreaProperty value, $Res Function(AreaProperty) then) =
      _$AreaPropertyCopyWithImpl<$Res, AreaProperty>;
  @useResult
  $Res call({VerticalAlignment alignment});
}

/// @nodoc
class _$AreaPropertyCopyWithImpl<$Res, $Val extends AreaProperty>
    implements $AreaPropertyCopyWith<$Res> {
  _$AreaPropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alignment = null,
  }) {
    return _then(_value.copyWith(
      alignment: null == alignment
          ? _value.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as VerticalAlignment,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AreaPropertyImplCopyWith<$Res>
    implements $AreaPropertyCopyWith<$Res> {
  factory _$$AreaPropertyImplCopyWith(
          _$AreaPropertyImpl value, $Res Function(_$AreaPropertyImpl) then) =
      __$$AreaPropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({VerticalAlignment alignment});
}

/// @nodoc
class __$$AreaPropertyImplCopyWithImpl<$Res>
    extends _$AreaPropertyCopyWithImpl<$Res, _$AreaPropertyImpl>
    implements _$$AreaPropertyImplCopyWith<$Res> {
  __$$AreaPropertyImplCopyWithImpl(
      _$AreaPropertyImpl _value, $Res Function(_$AreaPropertyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alignment = null,
  }) {
    return _then(_$AreaPropertyImpl(
      alignment: null == alignment
          ? _value.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as VerticalAlignment,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaPropertyImpl implements _AreaProperty {
  const _$AreaPropertyImpl({this.alignment = VerticalAlignment.top});

  factory _$AreaPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AreaPropertyImplFromJson(json);

  @override
  @JsonKey()
  final VerticalAlignment alignment;

  @override
  String toString() {
    return 'AreaProperty(alignment: $alignment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaPropertyImpl &&
            (identical(other.alignment, alignment) ||
                other.alignment == alignment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, alignment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaPropertyImplCopyWith<_$AreaPropertyImpl> get copyWith =>
      __$$AreaPropertyImplCopyWithImpl<_$AreaPropertyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaPropertyImplToJson(
      this,
    );
  }
}

abstract class _AreaProperty implements AreaProperty {
  const factory _AreaProperty({final VerticalAlignment alignment}) =
      _$AreaPropertyImpl;

  factory _AreaProperty.fromJson(Map<String, dynamic> json) =
      _$AreaPropertyImpl.fromJson;

  @override
  VerticalAlignment get alignment;
  @override
  @JsonKey(ignore: true)
  _$$AreaPropertyImplCopyWith<_$AreaPropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TextSpan _$TextSpanFromJson(Map<String, dynamic> json) {
  return _TextSpan.fromJson(json);
}

/// @nodoc
mixin _$TextSpan {
  String get text => throw _privateConstructorUsedError;
  SpanProperty get property => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text, SpanProperty property) text,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text, SpanProperty property)? text,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text, SpanProperty property)? text,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TextSpan value) text,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TextSpan value)? text,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TextSpan value)? text,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TextSpanCopyWith<TextSpan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextSpanCopyWith<$Res> {
  factory $TextSpanCopyWith(TextSpan value, $Res Function(TextSpan) then) =
      _$TextSpanCopyWithImpl<$Res, TextSpan>;
  @useResult
  $Res call({String text, SpanProperty property});

  $SpanPropertyCopyWith<$Res> get property;
}

/// @nodoc
class _$TextSpanCopyWithImpl<$Res, $Val extends TextSpan>
    implements $TextSpanCopyWith<$Res> {
  _$TextSpanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? property = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      property: null == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as SpanProperty,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SpanPropertyCopyWith<$Res> get property {
    return $SpanPropertyCopyWith<$Res>(_value.property, (value) {
      return _then(_value.copyWith(property: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TextSpanImplCopyWith<$Res>
    implements $TextSpanCopyWith<$Res> {
  factory _$$TextSpanImplCopyWith(
          _$TextSpanImpl value, $Res Function(_$TextSpanImpl) then) =
      __$$TextSpanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, SpanProperty property});

  @override
  $SpanPropertyCopyWith<$Res> get property;
}

/// @nodoc
class __$$TextSpanImplCopyWithImpl<$Res>
    extends _$TextSpanCopyWithImpl<$Res, _$TextSpanImpl>
    implements _$$TextSpanImplCopyWith<$Res> {
  __$$TextSpanImplCopyWithImpl(
      _$TextSpanImpl _value, $Res Function(_$TextSpanImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? property = null,
  }) {
    return _then(_$TextSpanImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      property: null == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as SpanProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TextSpanImpl extends _TextSpan {
  const _$TextSpanImpl(
      {this.text = '', this.property = const SpanProperty.undefined()})
      : super._();

  factory _$TextSpanImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextSpanImplFromJson(json);

  @override
  @JsonKey()
  final String text;
  @override
  @JsonKey()
  final SpanProperty property;

  @override
  String toString() {
    return 'TextSpan.text(text: $text, property: $property)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextSpanImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.property, property) ||
                other.property == property));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, property);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextSpanImplCopyWith<_$TextSpanImpl> get copyWith =>
      __$$TextSpanImplCopyWithImpl<_$TextSpanImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text, SpanProperty property) text,
  }) {
    return text(this.text, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text, SpanProperty property)? text,
  }) {
    return text?.call(this.text, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text, SpanProperty property)? text,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this.text, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TextSpan value) text,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TextSpan value)? text,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TextSpan value)? text,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TextSpanImplToJson(
      this,
    );
  }
}

abstract class _TextSpan extends TextSpan {
  const factory _TextSpan({final String text, final SpanProperty property}) =
      _$TextSpanImpl;
  const _TextSpan._() : super._();

  factory _TextSpan.fromJson(Map<String, dynamic> json) =
      _$TextSpanImpl.fromJson;

  @override
  String get text;
  @override
  SpanProperty get property;
  @override
  @JsonKey(ignore: true)
  _$$TextSpanImplCopyWith<_$TextSpanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IndexedModel<T> {
  int get index => throw _privateConstructorUsedError;
  T get model => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $IndexedModelCopyWith<T, IndexedModel<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndexedModelCopyWith<T, $Res> {
  factory $IndexedModelCopyWith(
          IndexedModel<T> value, $Res Function(IndexedModel<T>) then) =
      _$IndexedModelCopyWithImpl<T, $Res, IndexedModel<T>>;
  @useResult
  $Res call({int index, T model});
}

/// @nodoc
class _$IndexedModelCopyWithImpl<T, $Res, $Val extends IndexedModel<T>>
    implements $IndexedModelCopyWith<T, $Res> {
  _$IndexedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? model = freezed,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IndexedModelImplCopyWith<T, $Res>
    implements $IndexedModelCopyWith<T, $Res> {
  factory _$$IndexedModelImplCopyWith(_$IndexedModelImpl<T> value,
          $Res Function(_$IndexedModelImpl<T>) then) =
      __$$IndexedModelImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({int index, T model});
}

/// @nodoc
class __$$IndexedModelImplCopyWithImpl<T, $Res>
    extends _$IndexedModelCopyWithImpl<T, $Res, _$IndexedModelImpl<T>>
    implements _$$IndexedModelImplCopyWith<T, $Res> {
  __$$IndexedModelImplCopyWithImpl(
      _$IndexedModelImpl<T> _value, $Res Function(_$IndexedModelImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? model = freezed,
  }) {
    return _then(_$IndexedModelImpl<T>(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$IndexedModelImpl<T> implements _IndexedModel<T> {
  const _$IndexedModelImpl(this.index, this.model);

  @override
  final int index;
  @override
  final T model;

  @override
  String toString() {
    return 'IndexedModel<$T>(index: $index, model: $model)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IndexedModelImpl<T> &&
            (identical(other.index, index) || other.index == index) &&
            const DeepCollectionEquality().equals(other.model, model));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, index, const DeepCollectionEquality().hash(model));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IndexedModelImplCopyWith<T, _$IndexedModelImpl<T>> get copyWith =>
      __$$IndexedModelImplCopyWithImpl<T, _$IndexedModelImpl<T>>(
          this, _$identity);
}

abstract class _IndexedModel<T> implements IndexedModel<T> {
  const factory _IndexedModel(final int index, final T model) =
      _$IndexedModelImpl<T>;

  @override
  int get index;
  @override
  T get model;
  @override
  @JsonKey(ignore: true)
  _$$IndexedModelImplCopyWith<T, _$IndexedModelImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

TextParagraph _$TextParagraphFromJson(Map<String, dynamic> json) {
  return _ParagraphProperty.fromJson(json);
}

/// @nodoc
mixin _$TextParagraph {
  ParagraphProperty get property => throw _privateConstructorUsedError;
  List<TextSpan> get textSpans => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ParagraphProperty property, List<TextSpan> textSpans)
        text,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ParagraphProperty property, List<TextSpan> textSpans)?
        text,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParagraphProperty property, List<TextSpan> textSpans)?
        text,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ParagraphProperty value) text,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParagraphProperty value)? text,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParagraphProperty value)? text,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TextParagraphCopyWith<TextParagraph> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextParagraphCopyWith<$Res> {
  factory $TextParagraphCopyWith(
          TextParagraph value, $Res Function(TextParagraph) then) =
      _$TextParagraphCopyWithImpl<$Res, TextParagraph>;
  @useResult
  $Res call({ParagraphProperty property, List<TextSpan> textSpans});

  $ParagraphPropertyCopyWith<$Res> get property;
}

/// @nodoc
class _$TextParagraphCopyWithImpl<$Res, $Val extends TextParagraph>
    implements $TextParagraphCopyWith<$Res> {
  _$TextParagraphCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? property = null,
    Object? textSpans = null,
  }) {
    return _then(_value.copyWith(
      property: null == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as ParagraphProperty,
      textSpans: null == textSpans
          ? _value.textSpans
          : textSpans // ignore: cast_nullable_to_non_nullable
              as List<TextSpan>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ParagraphPropertyCopyWith<$Res> get property {
    return $ParagraphPropertyCopyWith<$Res>(_value.property, (value) {
      return _then(_value.copyWith(property: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ParagraphPropertyImplCopyWith<$Res>
    implements $TextParagraphCopyWith<$Res> {
  factory _$$ParagraphPropertyImplCopyWith(_$ParagraphPropertyImpl value,
          $Res Function(_$ParagraphPropertyImpl) then) =
      __$$ParagraphPropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ParagraphProperty property, List<TextSpan> textSpans});

  @override
  $ParagraphPropertyCopyWith<$Res> get property;
}

/// @nodoc
class __$$ParagraphPropertyImplCopyWithImpl<$Res>
    extends _$TextParagraphCopyWithImpl<$Res, _$ParagraphPropertyImpl>
    implements _$$ParagraphPropertyImplCopyWith<$Res> {
  __$$ParagraphPropertyImplCopyWithImpl(_$ParagraphPropertyImpl _value,
      $Res Function(_$ParagraphPropertyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? property = null,
    Object? textSpans = null,
  }) {
    return _then(_$ParagraphPropertyImpl(
      property: null == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as ParagraphProperty,
      textSpans: null == textSpans
          ? _value._textSpans
          : textSpans // ignore: cast_nullable_to_non_nullable
              as List<TextSpan>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ParagraphPropertyImpl extends _ParagraphProperty {
  const _$ParagraphPropertyImpl(
      {this.property = const ParagraphProperty.undefined(),
      final List<TextSpan> textSpans = const []})
      : _textSpans = textSpans,
        super._();

  factory _$ParagraphPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ParagraphPropertyImplFromJson(json);

  @override
  @JsonKey()
  final ParagraphProperty property;
  final List<TextSpan> _textSpans;
  @override
  @JsonKey()
  List<TextSpan> get textSpans {
    if (_textSpans is EqualUnmodifiableListView) return _textSpans;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_textSpans);
  }

  @override
  String toString() {
    return 'TextParagraph.text(property: $property, textSpans: $textSpans)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ParagraphPropertyImpl &&
            (identical(other.property, property) ||
                other.property == property) &&
            const DeepCollectionEquality()
                .equals(other._textSpans, _textSpans));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, property, const DeepCollectionEquality().hash(_textSpans));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ParagraphPropertyImplCopyWith<_$ParagraphPropertyImpl> get copyWith =>
      __$$ParagraphPropertyImplCopyWithImpl<_$ParagraphPropertyImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            ParagraphProperty property, List<TextSpan> textSpans)
        text,
  }) {
    return text(property, textSpans);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ParagraphProperty property, List<TextSpan> textSpans)?
        text,
  }) {
    return text?.call(property, textSpans);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParagraphProperty property, List<TextSpan> textSpans)?
        text,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(property, textSpans);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ParagraphProperty value) text,
  }) {
    return text(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ParagraphProperty value)? text,
  }) {
    return text?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ParagraphProperty value)? text,
    required TResult orElse(),
  }) {
    if (text != null) {
      return text(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ParagraphPropertyImplToJson(
      this,
    );
  }
}

abstract class _ParagraphProperty extends TextParagraph {
  const factory _ParagraphProperty(
      {final ParagraphProperty property,
      final List<TextSpan> textSpans}) = _$ParagraphPropertyImpl;
  const _ParagraphProperty._() : super._();

  factory _ParagraphProperty.fromJson(Map<String, dynamic> json) =
      _$ParagraphPropertyImpl.fromJson;

  @override
  ParagraphProperty get property;
  @override
  List<TextSpan> get textSpans;
  @override
  @JsonKey(ignore: true)
  _$$ParagraphPropertyImplCopyWith<_$ParagraphPropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TextArea _$TextAreaFromJson(Map<String, dynamic> json) {
  return _TextArea.fromJson(json);
}

/// @nodoc
mixin _$TextArea {
  AreaProperty get areaProperty => throw _privateConstructorUsedError;
  TextParagraph get paragraph => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TextAreaCopyWith<TextArea> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextAreaCopyWith<$Res> {
  factory $TextAreaCopyWith(TextArea value, $Res Function(TextArea) then) =
      _$TextAreaCopyWithImpl<$Res, TextArea>;
  @useResult
  $Res call({AreaProperty areaProperty, TextParagraph paragraph});

  $AreaPropertyCopyWith<$Res> get areaProperty;
  $TextParagraphCopyWith<$Res> get paragraph;
}

/// @nodoc
class _$TextAreaCopyWithImpl<$Res, $Val extends TextArea>
    implements $TextAreaCopyWith<$Res> {
  _$TextAreaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areaProperty = null,
    Object? paragraph = null,
  }) {
    return _then(_value.copyWith(
      areaProperty: null == areaProperty
          ? _value.areaProperty
          : areaProperty // ignore: cast_nullable_to_non_nullable
              as AreaProperty,
      paragraph: null == paragraph
          ? _value.paragraph
          : paragraph // ignore: cast_nullable_to_non_nullable
              as TextParagraph,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AreaPropertyCopyWith<$Res> get areaProperty {
    return $AreaPropertyCopyWith<$Res>(_value.areaProperty, (value) {
      return _then(_value.copyWith(areaProperty: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TextParagraphCopyWith<$Res> get paragraph {
    return $TextParagraphCopyWith<$Res>(_value.paragraph, (value) {
      return _then(_value.copyWith(paragraph: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TextAreaImplCopyWith<$Res>
    implements $TextAreaCopyWith<$Res> {
  factory _$$TextAreaImplCopyWith(
          _$TextAreaImpl value, $Res Function(_$TextAreaImpl) then) =
      __$$TextAreaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AreaProperty areaProperty, TextParagraph paragraph});

  @override
  $AreaPropertyCopyWith<$Res> get areaProperty;
  @override
  $TextParagraphCopyWith<$Res> get paragraph;
}

/// @nodoc
class __$$TextAreaImplCopyWithImpl<$Res>
    extends _$TextAreaCopyWithImpl<$Res, _$TextAreaImpl>
    implements _$$TextAreaImplCopyWith<$Res> {
  __$$TextAreaImplCopyWithImpl(
      _$TextAreaImpl _value, $Res Function(_$TextAreaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areaProperty = null,
    Object? paragraph = null,
  }) {
    return _then(_$TextAreaImpl(
      areaProperty: null == areaProperty
          ? _value.areaProperty
          : areaProperty // ignore: cast_nullable_to_non_nullable
              as AreaProperty,
      paragraph: null == paragraph
          ? _value.paragraph
          : paragraph // ignore: cast_nullable_to_non_nullable
              as TextParagraph,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TextAreaImpl extends _TextArea {
  const _$TextAreaImpl(
      {this.areaProperty = const AreaProperty(), required this.paragraph})
      : super._();

  factory _$TextAreaImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextAreaImplFromJson(json);

  @override
  @JsonKey()
  final AreaProperty areaProperty;
  @override
  final TextParagraph paragraph;

  @override
  String toString() {
    return 'TextArea(areaProperty: $areaProperty, paragraph: $paragraph)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextAreaImpl &&
            (identical(other.areaProperty, areaProperty) ||
                other.areaProperty == areaProperty) &&
            (identical(other.paragraph, paragraph) ||
                other.paragraph == paragraph));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, areaProperty, paragraph);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextAreaImplCopyWith<_$TextAreaImpl> get copyWith =>
      __$$TextAreaImplCopyWithImpl<_$TextAreaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TextAreaImplToJson(
      this,
    );
  }
}

abstract class _TextArea extends TextArea {
  const factory _TextArea(
      {final AreaProperty areaProperty,
      required final TextParagraph paragraph}) = _$TextAreaImpl;
  const _TextArea._() : super._();

  factory _TextArea.fromJson(Map<String, dynamic> json) =
      _$TextAreaImpl.fromJson;

  @override
  AreaProperty get areaProperty;
  @override
  TextParagraph get paragraph;
  @override
  @JsonKey(ignore: true)
  _$$TextAreaImplCopyWith<_$TextAreaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TextStyleSheet _$TextStyleSheetFromJson(Map<String, dynamic> json) {
  return _TextStyleSheet.fromJson(json);
}

/// @nodoc
mixin _$TextStyleSheet {
  String get name => throw _privateConstructorUsedError;
  Map<String, DefinedSpanProperty> get spanProperties =>
      throw _privateConstructorUsedError;
  Map<String, DefinedParagraphProperty> get paragraphProperties =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TextStyleSheetCopyWith<TextStyleSheet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextStyleSheetCopyWith<$Res> {
  factory $TextStyleSheetCopyWith(
          TextStyleSheet value, $Res Function(TextStyleSheet) then) =
      _$TextStyleSheetCopyWithImpl<$Res, TextStyleSheet>;
  @useResult
  $Res call(
      {String name,
      Map<String, DefinedSpanProperty> spanProperties,
      Map<String, DefinedParagraphProperty> paragraphProperties});
}

/// @nodoc
class _$TextStyleSheetCopyWithImpl<$Res, $Val extends TextStyleSheet>
    implements $TextStyleSheetCopyWith<$Res> {
  _$TextStyleSheetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? spanProperties = null,
    Object? paragraphProperties = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      spanProperties: null == spanProperties
          ? _value.spanProperties
          : spanProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, DefinedSpanProperty>,
      paragraphProperties: null == paragraphProperties
          ? _value.paragraphProperties
          : paragraphProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, DefinedParagraphProperty>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TextStyleSheetImplCopyWith<$Res>
    implements $TextStyleSheetCopyWith<$Res> {
  factory _$$TextStyleSheetImplCopyWith(_$TextStyleSheetImpl value,
          $Res Function(_$TextStyleSheetImpl) then) =
      __$$TextStyleSheetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      Map<String, DefinedSpanProperty> spanProperties,
      Map<String, DefinedParagraphProperty> paragraphProperties});
}

/// @nodoc
class __$$TextStyleSheetImplCopyWithImpl<$Res>
    extends _$TextStyleSheetCopyWithImpl<$Res, _$TextStyleSheetImpl>
    implements _$$TextStyleSheetImplCopyWith<$Res> {
  __$$TextStyleSheetImplCopyWithImpl(
      _$TextStyleSheetImpl _value, $Res Function(_$TextStyleSheetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? spanProperties = null,
    Object? paragraphProperties = null,
  }) {
    return _then(_$TextStyleSheetImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      spanProperties: null == spanProperties
          ? _value._spanProperties
          : spanProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, DefinedSpanProperty>,
      paragraphProperties: null == paragraphProperties
          ? _value._paragraphProperties
          : paragraphProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, DefinedParagraphProperty>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TextStyleSheetImpl extends _TextStyleSheet {
  const _$TextStyleSheetImpl(
      {this.name = '',
      final Map<String, DefinedSpanProperty> spanProperties = const {},
      final Map<String, DefinedParagraphProperty> paragraphProperties =
          const {}})
      : _spanProperties = spanProperties,
        _paragraphProperties = paragraphProperties,
        super._();

  factory _$TextStyleSheetImpl.fromJson(Map<String, dynamic> json) =>
      _$$TextStyleSheetImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  final Map<String, DefinedSpanProperty> _spanProperties;
  @override
  @JsonKey()
  Map<String, DefinedSpanProperty> get spanProperties {
    if (_spanProperties is EqualUnmodifiableMapView) return _spanProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_spanProperties);
  }

  final Map<String, DefinedParagraphProperty> _paragraphProperties;
  @override
  @JsonKey()
  Map<String, DefinedParagraphProperty> get paragraphProperties {
    if (_paragraphProperties is EqualUnmodifiableMapView)
      return _paragraphProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paragraphProperties);
  }

  @override
  String toString() {
    return 'TextStyleSheet(name: $name, spanProperties: $spanProperties, paragraphProperties: $paragraphProperties)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextStyleSheetImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._spanProperties, _spanProperties) &&
            const DeepCollectionEquality()
                .equals(other._paragraphProperties, _paragraphProperties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_spanProperties),
      const DeepCollectionEquality().hash(_paragraphProperties));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextStyleSheetImplCopyWith<_$TextStyleSheetImpl> get copyWith =>
      __$$TextStyleSheetImplCopyWithImpl<_$TextStyleSheetImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TextStyleSheetImplToJson(
      this,
    );
  }
}

abstract class _TextStyleSheet extends TextStyleSheet {
  const factory _TextStyleSheet(
          {final String name,
          final Map<String, DefinedSpanProperty> spanProperties,
          final Map<String, DefinedParagraphProperty> paragraphProperties}) =
      _$TextStyleSheetImpl;
  const _TextStyleSheet._() : super._();

  factory _TextStyleSheet.fromJson(Map<String, dynamic> json) =
      _$TextStyleSheetImpl.fromJson;

  @override
  String get name;
  @override
  Map<String, DefinedSpanProperty> get spanProperties;
  @override
  Map<String, DefinedParagraphProperty> get paragraphProperties;
  @override
  @JsonKey(ignore: true)
  _$$TextStyleSheetImplCopyWith<_$TextStyleSheetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
