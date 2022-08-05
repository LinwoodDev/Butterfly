// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
    TResult Function(DefinedSpanProperty value)? defined,
    TResult Function(NamedSpanProperty value)? named,
    TResult Function(UndefinedSpanProperty value)? undefined,
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
      _$SpanPropertyCopyWithImpl<$Res>;
}

/// @nodoc
class _$SpanPropertyCopyWithImpl<$Res> implements $SpanPropertyCopyWith<$Res> {
  _$SpanPropertyCopyWithImpl(this._value, this._then);

  final SpanProperty _value;
  // ignore: unused_field
  final $Res Function(SpanProperty) _then;
}

/// @nodoc
abstract class _$$DefinedSpanPropertyCopyWith<$Res> {
  factory _$$DefinedSpanPropertyCopyWith(_$DefinedSpanProperty value,
          $Res Function(_$DefinedSpanProperty) then) =
      __$$DefinedSpanPropertyCopyWithImpl<$Res>;
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
    extends _$SpanPropertyCopyWithImpl<$Res>
    implements _$$DefinedSpanPropertyCopyWith<$Res> {
  __$$DefinedSpanPropertyCopyWithImpl(
      _$DefinedSpanProperty _value, $Res Function(_$DefinedSpanProperty) _then)
      : super(_value, (v) => _then(v as _$DefinedSpanProperty));

  @override
  _$DefinedSpanProperty get _value => super._value as _$DefinedSpanProperty;

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
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as double,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      fontWeight: fontWeight == freezed
          ? _value.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as int,
      lineThrough: lineThrough == freezed
          ? _value.lineThrough
          : lineThrough // ignore: cast_nullable_to_non_nullable
              as bool,
      underline: underline == freezed
          ? _value.underline
          : underline // ignore: cast_nullable_to_non_nullable
              as bool,
      overline: overline == freezed
          ? _value.overline
          : overline // ignore: cast_nullable_to_non_nullable
              as bool,
      italic: italic == freezed
          ? _value.italic
          : italic // ignore: cast_nullable_to_non_nullable
              as bool,
      letterSpacing: letterSpacing == freezed
          ? _value.letterSpacing
          : letterSpacing // ignore: cast_nullable_to_non_nullable
              as double,
      decorationColor: decorationColor == freezed
          ? _value.decorationColor
          : decorationColor // ignore: cast_nullable_to_non_nullable
              as int,
      decorationStyle: decorationStyle == freezed
          ? _value.decorationStyle
          : decorationStyle // ignore: cast_nullable_to_non_nullable
              as TextDecorationStyle,
      decorationThickness: decorationThickness == freezed
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
            const DeepCollectionEquality().equals(other.size, size) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality()
                .equals(other.fontWeight, fontWeight) &&
            const DeepCollectionEquality()
                .equals(other.lineThrough, lineThrough) &&
            const DeepCollectionEquality().equals(other.underline, underline) &&
            const DeepCollectionEquality().equals(other.overline, overline) &&
            const DeepCollectionEquality().equals(other.italic, italic) &&
            const DeepCollectionEquality()
                .equals(other.letterSpacing, letterSpacing) &&
            const DeepCollectionEquality()
                .equals(other.decorationColor, decorationColor) &&
            const DeepCollectionEquality()
                .equals(other.decorationStyle, decorationStyle) &&
            const DeepCollectionEquality()
                .equals(other.decorationThickness, decorationThickness));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(size),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(fontWeight),
      const DeepCollectionEquality().hash(lineThrough),
      const DeepCollectionEquality().hash(underline),
      const DeepCollectionEquality().hash(overline),
      const DeepCollectionEquality().hash(italic),
      const DeepCollectionEquality().hash(letterSpacing),
      const DeepCollectionEquality().hash(decorationColor),
      const DeepCollectionEquality().hash(decorationStyle),
      const DeepCollectionEquality().hash(decorationThickness));

  @JsonKey(ignore: true)
  @override
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
    TResult Function(DefinedSpanProperty value)? defined,
    TResult Function(NamedSpanProperty value)? named,
    TResult Function(UndefinedSpanProperty value)? undefined,
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
  $Res call({String name});
}

/// @nodoc
class __$$NamedSpanPropertyCopyWithImpl<$Res>
    extends _$SpanPropertyCopyWithImpl<$Res>
    implements _$$NamedSpanPropertyCopyWith<$Res> {
  __$$NamedSpanPropertyCopyWithImpl(
      _$NamedSpanProperty _value, $Res Function(_$NamedSpanProperty) _then)
      : super(_value, (v) => _then(v as _$NamedSpanProperty));

  @override
  _$NamedSpanProperty get _value => super._value as _$NamedSpanProperty;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$NamedSpanProperty(
      name == freezed
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
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
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
    TResult Function(DefinedSpanProperty value)? defined,
    TResult Function(NamedSpanProperty value)? named,
    TResult Function(UndefinedSpanProperty value)? undefined,
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
    extends _$SpanPropertyCopyWithImpl<$Res>
    implements _$$UndefinedSpanPropertyCopyWith<$Res> {
  __$$UndefinedSpanPropertyCopyWithImpl(_$UndefinedSpanProperty _value,
      $Res Function(_$UndefinedSpanProperty) _then)
      : super(_value, (v) => _then(v as _$UndefinedSpanProperty));

  @override
  _$UndefinedSpanProperty get _value => super._value as _$UndefinedSpanProperty;
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
    TResult Function(DefinedSpanProperty value)? defined,
    TResult Function(NamedSpanProperty value)? named,
    TResult Function(UndefinedSpanProperty value)? undefined,
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

AbstractProperty _$AbstractPropertyFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'defined':
      return DefinedAbstractProperty.fromJson(json);
    case 'named':
      return NamedAbstractProperty.fromJson(json);
    case 'undefined':
      return UndefinedAbstractProperty.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'AbstractProperty',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$AbstractProperty {
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
    TResult Function(SpanProperty spanProperty, HorizontalAlignment alignment)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
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
    required TResult Function(DefinedAbstractProperty value) defined,
    required TResult Function(NamedAbstractProperty value) named,
    required TResult Function(UndefinedAbstractProperty value) undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(DefinedAbstractProperty value)? defined,
    TResult Function(NamedAbstractProperty value)? named,
    TResult Function(UndefinedAbstractProperty value)? undefined,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedAbstractProperty value)? defined,
    TResult Function(NamedAbstractProperty value)? named,
    TResult Function(UndefinedAbstractProperty value)? undefined,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AbstractPropertyCopyWith<$Res> {
  factory $AbstractPropertyCopyWith(
          AbstractProperty value, $Res Function(AbstractProperty) then) =
      _$AbstractPropertyCopyWithImpl<$Res>;
}

/// @nodoc
class _$AbstractPropertyCopyWithImpl<$Res>
    implements $AbstractPropertyCopyWith<$Res> {
  _$AbstractPropertyCopyWithImpl(this._value, this._then);

  final AbstractProperty _value;
  // ignore: unused_field
  final $Res Function(AbstractProperty) _then;
}

/// @nodoc
abstract class _$$DefinedAbstractPropertyCopyWith<$Res> {
  factory _$$DefinedAbstractPropertyCopyWith(_$DefinedAbstractProperty value,
          $Res Function(_$DefinedAbstractProperty) then) =
      __$$DefinedAbstractPropertyCopyWithImpl<$Res>;
  $Res call({SpanProperty spanProperty, HorizontalAlignment alignment});

  $SpanPropertyCopyWith<$Res> get spanProperty;
}

/// @nodoc
class __$$DefinedAbstractPropertyCopyWithImpl<$Res>
    extends _$AbstractPropertyCopyWithImpl<$Res>
    implements _$$DefinedAbstractPropertyCopyWith<$Res> {
  __$$DefinedAbstractPropertyCopyWithImpl(_$DefinedAbstractProperty _value,
      $Res Function(_$DefinedAbstractProperty) _then)
      : super(_value, (v) => _then(v as _$DefinedAbstractProperty));

  @override
  _$DefinedAbstractProperty get _value =>
      super._value as _$DefinedAbstractProperty;

  @override
  $Res call({
    Object? spanProperty = freezed,
    Object? alignment = freezed,
  }) {
    return _then(_$DefinedAbstractProperty(
      spanProperty: spanProperty == freezed
          ? _value.spanProperty
          : spanProperty // ignore: cast_nullable_to_non_nullable
              as SpanProperty,
      alignment: alignment == freezed
          ? _value.alignment
          : alignment // ignore: cast_nullable_to_non_nullable
              as HorizontalAlignment,
    ));
  }

  @override
  $SpanPropertyCopyWith<$Res> get spanProperty {
    return $SpanPropertyCopyWith<$Res>(_value.spanProperty, (value) {
      return _then(_value.copyWith(spanProperty: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$DefinedAbstractProperty implements DefinedAbstractProperty {
  const _$DefinedAbstractProperty(
      {this.spanProperty = const SpanProperty.undefined(),
      this.alignment = HorizontalAlignment.left,
      final String? $type})
      : $type = $type ?? 'defined';

  factory _$DefinedAbstractProperty.fromJson(Map<String, dynamic> json) =>
      _$$DefinedAbstractPropertyFromJson(json);

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
    return 'AbstractProperty.defined(spanProperty: $spanProperty, alignment: $alignment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DefinedAbstractProperty &&
            const DeepCollectionEquality()
                .equals(other.spanProperty, spanProperty) &&
            const DeepCollectionEquality().equals(other.alignment, alignment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(spanProperty),
      const DeepCollectionEquality().hash(alignment));

  @JsonKey(ignore: true)
  @override
  _$$DefinedAbstractPropertyCopyWith<_$DefinedAbstractProperty> get copyWith =>
      __$$DefinedAbstractPropertyCopyWithImpl<_$DefinedAbstractProperty>(
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
    TResult Function(SpanProperty spanProperty, HorizontalAlignment alignment)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
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
    required TResult Function(DefinedAbstractProperty value) defined,
    required TResult Function(NamedAbstractProperty value) named,
    required TResult Function(UndefinedAbstractProperty value) undefined,
  }) {
    return defined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(DefinedAbstractProperty value)? defined,
    TResult Function(NamedAbstractProperty value)? named,
    TResult Function(UndefinedAbstractProperty value)? undefined,
  }) {
    return defined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedAbstractProperty value)? defined,
    TResult Function(NamedAbstractProperty value)? named,
    TResult Function(UndefinedAbstractProperty value)? undefined,
    required TResult orElse(),
  }) {
    if (defined != null) {
      return defined(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DefinedAbstractPropertyToJson(
      this,
    );
  }
}

abstract class DefinedAbstractProperty implements AbstractProperty {
  const factory DefinedAbstractProperty(
      {final SpanProperty spanProperty,
      final HorizontalAlignment alignment}) = _$DefinedAbstractProperty;

  factory DefinedAbstractProperty.fromJson(Map<String, dynamic> json) =
      _$DefinedAbstractProperty.fromJson;

  SpanProperty get spanProperty;
  HorizontalAlignment get alignment;
  @JsonKey(ignore: true)
  _$$DefinedAbstractPropertyCopyWith<_$DefinedAbstractProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NamedAbstractPropertyCopyWith<$Res> {
  factory _$$NamedAbstractPropertyCopyWith(_$NamedAbstractProperty value,
          $Res Function(_$NamedAbstractProperty) then) =
      __$$NamedAbstractPropertyCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class __$$NamedAbstractPropertyCopyWithImpl<$Res>
    extends _$AbstractPropertyCopyWithImpl<$Res>
    implements _$$NamedAbstractPropertyCopyWith<$Res> {
  __$$NamedAbstractPropertyCopyWithImpl(_$NamedAbstractProperty _value,
      $Res Function(_$NamedAbstractProperty) _then)
      : super(_value, (v) => _then(v as _$NamedAbstractProperty));

  @override
  _$NamedAbstractProperty get _value => super._value as _$NamedAbstractProperty;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$NamedAbstractProperty(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NamedAbstractProperty implements NamedAbstractProperty {
  const _$NamedAbstractProperty(this.name, {final String? $type})
      : $type = $type ?? 'named';

  factory _$NamedAbstractProperty.fromJson(Map<String, dynamic> json) =>
      _$$NamedAbstractPropertyFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AbstractProperty.named(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NamedAbstractProperty &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$NamedAbstractPropertyCopyWith<_$NamedAbstractProperty> get copyWith =>
      __$$NamedAbstractPropertyCopyWithImpl<_$NamedAbstractProperty>(
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
    TResult Function(SpanProperty spanProperty, HorizontalAlignment alignment)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
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
    required TResult Function(DefinedAbstractProperty value) defined,
    required TResult Function(NamedAbstractProperty value) named,
    required TResult Function(UndefinedAbstractProperty value) undefined,
  }) {
    return named(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(DefinedAbstractProperty value)? defined,
    TResult Function(NamedAbstractProperty value)? named,
    TResult Function(UndefinedAbstractProperty value)? undefined,
  }) {
    return named?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedAbstractProperty value)? defined,
    TResult Function(NamedAbstractProperty value)? named,
    TResult Function(UndefinedAbstractProperty value)? undefined,
    required TResult orElse(),
  }) {
    if (named != null) {
      return named(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$NamedAbstractPropertyToJson(
      this,
    );
  }
}

abstract class NamedAbstractProperty implements AbstractProperty {
  const factory NamedAbstractProperty(final String name) =
      _$NamedAbstractProperty;

  factory NamedAbstractProperty.fromJson(Map<String, dynamic> json) =
      _$NamedAbstractProperty.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$NamedAbstractPropertyCopyWith<_$NamedAbstractProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UndefinedAbstractPropertyCopyWith<$Res> {
  factory _$$UndefinedAbstractPropertyCopyWith(
          _$UndefinedAbstractProperty value,
          $Res Function(_$UndefinedAbstractProperty) then) =
      __$$UndefinedAbstractPropertyCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UndefinedAbstractPropertyCopyWithImpl<$Res>
    extends _$AbstractPropertyCopyWithImpl<$Res>
    implements _$$UndefinedAbstractPropertyCopyWith<$Res> {
  __$$UndefinedAbstractPropertyCopyWithImpl(_$UndefinedAbstractProperty _value,
      $Res Function(_$UndefinedAbstractProperty) _then)
      : super(_value, (v) => _then(v as _$UndefinedAbstractProperty));

  @override
  _$UndefinedAbstractProperty get _value =>
      super._value as _$UndefinedAbstractProperty;
}

/// @nodoc
@JsonSerializable()
class _$UndefinedAbstractProperty implements UndefinedAbstractProperty {
  const _$UndefinedAbstractProperty({final String? $type})
      : $type = $type ?? 'undefined';

  factory _$UndefinedAbstractProperty.fromJson(Map<String, dynamic> json) =>
      _$$UndefinedAbstractPropertyFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'AbstractProperty.undefined()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UndefinedAbstractProperty);
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
    TResult Function(SpanProperty spanProperty, HorizontalAlignment alignment)?
        defined,
    TResult Function(String name)? named,
    TResult Function()? undefined,
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
    required TResult Function(DefinedAbstractProperty value) defined,
    required TResult Function(NamedAbstractProperty value) named,
    required TResult Function(UndefinedAbstractProperty value) undefined,
  }) {
    return undefined(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(DefinedAbstractProperty value)? defined,
    TResult Function(NamedAbstractProperty value)? named,
    TResult Function(UndefinedAbstractProperty value)? undefined,
  }) {
    return undefined?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DefinedAbstractProperty value)? defined,
    TResult Function(NamedAbstractProperty value)? named,
    TResult Function(UndefinedAbstractProperty value)? undefined,
    required TResult orElse(),
  }) {
    if (undefined != null) {
      return undefined(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UndefinedAbstractPropertyToJson(
      this,
    );
  }
}

abstract class UndefinedAbstractProperty implements AbstractProperty {
  const factory UndefinedAbstractProperty() = _$UndefinedAbstractProperty;

  factory UndefinedAbstractProperty.fromJson(Map<String, dynamic> json) =
      _$UndefinedAbstractProperty.fromJson;
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
      _$TextSpanCopyWithImpl<$Res>;
  $Res call({String text, SpanProperty property});

  $SpanPropertyCopyWith<$Res> get property;
}

/// @nodoc
class _$TextSpanCopyWithImpl<$Res> implements $TextSpanCopyWith<$Res> {
  _$TextSpanCopyWithImpl(this._value, this._then);

  final TextSpan _value;
  // ignore: unused_field
  final $Res Function(TextSpan) _then;

  @override
  $Res call({
    Object? text = freezed,
    Object? property = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      property: property == freezed
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as SpanProperty,
    ));
  }

  @override
  $SpanPropertyCopyWith<$Res> get property {
    return $SpanPropertyCopyWith<$Res>(_value.property, (value) {
      return _then(_value.copyWith(property: value));
    });
  }
}

/// @nodoc
abstract class _$$_TextSpanCopyWith<$Res> implements $TextSpanCopyWith<$Res> {
  factory _$$_TextSpanCopyWith(
          _$_TextSpan value, $Res Function(_$_TextSpan) then) =
      __$$_TextSpanCopyWithImpl<$Res>;
  @override
  $Res call({String text, SpanProperty property});

  @override
  $SpanPropertyCopyWith<$Res> get property;
}

/// @nodoc
class __$$_TextSpanCopyWithImpl<$Res> extends _$TextSpanCopyWithImpl<$Res>
    implements _$$_TextSpanCopyWith<$Res> {
  __$$_TextSpanCopyWithImpl(
      _$_TextSpan _value, $Res Function(_$_TextSpan) _then)
      : super(_value, (v) => _then(v as _$_TextSpan));

  @override
  _$_TextSpan get _value => super._value as _$_TextSpan;

  @override
  $Res call({
    Object? text = freezed,
    Object? property = freezed,
  }) {
    return _then(_$_TextSpan(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      property: property == freezed
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
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.property, property));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(property));

  @JsonKey(ignore: true)
  @override
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

TextAbstract _$TextAbstractFromJson(Map<String, dynamic> json) {
  return _AbstractProperty.fromJson(json);
}

/// @nodoc
mixin _$TextAbstract {
  AbstractProperty get textProperty => throw _privateConstructorUsedError;
  List<TextSpan> get textSpans => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TextAbstractCopyWith<TextAbstract> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextAbstractCopyWith<$Res> {
  factory $TextAbstractCopyWith(
          TextAbstract value, $Res Function(TextAbstract) then) =
      _$TextAbstractCopyWithImpl<$Res>;
  $Res call({AbstractProperty textProperty, List<TextSpan> textSpans});

  $AbstractPropertyCopyWith<$Res> get textProperty;
}

/// @nodoc
class _$TextAbstractCopyWithImpl<$Res> implements $TextAbstractCopyWith<$Res> {
  _$TextAbstractCopyWithImpl(this._value, this._then);

  final TextAbstract _value;
  // ignore: unused_field
  final $Res Function(TextAbstract) _then;

  @override
  $Res call({
    Object? textProperty = freezed,
    Object? textSpans = freezed,
  }) {
    return _then(_value.copyWith(
      textProperty: textProperty == freezed
          ? _value.textProperty
          : textProperty // ignore: cast_nullable_to_non_nullable
              as AbstractProperty,
      textSpans: textSpans == freezed
          ? _value.textSpans
          : textSpans // ignore: cast_nullable_to_non_nullable
              as List<TextSpan>,
    ));
  }

  @override
  $AbstractPropertyCopyWith<$Res> get textProperty {
    return $AbstractPropertyCopyWith<$Res>(_value.textProperty, (value) {
      return _then(_value.copyWith(textProperty: value));
    });
  }
}

/// @nodoc
abstract class _$$_AbstractPropertyCopyWith<$Res>
    implements $TextAbstractCopyWith<$Res> {
  factory _$$_AbstractPropertyCopyWith(
          _$_AbstractProperty value, $Res Function(_$_AbstractProperty) then) =
      __$$_AbstractPropertyCopyWithImpl<$Res>;
  @override
  $Res call({AbstractProperty textProperty, List<TextSpan> textSpans});

  @override
  $AbstractPropertyCopyWith<$Res> get textProperty;
}

/// @nodoc
class __$$_AbstractPropertyCopyWithImpl<$Res>
    extends _$TextAbstractCopyWithImpl<$Res>
    implements _$$_AbstractPropertyCopyWith<$Res> {
  __$$_AbstractPropertyCopyWithImpl(
      _$_AbstractProperty _value, $Res Function(_$_AbstractProperty) _then)
      : super(_value, (v) => _then(v as _$_AbstractProperty));

  @override
  _$_AbstractProperty get _value => super._value as _$_AbstractProperty;

  @override
  $Res call({
    Object? textProperty = freezed,
    Object? textSpans = freezed,
  }) {
    return _then(_$_AbstractProperty(
      textProperty: textProperty == freezed
          ? _value.textProperty
          : textProperty // ignore: cast_nullable_to_non_nullable
              as AbstractProperty,
      textSpans: textSpans == freezed
          ? _value._textSpans
          : textSpans // ignore: cast_nullable_to_non_nullable
              as List<TextSpan>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AbstractProperty implements _AbstractProperty {
  const _$_AbstractProperty(
      {this.textProperty = const AbstractProperty.undefined(),
      final List<TextSpan> textSpans = const []})
      : _textSpans = textSpans;

  factory _$_AbstractProperty.fromJson(Map<String, dynamic> json) =>
      _$$_AbstractPropertyFromJson(json);

  @override
  @JsonKey()
  final AbstractProperty textProperty;
  final List<TextSpan> _textSpans;
  @override
  @JsonKey()
  List<TextSpan> get textSpans {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_textSpans);
  }

  @override
  String toString() {
    return 'TextAbstract(textProperty: $textProperty, textSpans: $textSpans)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AbstractProperty &&
            const DeepCollectionEquality()
                .equals(other.textProperty, textProperty) &&
            const DeepCollectionEquality()
                .equals(other._textSpans, _textSpans));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(textProperty),
      const DeepCollectionEquality().hash(_textSpans));

  @JsonKey(ignore: true)
  @override
  _$$_AbstractPropertyCopyWith<_$_AbstractProperty> get copyWith =>
      __$$_AbstractPropertyCopyWithImpl<_$_AbstractProperty>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AbstractPropertyToJson(
      this,
    );
  }
}

abstract class _AbstractProperty implements TextAbstract {
  const factory _AbstractProperty(
      {final AbstractProperty textProperty,
      final List<TextSpan> textSpans}) = _$_AbstractProperty;

  factory _AbstractProperty.fromJson(Map<String, dynamic> json) =
      _$_AbstractProperty.fromJson;

  @override
  AbstractProperty get textProperty;
  @override
  List<TextSpan> get textSpans;
  @override
  @JsonKey(ignore: true)
  _$$_AbstractPropertyCopyWith<_$_AbstractProperty> get copyWith =>
      throw _privateConstructorUsedError;
}
