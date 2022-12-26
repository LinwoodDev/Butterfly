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
            double size,
            int color,
            int fontWeight,
            bool lineThrough,
            bool underline,
            bool overline,
            bool italic,
            double letterSpacing,
            int decorationColor,
            TextDecorationStyle decorationStyle,
            double decorationThickness)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            double size,
            int color,
            int fontWeight,
            bool lineThrough,
            bool underline,
            bool overline,
            bool italic,
            double letterSpacing,
            int decorationColor,
            TextDecorationStyle decorationStyle,
            double decorationThickness)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            double size,
            int color,
            int fontWeight,
            bool lineThrough,
            bool underline,
            bool overline,
            bool italic,
            double letterSpacing,
            int decorationColor,
            TextDecorationStyle decorationStyle,
            double decorationThickness)?
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
      {double size,
      int color,
      int fontWeight,
      bool lineThrough,
      bool underline,
      bool overline,
      bool italic,
      double letterSpacing,
      int decorationColor,
      TextDecorationStyle decorationStyle,
      double decorationThickness});
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
    Object? size = null,
    Object? color = null,
    Object? fontWeight = null,
    Object? lineThrough = null,
    Object? underline = null,
    Object? overline = null,
    Object? italic = null,
    Object? letterSpacing = null,
    Object? decorationColor = null,
    Object? decorationStyle = null,
    Object? decorationThickness = null,
  }) {
    return _then(_$DefinedSpanProperty(
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      fontWeight: null == fontWeight
          ? _value.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as int,
      lineThrough: null == lineThrough
          ? _value.lineThrough
          : lineThrough // ignore: cast_nullable_to_non_nullable
              as bool,
      underline: null == underline
          ? _value.underline
          : underline // ignore: cast_nullable_to_non_nullable
              as bool,
      overline: null == overline
          ? _value.overline
          : overline // ignore: cast_nullable_to_non_nullable
              as bool,
      italic: null == italic
          ? _value.italic
          : italic // ignore: cast_nullable_to_non_nullable
              as bool,
      letterSpacing: null == letterSpacing
          ? _value.letterSpacing
          : letterSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      decorationColor: null == decorationColor
          ? _value.decorationColor
          : decorationColor // ignore: cast_nullable_to_non_nullable
              as int,
      decorationStyle: null == decorationStyle
          ? _value.decorationStyle
          : decorationStyle // ignore: cast_nullable_to_non_nullable
              as TextDecorationStyle,
      decorationThickness: null == decorationThickness
          ? _value.decorationThickness
          : decorationThickness // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DefinedSpanProperty implements DefinedSpanProperty {
  const _$DefinedSpanProperty(
      {this.size = 12,
      this.color = kColorBlack,
      this.fontWeight = 3,
      this.lineThrough = false,
      this.underline = false,
      this.overline = false,
      this.italic = false,
      this.letterSpacing = 0,
      this.decorationColor = kColorBlack,
      this.decorationStyle = TextDecorationStyle.solid,
      this.decorationThickness = 1,
      final String? $type})
      : $type = $type ?? 'defined';

  factory _$DefinedSpanProperty.fromJson(Map<String, dynamic> json) =>
      _$$DefinedSpanPropertyFromJson(json);

  @override
  @JsonKey()
  final double size;
  @override
  @JsonKey()
  final int color;
  @override
  @JsonKey()
  final int fontWeight;
  @override
  @JsonKey()
  final bool lineThrough;
  @override
  @JsonKey()
  final bool underline;
  @override
  @JsonKey()
  final bool overline;
  @override
  @JsonKey()
  final bool italic;
  @override
  @JsonKey()
  final double letterSpacing;
  @override
  @JsonKey()
  final int decorationColor;
  @override
  @JsonKey()
  final TextDecorationStyle decorationStyle;
  @override
  @JsonKey()
  final double decorationThickness;

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
            double size,
            int color,
            int fontWeight,
            bool lineThrough,
            bool underline,
            bool overline,
            bool italic,
            double letterSpacing,
            int decorationColor,
            TextDecorationStyle decorationStyle,
            double decorationThickness)
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
            double size,
            int color,
            int fontWeight,
            bool lineThrough,
            bool underline,
            bool overline,
            bool italic,
            double letterSpacing,
            int decorationColor,
            TextDecorationStyle decorationStyle,
            double decorationThickness)?
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
            double size,
            int color,
            int fontWeight,
            bool lineThrough,
            bool underline,
            bool overline,
            bool italic,
            double letterSpacing,
            int decorationColor,
            TextDecorationStyle decorationStyle,
            double decorationThickness)?
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
      {final double size,
      final int color,
      final int fontWeight,
      final bool lineThrough,
      final bool underline,
      final bool overline,
      final bool italic,
      final double letterSpacing,
      final int decorationColor,
      final TextDecorationStyle decorationStyle,
      final double decorationThickness}) = _$DefinedSpanProperty;

  factory DefinedSpanProperty.fromJson(Map<String, dynamic> json) =
      _$DefinedSpanProperty.fromJson;

  double get size;
  int get color;
  int get fontWeight;
  bool get lineThrough;
  bool get underline;
  bool get overline;
  bool get italic;
  double get letterSpacing;
  int get decorationColor;
  TextDecorationStyle get decorationStyle;
  double get decorationThickness;
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
            double size,
            int color,
            int fontWeight,
            bool lineThrough,
            bool underline,
            bool overline,
            bool italic,
            double letterSpacing,
            int decorationColor,
            TextDecorationStyle decorationStyle,
            double decorationThickness)
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
            double size,
            int color,
            int fontWeight,
            bool lineThrough,
            bool underline,
            bool overline,
            bool italic,
            double letterSpacing,
            int decorationColor,
            TextDecorationStyle decorationStyle,
            double decorationThickness)?
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
            double size,
            int color,
            int fontWeight,
            bool lineThrough,
            bool underline,
            bool overline,
            bool italic,
            double letterSpacing,
            int decorationColor,
            TextDecorationStyle decorationStyle,
            double decorationThickness)?
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
            double size,
            int color,
            int fontWeight,
            bool lineThrough,
            bool underline,
            bool overline,
            bool italic,
            double letterSpacing,
            int decorationColor,
            TextDecorationStyle decorationStyle,
            double decorationThickness)
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
            double size,
            int color,
            int fontWeight,
            bool lineThrough,
            bool underline,
            bool overline,
            bool italic,
            double letterSpacing,
            int decorationColor,
            TextDecorationStyle decorationStyle,
            double decorationThickness)?
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
            double size,
            int color,
            int fontWeight,
            bool lineThrough,
            bool underline,
            bool overline,
            bool italic,
            double letterSpacing,
            int decorationColor,
            TextDecorationStyle decorationStyle,
            double decorationThickness)?
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
            SpanProperty spanProperty, HorizontalAlignment alignment)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SpanProperty spanProperty, HorizontalAlignment alignment)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SpanProperty spanProperty, HorizontalAlignment alignment)?
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
  $Res call({SpanProperty spanProperty, HorizontalAlignment alignment});

  $SpanPropertyCopyWith<$Res> get spanProperty;
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
    Object? spanProperty = null,
    Object? alignment = null,
  }) {
    return _then(_$DefinedParagraphProperty(
      spanProperty: null == spanProperty
          ? _value.spanProperty
          : spanProperty // ignore: cast_nullable_to_non_nullable
              as SpanProperty,
      alignment: null == alignment
          ? _value.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as HorizontalAlignment,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SpanPropertyCopyWith<$Res> get spanProperty {
    return $SpanPropertyCopyWith<$Res>(_value.spanProperty, (value) {
      return _then(_value.copyWith(spanProperty: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$DefinedParagraphProperty implements DefinedParagraphProperty {
  const _$DefinedParagraphProperty(
      {this.spanProperty = const SpanProperty.undefined(),
      this.alignment = HorizontalAlignment.left,
      final String? $type})
      : $type = $type ?? 'defined';

  factory _$DefinedParagraphProperty.fromJson(Map<String, dynamic> json) =>
      _$$DefinedParagraphPropertyFromJson(json);

  @override
  @JsonKey()
  final SpanProperty spanProperty;
  @override
  @JsonKey()
  final HorizontalAlignment alignment;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'ParagraphProperty.defined(spanProperty: $spanProperty, alignment: $alignment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DefinedParagraphProperty &&
            (identical(other.spanProperty, spanProperty) ||
                other.spanProperty == spanProperty) &&
            (identical(other.alignment, alignment) ||
                other.alignment == alignment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, spanProperty, alignment);

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
            SpanProperty spanProperty, HorizontalAlignment alignment)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) {
    return defined(spanProperty, alignment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SpanProperty spanProperty, HorizontalAlignment alignment)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) {
    return defined?.call(spanProperty, alignment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SpanProperty spanProperty, HorizontalAlignment alignment)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (defined != null) {
      return defined(spanProperty, alignment);
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
      {final SpanProperty spanProperty,
      final HorizontalAlignment alignment}) = _$DefinedParagraphProperty;

  factory DefinedParagraphProperty.fromJson(Map<String, dynamic> json) =
      _$DefinedParagraphProperty.fromJson;

  SpanProperty get spanProperty;
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
            SpanProperty spanProperty, HorizontalAlignment alignment)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) {
    return named(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SpanProperty spanProperty, HorizontalAlignment alignment)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) {
    return named?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SpanProperty spanProperty, HorizontalAlignment alignment)?
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
            SpanProperty spanProperty, HorizontalAlignment alignment)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) {
    return undefined();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SpanProperty spanProperty, HorizontalAlignment alignment)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) {
    return undefined?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SpanProperty spanProperty, HorizontalAlignment alignment)?
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
  switch (json['type']) {
    case 'defined':
      return DefinedAreaProperty.fromJson(json);
    case 'named':
      return NamedAreaProperty.fromJson(json);
    case 'undefined':
      return UndefinedAreaProperty.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'AreaProperty',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$AreaProperty {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParagraphProperty paragraphProperty,
            VerticalAlignment verticalAlignment)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ParagraphProperty paragraphProperty,
            VerticalAlignment verticalAlignment)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParagraphProperty paragraphProperty,
            VerticalAlignment verticalAlignment)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DefinedAreaProperty value) defined,
    required TResult Function(NamedAreaProperty value) named,
    required TResult Function(UndefinedAreaProperty value) undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DefinedAreaProperty value)? defined,
    TResult? Function(NamedAreaProperty value)? named,
    TResult? Function(UndefinedAreaProperty value)? undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedAreaProperty value)? defined,
    TResult Function(NamedAreaProperty value)? named,
    TResult Function(UndefinedAreaProperty value)? undefined,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AreaPropertyCopyWith<$Res> {
  factory $AreaPropertyCopyWith(
          AreaProperty value, $Res Function(AreaProperty) then) =
      _$AreaPropertyCopyWithImpl<$Res, AreaProperty>;
}

/// @nodoc
class _$AreaPropertyCopyWithImpl<$Res, $Val extends AreaProperty>
    implements $AreaPropertyCopyWith<$Res> {
  _$AreaPropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$DefinedAreaPropertyCopyWith<$Res> {
  factory _$$DefinedAreaPropertyCopyWith(_$DefinedAreaProperty value,
          $Res Function(_$DefinedAreaProperty) then) =
      __$$DefinedAreaPropertyCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {ParagraphProperty paragraphProperty,
      VerticalAlignment verticalAlignment});

  $ParagraphPropertyCopyWith<$Res> get paragraphProperty;
}

/// @nodoc
class __$$DefinedAreaPropertyCopyWithImpl<$Res>
    extends _$AreaPropertyCopyWithImpl<$Res, _$DefinedAreaProperty>
    implements _$$DefinedAreaPropertyCopyWith<$Res> {
  __$$DefinedAreaPropertyCopyWithImpl(
      _$DefinedAreaProperty _value, $Res Function(_$DefinedAreaProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paragraphProperty = null,
    Object? verticalAlignment = null,
  }) {
    return _then(_$DefinedAreaProperty(
      paragraphProperty: null == paragraphProperty
          ? _value.paragraphProperty
          : paragraphProperty // ignore: cast_nullable_to_non_nullable
              as ParagraphProperty,
      verticalAlignment: null == verticalAlignment
          ? _value.verticalAlignment
          : verticalAlignment // ignore: cast_nullable_to_non_nullable
              as VerticalAlignment,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ParagraphPropertyCopyWith<$Res> get paragraphProperty {
    return $ParagraphPropertyCopyWith<$Res>(_value.paragraphProperty, (value) {
      return _then(_value.copyWith(paragraphProperty: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$DefinedAreaProperty implements DefinedAreaProperty {
  const _$DefinedAreaProperty(
      {this.paragraphProperty = const ParagraphProperty.undefined(),
      this.verticalAlignment = VerticalAlignment.top,
      final String? $type})
      : $type = $type ?? 'defined';

  factory _$DefinedAreaProperty.fromJson(Map<String, dynamic> json) =>
      _$$DefinedAreaPropertyFromJson(json);

  @override
  @JsonKey()
  final ParagraphProperty paragraphProperty;
  @override
  @JsonKey()
  final VerticalAlignment verticalAlignment;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AreaProperty.defined(paragraphProperty: $paragraphProperty, verticalAlignment: $verticalAlignment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DefinedAreaProperty &&
            (identical(other.paragraphProperty, paragraphProperty) ||
                other.paragraphProperty == paragraphProperty) &&
            (identical(other.verticalAlignment, verticalAlignment) ||
                other.verticalAlignment == verticalAlignment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, paragraphProperty, verticalAlignment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DefinedAreaPropertyCopyWith<_$DefinedAreaProperty> get copyWith =>
      __$$DefinedAreaPropertyCopyWithImpl<_$DefinedAreaProperty>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParagraphProperty paragraphProperty,
            VerticalAlignment verticalAlignment)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) {
    return defined(paragraphProperty, verticalAlignment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ParagraphProperty paragraphProperty,
            VerticalAlignment verticalAlignment)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) {
    return defined?.call(paragraphProperty, verticalAlignment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParagraphProperty paragraphProperty,
            VerticalAlignment verticalAlignment)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
    required TResult orElse(),
  }) {
    if (defined != null) {
      return defined(paragraphProperty, verticalAlignment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DefinedAreaProperty value) defined,
    required TResult Function(NamedAreaProperty value) named,
    required TResult Function(UndefinedAreaProperty value) undefined,
  }) {
    return defined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DefinedAreaProperty value)? defined,
    TResult? Function(NamedAreaProperty value)? named,
    TResult? Function(UndefinedAreaProperty value)? undefined,
  }) {
    return defined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedAreaProperty value)? defined,
    TResult Function(NamedAreaProperty value)? named,
    TResult Function(UndefinedAreaProperty value)? undefined,
    required TResult orElse(),
  }) {
    if (defined != null) {
      return defined(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DefinedAreaPropertyToJson(
      this,
    );
  }
}

abstract class DefinedAreaProperty implements AreaProperty {
  const factory DefinedAreaProperty(
      {final ParagraphProperty paragraphProperty,
      final VerticalAlignment verticalAlignment}) = _$DefinedAreaProperty;

  factory DefinedAreaProperty.fromJson(Map<String, dynamic> json) =
      _$DefinedAreaProperty.fromJson;

  ParagraphProperty get paragraphProperty;
  VerticalAlignment get verticalAlignment;
  @JsonKey(ignore: true)
  _$$DefinedAreaPropertyCopyWith<_$DefinedAreaProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NamedAreaPropertyCopyWith<$Res> {
  factory _$$NamedAreaPropertyCopyWith(
          _$NamedAreaProperty value, $Res Function(_$NamedAreaProperty) then) =
      __$$NamedAreaPropertyCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$NamedAreaPropertyCopyWithImpl<$Res>
    extends _$AreaPropertyCopyWithImpl<$Res, _$NamedAreaProperty>
    implements _$$NamedAreaPropertyCopyWith<$Res> {
  __$$NamedAreaPropertyCopyWithImpl(
      _$NamedAreaProperty _value, $Res Function(_$NamedAreaProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$NamedAreaProperty(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NamedAreaProperty implements NamedAreaProperty {
  const _$NamedAreaProperty(this.name, {final String? $type})
      : $type = $type ?? 'named';

  factory _$NamedAreaProperty.fromJson(Map<String, dynamic> json) =>
      _$$NamedAreaPropertyFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AreaProperty.named(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NamedAreaProperty &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NamedAreaPropertyCopyWith<_$NamedAreaProperty> get copyWith =>
      __$$NamedAreaPropertyCopyWithImpl<_$NamedAreaProperty>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParagraphProperty paragraphProperty,
            VerticalAlignment verticalAlignment)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) {
    return named(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ParagraphProperty paragraphProperty,
            VerticalAlignment verticalAlignment)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) {
    return named?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParagraphProperty paragraphProperty,
            VerticalAlignment verticalAlignment)?
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
    required TResult Function(DefinedAreaProperty value) defined,
    required TResult Function(NamedAreaProperty value) named,
    required TResult Function(UndefinedAreaProperty value) undefined,
  }) {
    return named(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DefinedAreaProperty value)? defined,
    TResult? Function(NamedAreaProperty value)? named,
    TResult? Function(UndefinedAreaProperty value)? undefined,
  }) {
    return named?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedAreaProperty value)? defined,
    TResult Function(NamedAreaProperty value)? named,
    TResult Function(UndefinedAreaProperty value)? undefined,
    required TResult orElse(),
  }) {
    if (named != null) {
      return named(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NamedAreaPropertyToJson(
      this,
    );
  }
}

abstract class NamedAreaProperty implements AreaProperty {
  const factory NamedAreaProperty(final String name) = _$NamedAreaProperty;

  factory NamedAreaProperty.fromJson(Map<String, dynamic> json) =
      _$NamedAreaProperty.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$NamedAreaPropertyCopyWith<_$NamedAreaProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UndefinedAreaPropertyCopyWith<$Res> {
  factory _$$UndefinedAreaPropertyCopyWith(_$UndefinedAreaProperty value,
          $Res Function(_$UndefinedAreaProperty) then) =
      __$$UndefinedAreaPropertyCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UndefinedAreaPropertyCopyWithImpl<$Res>
    extends _$AreaPropertyCopyWithImpl<$Res, _$UndefinedAreaProperty>
    implements _$$UndefinedAreaPropertyCopyWith<$Res> {
  __$$UndefinedAreaPropertyCopyWithImpl(_$UndefinedAreaProperty _value,
      $Res Function(_$UndefinedAreaProperty) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$UndefinedAreaProperty implements UndefinedAreaProperty {
  const _$UndefinedAreaProperty({final String? $type})
      : $type = $type ?? 'undefined';

  factory _$UndefinedAreaProperty.fromJson(Map<String, dynamic> json) =>
      _$$UndefinedAreaPropertyFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AreaProperty.undefined()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UndefinedAreaProperty);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ParagraphProperty paragraphProperty,
            VerticalAlignment verticalAlignment)
        defined,
    required TResult Function(String name) named,
    required TResult Function() undefined,
  }) {
    return undefined();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(ParagraphProperty paragraphProperty,
            VerticalAlignment verticalAlignment)?
        defined,
    TResult? Function(String name)? named,
    TResult? Function()? undefined,
  }) {
    return undefined?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ParagraphProperty paragraphProperty,
            VerticalAlignment verticalAlignment)?
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
    required TResult Function(DefinedAreaProperty value) defined,
    required TResult Function(NamedAreaProperty value) named,
    required TResult Function(UndefinedAreaProperty value) undefined,
  }) {
    return undefined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DefinedAreaProperty value)? defined,
    TResult? Function(NamedAreaProperty value)? named,
    TResult? Function(UndefinedAreaProperty value)? undefined,
  }) {
    return undefined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedAreaProperty value)? defined,
    TResult Function(NamedAreaProperty value)? named,
    TResult Function(UndefinedAreaProperty value)? undefined,
    required TResult orElse(),
  }) {
    if (undefined != null) {
      return undefined(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UndefinedAreaPropertyToJson(
      this,
    );
  }
}

abstract class UndefinedAreaProperty implements AreaProperty {
  const factory UndefinedAreaProperty() = _$UndefinedAreaProperty;

  factory UndefinedAreaProperty.fromJson(Map<String, dynamic> json) =
      _$UndefinedAreaProperty.fromJson;
}

TextSpan _$TextSpanFromJson(Map<String, dynamic> json) {
  return _TextSpan.fromJson(json);
}

/// @nodoc
mixin _$TextSpan {
  String get text => throw _privateConstructorUsedError;
  SpanProperty get property => throw _privateConstructorUsedError;

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
class _$_TextSpan implements _TextSpan {
  const _$_TextSpan(
      {this.text = '', this.property = const SpanProperty.undefined()});

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
    return 'TextSpan(text: $text, property: $property)';
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
  Map<String, dynamic> toJson() {
    return _$$_TextSpanToJson(
      this,
    );
  }
}

abstract class _TextSpan implements TextSpan {
  const factory _TextSpan({final String text, final SpanProperty property}) =
      _$_TextSpan;

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

TextParagraph _$TextParagraphFromJson(Map<String, dynamic> json) {
  return _ParagraphProperty.fromJson(json);
}

/// @nodoc
mixin _$TextParagraph {
  ParagraphProperty get textProperty => throw _privateConstructorUsedError;
  List<TextSpan> get textSpans => throw _privateConstructorUsedError;

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
  $Res call({ParagraphProperty textProperty, List<TextSpan> textSpans});

  $ParagraphPropertyCopyWith<$Res> get textProperty;
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
    Object? textProperty = null,
    Object? textSpans = null,
  }) {
    return _then(_value.copyWith(
      textProperty: null == textProperty
          ? _value.textProperty
          : textProperty // ignore: cast_nullable_to_non_nullable
              as ParagraphProperty,
      textSpans: null == textSpans
          ? _value.textSpans
          : textSpans // ignore: cast_nullable_to_non_nullable
              as List<TextSpan>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ParagraphPropertyCopyWith<$Res> get textProperty {
    return $ParagraphPropertyCopyWith<$Res>(_value.textProperty, (value) {
      return _then(_value.copyWith(textProperty: value) as $Val);
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
  $Res call({ParagraphProperty textProperty, List<TextSpan> textSpans});

  @override
  $ParagraphPropertyCopyWith<$Res> get textProperty;
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
    Object? textProperty = null,
    Object? textSpans = null,
  }) {
    return _then(_$_ParagraphProperty(
      textProperty: null == textProperty
          ? _value.textProperty
          : textProperty // ignore: cast_nullable_to_non_nullable
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
class _$_ParagraphProperty implements _ParagraphProperty {
  const _$_ParagraphProperty(
      {this.textProperty = const ParagraphProperty.undefined(),
      final List<TextSpan> textSpans = const []})
      : _textSpans = textSpans;

  factory _$_ParagraphProperty.fromJson(Map<String, dynamic> json) =>
      _$$_ParagraphPropertyFromJson(json);

  @override
  @JsonKey()
  final ParagraphProperty textProperty;
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
    return 'TextParagraph(textProperty: $textProperty, textSpans: $textSpans)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ParagraphProperty &&
            (identical(other.textProperty, textProperty) ||
                other.textProperty == textProperty) &&
            const DeepCollectionEquality()
                .equals(other._textSpans, _textSpans));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, textProperty,
      const DeepCollectionEquality().hash(_textSpans));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ParagraphPropertyCopyWith<_$_ParagraphProperty> get copyWith =>
      __$$_ParagraphPropertyCopyWithImpl<_$_ParagraphProperty>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ParagraphPropertyToJson(
      this,
    );
  }
}

abstract class _ParagraphProperty implements TextParagraph {
  const factory _ParagraphProperty(
      {final ParagraphProperty textProperty,
      final List<TextSpan> textSpans}) = _$_ParagraphProperty;

  factory _ParagraphProperty.fromJson(Map<String, dynamic> json) =
      _$_ParagraphProperty.fromJson;

  @override
  ParagraphProperty get textProperty;
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
  List<TextParagraph> get textParagraphs => throw _privateConstructorUsedError;

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
  $Res call({AreaProperty areaProperty, List<TextParagraph> textParagraphs});

  $AreaPropertyCopyWith<$Res> get areaProperty;
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
    Object? textParagraphs = null,
  }) {
    return _then(_value.copyWith(
      areaProperty: null == areaProperty
          ? _value.areaProperty
          : areaProperty // ignore: cast_nullable_to_non_nullable
              as AreaProperty,
      textParagraphs: null == textParagraphs
          ? _value.textParagraphs
          : textParagraphs // ignore: cast_nullable_to_non_nullable
              as List<TextParagraph>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AreaPropertyCopyWith<$Res> get areaProperty {
    return $AreaPropertyCopyWith<$Res>(_value.areaProperty, (value) {
      return _then(_value.copyWith(areaProperty: value) as $Val);
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
  $Res call({AreaProperty areaProperty, List<TextParagraph> textParagraphs});

  @override
  $AreaPropertyCopyWith<$Res> get areaProperty;
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
    Object? textParagraphs = null,
  }) {
    return _then(_$_TextArea(
      areaProperty: null == areaProperty
          ? _value.areaProperty
          : areaProperty // ignore: cast_nullable_to_non_nullable
              as AreaProperty,
      textParagraphs: null == textParagraphs
          ? _value._textParagraphs
          : textParagraphs // ignore: cast_nullable_to_non_nullable
              as List<TextParagraph>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TextArea implements _TextArea {
  const _$_TextArea(
      {this.areaProperty = const AreaProperty.undefined(),
      final List<TextParagraph> textParagraphs = const []})
      : _textParagraphs = textParagraphs;

  factory _$_TextArea.fromJson(Map<String, dynamic> json) =>
      _$$_TextAreaFromJson(json);

  @override
  @JsonKey()
  final AreaProperty areaProperty;
  final List<TextParagraph> _textParagraphs;
  @override
  @JsonKey()
  List<TextParagraph> get textParagraphs {
    if (_textParagraphs is EqualUnmodifiableListView) return _textParagraphs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_textParagraphs);
  }

  @override
  String toString() {
    return 'TextArea(areaProperty: $areaProperty, textParagraphs: $textParagraphs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextArea &&
            (identical(other.areaProperty, areaProperty) ||
                other.areaProperty == areaProperty) &&
            const DeepCollectionEquality()
                .equals(other._textParagraphs, _textParagraphs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, areaProperty,
      const DeepCollectionEquality().hash(_textParagraphs));

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

abstract class _TextArea implements TextArea {
  const factory _TextArea(
      {final AreaProperty areaProperty,
      final List<TextParagraph> textParagraphs}) = _$_TextArea;

  factory _TextArea.fromJson(Map<String, dynamic> json) = _$_TextArea.fromJson;

  @override
  AreaProperty get areaProperty;
  @override
  List<TextParagraph> get textParagraphs;
  @override
  @JsonKey(ignore: true)
  _$$_TextAreaCopyWith<_$_TextArea> get copyWith =>
      throw _privateConstructorUsedError;
}

RichStyleSheet _$RichStyleSheetFromJson(Map<String, dynamic> json) {
  return _RichStyleSheet.fromJson(json);
}

/// @nodoc
mixin _$RichStyleSheet {
  String get name => throw _privateConstructorUsedError;
  Map<String, DefinedSpanProperty> get spanProperties =>
      throw _privateConstructorUsedError;
  Map<String, DefinedParagraphProperty> get paragraphProperties =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RichStyleSheetCopyWith<RichStyleSheet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RichStyleSheetCopyWith<$Res> {
  factory $RichStyleSheetCopyWith(
          RichStyleSheet value, $Res Function(RichStyleSheet) then) =
      _$RichStyleSheetCopyWithImpl<$Res, RichStyleSheet>;
  @useResult
  $Res call(
      {String name,
      Map<String, DefinedSpanProperty> spanProperties,
      Map<String, DefinedParagraphProperty> paragraphProperties});
}

/// @nodoc
class _$RichStyleSheetCopyWithImpl<$Res, $Val extends RichStyleSheet>
    implements $RichStyleSheetCopyWith<$Res> {
  _$RichStyleSheetCopyWithImpl(this._value, this._then);

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
abstract class _$$_RichStyleSheetCopyWith<$Res>
    implements $RichStyleSheetCopyWith<$Res> {
  factory _$$_RichStyleSheetCopyWith(
          _$_RichStyleSheet value, $Res Function(_$_RichStyleSheet) then) =
      __$$_RichStyleSheetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      Map<String, DefinedSpanProperty> spanProperties,
      Map<String, DefinedParagraphProperty> paragraphProperties});
}

/// @nodoc
class __$$_RichStyleSheetCopyWithImpl<$Res>
    extends _$RichStyleSheetCopyWithImpl<$Res, _$_RichStyleSheet>
    implements _$$_RichStyleSheetCopyWith<$Res> {
  __$$_RichStyleSheetCopyWithImpl(
      _$_RichStyleSheet _value, $Res Function(_$_RichStyleSheet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? spanProperties = null,
    Object? paragraphProperties = null,
  }) {
    return _then(_$_RichStyleSheet(
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
class _$_RichStyleSheet implements _RichStyleSheet {
  const _$_RichStyleSheet(
      {this.name = '',
      final Map<String, DefinedSpanProperty> spanProperties = const [],
      final Map<String, DefinedParagraphProperty> paragraphProperties =
          const []})
      : _spanProperties = spanProperties,
        _paragraphProperties = paragraphProperties;

  factory _$_RichStyleSheet.fromJson(Map<String, dynamic> json) =>
      _$$_RichStyleSheetFromJson(json);

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
    return 'RichStyleSheet(name: $name, spanProperties: $spanProperties, paragraphProperties: $paragraphProperties)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RichStyleSheet &&
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
  _$$_RichStyleSheetCopyWith<_$_RichStyleSheet> get copyWith =>
      __$$_RichStyleSheetCopyWithImpl<_$_RichStyleSheet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RichStyleSheetToJson(
      this,
    );
  }
}

abstract class _RichStyleSheet implements RichStyleSheet {
  const factory _RichStyleSheet(
          {final String name,
          final Map<String, DefinedSpanProperty> spanProperties,
          final Map<String, DefinedParagraphProperty> paragraphProperties}) =
      _$_RichStyleSheet;

  factory _RichStyleSheet.fromJson(Map<String, dynamic> json) =
      _$_RichStyleSheet.fromJson;

  @override
  String get name;
  @override
  Map<String, DefinedSpanProperty> get spanProperties;
  @override
  Map<String, DefinedParagraphProperty> get paragraphProperties;
  @override
  @JsonKey(ignore: true)
  _$$_RichStyleSheetCopyWith<_$_RichStyleSheet> get copyWith =>
      throw _privateConstructorUsedError;
}

MarkdownStyleSheet _$MarkdownStyleSheetFromJson(Map<String, dynamic> json) {
  return _MarkdownStyleSheet.fromJson(json);
}

/// @nodoc
mixin _$MarkdownStyleSheet {
  String get name => throw _privateConstructorUsedError;
  DefinedParagraphProperty get h1 => throw _privateConstructorUsedError;
  DefinedParagraphProperty get h2 => throw _privateConstructorUsedError;
  DefinedParagraphProperty get h3 => throw _privateConstructorUsedError;
  DefinedParagraphProperty get h4 => throw _privateConstructorUsedError;
  DefinedParagraphProperty get h5 => throw _privateConstructorUsedError;
  DefinedParagraphProperty get h6 => throw _privateConstructorUsedError;
  DefinedParagraphProperty get p => throw _privateConstructorUsedError;
  DefinedParagraphProperty get blockquote => throw _privateConstructorUsedError;
  DefinedParagraphProperty get code => throw _privateConstructorUsedError;
  DefinedParagraphProperty get pre => throw _privateConstructorUsedError;
  DefinedParagraphProperty get ol => throw _privateConstructorUsedError;
  DefinedParagraphProperty get ul => throw _privateConstructorUsedError;
  DefinedParagraphProperty get li => throw _privateConstructorUsedError;
  DefinedParagraphProperty get table => throw _privateConstructorUsedError;
  DefinedParagraphProperty get thead => throw _privateConstructorUsedError;
  DefinedParagraphProperty get tbody => throw _privateConstructorUsedError;
  DefinedParagraphProperty get tr => throw _privateConstructorUsedError;
  DefinedParagraphProperty get th => throw _privateConstructorUsedError;
  DefinedParagraphProperty get td => throw _privateConstructorUsedError;
  DefinedSpanProperty get em => throw _privateConstructorUsedError;
  DefinedSpanProperty get strong => throw _privateConstructorUsedError;
  DefinedSpanProperty get codeSpan => throw _privateConstructorUsedError;
  DefinedSpanProperty get del => throw _privateConstructorUsedError;
  DefinedSpanProperty get a => throw _privateConstructorUsedError;
  DefinedSpanProperty get img => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MarkdownStyleSheetCopyWith<MarkdownStyleSheet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkdownStyleSheetCopyWith<$Res> {
  factory $MarkdownStyleSheetCopyWith(
          MarkdownStyleSheet value, $Res Function(MarkdownStyleSheet) then) =
      _$MarkdownStyleSheetCopyWithImpl<$Res, MarkdownStyleSheet>;
  @useResult
  $Res call(
      {String name,
      DefinedParagraphProperty h1,
      DefinedParagraphProperty h2,
      DefinedParagraphProperty h3,
      DefinedParagraphProperty h4,
      DefinedParagraphProperty h5,
      DefinedParagraphProperty h6,
      DefinedParagraphProperty p,
      DefinedParagraphProperty blockquote,
      DefinedParagraphProperty code,
      DefinedParagraphProperty pre,
      DefinedParagraphProperty ol,
      DefinedParagraphProperty ul,
      DefinedParagraphProperty li,
      DefinedParagraphProperty table,
      DefinedParagraphProperty thead,
      DefinedParagraphProperty tbody,
      DefinedParagraphProperty tr,
      DefinedParagraphProperty th,
      DefinedParagraphProperty td,
      DefinedSpanProperty em,
      DefinedSpanProperty strong,
      DefinedSpanProperty codeSpan,
      DefinedSpanProperty del,
      DefinedSpanProperty a,
      DefinedSpanProperty img});
}

/// @nodoc
class _$MarkdownStyleSheetCopyWithImpl<$Res, $Val extends MarkdownStyleSheet>
    implements $MarkdownStyleSheetCopyWith<$Res> {
  _$MarkdownStyleSheetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? h1 = freezed,
    Object? h2 = freezed,
    Object? h3 = freezed,
    Object? h4 = freezed,
    Object? h5 = freezed,
    Object? h6 = freezed,
    Object? p = freezed,
    Object? blockquote = freezed,
    Object? code = freezed,
    Object? pre = freezed,
    Object? ol = freezed,
    Object? ul = freezed,
    Object? li = freezed,
    Object? table = freezed,
    Object? thead = freezed,
    Object? tbody = freezed,
    Object? tr = freezed,
    Object? th = freezed,
    Object? td = freezed,
    Object? em = freezed,
    Object? strong = freezed,
    Object? codeSpan = freezed,
    Object? del = freezed,
    Object? a = freezed,
    Object? img = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      h1: freezed == h1
          ? _value.h1
          : h1 // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      h2: freezed == h2
          ? _value.h2
          : h2 // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      h3: freezed == h3
          ? _value.h3
          : h3 // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      h4: freezed == h4
          ? _value.h4
          : h4 // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      h5: freezed == h5
          ? _value.h5
          : h5 // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      h6: freezed == h6
          ? _value.h6
          : h6 // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      p: freezed == p
          ? _value.p
          : p // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      blockquote: freezed == blockquote
          ? _value.blockquote
          : blockquote // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      pre: freezed == pre
          ? _value.pre
          : pre // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      ol: freezed == ol
          ? _value.ol
          : ol // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      ul: freezed == ul
          ? _value.ul
          : ul // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      li: freezed == li
          ? _value.li
          : li // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      table: freezed == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      thead: freezed == thead
          ? _value.thead
          : thead // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      tbody: freezed == tbody
          ? _value.tbody
          : tbody // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      tr: freezed == tr
          ? _value.tr
          : tr // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      th: freezed == th
          ? _value.th
          : th // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      td: freezed == td
          ? _value.td
          : td // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      em: freezed == em
          ? _value.em
          : em // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
      strong: freezed == strong
          ? _value.strong
          : strong // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
      codeSpan: freezed == codeSpan
          ? _value.codeSpan
          : codeSpan // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
      del: freezed == del
          ? _value.del
          : del // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
      a: freezed == a
          ? _value.a
          : a // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
      img: freezed == img
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MarkdownStyleSheetCopyWith<$Res>
    implements $MarkdownStyleSheetCopyWith<$Res> {
  factory _$$_MarkdownStyleSheetCopyWith(_$_MarkdownStyleSheet value,
          $Res Function(_$_MarkdownStyleSheet) then) =
      __$$_MarkdownStyleSheetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      DefinedParagraphProperty h1,
      DefinedParagraphProperty h2,
      DefinedParagraphProperty h3,
      DefinedParagraphProperty h4,
      DefinedParagraphProperty h5,
      DefinedParagraphProperty h6,
      DefinedParagraphProperty p,
      DefinedParagraphProperty blockquote,
      DefinedParagraphProperty code,
      DefinedParagraphProperty pre,
      DefinedParagraphProperty ol,
      DefinedParagraphProperty ul,
      DefinedParagraphProperty li,
      DefinedParagraphProperty table,
      DefinedParagraphProperty thead,
      DefinedParagraphProperty tbody,
      DefinedParagraphProperty tr,
      DefinedParagraphProperty th,
      DefinedParagraphProperty td,
      DefinedSpanProperty em,
      DefinedSpanProperty strong,
      DefinedSpanProperty codeSpan,
      DefinedSpanProperty del,
      DefinedSpanProperty a,
      DefinedSpanProperty img});
}

/// @nodoc
class __$$_MarkdownStyleSheetCopyWithImpl<$Res>
    extends _$MarkdownStyleSheetCopyWithImpl<$Res, _$_MarkdownStyleSheet>
    implements _$$_MarkdownStyleSheetCopyWith<$Res> {
  __$$_MarkdownStyleSheetCopyWithImpl(
      _$_MarkdownStyleSheet _value, $Res Function(_$_MarkdownStyleSheet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? h1 = freezed,
    Object? h2 = freezed,
    Object? h3 = freezed,
    Object? h4 = freezed,
    Object? h5 = freezed,
    Object? h6 = freezed,
    Object? p = freezed,
    Object? blockquote = freezed,
    Object? code = freezed,
    Object? pre = freezed,
    Object? ol = freezed,
    Object? ul = freezed,
    Object? li = freezed,
    Object? table = freezed,
    Object? thead = freezed,
    Object? tbody = freezed,
    Object? tr = freezed,
    Object? th = freezed,
    Object? td = freezed,
    Object? em = freezed,
    Object? strong = freezed,
    Object? codeSpan = freezed,
    Object? del = freezed,
    Object? a = freezed,
    Object? img = freezed,
  }) {
    return _then(_$_MarkdownStyleSheet(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      h1: freezed == h1
          ? _value.h1
          : h1 // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      h2: freezed == h2
          ? _value.h2
          : h2 // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      h3: freezed == h3
          ? _value.h3
          : h3 // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      h4: freezed == h4
          ? _value.h4
          : h4 // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      h5: freezed == h5
          ? _value.h5
          : h5 // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      h6: freezed == h6
          ? _value.h6
          : h6 // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      p: freezed == p
          ? _value.p
          : p // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      blockquote: freezed == blockquote
          ? _value.blockquote
          : blockquote // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      pre: freezed == pre
          ? _value.pre
          : pre // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      ol: freezed == ol
          ? _value.ol
          : ol // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      ul: freezed == ul
          ? _value.ul
          : ul // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      li: freezed == li
          ? _value.li
          : li // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      table: freezed == table
          ? _value.table
          : table // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      thead: freezed == thead
          ? _value.thead
          : thead // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      tbody: freezed == tbody
          ? _value.tbody
          : tbody // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      tr: freezed == tr
          ? _value.tr
          : tr // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      th: freezed == th
          ? _value.th
          : th // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      td: freezed == td
          ? _value.td
          : td // ignore: cast_nullable_to_non_nullable
              as DefinedParagraphProperty,
      em: freezed == em
          ? _value.em
          : em // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
      strong: freezed == strong
          ? _value.strong
          : strong // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
      codeSpan: freezed == codeSpan
          ? _value.codeSpan
          : codeSpan // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
      del: freezed == del
          ? _value.del
          : del // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
      a: freezed == a
          ? _value.a
          : a // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
      img: freezed == img
          ? _value.img
          : img // ignore: cast_nullable_to_non_nullable
              as DefinedSpanProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MarkdownStyleSheet implements _MarkdownStyleSheet {
  const _$_MarkdownStyleSheet(
      {this.name = '',
      required this.h1,
      required this.h2,
      required this.h3,
      required this.h4,
      required this.h5,
      required this.h6,
      required this.p,
      required this.blockquote,
      required this.code,
      required this.pre,
      required this.ol,
      required this.ul,
      required this.li,
      required this.table,
      required this.thead,
      required this.tbody,
      required this.tr,
      required this.th,
      required this.td,
      required this.em,
      required this.strong,
      required this.codeSpan,
      required this.del,
      required this.a,
      required this.img});

  factory _$_MarkdownStyleSheet.fromJson(Map<String, dynamic> json) =>
      _$$_MarkdownStyleSheetFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  final DefinedParagraphProperty h1;
  @override
  final DefinedParagraphProperty h2;
  @override
  final DefinedParagraphProperty h3;
  @override
  final DefinedParagraphProperty h4;
  @override
  final DefinedParagraphProperty h5;
  @override
  final DefinedParagraphProperty h6;
  @override
  final DefinedParagraphProperty p;
  @override
  final DefinedParagraphProperty blockquote;
  @override
  final DefinedParagraphProperty code;
  @override
  final DefinedParagraphProperty pre;
  @override
  final DefinedParagraphProperty ol;
  @override
  final DefinedParagraphProperty ul;
  @override
  final DefinedParagraphProperty li;
  @override
  final DefinedParagraphProperty table;
  @override
  final DefinedParagraphProperty thead;
  @override
  final DefinedParagraphProperty tbody;
  @override
  final DefinedParagraphProperty tr;
  @override
  final DefinedParagraphProperty th;
  @override
  final DefinedParagraphProperty td;
  @override
  final DefinedSpanProperty em;
  @override
  final DefinedSpanProperty strong;
  @override
  final DefinedSpanProperty codeSpan;
  @override
  final DefinedSpanProperty del;
  @override
  final DefinedSpanProperty a;
  @override
  final DefinedSpanProperty img;

  @override
  String toString() {
    return 'MarkdownStyleSheet(name: $name, h1: $h1, h2: $h2, h3: $h3, h4: $h4, h5: $h5, h6: $h6, p: $p, blockquote: $blockquote, code: $code, pre: $pre, ol: $ol, ul: $ul, li: $li, table: $table, thead: $thead, tbody: $tbody, tr: $tr, th: $th, td: $td, em: $em, strong: $strong, codeSpan: $codeSpan, del: $del, a: $a, img: $img)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MarkdownStyleSheet &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.h1, h1) &&
            const DeepCollectionEquality().equals(other.h2, h2) &&
            const DeepCollectionEquality().equals(other.h3, h3) &&
            const DeepCollectionEquality().equals(other.h4, h4) &&
            const DeepCollectionEquality().equals(other.h5, h5) &&
            const DeepCollectionEquality().equals(other.h6, h6) &&
            const DeepCollectionEquality().equals(other.p, p) &&
            const DeepCollectionEquality()
                .equals(other.blockquote, blockquote) &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.pre, pre) &&
            const DeepCollectionEquality().equals(other.ol, ol) &&
            const DeepCollectionEquality().equals(other.ul, ul) &&
            const DeepCollectionEquality().equals(other.li, li) &&
            const DeepCollectionEquality().equals(other.table, table) &&
            const DeepCollectionEquality().equals(other.thead, thead) &&
            const DeepCollectionEquality().equals(other.tbody, tbody) &&
            const DeepCollectionEquality().equals(other.tr, tr) &&
            const DeepCollectionEquality().equals(other.th, th) &&
            const DeepCollectionEquality().equals(other.td, td) &&
            const DeepCollectionEquality().equals(other.em, em) &&
            const DeepCollectionEquality().equals(other.strong, strong) &&
            const DeepCollectionEquality().equals(other.codeSpan, codeSpan) &&
            const DeepCollectionEquality().equals(other.del, del) &&
            const DeepCollectionEquality().equals(other.a, a) &&
            const DeepCollectionEquality().equals(other.img, img));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        name,
        const DeepCollectionEquality().hash(h1),
        const DeepCollectionEquality().hash(h2),
        const DeepCollectionEquality().hash(h3),
        const DeepCollectionEquality().hash(h4),
        const DeepCollectionEquality().hash(h5),
        const DeepCollectionEquality().hash(h6),
        const DeepCollectionEquality().hash(p),
        const DeepCollectionEquality().hash(blockquote),
        const DeepCollectionEquality().hash(code),
        const DeepCollectionEquality().hash(pre),
        const DeepCollectionEquality().hash(ol),
        const DeepCollectionEquality().hash(ul),
        const DeepCollectionEquality().hash(li),
        const DeepCollectionEquality().hash(table),
        const DeepCollectionEquality().hash(thead),
        const DeepCollectionEquality().hash(tbody),
        const DeepCollectionEquality().hash(tr),
        const DeepCollectionEquality().hash(th),
        const DeepCollectionEquality().hash(td),
        const DeepCollectionEquality().hash(em),
        const DeepCollectionEquality().hash(strong),
        const DeepCollectionEquality().hash(codeSpan),
        const DeepCollectionEquality().hash(del),
        const DeepCollectionEquality().hash(a),
        const DeepCollectionEquality().hash(img)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MarkdownStyleSheetCopyWith<_$_MarkdownStyleSheet> get copyWith =>
      __$$_MarkdownStyleSheetCopyWithImpl<_$_MarkdownStyleSheet>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MarkdownStyleSheetToJson(
      this,
    );
  }
}

abstract class _MarkdownStyleSheet implements MarkdownStyleSheet {
  const factory _MarkdownStyleSheet(
      {final String name,
      required final DefinedParagraphProperty h1,
      required final DefinedParagraphProperty h2,
      required final DefinedParagraphProperty h3,
      required final DefinedParagraphProperty h4,
      required final DefinedParagraphProperty h5,
      required final DefinedParagraphProperty h6,
      required final DefinedParagraphProperty p,
      required final DefinedParagraphProperty blockquote,
      required final DefinedParagraphProperty code,
      required final DefinedParagraphProperty pre,
      required final DefinedParagraphProperty ol,
      required final DefinedParagraphProperty ul,
      required final DefinedParagraphProperty li,
      required final DefinedParagraphProperty table,
      required final DefinedParagraphProperty thead,
      required final DefinedParagraphProperty tbody,
      required final DefinedParagraphProperty tr,
      required final DefinedParagraphProperty th,
      required final DefinedParagraphProperty td,
      required final DefinedSpanProperty em,
      required final DefinedSpanProperty strong,
      required final DefinedSpanProperty codeSpan,
      required final DefinedSpanProperty del,
      required final DefinedSpanProperty a,
      required final DefinedSpanProperty img}) = _$_MarkdownStyleSheet;

  factory _MarkdownStyleSheet.fromJson(Map<String, dynamic> json) =
      _$_MarkdownStyleSheet.fromJson;

  @override
  String get name;
  @override
  DefinedParagraphProperty get h1;
  @override
  DefinedParagraphProperty get h2;
  @override
  DefinedParagraphProperty get h3;
  @override
  DefinedParagraphProperty get h4;
  @override
  DefinedParagraphProperty get h5;
  @override
  DefinedParagraphProperty get h6;
  @override
  DefinedParagraphProperty get p;
  @override
  DefinedParagraphProperty get blockquote;
  @override
  DefinedParagraphProperty get code;
  @override
  DefinedParagraphProperty get pre;
  @override
  DefinedParagraphProperty get ol;
  @override
  DefinedParagraphProperty get ul;
  @override
  DefinedParagraphProperty get li;
  @override
  DefinedParagraphProperty get table;
  @override
  DefinedParagraphProperty get thead;
  @override
  DefinedParagraphProperty get tbody;
  @override
  DefinedParagraphProperty get tr;
  @override
  DefinedParagraphProperty get th;
  @override
  DefinedParagraphProperty get td;
  @override
  DefinedSpanProperty get em;
  @override
  DefinedSpanProperty get strong;
  @override
  DefinedSpanProperty get codeSpan;
  @override
  DefinedSpanProperty get del;
  @override
  DefinedSpanProperty get a;
  @override
  DefinedSpanProperty get img;
  @override
  @JsonKey(ignore: true)
  _$$_MarkdownStyleSheetCopyWith<_$_MarkdownStyleSheet> get copyWith =>
      throw _privateConstructorUsedError;
}
