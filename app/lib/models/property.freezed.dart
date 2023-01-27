// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Property _$PropertyFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
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
  double get strokeWidth => throw _privateConstructorUsedError;
  int get color => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double strokeWidth, double strokeMultiplier,
            int color, bool fill, double smoothing, double streamline)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double strokeWidth, double strokeMultiplier, int color,
            bool fill, double smoothing, double streamline)?
        pen,
    TResult? Function(double strokeWidth, PathShape shape, int color)? shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double strokeWidth, double strokeMultiplier, int color,
            bool fill, double smoothing, double streamline)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenProperty value) pen,
    required TResult Function(ShapeProperty value) shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PenProperty value)? pen,
    TResult? Function(ShapeProperty value)? shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenProperty value)? pen,
    TResult Function(ShapeProperty value)? shape,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PropertyCopyWith<Property> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropertyCopyWith<$Res> {
  factory $PropertyCopyWith(Property value, $Res Function(Property) then) =
      _$PropertyCopyWithImpl<$Res, Property>;
  @useResult
  $Res call({double strokeWidth, int color});
}

/// @nodoc
class _$PropertyCopyWithImpl<$Res, $Val extends Property>
    implements $PropertyCopyWith<$Res> {
  _$PropertyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strokeWidth = null,
    Object? color = null,
  }) {
    return _then(_value.copyWith(
      strokeWidth: null == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PenPropertyCopyWith<$Res> implements $PropertyCopyWith<$Res> {
  factory _$$PenPropertyCopyWith(
          _$PenProperty value, $Res Function(_$PenProperty) then) =
      __$$PenPropertyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double strokeWidth,
      double strokeMultiplier,
      int color,
      bool fill,
      double smoothing,
      double streamline});
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
    Object? smoothing = null,
    Object? streamline = null,
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
      smoothing: null == smoothing
          ? _value.smoothing
          : smoothing // ignore: cast_nullable_to_non_nullable
              as double,
      streamline: null == streamline
          ? _value.streamline
          : streamline // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PenProperty implements PenProperty {
  const _$PenProperty(
      {this.strokeWidth = 5,
      this.strokeMultiplier = 0.5,
      this.color = kColorBlack,
      this.fill = false,
      this.smoothing = 0.5,
      this.streamline = 0.3,
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
  @override
  @JsonKey()
  final double smoothing;
  @override
  @JsonKey()
  final double streamline;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Property.pen(strokeWidth: $strokeWidth, strokeMultiplier: $strokeMultiplier, color: $color, fill: $fill, smoothing: $smoothing, streamline: $streamline)';
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
            (identical(other.fill, fill) || other.fill == fill) &&
            (identical(other.smoothing, smoothing) ||
                other.smoothing == smoothing) &&
            (identical(other.streamline, streamline) ||
                other.streamline == streamline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, strokeWidth, strokeMultiplier,
      color, fill, smoothing, streamline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PenPropertyCopyWith<_$PenProperty> get copyWith =>
      __$$PenPropertyCopyWithImpl<_$PenProperty>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double strokeWidth, double strokeMultiplier,
            int color, bool fill, double smoothing, double streamline)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) {
    return pen(
        strokeWidth, strokeMultiplier, color, fill, smoothing, streamline);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double strokeWidth, double strokeMultiplier, int color,
            bool fill, double smoothing, double streamline)?
        pen,
    TResult? Function(double strokeWidth, PathShape shape, int color)? shape,
  }) {
    return pen?.call(
        strokeWidth, strokeMultiplier, color, fill, smoothing, streamline);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double strokeWidth, double strokeMultiplier, int color,
            bool fill, double smoothing, double streamline)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(
          strokeWidth, strokeMultiplier, color, fill, smoothing, streamline);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenProperty value) pen,
    required TResult Function(ShapeProperty value) shape,
  }) {
    return pen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PenProperty value)? pen,
    TResult? Function(ShapeProperty value)? shape,
  }) {
    return pen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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
      final bool fill,
      final double smoothing,
      final double streamline}) = _$PenProperty;

  factory PenProperty.fromJson(Map<String, dynamic> json) =
      _$PenProperty.fromJson;

  @override
  double get strokeWidth;
  double get strokeMultiplier;
  @override
  int get color;
  bool get fill;
  double get smoothing;
  double get streamline;
  @override
  @JsonKey(ignore: true)
  _$$PenPropertyCopyWith<_$PenProperty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShapePropertyCopyWith<$Res>
    implements $PropertyCopyWith<$Res> {
  factory _$$ShapePropertyCopyWith(
          _$ShapeProperty value, $Res Function(_$ShapeProperty) then) =
      __$$ShapePropertyCopyWithImpl<$Res>;
  @override
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
    required TResult Function(double strokeWidth, double strokeMultiplier,
            int color, bool fill, double smoothing, double streamline)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) {
    return shape(strokeWidth, this.shape, color);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double strokeWidth, double strokeMultiplier, int color,
            bool fill, double smoothing, double streamline)?
        pen,
    TResult? Function(double strokeWidth, PathShape shape, int color)? shape,
  }) {
    return shape?.call(strokeWidth, this.shape, color);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double strokeWidth, double strokeMultiplier, int color,
            bool fill, double smoothing, double streamline)?
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
    required TResult Function(PenProperty value) pen,
    required TResult Function(ShapeProperty value) shape,
  }) {
    return shape(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PenProperty value)? pen,
    TResult? Function(ShapeProperty value)? shape,
  }) {
    return shape?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
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

  @override
  double get strokeWidth;
  PathShape get shape;
  @override
  int get color;
  @override
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
