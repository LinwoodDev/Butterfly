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
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandProperty value) hand,
    required TResult Function(LabelProperty value) label,
    required TResult Function(EraserProperty value) eraser,
    required TResult Function(PenProperty value) pen,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandProperty value)? hand,
    TResult Function(LabelProperty value)? label,
    TResult Function(EraserProperty value)? eraser,
    TResult Function(PenProperty value)? pen,
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
abstract class $HandPropertyCopyWith<$Res> {
  factory $HandPropertyCopyWith(
          HandProperty value, $Res Function(HandProperty) then) =
      _$HandPropertyCopyWithImpl<$Res>;
  $Res call({bool includeEraser});
}

/// @nodoc
class _$HandPropertyCopyWithImpl<$Res> extends _$PropertyCopyWithImpl<$Res>
    implements $HandPropertyCopyWith<$Res> {
  _$HandPropertyCopyWithImpl(
      HandProperty _value, $Res Function(HandProperty) _then)
      : super(_value, (v) => _then(v as HandProperty));

  @override
  HandProperty get _value => super._value as HandProperty;

  @override
  $Res call({
    Object? includeEraser = freezed,
  }) {
    return _then(HandProperty(
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
            other is HandProperty &&
            const DeepCollectionEquality()
                .equals(other.includeEraser, includeEraser));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(includeEraser));

  @JsonKey(ignore: true)
  @override
  $HandPropertyCopyWith<HandProperty> get copyWith =>
      _$HandPropertyCopyWithImpl<HandProperty>(this, _$identity);

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
  $HandPropertyCopyWith<HandProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabelPropertyCopyWith<$Res> {
  factory $LabelPropertyCopyWith(
          LabelProperty value, $Res Function(LabelProperty) then) =
      _$LabelPropertyCopyWithImpl<$Res>;
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
class _$LabelPropertyCopyWithImpl<$Res> extends _$PropertyCopyWithImpl<$Res>
    implements $LabelPropertyCopyWith<$Res> {
  _$LabelPropertyCopyWithImpl(
      LabelProperty _value, $Res Function(LabelProperty) _then)
      : super(_value, (v) => _then(v as LabelProperty));

  @override
  LabelProperty get _value => super._value as LabelProperty;

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
    return _then(LabelProperty(
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
            other is LabelProperty &&
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
  $LabelPropertyCopyWith<LabelProperty> get copyWith =>
      _$LabelPropertyCopyWithImpl<LabelProperty>(this, _$identity);

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
  $LabelPropertyCopyWith<LabelProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EraserPropertyCopyWith<$Res> {
  factory $EraserPropertyCopyWith(
          EraserProperty value, $Res Function(EraserProperty) then) =
      _$EraserPropertyCopyWithImpl<$Res>;
  $Res call({double strokeWidth, double strokeMultiplier, int color});
}

/// @nodoc
class _$EraserPropertyCopyWithImpl<$Res> extends _$PropertyCopyWithImpl<$Res>
    implements $EraserPropertyCopyWith<$Res> {
  _$EraserPropertyCopyWithImpl(
      EraserProperty _value, $Res Function(EraserProperty) _then)
      : super(_value, (v) => _then(v as EraserProperty));

  @override
  EraserProperty get _value => super._value as EraserProperty;

  @override
  $Res call({
    Object? strokeWidth = freezed,
    Object? strokeMultiplier = freezed,
    Object? color = freezed,
  }) {
    return _then(EraserProperty(
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
            other is EraserProperty &&
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
  $EraserPropertyCopyWith<EraserProperty> get copyWith =>
      _$EraserPropertyCopyWithImpl<EraserProperty>(this, _$identity);

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
  $EraserPropertyCopyWith<EraserProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PenPropertyCopyWith<$Res> {
  factory $PenPropertyCopyWith(
          PenProperty value, $Res Function(PenProperty) then) =
      _$PenPropertyCopyWithImpl<$Res>;
  $Res call(
      {double strokeWidth, double strokeMultiplier, int color, bool fill});
}

/// @nodoc
class _$PenPropertyCopyWithImpl<$Res> extends _$PropertyCopyWithImpl<$Res>
    implements $PenPropertyCopyWith<$Res> {
  _$PenPropertyCopyWithImpl(
      PenProperty _value, $Res Function(PenProperty) _then)
      : super(_value, (v) => _then(v as PenProperty));

  @override
  PenProperty get _value => super._value as PenProperty;

  @override
  $Res call({
    Object? strokeWidth = freezed,
    Object? strokeMultiplier = freezed,
    Object? color = freezed,
    Object? fill = freezed,
  }) {
    return _then(PenProperty(
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
            other is PenProperty &&
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
  $PenPropertyCopyWith<PenProperty> get copyWith =>
      _$PenPropertyCopyWithImpl<PenProperty>(this, _$identity);

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
  $PenPropertyCopyWith<PenProperty> get copyWith =>
      throw _privateConstructorUsedError;
}
