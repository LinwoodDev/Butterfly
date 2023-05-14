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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
            double? decorationThickness)
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
            double? decorationThickness)?
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
            double? decorationThickness)?
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
abstract class _$$DefinedSpanPropertyCopyWith<$Res> {
  factory _$$DefinedSpanPropertyCopyWith(_$DefinedSpanProperty value,
          $Res Function(_$DefinedSpanProperty) then) =
      __$$DefinedSpanPropertyCopyWithImpl<$Res>;
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
      double? decorationThickness});
}

/// @nodoc
class __$$DefinedSpanPropertyCopyWithImpl<$Res>
    extends _$SpanPropertyCopyWithImpl<$Res, _$DefinedSpanProperty>
    implements _$$DefinedSpanPropertyCopyWith<$Res> {
  __$$DefinedSpanPropertyCopyWithImpl(
      _$DefinedSpanProperty _value, $Res Function(_$DefinedSpanProperty) _then)
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
  }) {
    return _then(_$DefinedSpanProperty(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DefinedSpanProperty implements DefinedSpanProperty {
  const _$DefinedSpanProperty(
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
      final String? $type})
      : $type = $type ?? 'defined';

  factory _$DefinedSpanProperty.fromJson(Map<String, dynamic> json) =>
      _$$DefinedSpanPropertyFromJson(json);

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

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'SpanProperty.defined(size: $size, color: $color, fontWeight: $fontWeight, lineThrough: $lineThrough, underline: $underline, overline: $overline, italic: $italic, letterSpacing: $letterSpacing, decorationColor: $decorationColor, decorationStyle: $decorationStyle, decorationThickness: $decorationThickness)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DefinedSpanProperty &&
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
                other.decorationThickness == decorationThickness));
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
      decorationThickness);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DefinedSpanPropertyCopyWith<_$DefinedSpanProperty> get copyWith =>
      __$$DefinedSpanPropertyCopyWithImpl<_$DefinedSpanProperty>(
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
            double? decorationThickness)
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
        decorationThickness);
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
            double? decorationThickness)?
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
        decorationThickness);
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
            double? decorationThickness)?
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
          decorationThickness);
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
    return _$$DefinedSpanPropertyToJson(
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
      final double? decorationThickness}) = _$DefinedSpanProperty;

  factory DefinedSpanProperty.fromJson(Map<String, dynamic> json) =
      _$DefinedSpanProperty.fromJson;

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
  @JsonKey(ignore: true)
  _$$DefinedSpanPropertyCopyWith<_$DefinedSpanProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NamedSpanPropertyCopyWith<$Res> {
  factory _$$NamedSpanPropertyCopyWith(
          _$NamedSpanProperty value, $Res Function(_$NamedSpanProperty) then) =
      __$$NamedSpanPropertyCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$NamedSpanPropertyCopyWithImpl<$Res>
    extends _$SpanPropertyCopyWithImpl<$Res, _$NamedSpanProperty>
    implements _$$NamedSpanPropertyCopyWith<$Res> {
  __$$NamedSpanPropertyCopyWithImpl(
      _$NamedSpanProperty _value, $Res Function(_$NamedSpanProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$NamedSpanProperty(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NamedSpanProperty implements NamedSpanProperty {
  const _$NamedSpanProperty(this.name, {final String? $type})
      : $type = $type ?? 'named';

  factory _$NamedSpanProperty.fromJson(Map<String, dynamic> json) =>
      _$$NamedSpanPropertyFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'SpanProperty.named(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NamedSpanProperty &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NamedSpanPropertyCopyWith<_$NamedSpanProperty> get copyWith =>
      __$$NamedSpanPropertyCopyWithImpl<_$NamedSpanProperty>(this, _$identity);

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
            double? decorationThickness)
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
            double? decorationThickness)?
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
            double? decorationThickness)?
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
    return _$$NamedSpanPropertyToJson(
      this,
    );
  }
}

abstract class NamedSpanProperty implements SpanProperty {
  const factory NamedSpanProperty(final String name) = _$NamedSpanProperty;

  factory NamedSpanProperty.fromJson(Map<String, dynamic> json) =
      _$NamedSpanProperty.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$NamedSpanPropertyCopyWith<_$NamedSpanProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UndefinedSpanPropertyCopyWith<$Res> {
  factory _$$UndefinedSpanPropertyCopyWith(_$UndefinedSpanProperty value,
          $Res Function(_$UndefinedSpanProperty) then) =
      __$$UndefinedSpanPropertyCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UndefinedSpanPropertyCopyWithImpl<$Res>
    extends _$SpanPropertyCopyWithImpl<$Res, _$UndefinedSpanProperty>
    implements _$$UndefinedSpanPropertyCopyWith<$Res> {
  __$$UndefinedSpanPropertyCopyWithImpl(_$UndefinedSpanProperty _value,
      $Res Function(_$UndefinedSpanProperty) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$UndefinedSpanProperty implements UndefinedSpanProperty {
  const _$UndefinedSpanProperty({final String? $type})
      : $type = $type ?? 'undefined';

  factory _$UndefinedSpanProperty.fromJson(Map<String, dynamic> json) =>
      _$$UndefinedSpanPropertyFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'SpanProperty.undefined()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UndefinedSpanProperty);
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
            double? decorationThickness)
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
            double? decorationThickness)?
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
            double? decorationThickness)?
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
    return _$$UndefinedSpanPropertyToJson(
      this,
    );
  }
}

abstract class UndefinedSpanProperty implements SpanProperty {
  const factory UndefinedSpanProperty() = _$UndefinedSpanProperty;

  factory UndefinedSpanProperty.fromJson(Map<String, dynamic> json) =
      _$UndefinedSpanProperty.fromJson;
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
abstract class _$$DefinedParagraphPropertyCopyWith<$Res> {
  factory _$$DefinedParagraphPropertyCopyWith(_$DefinedParagraphProperty value,
          $Res Function(_$DefinedParagraphProperty) then) =
      __$$DefinedParagraphPropertyCopyWithImpl<$Res>;
  @useResult
  $Res call({DefinedSpanProperty span, HorizontalAlignment alignment});
}

/// @nodoc
class __$$DefinedParagraphPropertyCopyWithImpl<$Res>
    extends _$ParagraphPropertyCopyWithImpl<$Res, _$DefinedParagraphProperty>
    implements _$$DefinedParagraphPropertyCopyWith<$Res> {
  __$$DefinedParagraphPropertyCopyWithImpl(_$DefinedParagraphProperty _value,
      $Res Function(_$DefinedParagraphProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? span = freezed,
    Object? alignment = null,
  }) {
    return _then(_$DefinedParagraphProperty(
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
class _$DefinedParagraphProperty implements DefinedParagraphProperty {
  const _$DefinedParagraphProperty(
      {this.span = const DefinedSpanProperty(),
      this.alignment = HorizontalAlignment.left,
      final String? $type})
      : $type = $type ?? 'defined';

  factory _$DefinedParagraphProperty.fromJson(Map<String, dynamic> json) =>
      _$$DefinedParagraphPropertyFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DefinedParagraphProperty &&
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
  _$$DefinedParagraphPropertyCopyWith<_$DefinedParagraphProperty>
      get copyWith =>
          __$$DefinedParagraphPropertyCopyWithImpl<_$DefinedParagraphProperty>(
              this, _$identity);

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
    return _$$DefinedParagraphPropertyToJson(
      this,
    );
  }
}

abstract class DefinedParagraphProperty implements ParagraphProperty {
  const factory DefinedParagraphProperty(
      {final DefinedSpanProperty span,
      final HorizontalAlignment alignment}) = _$DefinedParagraphProperty;

  factory DefinedParagraphProperty.fromJson(Map<String, dynamic> json) =
      _$DefinedParagraphProperty.fromJson;

  DefinedSpanProperty get span;
  HorizontalAlignment get alignment;
  @JsonKey(ignore: true)
  _$$DefinedParagraphPropertyCopyWith<_$DefinedParagraphProperty>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NamedParagraphPropertyCopyWith<$Res> {
  factory _$$NamedParagraphPropertyCopyWith(_$NamedParagraphProperty value,
          $Res Function(_$NamedParagraphProperty) then) =
      __$$NamedParagraphPropertyCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$NamedParagraphPropertyCopyWithImpl<$Res>
    extends _$ParagraphPropertyCopyWithImpl<$Res, _$NamedParagraphProperty>
    implements _$$NamedParagraphPropertyCopyWith<$Res> {
  __$$NamedParagraphPropertyCopyWithImpl(_$NamedParagraphProperty _value,
      $Res Function(_$NamedParagraphProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$NamedParagraphProperty(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NamedParagraphProperty implements NamedParagraphProperty {
  const _$NamedParagraphProperty(this.name, {final String? $type})
      : $type = $type ?? 'named';

  factory _$NamedParagraphProperty.fromJson(Map<String, dynamic> json) =>
      _$$NamedParagraphPropertyFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ParagraphProperty.named(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NamedParagraphProperty &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NamedParagraphPropertyCopyWith<_$NamedParagraphProperty> get copyWith =>
      __$$NamedParagraphPropertyCopyWithImpl<_$NamedParagraphProperty>(
          this, _$identity);

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
    return _$$NamedParagraphPropertyToJson(
      this,
    );
  }
}

abstract class NamedParagraphProperty implements ParagraphProperty {
  const factory NamedParagraphProperty(final String name) =
      _$NamedParagraphProperty;

  factory NamedParagraphProperty.fromJson(Map<String, dynamic> json) =
      _$NamedParagraphProperty.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$NamedParagraphPropertyCopyWith<_$NamedParagraphProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UndefinedParagraphPropertyCopyWith<$Res> {
  factory _$$UndefinedParagraphPropertyCopyWith(
          _$UndefinedParagraphProperty value,
          $Res Function(_$UndefinedParagraphProperty) then) =
      __$$UndefinedParagraphPropertyCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UndefinedParagraphPropertyCopyWithImpl<$Res>
    extends _$ParagraphPropertyCopyWithImpl<$Res, _$UndefinedParagraphProperty>
    implements _$$UndefinedParagraphPropertyCopyWith<$Res> {
  __$$UndefinedParagraphPropertyCopyWithImpl(
      _$UndefinedParagraphProperty _value,
      $Res Function(_$UndefinedParagraphProperty) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$UndefinedParagraphProperty implements UndefinedParagraphProperty {
  const _$UndefinedParagraphProperty({final String? $type})
      : $type = $type ?? 'undefined';

  factory _$UndefinedParagraphProperty.fromJson(Map<String, dynamic> json) =>
      _$$UndefinedParagraphPropertyFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ParagraphProperty.undefined()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UndefinedParagraphProperty);
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
    return _$$UndefinedParagraphPropertyToJson(
      this,
    );
  }
}

abstract class UndefinedParagraphProperty implements ParagraphProperty {
  const factory UndefinedParagraphProperty() = _$UndefinedParagraphProperty;

  factory UndefinedParagraphProperty.fromJson(Map<String, dynamic> json) =
      _$UndefinedParagraphProperty.fromJson;
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
abstract class _$$_AreaPropertyCopyWith<$Res>
    implements $AreaPropertyCopyWith<$Res> {
  factory _$$_AreaPropertyCopyWith(
          _$_AreaProperty value, $Res Function(_$_AreaProperty) then) =
      __$$_AreaPropertyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({VerticalAlignment alignment});
}

/// @nodoc
class __$$_AreaPropertyCopyWithImpl<$Res>
    extends _$AreaPropertyCopyWithImpl<$Res, _$_AreaProperty>
    implements _$$_AreaPropertyCopyWith<$Res> {
  __$$_AreaPropertyCopyWithImpl(
      _$_AreaProperty _value, $Res Function(_$_AreaProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alignment = null,
  }) {
    return _then(_$_AreaProperty(
      alignment: null == alignment
          ? _value.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as VerticalAlignment,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AreaProperty implements _AreaProperty {
  const _$_AreaProperty({this.alignment = VerticalAlignment.top});

  factory _$_AreaProperty.fromJson(Map<String, dynamic> json) =>
      _$$_AreaPropertyFromJson(json);

  @override
  @JsonKey()
  final VerticalAlignment alignment;

  @override
  String toString() {
    return 'AreaProperty(alignment: $alignment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AreaProperty &&
            (identical(other.alignment, alignment) ||
                other.alignment == alignment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, alignment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AreaPropertyCopyWith<_$_AreaProperty> get copyWith =>
      __$$_AreaPropertyCopyWithImpl<_$_AreaProperty>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AreaPropertyToJson(
      this,
    );
  }
}

abstract class _AreaProperty implements AreaProperty {
  const factory _AreaProperty({final VerticalAlignment alignment}) =
      _$_AreaProperty;

  factory _AreaProperty.fromJson(Map<String, dynamic> json) =
      _$_AreaProperty.fromJson;

  @override
  VerticalAlignment get alignment;
  @override
  @JsonKey(ignore: true)
  _$$_AreaPropertyCopyWith<_$_AreaProperty> get copyWith =>
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
abstract class _$$_TextSpanCopyWith<$Res> implements $TextSpanCopyWith<$Res> {
  factory _$$_TextSpanCopyWith(
          _$_TextSpan value, $Res Function(_$_TextSpan) then) =
      __$$_TextSpanCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, SpanProperty property});

  @override
  $SpanPropertyCopyWith<$Res> get property;
}

/// @nodoc
class __$$_TextSpanCopyWithImpl<$Res>
    extends _$TextSpanCopyWithImpl<$Res, _$_TextSpan>
    implements _$$_TextSpanCopyWith<$Res> {
  __$$_TextSpanCopyWithImpl(
      _$_TextSpan _value, $Res Function(_$_TextSpan) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? property = null,
  }) {
    return _then(_$_TextSpan(
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
class _$_TextSpan extends _TextSpan {
  const _$_TextSpan(
      {this.text = '', this.property = const SpanProperty.undefined()})
      : super._();

  factory _$_TextSpan.fromJson(Map<String, dynamic> json) =>
      _$$_TextSpanFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextSpan &&
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
  _$$_TextSpanCopyWith<_$_TextSpan> get copyWith =>
      __$$_TextSpanCopyWithImpl<_$_TextSpan>(this, _$identity);

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
    return _$$_TextSpanToJson(
      this,
    );
  }
}

abstract class _TextSpan extends TextSpan {
  const factory _TextSpan({final String text, final SpanProperty property}) =
      _$_TextSpan;
  const _TextSpan._() : super._();

  factory _TextSpan.fromJson(Map<String, dynamic> json) = _$_TextSpan.fromJson;

  @override
  String get text;
  @override
  SpanProperty get property;
  @override
  @JsonKey(ignore: true)
  _$$_TextSpanCopyWith<_$_TextSpan> get copyWith =>
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
abstract class _$$_IndexedModelCopyWith<T, $Res>
    implements $IndexedModelCopyWith<T, $Res> {
  factory _$$_IndexedModelCopyWith(
          _$_IndexedModel<T> value, $Res Function(_$_IndexedModel<T>) then) =
      __$$_IndexedModelCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({int index, T model});
}

/// @nodoc
class __$$_IndexedModelCopyWithImpl<T, $Res>
    extends _$IndexedModelCopyWithImpl<T, $Res, _$_IndexedModel<T>>
    implements _$$_IndexedModelCopyWith<T, $Res> {
  __$$_IndexedModelCopyWithImpl(
      _$_IndexedModel<T> _value, $Res Function(_$_IndexedModel<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? model = freezed,
  }) {
    return _then(_$_IndexedModel<T>(
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

class _$_IndexedModel<T> implements _IndexedModel<T> {
  const _$_IndexedModel(this.index, this.model);

  @override
  final int index;
  @override
  final T model;

  @override
  String toString() {
    return 'IndexedModel<$T>(index: $index, model: $model)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IndexedModel<T> &&
            (identical(other.index, index) || other.index == index) &&
            const DeepCollectionEquality().equals(other.model, model));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, index, const DeepCollectionEquality().hash(model));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IndexedModelCopyWith<T, _$_IndexedModel<T>> get copyWith =>
      __$$_IndexedModelCopyWithImpl<T, _$_IndexedModel<T>>(this, _$identity);
}

abstract class _IndexedModel<T> implements IndexedModel<T> {
  const factory _IndexedModel(final int index, final T model) =
      _$_IndexedModel<T>;

  @override
  int get index;
  @override
  T get model;
  @override
  @JsonKey(ignore: true)
  _$$_IndexedModelCopyWith<T, _$_IndexedModel<T>> get copyWith =>
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
abstract class _$$_ParagraphPropertyCopyWith<$Res>
    implements $TextParagraphCopyWith<$Res> {
  factory _$$_ParagraphPropertyCopyWith(_$_ParagraphProperty value,
          $Res Function(_$_ParagraphProperty) then) =
      __$$_ParagraphPropertyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ParagraphProperty property, List<TextSpan> textSpans});

  @override
  $ParagraphPropertyCopyWith<$Res> get property;
}

/// @nodoc
class __$$_ParagraphPropertyCopyWithImpl<$Res>
    extends _$TextParagraphCopyWithImpl<$Res, _$_ParagraphProperty>
    implements _$$_ParagraphPropertyCopyWith<$Res> {
  __$$_ParagraphPropertyCopyWithImpl(
      _$_ParagraphProperty _value, $Res Function(_$_ParagraphProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? property = null,
    Object? textSpans = null,
  }) {
    return _then(_$_ParagraphProperty(
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
class _$_ParagraphProperty extends _ParagraphProperty {
  const _$_ParagraphProperty(
      {this.property = const ParagraphProperty.undefined(),
      final List<TextSpan> textSpans = const []})
      : _textSpans = textSpans,
        super._();

  factory _$_ParagraphProperty.fromJson(Map<String, dynamic> json) =>
      _$$_ParagraphPropertyFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ParagraphProperty &&
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
  _$$_ParagraphPropertyCopyWith<_$_ParagraphProperty> get copyWith =>
      __$$_ParagraphPropertyCopyWithImpl<_$_ParagraphProperty>(
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
    return _$$_ParagraphPropertyToJson(
      this,
    );
  }
}

abstract class _ParagraphProperty extends TextParagraph {
  const factory _ParagraphProperty(
      {final ParagraphProperty property,
      final List<TextSpan> textSpans}) = _$_ParagraphProperty;
  const _ParagraphProperty._() : super._();

  factory _ParagraphProperty.fromJson(Map<String, dynamic> json) =
      _$_ParagraphProperty.fromJson;

  @override
  ParagraphProperty get property;
  @override
  List<TextSpan> get textSpans;
  @override
  @JsonKey(ignore: true)
  _$$_ParagraphPropertyCopyWith<_$_ParagraphProperty> get copyWith =>
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
abstract class _$$_TextAreaCopyWith<$Res> implements $TextAreaCopyWith<$Res> {
  factory _$$_TextAreaCopyWith(
          _$_TextArea value, $Res Function(_$_TextArea) then) =
      __$$_TextAreaCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AreaProperty areaProperty, TextParagraph paragraph});

  @override
  $AreaPropertyCopyWith<$Res> get areaProperty;
  @override
  $TextParagraphCopyWith<$Res> get paragraph;
}

/// @nodoc
class __$$_TextAreaCopyWithImpl<$Res>
    extends _$TextAreaCopyWithImpl<$Res, _$_TextArea>
    implements _$$_TextAreaCopyWith<$Res> {
  __$$_TextAreaCopyWithImpl(
      _$_TextArea _value, $Res Function(_$_TextArea) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areaProperty = null,
    Object? paragraph = null,
  }) {
    return _then(_$_TextArea(
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
class _$_TextArea extends _TextArea {
  const _$_TextArea(
      {this.areaProperty = const AreaProperty(), required this.paragraph})
      : super._();

  factory _$_TextArea.fromJson(Map<String, dynamic> json) =>
      _$$_TextAreaFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextArea &&
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
  _$$_TextAreaCopyWith<_$_TextArea> get copyWith =>
      __$$_TextAreaCopyWithImpl<_$_TextArea>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TextAreaToJson(
      this,
    );
  }
}

abstract class _TextArea extends TextArea {
  const factory _TextArea(
      {final AreaProperty areaProperty,
      required final TextParagraph paragraph}) = _$_TextArea;
  const _TextArea._() : super._();

  factory _TextArea.fromJson(Map<String, dynamic> json) = _$_TextArea.fromJson;

  @override
  AreaProperty get areaProperty;
  @override
  TextParagraph get paragraph;
  @override
  @JsonKey(ignore: true)
  _$$_TextAreaCopyWith<_$_TextArea> get copyWith =>
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
abstract class _$$_TextStyleSheetCopyWith<$Res>
    implements $TextStyleSheetCopyWith<$Res> {
  factory _$$_TextStyleSheetCopyWith(
          _$_TextStyleSheet value, $Res Function(_$_TextStyleSheet) then) =
      __$$_TextStyleSheetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      Map<String, DefinedSpanProperty> spanProperties,
      Map<String, DefinedParagraphProperty> paragraphProperties});
}

/// @nodoc
class __$$_TextStyleSheetCopyWithImpl<$Res>
    extends _$TextStyleSheetCopyWithImpl<$Res, _$_TextStyleSheet>
    implements _$$_TextStyleSheetCopyWith<$Res> {
  __$$_TextStyleSheetCopyWithImpl(
      _$_TextStyleSheet _value, $Res Function(_$_TextStyleSheet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? spanProperties = null,
    Object? paragraphProperties = null,
  }) {
    return _then(_$_TextStyleSheet(
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
class _$_TextStyleSheet extends _TextStyleSheet {
  const _$_TextStyleSheet(
      {this.name = '',
      final Map<String, DefinedSpanProperty> spanProperties = const {},
      final Map<String, DefinedParagraphProperty> paragraphProperties =
          const {}})
      : _spanProperties = spanProperties,
        _paragraphProperties = paragraphProperties,
        super._();

  factory _$_TextStyleSheet.fromJson(Map<String, dynamic> json) =>
      _$$_TextStyleSheetFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextStyleSheet &&
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
  _$$_TextStyleSheetCopyWith<_$_TextStyleSheet> get copyWith =>
      __$$_TextStyleSheetCopyWithImpl<_$_TextStyleSheet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TextStyleSheetToJson(
      this,
    );
  }
}

abstract class _TextStyleSheet extends TextStyleSheet {
  const factory _TextStyleSheet(
          {final String name,
          final Map<String, DefinedSpanProperty> spanProperties,
          final Map<String, DefinedParagraphProperty> paragraphProperties}) =
      _$_TextStyleSheet;
  const _TextStyleSheet._() : super._();

  factory _TextStyleSheet.fromJson(Map<String, dynamic> json) =
      _$_TextStyleSheet.fromJson;

  @override
  String get name;
  @override
  Map<String, DefinedSpanProperty> get spanProperties;
  @override
  Map<String, DefinedParagraphProperty> get paragraphProperties;
  @override
  @JsonKey(ignore: true)
  _$$_TextStyleSheetCopyWith<_$_TextStyleSheet> get copyWith =>
      throw _privateConstructorUsedError;
}
