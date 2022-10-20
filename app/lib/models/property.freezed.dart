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
    required TResult Function(double strokeWidth, double strokeMultiplier)
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult? Function(double strokeWidth, double strokeMultiplier)? eraser,
    TResult? Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult? Function(double strokeWidth, PathShape shape, int color)? shape,
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier)? eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LabelProperty value) label,
    required TResult Function(EraserProperty value) eraser,
    required TResult Function(PenProperty value) pen,
    required TResult Function(ShapeProperty value) shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LabelProperty value)? label,
    TResult? Function(EraserProperty value)? eraser,
    TResult? Function(PenProperty value)? pen,
    TResult? Function(ShapeProperty value)? shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
      _$PropertyCopyWithImpl<$Res, Property>;
}

/// @nodoc
class _$PropertyCopyWithImpl<$Res, $Val extends Property>
    implements $PropertyCopyWith<$Res> {
  _$PropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LabelPropertyCopyWith<$Res> {
  factory _$$LabelPropertyCopyWith(
          _$LabelProperty value, $Res Function(_$LabelProperty) then) =
      __$$LabelPropertyCopyWithImpl<$Res>;
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
      double decorationThickness,
      HorizontalAlignment horizontalAlignment,
      VerticalAlignment verticalAlignment});
}

/// @nodoc
class __$$LabelPropertyCopyWithImpl<$Res>
    extends _$PropertyCopyWithImpl<$Res, _$LabelProperty>
    implements _$$LabelPropertyCopyWith<$Res> {
  __$$LabelPropertyCopyWithImpl(
      _$LabelProperty _value, $Res Function(_$LabelProperty) _then)
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
    Object? horizontalAlignment = null,
    Object? verticalAlignment = null,
  }) {
    return _then(_$LabelProperty(
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
      horizontalAlignment: null == horizontalAlignment
          ? _value.horizontalAlignment
          : horizontalAlignment // ignore: cast_nullable_to_non_nullable
              as HorizontalAlignment,
      verticalAlignment: null == verticalAlignment
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
            (identical(other.horizontalAlignment, horizontalAlignment) ||
                other.horizontalAlignment == horizontalAlignment) &&
            (identical(other.verticalAlignment, verticalAlignment) ||
                other.verticalAlignment == verticalAlignment));
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
      horizontalAlignment,
      verticalAlignment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LabelPropertyCopyWith<_$LabelProperty> get copyWith =>
      __$$LabelPropertyCopyWithImpl<_$LabelProperty>(this, _$identity);

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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)
        label,
    required TResult Function(double strokeWidth, double strokeMultiplier)
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult? Function(double strokeWidth, double strokeMultiplier)? eraser,
    TResult? Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult? Function(double strokeWidth, PathShape shape, int color)? shape,
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
    TResult Function(double strokeWidth, double strokeMultiplier)? eraser,
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
    TResult? Function(LabelProperty value)? label,
    TResult? Function(EraserProperty value)? eraser,
    TResult? Function(PenProperty value)? pen,
    TResult? Function(ShapeProperty value)? shape,
  }) {
    return label?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
    return _$$LabelPropertyToJson(
      this,
    );
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
  HorizontalAlignment get horizontalAlignment;
  VerticalAlignment get verticalAlignment;
  @JsonKey(ignore: true)
  _$$LabelPropertyCopyWith<_$LabelProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EraserPropertyCopyWith<$Res> {
  factory _$$EraserPropertyCopyWith(
          _$EraserProperty value, $Res Function(_$EraserProperty) then) =
      __$$EraserPropertyCopyWithImpl<$Res>;
  @useResult
  $Res call({double strokeWidth, double strokeMultiplier});
}

/// @nodoc
class __$$EraserPropertyCopyWithImpl<$Res>
    extends _$PropertyCopyWithImpl<$Res, _$EraserProperty>
    implements _$$EraserPropertyCopyWith<$Res> {
  __$$EraserPropertyCopyWithImpl(
      _$EraserProperty _value, $Res Function(_$EraserProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strokeWidth = null,
    Object? strokeMultiplier = null,
  }) {
    return _then(_$EraserProperty(
      strokeWidth: null == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      strokeMultiplier: null == strokeMultiplier
          ? _value.strokeMultiplier
          : strokeMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EraserProperty implements EraserProperty {
  const _$EraserProperty(
      {this.strokeWidth = 5, this.strokeMultiplier = 10, final String? $type})
      : $type = $type ?? 'eraser';

  factory _$EraserProperty.fromJson(Map<String, dynamic> json) =>
      _$$EraserPropertyFromJson(json);

  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final double strokeMultiplier;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Property.eraser(strokeWidth: $strokeWidth, strokeMultiplier: $strokeMultiplier)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EraserProperty &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.strokeMultiplier, strokeMultiplier) ||
                other.strokeMultiplier == strokeMultiplier));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, strokeWidth, strokeMultiplier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EraserPropertyCopyWith<_$EraserProperty> get copyWith =>
      __$$EraserPropertyCopyWithImpl<_$EraserProperty>(this, _$identity);

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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)
        label,
    required TResult Function(double strokeWidth, double strokeMultiplier)
        eraser,
    required TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) {
    return eraser(strokeWidth, strokeMultiplier);
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult? Function(double strokeWidth, double strokeMultiplier)? eraser,
    TResult? Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult? Function(double strokeWidth, PathShape shape, int color)? shape,
  }) {
    return eraser?.call(strokeWidth, strokeMultiplier);
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier)? eraser,
    TResult Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
    required TResult orElse(),
  }) {
    if (eraser != null) {
      return eraser(strokeWidth, strokeMultiplier);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
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
    TResult? Function(LabelProperty value)? label,
    TResult? Function(EraserProperty value)? eraser,
    TResult? Function(PenProperty value)? pen,
    TResult? Function(ShapeProperty value)? shape,
  }) {
    return eraser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
    return _$$EraserPropertyToJson(
      this,
    );
  }
}

abstract class EraserProperty implements Property, PathProperty {
  const factory EraserProperty(
      {final double strokeWidth,
      final double strokeMultiplier}) = _$EraserProperty;

  factory EraserProperty.fromJson(Map<String, dynamic> json) =
      _$EraserProperty.fromJson;

  double get strokeWidth;
  double get strokeMultiplier;
  @JsonKey(ignore: true)
  _$$EraserPropertyCopyWith<_$EraserProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PenPropertyCopyWith<$Res> {
  factory _$$PenPropertyCopyWith(
          _$PenProperty value, $Res Function(_$PenProperty) then) =
      __$$PenPropertyCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {double strokeWidth, double strokeMultiplier, int color, bool fill});
}

/// @nodoc
class __$$PenPropertyCopyWithImpl<$Res>
    extends _$PropertyCopyWithImpl<$Res, _$PenProperty>
    implements _$$PenPropertyCopyWith<$Res> {
  __$$PenPropertyCopyWithImpl(
      _$PenProperty _value, $Res Function(_$PenProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strokeWidth = null,
    Object? strokeMultiplier = null,
    Object? color = null,
    Object? fill = null,
  }) {
    return _then(_$PenProperty(
      strokeWidth: null == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      strokeMultiplier: null == strokeMultiplier
          ? _value.strokeMultiplier
          : strokeMultiplier // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      fill: null == fill
          ? _value.fill
          : fill // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PenProperty implements PenProperty {
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
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.strokeMultiplier, strokeMultiplier) ||
                other.strokeMultiplier == strokeMultiplier) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.fill, fill) || other.fill == fill));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, strokeWidth, strokeMultiplier, color, fill);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PenPropertyCopyWith<_$PenProperty> get copyWith =>
      __$$PenPropertyCopyWithImpl<_$PenProperty>(this, _$identity);

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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)
        label,
    required TResult Function(double strokeWidth, double strokeMultiplier)
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult? Function(double strokeWidth, double strokeMultiplier)? eraser,
    TResult? Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult? Function(double strokeWidth, PathShape shape, int color)? shape,
  }) {
    return pen?.call(strokeWidth, strokeMultiplier, color, fill);
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier)? eraser,
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
    TResult? Function(LabelProperty value)? label,
    TResult? Function(EraserProperty value)? eraser,
    TResult? Function(PenProperty value)? pen,
    TResult? Function(ShapeProperty value)? shape,
  }) {
    return pen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
    return _$$PenPropertyToJson(
      this,
    );
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

  double get strokeWidth;
  double get strokeMultiplier;
  int get color;
  bool get fill;
  @JsonKey(ignore: true)
  _$$PenPropertyCopyWith<_$PenProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShapePropertyCopyWith<$Res> {
  factory _$$ShapePropertyCopyWith(
          _$ShapeProperty value, $Res Function(_$ShapeProperty) then) =
      __$$ShapePropertyCopyWithImpl<$Res>;
  @useResult
  $Res call({double strokeWidth, PathShape shape, int color});

  $PathShapeCopyWith<$Res> get shape;
}

/// @nodoc
class __$$ShapePropertyCopyWithImpl<$Res>
    extends _$PropertyCopyWithImpl<$Res, _$ShapeProperty>
    implements _$$ShapePropertyCopyWith<$Res> {
  __$$ShapePropertyCopyWithImpl(
      _$ShapeProperty _value, $Res Function(_$ShapeProperty) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strokeWidth = null,
    Object? shape = null,
    Object? color = null,
  }) {
    return _then(_$ShapeProperty(
      strokeWidth: null == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      shape: null == shape
          ? _value.shape
          : shape // ignore: cast_nullable_to_non_nullable
              as PathShape,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
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
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.shape, shape) || other.shape == shape) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, strokeWidth, shape, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShapePropertyCopyWith<_$ShapeProperty> get copyWith =>
      __$$ShapePropertyCopyWithImpl<_$ShapeProperty>(this, _$identity);

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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)
        label,
    required TResult Function(double strokeWidth, double strokeMultiplier)
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult? Function(double strokeWidth, double strokeMultiplier)? eraser,
    TResult? Function(
            double strokeWidth, double strokeMultiplier, int color, bool fill)?
        pen,
    TResult? Function(double strokeWidth, PathShape shape, int color)? shape,
  }) {
    return shape?.call(strokeWidth, this.shape, color);
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
            double decorationThickness,
            HorizontalAlignment horizontalAlignment,
            VerticalAlignment verticalAlignment)?
        label,
    TResult Function(double strokeWidth, double strokeMultiplier)? eraser,
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
    TResult? Function(LabelProperty value)? label,
    TResult? Function(EraserProperty value)? eraser,
    TResult? Function(PenProperty value)? pen,
    TResult? Function(ShapeProperty value)? shape,
  }) {
    return shape?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
    return _$$ShapePropertyToJson(
      this,
    );
  }
}

abstract class ShapeProperty implements Property {
  const factory ShapeProperty(
      {final double strokeWidth,
      required final PathShape shape,
      final int color}) = _$ShapeProperty;

  factory ShapeProperty.fromJson(Map<String, dynamic> json) =
      _$ShapeProperty.fromJson;

  double get strokeWidth;
  PathShape get shape;
  int get color;
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
    TResult? Function(int fillColor)? circle,
    TResult? Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)?
        rectangle,
    TResult? Function()? line,
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
    TResult? Function(CircleShape value)? circle,
    TResult? Function(RectangleShape value)? rectangle,
    TResult? Function(LineShape value)? line,
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
      _$PathShapeCopyWithImpl<$Res, PathShape>;
}

/// @nodoc
class _$PathShapeCopyWithImpl<$Res, $Val extends PathShape>
    implements $PathShapeCopyWith<$Res> {
  _$PathShapeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CircleShapeCopyWith<$Res> {
  factory _$$CircleShapeCopyWith(
          _$CircleShape value, $Res Function(_$CircleShape) then) =
      __$$CircleShapeCopyWithImpl<$Res>;
  @useResult
  $Res call({int fillColor});
}

/// @nodoc
class __$$CircleShapeCopyWithImpl<$Res>
    extends _$PathShapeCopyWithImpl<$Res, _$CircleShape>
    implements _$$CircleShapeCopyWith<$Res> {
  __$$CircleShapeCopyWithImpl(
      _$CircleShape _value, $Res Function(_$CircleShape) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fillColor = null,
  }) {
    return _then(_$CircleShape(
      fillColor: null == fillColor
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
            (identical(other.fillColor, fillColor) ||
                other.fillColor == fillColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fillColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
    TResult? Function(int fillColor)? circle,
    TResult? Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)?
        rectangle,
    TResult? Function()? line,
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
    TResult? Function(CircleShape value)? circle,
    TResult? Function(RectangleShape value)? rectangle,
    TResult? Function(LineShape value)? line,
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
    return _$$CircleShapeToJson(
      this,
    );
  }
}

abstract class CircleShape extends PathShape {
  const factory CircleShape({final int fillColor}) = _$CircleShape;
  const CircleShape._() : super._();

  factory CircleShape.fromJson(Map<String, dynamic> json) =
      _$CircleShape.fromJson;

  int get fillColor;
  @JsonKey(ignore: true)
  _$$CircleShapeCopyWith<_$CircleShape> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RectangleShapeCopyWith<$Res> {
  factory _$$RectangleShapeCopyWith(
          _$RectangleShape value, $Res Function(_$RectangleShape) then) =
      __$$RectangleShapeCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int fillColor,
      double topLeftCornerRadius,
      double topRightCornerRadius,
      double bottomLeftCornerRadius,
      double bottomRightCornerRadius});
}

/// @nodoc
class __$$RectangleShapeCopyWithImpl<$Res>
    extends _$PathShapeCopyWithImpl<$Res, _$RectangleShape>
    implements _$$RectangleShapeCopyWith<$Res> {
  __$$RectangleShapeCopyWithImpl(
      _$RectangleShape _value, $Res Function(_$RectangleShape) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fillColor = null,
    Object? topLeftCornerRadius = null,
    Object? topRightCornerRadius = null,
    Object? bottomLeftCornerRadius = null,
    Object? bottomRightCornerRadius = null,
  }) {
    return _then(_$RectangleShape(
      fillColor: null == fillColor
          ? _value.fillColor
          : fillColor // ignore: cast_nullable_to_non_nullable
              as int,
      topLeftCornerRadius: null == topLeftCornerRadius
          ? _value.topLeftCornerRadius
          : topLeftCornerRadius // ignore: cast_nullable_to_non_nullable
              as double,
      topRightCornerRadius: null == topRightCornerRadius
          ? _value.topRightCornerRadius
          : topRightCornerRadius // ignore: cast_nullable_to_non_nullable
              as double,
      bottomLeftCornerRadius: null == bottomLeftCornerRadius
          ? _value.bottomLeftCornerRadius
          : bottomLeftCornerRadius // ignore: cast_nullable_to_non_nullable
              as double,
      bottomRightCornerRadius: null == bottomRightCornerRadius
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
            (identical(other.fillColor, fillColor) ||
                other.fillColor == fillColor) &&
            (identical(other.topLeftCornerRadius, topLeftCornerRadius) ||
                other.topLeftCornerRadius == topLeftCornerRadius) &&
            (identical(other.topRightCornerRadius, topRightCornerRadius) ||
                other.topRightCornerRadius == topRightCornerRadius) &&
            (identical(other.bottomLeftCornerRadius, bottomLeftCornerRadius) ||
                other.bottomLeftCornerRadius == bottomLeftCornerRadius) &&
            (identical(
                    other.bottomRightCornerRadius, bottomRightCornerRadius) ||
                other.bottomRightCornerRadius == bottomRightCornerRadius));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fillColor, topLeftCornerRadius,
      topRightCornerRadius, bottomLeftCornerRadius, bottomRightCornerRadius);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
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
    TResult? Function(int fillColor)? circle,
    TResult? Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)?
        rectangle,
    TResult? Function()? line,
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
    TResult? Function(CircleShape value)? circle,
    TResult? Function(RectangleShape value)? rectangle,
    TResult? Function(LineShape value)? line,
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
    return _$$RectangleShapeToJson(
      this,
    );
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

  int get fillColor;
  double get topLeftCornerRadius;
  double get topRightCornerRadius;
  double get bottomLeftCornerRadius;
  double get bottomRightCornerRadius;
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
class __$$LineShapeCopyWithImpl<$Res>
    extends _$PathShapeCopyWithImpl<$Res, _$LineShape>
    implements _$$LineShapeCopyWith<$Res> {
  __$$LineShapeCopyWithImpl(
      _$LineShape _value, $Res Function(_$LineShape) _then)
      : super(_value, _then);
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
    TResult? Function(int fillColor)? circle,
    TResult? Function(
            int fillColor,
            double topLeftCornerRadius,
            double topRightCornerRadius,
            double bottomLeftCornerRadius,
            double bottomRightCornerRadius)?
        rectangle,
    TResult? Function()? line,
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
    TResult? Function(CircleShape value)? circle,
    TResult? Function(RectangleShape value)? rectangle,
    TResult? Function(LineShape value)? line,
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
    return _$$LineShapeToJson(
      this,
    );
  }
}

abstract class LineShape extends PathShape {
  const factory LineShape() = _$LineShape;
  const LineShape._() : super._();

  factory LineShape.fromJson(Map<String, dynamic> json) = _$LineShape.fromJson;
}
