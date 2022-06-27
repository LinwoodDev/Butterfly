// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'property.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Property _$PropertyFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'hand':
      return HandProperty.fromJson(json);
    case 'label':
      return LabelProperty.fromJson(json);
    case 'eraser':
      return EraserProperty.fromJson(json);
    case 'pen':
      return PenProperty.fromJson(json);
    case 'shape':
      return ShapeProperty.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'Property', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$Property {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool includeEraser) hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)
        label,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color)
        eraser,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool includeEraser)? hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier, int color)?
        eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool includeEraser)? hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier, int color)?
        eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandProperty value) hand,
    required TResult Function(LabelProperty value) label,
    required TResult Function(EraserProperty value) eraser,
    required TResult Function(PenProperty value) pen,
    required TResult Function(ShapeProperty value) shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropertyCopyWith<$Res> {
  factory $PropertyCopyWith(Property value, $Res Function(Property) then) =
      _$PropertyCopyWithImpl<$Res>;
}

/// @nodoc
class _$PropertyCopyWithImpl<$Res> implements $PropertyCopyWith<$Res> {
  _$PropertyCopyWithImpl(this._value, this._then);

  final Property _value;
  // ignore: unused_field
  final $Res Function(Property) _then;
}

/// @nodoc
abstract class _$$HandPropertyCopyWith<$Res> {
  factory _$$HandPropertyCopyWith(
          _$HandProperty value, $Res Function(_$HandProperty) then) =
      __$$HandPropertyCopyWithImpl<$Res>;
  $Res call({bool includeEraser});
}

/// @nodoc
class __$$HandPropertyCopyWithImpl<$Res> extends _$PropertyCopyWithImpl<$Res>
    implements _$$HandPropertyCopyWith<$Res> {
  __$$HandPropertyCopyWithImpl(
      _$HandProperty _value, $Res Function(_$HandProperty) _then)
      : super(_value, (v) => _then(v as _$HandProperty));

  @override
  _$HandProperty get _value => super._value as _$HandProperty;

  @override
  $Res call({
    Object? includeEraser = freezed,
  }) {
    return _then(_$HandProperty(
      includeEraser: includeEraser == freezed
          ? _value.includeEraser
          : includeEraser // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HandProperty implements HandProperty {
  const _$HandProperty({this.includeEraser = false, final String? $type})
      : $type = $type ?? 'hand';

  factory _$HandProperty.fromJson(Map<String, dynamic> json) =>
      _$$HandPropertyFromJson(json);

  @override
  @JsonKey()
  final bool includeEraser;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Property.hand(includeEraser: $includeEraser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HandProperty &&
            const DeepCollectionEquality()
                .equals(other.includeEraser, includeEraser));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(includeEraser));

  @JsonKey(ignore: true)
  @override
  _$$HandPropertyCopyWith<_$HandProperty> get copyWith =>
      __$$HandPropertyCopyWithImpl<_$HandProperty>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool includeEraser) hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)
        label,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color)
        eraser,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) {
    return hand(includeEraser);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool includeEraser)? hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier, int color)?
        eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
  }) {
    return hand?.call(includeEraser);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool includeEraser)? hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier, int color)?
        eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
    required TResult orElse(),
  }) {
    if (hand != null) {
      return hand(includeEraser);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandProperty value) hand,
    required TResult Function(LabelProperty value) label,
    required TResult Function(EraserProperty value) eraser,
    required TResult Function(PenProperty value) pen,
    required TResult Function(ShapeProperty value) shape,
  }) {
    return hand(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
  }) {
    return hand?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
    required TResult orElse(),
  }) {
    if (hand != null) {
      return hand(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$HandPropertyToJson(this);
  }
}

abstract class HandProperty implements Property {
  const factory HandProperty({final bool includeEraser}) = _$HandProperty;

  factory HandProperty.fromJson(Map<String, dynamic> json) =
      _$HandProperty.fromJson;

  bool get includeEraser => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$HandPropertyCopyWith<_$HandProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LabelPropertyCopyWith<$Res> {
  factory _$$LabelPropertyCopyWith(
          _$LabelProperty value, $Res Function(_$LabelProperty) then) =
      __$$LabelPropertyCopyWithImpl<$Res>;
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
      double decorationThickness,
      HorizontalAlignment horizontalAlignment,
      VerticalAlignment verticalAlignment});
}

/// @nodoc
class __$$LabelPropertyCopyWithImpl<$Res> extends _$PropertyCopyWithImpl<$Res>
    implements _$$LabelPropertyCopyWith<$Res> {
  __$$LabelPropertyCopyWithImpl(
      _$LabelProperty _value, $Res Function(_$LabelProperty) _then)
      : super(_value, (v) => _then(v as _$LabelProperty));

  @override
  _$LabelProperty get _value => super._value as _$LabelProperty;

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
    Object? horizontalAlignment = freezed,
    Object? verticalAlignment = freezed,
  }) {
    return _then(_$LabelProperty(
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
      horizontalAlignment: horizontalAlignment == freezed
          ? _value.horizontalAlignment
          : horizontalAlignment // ignore: cast_nullable_to_non_nullable
              as HorizontalAlignment,
      verticalAlignment: verticalAlignment == freezed
          ? _value.verticalAlignment
          : verticalAlignment // ignore: cast_nullable_to_non_nullable
              as VerticalAlignment,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LabelProperty implements LabelProperty {
  const _$LabelProperty(
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
      this.horizontalAlignment = HorizontalAlignment.left,
      this.verticalAlignment = VerticalAlignment.top,
      final String? $type})
      : $type = $type ?? 'label';

  factory _$LabelProperty.fromJson(Map<String, dynamic> json) =>
      _$$LabelPropertyFromJson(json);

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
  @override
  @JsonKey()
  final HorizontalAlignment horizontalAlignment;
  @override
  @JsonKey()
  final VerticalAlignment verticalAlignment;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Property.label(size: $size, color: $color, fontWeight: $fontWeight, lineThrough: $lineThrough, underline: $underline, overline: $overline, italic: $italic, letterSpacing: $letterSpacing, decorationColor: $decorationColor, decorationStyle: $decorationStyle, decorationThickness: $decorationThickness, horizontalAlignment: $horizontalAlignment, verticalAlignment: $verticalAlignment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LabelProperty &&
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
                .equals(other.decorationThickness, decorationThickness) &&
            const DeepCollectionEquality()
                .equals(other.horizontalAlignment, horizontalAlignment) &&
            const DeepCollectionEquality()
                .equals(other.verticalAlignment, verticalAlignment));
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
      const DeepCollectionEquality().hash(decorationThickness),
      const DeepCollectionEquality().hash(horizontalAlignment),
      const DeepCollectionEquality().hash(verticalAlignment));

  @JsonKey(ignore: true)
  @override
  _$$LabelPropertyCopyWith<_$LabelProperty> get copyWith =>
      __$$LabelPropertyCopyWithImpl<_$LabelProperty>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool includeEraser) hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)
        label,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color)
        eraser,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) {
    return label(
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
        horizontalAlignment,
        verticalAlignment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool includeEraser)? hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier, int color)?
        eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
  }) {
    return label?.call(
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
        horizontalAlignment,
        verticalAlignment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool includeEraser)? hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier, int color)?
        eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
    required TResult orElse(),
  }) {
    if (label != null) {
      return label(
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
          horizontalAlignment,
          verticalAlignment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandProperty value) hand,
    required TResult Function(LabelProperty value) label,
    required TResult Function(EraserProperty value) eraser,
    required TResult Function(PenProperty value) pen,
    required TResult Function(ShapeProperty value) shape,
  }) {
    return label(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
  }) {
    return label?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
    required TResult orElse(),
  }) {
    if (label != null) {
      return label(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LabelPropertyToJson(this);
  }
}

abstract class LabelProperty implements Property {
  const factory LabelProperty(
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
      final double decorationThickness,
      final HorizontalAlignment horizontalAlignment,
      final VerticalAlignment verticalAlignment}) = _$LabelProperty;

  factory LabelProperty.fromJson(Map<String, dynamic> json) =
      _$LabelProperty.fromJson;

  double get size => throw _privateConstructorUsedError;
  int get color => throw _privateConstructorUsedError;
  int get fontWeight => throw _privateConstructorUsedError;
  bool get lineThrough => throw _privateConstructorUsedError;
  bool get underline => throw _privateConstructorUsedError;
  bool get overline => throw _privateConstructorUsedError;
  bool get italic => throw _privateConstructorUsedError;
  double get letterSpacing => throw _privateConstructorUsedError;
  int get decorationColor => throw _privateConstructorUsedError;
  TextDecorationStyle get decorationStyle => throw _privateConstructorUsedError;
  double get decorationThickness => throw _privateConstructorUsedError;
  HorizontalAlignment get horizontalAlignment =>
      throw _privateConstructorUsedError;
  VerticalAlignment get verticalAlignment => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$LabelPropertyCopyWith<_$LabelProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EraserPropertyCopyWith<$Res> {
  factory _$$EraserPropertyCopyWith(
          _$EraserProperty value, $Res Function(_$EraserProperty) then) =
      __$$EraserPropertyCopyWithImpl<$Res>;
  $Res call({double strokeWidth, double strokeMultiplier, int color});
}

/// @nodoc
class __$$EraserPropertyCopyWithImpl<$Res> extends _$PropertyCopyWithImpl<$Res>
    implements _$$EraserPropertyCopyWith<$Res> {
  __$$EraserPropertyCopyWithImpl(
      _$EraserProperty _value, $Res Function(_$EraserProperty) _then)
      : super(_value, (v) => _then(v as _$EraserProperty));

  @override
  _$EraserProperty get _value => super._value as _$EraserProperty;

  @override
  $Res call({
    Object? strokeWidth = freezed,
    Object? strokeMultiplier = freezed,
    Object? color = freezed,
  }) {
    return _then(_$EraserProperty(
      strokeWidth: strokeWidth == freezed
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      strokeMultiplier: strokeMultiplier == freezed
          ? _value.strokeMultiplier
          : strokeMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EraserProperty with PathProperty implements EraserProperty {
  const _$EraserProperty(
      {this.strokeWidth = 5,
      this.strokeMultiplier = 10,
      this.color = kColorBlack,
      final String? $type})
      : $type = $type ?? 'eraser';

  factory _$EraserProperty.fromJson(Map<String, dynamic> json) =>
      _$$EraserPropertyFromJson(json);

  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final double strokeMultiplier;
  @override
  @JsonKey()
  final int color;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Property.eraser(strokeWidth: $strokeWidth, strokeMultiplier: $strokeMultiplier, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EraserProperty &&
            const DeepCollectionEquality()
                .equals(other.strokeWidth, strokeWidth) &&
            const DeepCollectionEquality()
                .equals(other.strokeMultiplier, strokeMultiplier) &&
            const DeepCollectionEquality().equals(other.color, color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(strokeWidth),
      const DeepCollectionEquality().hash(strokeMultiplier),
      const DeepCollectionEquality().hash(color));

  @JsonKey(ignore: true)
  @override
  _$$EraserPropertyCopyWith<_$EraserProperty> get copyWith =>
      __$$EraserPropertyCopyWithImpl<_$EraserProperty>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool includeEraser) hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)
        label,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color)
        eraser,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) {
    return eraser(strokeWidth, strokeMultiplier, color);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool includeEraser)? hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier, int color)?
        eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
  }) {
    return eraser?.call(strokeWidth, strokeMultiplier, color);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool includeEraser)? hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier, int color)?
        eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
    required TResult orElse(),
  }) {
    if (eraser != null) {
      return eraser(strokeWidth, strokeMultiplier, color);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandProperty value) hand,
    required TResult Function(LabelProperty value) label,
    required TResult Function(EraserProperty value) eraser,
    required TResult Function(PenProperty value) pen,
    required TResult Function(ShapeProperty value) shape,
  }) {
    return eraser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
  }) {
    return eraser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
    required TResult orElse(),
  }) {
    if (eraser != null) {
      return eraser(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EraserPropertyToJson(this);
  }
}

abstract class EraserProperty implements Property, PathProperty {
  const factory EraserProperty(
      {final double strokeWidth,
      final double strokeMultiplier,
      final int color}) = _$EraserProperty;

  factory EraserProperty.fromJson(Map<String, dynamic> json) =
      _$EraserProperty.fromJson;

  double get strokeWidth => throw _privateConstructorUsedError;
  double get strokeMultiplier => throw _privateConstructorUsedError;
  int get color => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$EraserPropertyCopyWith<_$EraserProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PenPropertyCopyWith<$Res> {
  factory _$$PenPropertyCopyWith(
          _$PenProperty value, $Res Function(_$PenProperty) then) =
      __$$PenPropertyCopyWithImpl<$Res>;
  $Res call(
      {double strokeWidth, double strokeMultiplier, int color, bool fill});
}

/// @nodoc
class __$$PenPropertyCopyWithImpl<$Res> extends _$PropertyCopyWithImpl<$Res>
    implements _$$PenPropertyCopyWith<$Res> {
  __$$PenPropertyCopyWithImpl(
      _$PenProperty _value, $Res Function(_$PenProperty) _then)
      : super(_value, (v) => _then(v as _$PenProperty));

  @override
  _$PenProperty get _value => super._value as _$PenProperty;

  @override
  $Res call({
    Object? strokeWidth = freezed,
    Object? strokeMultiplier = freezed,
    Object? color = freezed,
    Object? fill = freezed,
  }) {
    return _then(_$PenProperty(
      strokeWidth: strokeWidth == freezed
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      strokeMultiplier: strokeMultiplier == freezed
          ? _value.strokeMultiplier
          : strokeMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      fill: fill == freezed
          ? _value.fill
          : fill // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PenProperty with PathProperty implements PenProperty {
  const _$PenProperty(
      {this.strokeWidth = 5,
      this.strokeMultiplier = 10,
      this.color = kColorBlack,
      this.fill = false,
      final String? $type})
      : $type = $type ?? 'pen';

  factory _$PenProperty.fromJson(Map<String, dynamic> json) =>
      _$$PenPropertyFromJson(json);

  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final double strokeMultiplier;
  @override
  @JsonKey()
  final int color;
  @override
  @JsonKey()
  final bool fill;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Property.pen(strokeWidth: $strokeWidth, strokeMultiplier: $strokeMultiplier, color: $color, fill: $fill)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PenProperty &&
            const DeepCollectionEquality()
                .equals(other.strokeWidth, strokeWidth) &&
            const DeepCollectionEquality()
                .equals(other.strokeMultiplier, strokeMultiplier) &&
            const DeepCollectionEquality().equals(other.color, color) &&
            const DeepCollectionEquality().equals(other.fill, fill));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(strokeWidth),
      const DeepCollectionEquality().hash(strokeMultiplier),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(fill));

  @JsonKey(ignore: true)
  @override
  _$$PenPropertyCopyWith<_$PenProperty> get copyWith =>
      __$$PenPropertyCopyWithImpl<_$PenProperty>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool includeEraser) hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)
        label,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color)
        eraser,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) {
    return pen(strokeWidth, strokeMultiplier, color, fill);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool includeEraser)? hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier, int color)?
        eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
  }) {
    return pen?.call(strokeWidth, strokeMultiplier, color, fill);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool includeEraser)? hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier, int color)?
        eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(strokeWidth, strokeMultiplier, color, fill);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandProperty value) hand,
    required TResult Function(LabelProperty value) label,
    required TResult Function(EraserProperty value) eraser,
    required TResult Function(PenProperty value) pen,
    required TResult Function(ShapeProperty value) shape,
  }) {
    return pen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
  }) {
    return pen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PenPropertyToJson(this);
  }
}

abstract class PenProperty implements Property, PathProperty {
  const factory PenProperty(
      {final double strokeWidth,
      final double strokeMultiplier,
      final int color,
      final bool fill}) = _$PenProperty;

  factory PenProperty.fromJson(Map<String, dynamic> json) =
      _$PenProperty.fromJson;

  double get strokeWidth => throw _privateConstructorUsedError;
  double get strokeMultiplier => throw _privateConstructorUsedError;
  int get color => throw _privateConstructorUsedError;
  bool get fill => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$PenPropertyCopyWith<_$PenProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShapePropertyCopyWith<$Res> {
  factory _$$ShapePropertyCopyWith(
          _$ShapeProperty value, $Res Function(_$ShapeProperty) then) =
      __$$ShapePropertyCopyWithImpl<$Res>;
  $Res call({double strokeWidth, PathShape shape, int color});

  $PathShapeCopyWith<$Res> get shape;
}

/// @nodoc
class __$$ShapePropertyCopyWithImpl<$Res> extends _$PropertyCopyWithImpl<$Res>
    implements _$$ShapePropertyCopyWith<$Res> {
  __$$ShapePropertyCopyWithImpl(
      _$ShapeProperty _value, $Res Function(_$ShapeProperty) _then)
      : super(_value, (v) => _then(v as _$ShapeProperty));

  @override
  _$ShapeProperty get _value => super._value as _$ShapeProperty;

  @override
  $Res call({
    Object? strokeWidth = freezed,
    Object? shape = freezed,
    Object? color = freezed,
  }) {
    return _then(_$ShapeProperty(
      strokeWidth: strokeWidth == freezed
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      shape: shape == freezed
          ? _value.shape
          : shape // ignore: cast_nullable_to_non_nullable
              as PathShape,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $PathShapeCopyWith<$Res> get shape {
    return $PathShapeCopyWith<$Res>(_value.shape, (value) {
      return _then(_value.copyWith(shape: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ShapeProperty implements ShapeProperty {
  const _$ShapeProperty(
      {this.strokeWidth = 5,
      required this.shape,
      this.color = kColorBlack,
      final String? $type})
      : $type = $type ?? 'shape';

  factory _$ShapeProperty.fromJson(Map<String, dynamic> json) =>
      _$$ShapePropertyFromJson(json);

  @override
  @JsonKey()
  final double strokeWidth;
  @override
  final PathShape shape;
  @override
  @JsonKey()
  final int color;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Property.shape(strokeWidth: $strokeWidth, shape: $shape, color: $color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShapeProperty &&
            const DeepCollectionEquality()
                .equals(other.strokeWidth, strokeWidth) &&
            const DeepCollectionEquality().equals(other.shape, shape) &&
            const DeepCollectionEquality().equals(other.color, color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(strokeWidth),
      const DeepCollectionEquality().hash(shape),
      const DeepCollectionEquality().hash(color));

  @JsonKey(ignore: true)
  @override
  _$$ShapePropertyCopyWith<_$ShapeProperty> get copyWith =>
      __$$ShapePropertyCopyWithImpl<_$ShapeProperty>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool includeEraser) hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)
        label,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color)
        eraser,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) {
    return shape(strokeWidth, this.shape, color);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(bool includeEraser)? hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier, int color)?
        eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
  }) {
    return shape?.call(strokeWidth, this.shape, color);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool includeEraser)? hand,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier, int color)?
        eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
    required TResult orElse(),
  }) {
    if (shape != null) {
      return shape(strokeWidth, this.shape, color);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandProperty value) hand,
    required TResult Function(LabelProperty value) label,
    required TResult Function(EraserProperty value) eraser,
    required TResult Function(PenProperty value) pen,
    required TResult Function(ShapeProperty value) shape,
  }) {
    return shape(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
  }) {
    return shape?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
    required TResult orElse(),
  }) {
    if (shape != null) {
      return shape(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ShapePropertyToJson(this);
  }
}

abstract class ShapeProperty implements Property {
  const factory ShapeProperty(
      {final double strokeWidth,
      required final PathShape shape,
      final int color}) = _$ShapeProperty;

  factory ShapeProperty.fromJson(Map<String, dynamic> json) =
      _$ShapeProperty.fromJson;

  double get strokeWidth => throw _privateConstructorUsedError;
  PathShape get shape => throw _privateConstructorUsedError;
  int get color => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$ShapePropertyCopyWith<_$ShapeProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

PathShape _$PathShapeFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'circle':
      return CircleShape.fromJson(json);
    case 'rectangle':
      return RectangleShape.fromJson(json);
    case 'line':
      return LineShape.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'PathShape', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$PathShape {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int fillColor) circle,
    required TResult Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)
        rectangle,
    required TResult Function() line,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int fillColor)? circle,
    TResult Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)?
        rectangle,
    TResult Function()? line,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int fillColor)? circle,
    TResult Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)?
        rectangle,
    TResult Function()? line,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CircleShape value) circle,
    required TResult Function(RectangleShape value) rectangle,
    required TResult Function(LineShape value) line,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CircleShape value)? circle,
    TResult Function(RectangleShape value)? rectangle,
    TResult Function(LineShape value)? line,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CircleShape value)? circle,
    TResult Function(RectangleShape value)? rectangle,
    TResult Function(LineShape value)? line,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PathShapeCopyWith<$Res> {
  factory $PathShapeCopyWith(PathShape value, $Res Function(PathShape) then) =
      _$PathShapeCopyWithImpl<$Res>;
}

/// @nodoc
class _$PathShapeCopyWithImpl<$Res> implements $PathShapeCopyWith<$Res> {
  _$PathShapeCopyWithImpl(this._value, this._then);

  final PathShape _value;
  // ignore: unused_field
  final $Res Function(PathShape) _then;
}

/// @nodoc
abstract class _$$CircleShapeCopyWith<$Res> {
  factory _$$CircleShapeCopyWith(
          _$CircleShape value, $Res Function(_$CircleShape) then) =
      __$$CircleShapeCopyWithImpl<$Res>;
  $Res call({int fillColor});
}

/// @nodoc
class __$$CircleShapeCopyWithImpl<$Res> extends _$PathShapeCopyWithImpl<$Res>
    implements _$$CircleShapeCopyWith<$Res> {
  __$$CircleShapeCopyWithImpl(
      _$CircleShape _value, $Res Function(_$CircleShape) _then)
      : super(_value, (v) => _then(v as _$CircleShape));

  @override
  _$CircleShape get _value => super._value as _$CircleShape;

  @override
  $Res call({
    Object? fillColor = freezed,
  }) {
    return _then(_$CircleShape(
      fillColor: fillColor == freezed
          ? _value.fillColor
          : fillColor // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CircleShape extends CircleShape {
  const _$CircleShape({this.fillColor = kColorTransparent, final String? $type})
      : $type = $type ?? 'circle',
        super._();

  factory _$CircleShape.fromJson(Map<String, dynamic> json) =>
      _$$CircleShapeFromJson(json);

  @override
  @JsonKey()
  final int fillColor;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PathShape.circle(fillColor: $fillColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CircleShape &&
            const DeepCollectionEquality().equals(other.fillColor, fillColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(fillColor));

  @JsonKey(ignore: true)
  @override
  _$$CircleShapeCopyWith<_$CircleShape> get copyWith =>
      __$$CircleShapeCopyWithImpl<_$CircleShape>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int fillColor) circle,
    required TResult Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)
        rectangle,
    required TResult Function() line,
  }) {
    return circle(fillColor);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int fillColor)? circle,
    TResult Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)?
        rectangle,
    TResult Function()? line,
  }) {
    return circle?.call(fillColor);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int fillColor)? circle,
    TResult Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)?
        rectangle,
    TResult Function()? line,
    required TResult orElse(),
  }) {
    if (circle != null) {
      return circle(fillColor);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CircleShape value) circle,
    required TResult Function(RectangleShape value) rectangle,
    required TResult Function(LineShape value) line,
  }) {
    return circle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CircleShape value)? circle,
    TResult Function(RectangleShape value)? rectangle,
    TResult Function(LineShape value)? line,
  }) {
    return circle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CircleShape value)? circle,
    TResult Function(RectangleShape value)? rectangle,
    TResult Function(LineShape value)? line,
    required TResult orElse(),
  }) {
    if (circle != null) {
      return circle(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CircleShapeToJson(this);
  }
}

abstract class CircleShape extends PathShape {
  const factory CircleShape({final int fillColor}) = _$CircleShape;
  const CircleShape._() : super._();

  factory CircleShape.fromJson(Map<String, dynamic> json) =
      _$CircleShape.fromJson;

  int get fillColor => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$CircleShapeCopyWith<_$CircleShape> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RectangleShapeCopyWith<$Res> {
  factory _$$RectangleShapeCopyWith(
          _$RectangleShape value, $Res Function(_$RectangleShape) then) =
      __$$RectangleShapeCopyWithImpl<$Res>;
  $Res call(
      {int fillColor,
      double topLeftCornerRadius,
      double topRightCornerRadius,
      double bottomLeftCornerRadius,
      double bottomRightCornerRadius});
}

/// @nodoc
class __$$RectangleShapeCopyWithImpl<$Res> extends _$PathShapeCopyWithImpl<$Res>
    implements _$$RectangleShapeCopyWith<$Res> {
  __$$RectangleShapeCopyWithImpl(
      _$RectangleShape _value, $Res Function(_$RectangleShape) _then)
      : super(_value, (v) => _then(v as _$RectangleShape));

  @override
  _$RectangleShape get _value => super._value as _$RectangleShape;

  @override
  $Res call({
    Object? fillColor = freezed,
    Object? topLeftCornerRadius = freezed,
    Object? topRightCornerRadius = freezed,
    Object? bottomLeftCornerRadius = freezed,
    Object? bottomRightCornerRadius = freezed,
  }) {
    return _then(_$RectangleShape(
      fillColor: fillColor == freezed
          ? _value.fillColor
          : fillColor // ignore: cast_nullable_to_non_nullable
              as int,
      topLeftCornerRadius: topLeftCornerRadius == freezed
          ? _value.topLeftCornerRadius
          : topLeftCornerRadius // ignore: cast_nullable_to_non_nullable
              as double,
      topRightCornerRadius: topRightCornerRadius == freezed
          ? _value.topRightCornerRadius
          : topRightCornerRadius // ignore: cast_nullable_to_non_nullable
              as double,
      bottomLeftCornerRadius: bottomLeftCornerRadius == freezed
          ? _value.bottomLeftCornerRadius
          : bottomLeftCornerRadius // ignore: cast_nullable_to_non_nullable
              as double,
      bottomRightCornerRadius: bottomRightCornerRadius == freezed
          ? _value.bottomRightCornerRadius
          : bottomRightCornerRadius // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RectangleShape extends RectangleShape {
  const _$RectangleShape(
      {this.fillColor = kColorTransparent,
      this.topLeftCornerRadius = 0,
      this.topRightCornerRadius = 0,
      this.bottomLeftCornerRadius = 0,
      this.bottomRightCornerRadius = 0,
      final String? $type})
      : $type = $type ?? 'rectangle',
        super._();

  factory _$RectangleShape.fromJson(Map<String, dynamic> json) =>
      _$$RectangleShapeFromJson(json);

  @override
  @JsonKey()
  final int fillColor;
  @override
  @JsonKey()
  final double topLeftCornerRadius;
  @override
  @JsonKey()
  final double topRightCornerRadius;
  @override
  @JsonKey()
  final double bottomLeftCornerRadius;
  @override
  @JsonKey()
  final double bottomRightCornerRadius;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PathShape.rectangle(fillColor: $fillColor, topLeftCornerRadius: $topLeftCornerRadius, topRightCornerRadius: $topRightCornerRadius, bottomLeftCornerRadius: $bottomLeftCornerRadius, bottomRightCornerRadius: $bottomRightCornerRadius)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RectangleShape &&
            const DeepCollectionEquality().equals(other.fillColor, fillColor) &&
            const DeepCollectionEquality()
                .equals(other.topLeftCornerRadius, topLeftCornerRadius) &&
            const DeepCollectionEquality()
                .equals(other.topRightCornerRadius, topRightCornerRadius) &&
            const DeepCollectionEquality()
                .equals(other.bottomLeftCornerRadius, bottomLeftCornerRadius) &&
            const DeepCollectionEquality().equals(
                other.bottomRightCornerRadius, bottomRightCornerRadius));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(fillColor),
      const DeepCollectionEquality().hash(topLeftCornerRadius),
      const DeepCollectionEquality().hash(topRightCornerRadius),
      const DeepCollectionEquality().hash(bottomLeftCornerRadius),
      const DeepCollectionEquality().hash(bottomRightCornerRadius));

  @JsonKey(ignore: true)
  @override
  _$$RectangleShapeCopyWith<_$RectangleShape> get copyWith =>
      __$$RectangleShapeCopyWithImpl<_$RectangleShape>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int fillColor) circle,
    required TResult Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)
        rectangle,
    required TResult Function() line,
  }) {
    return rectangle(fillColor, topLeftCornerRadius, topRightCornerRadius,
        bottomLeftCornerRadius, bottomRightCornerRadius);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int fillColor)? circle,
    TResult Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)?
        rectangle,
    TResult Function()? line,
  }) {
    return rectangle?.call(fillColor, topLeftCornerRadius, topRightCornerRadius,
        bottomLeftCornerRadius, bottomRightCornerRadius);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int fillColor)? circle,
    TResult Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)?
        rectangle,
    TResult Function()? line,
    required TResult orElse(),
  }) {
    if (rectangle != null) {
      return rectangle(fillColor, topLeftCornerRadius, topRightCornerRadius,
          bottomLeftCornerRadius, bottomRightCornerRadius);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CircleShape value) circle,
    required TResult Function(RectangleShape value) rectangle,
    required TResult Function(LineShape value) line,
  }) {
    return rectangle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CircleShape value)? circle,
    TResult Function(RectangleShape value)? rectangle,
    TResult Function(LineShape value)? line,
  }) {
    return rectangle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CircleShape value)? circle,
    TResult Function(RectangleShape value)? rectangle,
    TResult Function(LineShape value)? line,
    required TResult orElse(),
  }) {
    if (rectangle != null) {
      return rectangle(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RectangleShapeToJson(this);
  }
}

abstract class RectangleShape extends PathShape {
  const factory RectangleShape(
      {final int fillColor,
      final double topLeftCornerRadius,
      final double topRightCornerRadius,
      final double bottomLeftCornerRadius,
      final double bottomRightCornerRadius}) = _$RectangleShape;
  const RectangleShape._() : super._();

  factory RectangleShape.fromJson(Map<String, dynamic> json) =
      _$RectangleShape.fromJson;

  int get fillColor => throw _privateConstructorUsedError;
  double get topLeftCornerRadius => throw _privateConstructorUsedError;
  double get topRightCornerRadius => throw _privateConstructorUsedError;
  double get bottomLeftCornerRadius => throw _privateConstructorUsedError;
  double get bottomRightCornerRadius => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$$RectangleShapeCopyWith<_$RectangleShape> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LineShapeCopyWith<$Res> {
  factory _$$LineShapeCopyWith(
          _$LineShape value, $Res Function(_$LineShape) then) =
      __$$LineShapeCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LineShapeCopyWithImpl<$Res> extends _$PathShapeCopyWithImpl<$Res>
    implements _$$LineShapeCopyWith<$Res> {
  __$$LineShapeCopyWithImpl(
      _$LineShape _value, $Res Function(_$LineShape) _then)
      : super(_value, (v) => _then(v as _$LineShape));

  @override
  _$LineShape get _value => super._value as _$LineShape;
}

/// @nodoc
@JsonSerializable()
class _$LineShape extends LineShape {
  const _$LineShape({final String? $type})
      : $type = $type ?? 'line',
        super._();

  factory _$LineShape.fromJson(Map<String, dynamic> json) =>
      _$$LineShapeFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PathShape.line()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LineShape);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int fillColor) circle,
    required TResult Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)
        rectangle,
    required TResult Function() line,
  }) {
    return line();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(int fillColor)? circle,
    TResult Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)?
        rectangle,
    TResult Function()? line,
  }) {
    return line?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int fillColor)? circle,
    TResult Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)?
        rectangle,
    TResult Function()? line,
    required TResult orElse(),
  }) {
    if (line != null) {
      return line();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CircleShape value) circle,
    required TResult Function(RectangleShape value) rectangle,
    required TResult Function(LineShape value) line,
  }) {
    return line(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(CircleShape value)? circle,
    TResult Function(RectangleShape value)? rectangle,
    TResult Function(LineShape value)? line,
  }) {
    return line?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CircleShape value)? circle,
    TResult Function(RectangleShape value)? rectangle,
    TResult Function(LineShape value)? line,
    required TResult orElse(),
  }) {
    if (line != null) {
      return line(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LineShapeToJson(this);
  }
}

abstract class LineShape extends PathShape {
  const factory LineShape() = _$LineShape;
  const LineShape._() : super._();

  factory LineShape.fromJson(Map<String, dynamic> json) = _$LineShape.fromJson;
}
