// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'property.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
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
  double get strokeWidth;
  @ColorJsonConverter()
  SRGBColor get color;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PropertyCopyWith<Property> get copyWith =>
      _$PropertyCopyWithImpl<Property>(this as Property, _$identity);

  /// Serializes this Property to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Property &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, strokeWidth, color);

  @override
  String toString() {
    return 'Property(strokeWidth: $strokeWidth, color: $color)';
  }
}

/// @nodoc
abstract mixin class $PropertyCopyWith<$Res> {
  factory $PropertyCopyWith(Property value, $Res Function(Property) _then) =
      _$PropertyCopyWithImpl;
  @useResult
  $Res call({double strokeWidth, @ColorJsonConverter() SRGBColor color});
}

/// @nodoc
class _$PropertyCopyWithImpl<$Res> implements $PropertyCopyWith<$Res> {
  _$PropertyCopyWithImpl(this._self, this._then);

  final Property _self;
  final $Res Function(Property) _then;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strokeWidth = null,
    Object? color = null,
  }) {
    return _then(_self.copyWith(
      strokeWidth: null == strokeWidth
          ? _self.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as SRGBColor,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class PenProperty implements Property, PathProperty {
  const PenProperty(
      {this.strokeWidth = 5,
      this.thinning = 0.4,
      @ColorJsonConverter() this.color = SRGBColor.black,
      @ColorJsonConverter() this.fill = SRGBColor.transparent,
      this.smoothing = 0.5,
      this.streamline = 0.3,
      final String? $type})
      : $type = $type ?? 'pen';
  factory PenProperty.fromJson(Map<String, dynamic> json) =>
      _$PenPropertyFromJson(json);

  @override
  @JsonKey()
  final double strokeWidth;
  @JsonKey()
  final double thinning;
  @override
  @JsonKey()
  @ColorJsonConverter()
  final SRGBColor color;
  @JsonKey()
  @ColorJsonConverter()
  final SRGBColor fill;
  @JsonKey()
  final double smoothing;
  @JsonKey()
  final double streamline;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PenPropertyCopyWith<PenProperty> get copyWith =>
      _$PenPropertyCopyWithImpl<PenProperty>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PenPropertyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PenProperty &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.thinning, thinning) ||
                other.thinning == thinning) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.fill, fill) || other.fill == fill) &&
            (identical(other.smoothing, smoothing) ||
                other.smoothing == smoothing) &&
            (identical(other.streamline, streamline) ||
                other.streamline == streamline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, strokeWidth, thinning, color, fill, smoothing, streamline);

  @override
  String toString() {
    return 'Property.pen(strokeWidth: $strokeWidth, thinning: $thinning, color: $color, fill: $fill, smoothing: $smoothing, streamline: $streamline)';
  }
}

/// @nodoc
abstract mixin class $PenPropertyCopyWith<$Res>
    implements $PropertyCopyWith<$Res> {
  factory $PenPropertyCopyWith(
          PenProperty value, $Res Function(PenProperty) _then) =
      _$PenPropertyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double strokeWidth,
      double thinning,
      @ColorJsonConverter() SRGBColor color,
      @ColorJsonConverter() SRGBColor fill,
      double smoothing,
      double streamline});
}

/// @nodoc
class _$PenPropertyCopyWithImpl<$Res> implements $PenPropertyCopyWith<$Res> {
  _$PenPropertyCopyWithImpl(this._self, this._then);

  final PenProperty _self;
  final $Res Function(PenProperty) _then;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? strokeWidth = null,
    Object? thinning = null,
    Object? color = null,
    Object? fill = null,
    Object? smoothing = null,
    Object? streamline = null,
  }) {
    return _then(PenProperty(
      strokeWidth: null == strokeWidth
          ? _self.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      thinning: null == thinning
          ? _self.thinning
          : thinning // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as SRGBColor,
      fill: null == fill
          ? _self.fill
          : fill // ignore: cast_nullable_to_non_nullable
              as SRGBColor,
      smoothing: null == smoothing
          ? _self.smoothing
          : smoothing // ignore: cast_nullable_to_non_nullable
              as double,
      streamline: null == streamline
          ? _self.streamline
          : streamline // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class ShapeProperty implements Property {
  const ShapeProperty(
      {this.strokeWidth = 5,
      required this.shape,
      @ColorJsonConverter() this.color = SRGBColor.black,
      final String? $type})
      : $type = $type ?? 'shape';
  factory ShapeProperty.fromJson(Map<String, dynamic> json) =>
      _$ShapePropertyFromJson(json);

  @override
  @JsonKey()
  final double strokeWidth;
  final PathShape shape;
  @override
  @JsonKey()
  @ColorJsonConverter()
  final SRGBColor color;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ShapePropertyCopyWith<ShapeProperty> get copyWith =>
      _$ShapePropertyCopyWithImpl<ShapeProperty>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ShapePropertyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ShapeProperty &&
            (identical(other.strokeWidth, strokeWidth) ||
                other.strokeWidth == strokeWidth) &&
            (identical(other.shape, shape) || other.shape == shape) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, strokeWidth, shape, color);

  @override
  String toString() {
    return 'Property.shape(strokeWidth: $strokeWidth, shape: $shape, color: $color)';
  }
}

/// @nodoc
abstract mixin class $ShapePropertyCopyWith<$Res>
    implements $PropertyCopyWith<$Res> {
  factory $ShapePropertyCopyWith(
          ShapeProperty value, $Res Function(ShapeProperty) _then) =
      _$ShapePropertyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {double strokeWidth,
      PathShape shape,
      @ColorJsonConverter() SRGBColor color});

  $PathShapeCopyWith<$Res> get shape;
}

/// @nodoc
class _$ShapePropertyCopyWithImpl<$Res>
    implements $ShapePropertyCopyWith<$Res> {
  _$ShapePropertyCopyWithImpl(this._self, this._then);

  final ShapeProperty _self;
  final $Res Function(ShapeProperty) _then;

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? strokeWidth = null,
    Object? shape = null,
    Object? color = null,
  }) {
    return _then(ShapeProperty(
      strokeWidth: null == strokeWidth
          ? _self.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      shape: null == shape
          ? _self.shape
          : shape // ignore: cast_nullable_to_non_nullable
              as PathShape,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as SRGBColor,
    ));
  }

  /// Create a copy of Property
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PathShapeCopyWith<$Res> get shape {
    return $PathShapeCopyWith<$Res>(_self.shape, (value) {
      return _then(_self.copyWith(shape: value));
    });
  }
}

PathShape _$PathShapeFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'circle':
      return CircleShape.fromJson(json);
    case 'rectangle':
      return RectangleShape.fromJson(json);
    case 'line':
      return LineShape.fromJson(json);
    case 'triangle':
      return TriangleShape.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'PathShape', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$PathShape {
  /// Serializes this PathShape to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PathShape);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PathShape()';
  }
}

/// @nodoc
class $PathShapeCopyWith<$Res> {
  $PathShapeCopyWith(PathShape _, $Res Function(PathShape) __);
}

/// @nodoc
@JsonSerializable()
class CircleShape extends PathShape {
  const CircleShape(
      {@ColorJsonConverter() this.fillColor = SRGBColor.transparent,
      final String? $type})
      : $type = $type ?? 'circle',
        super._();
  factory CircleShape.fromJson(Map<String, dynamic> json) =>
      _$CircleShapeFromJson(json);

  @JsonKey()
  @ColorJsonConverter()
  final SRGBColor fillColor;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of PathShape
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CircleShapeCopyWith<CircleShape> get copyWith =>
      _$CircleShapeCopyWithImpl<CircleShape>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CircleShapeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CircleShape &&
            (identical(other.fillColor, fillColor) ||
                other.fillColor == fillColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fillColor);

  @override
  String toString() {
    return 'PathShape.circle(fillColor: $fillColor)';
  }
}

/// @nodoc
abstract mixin class $CircleShapeCopyWith<$Res>
    implements $PathShapeCopyWith<$Res> {
  factory $CircleShapeCopyWith(
          CircleShape value, $Res Function(CircleShape) _then) =
      _$CircleShapeCopyWithImpl;
  @useResult
  $Res call({@ColorJsonConverter() SRGBColor fillColor});
}

/// @nodoc
class _$CircleShapeCopyWithImpl<$Res> implements $CircleShapeCopyWith<$Res> {
  _$CircleShapeCopyWithImpl(this._self, this._then);

  final CircleShape _self;
  final $Res Function(CircleShape) _then;

  /// Create a copy of PathShape
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fillColor = null,
  }) {
    return _then(CircleShape(
      fillColor: null == fillColor
          ? _self.fillColor
          : fillColor // ignore: cast_nullable_to_non_nullable
              as SRGBColor,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class RectangleShape extends PathShape {
  const RectangleShape(
      {@ColorJsonConverter() this.fillColor = SRGBColor.transparent,
      this.topLeftCornerRadius = 0,
      this.topRightCornerRadius = 0,
      this.bottomLeftCornerRadius = 0,
      this.bottomRightCornerRadius = 0,
      final String? $type})
      : $type = $type ?? 'rectangle',
        super._();
  factory RectangleShape.fromJson(Map<String, dynamic> json) =>
      _$RectangleShapeFromJson(json);

  @JsonKey()
  @ColorJsonConverter()
  final SRGBColor fillColor;
  @JsonKey()
  final double topLeftCornerRadius;
  @JsonKey()
  final double topRightCornerRadius;
  @JsonKey()
  final double bottomLeftCornerRadius;
  @JsonKey()
  final double bottomRightCornerRadius;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of PathShape
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RectangleShapeCopyWith<RectangleShape> get copyWith =>
      _$RectangleShapeCopyWithImpl<RectangleShape>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RectangleShapeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RectangleShape &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fillColor, topLeftCornerRadius,
      topRightCornerRadius, bottomLeftCornerRadius, bottomRightCornerRadius);

  @override
  String toString() {
    return 'PathShape.rectangle(fillColor: $fillColor, topLeftCornerRadius: $topLeftCornerRadius, topRightCornerRadius: $topRightCornerRadius, bottomLeftCornerRadius: $bottomLeftCornerRadius, bottomRightCornerRadius: $bottomRightCornerRadius)';
  }
}

/// @nodoc
abstract mixin class $RectangleShapeCopyWith<$Res>
    implements $PathShapeCopyWith<$Res> {
  factory $RectangleShapeCopyWith(
          RectangleShape value, $Res Function(RectangleShape) _then) =
      _$RectangleShapeCopyWithImpl;
  @useResult
  $Res call(
      {@ColorJsonConverter() SRGBColor fillColor,
      double topLeftCornerRadius,
      double topRightCornerRadius,
      double bottomLeftCornerRadius,
      double bottomRightCornerRadius});
}

/// @nodoc
class _$RectangleShapeCopyWithImpl<$Res>
    implements $RectangleShapeCopyWith<$Res> {
  _$RectangleShapeCopyWithImpl(this._self, this._then);

  final RectangleShape _self;
  final $Res Function(RectangleShape) _then;

  /// Create a copy of PathShape
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fillColor = null,
    Object? topLeftCornerRadius = null,
    Object? topRightCornerRadius = null,
    Object? bottomLeftCornerRadius = null,
    Object? bottomRightCornerRadius = null,
  }) {
    return _then(RectangleShape(
      fillColor: null == fillColor
          ? _self.fillColor
          : fillColor // ignore: cast_nullable_to_non_nullable
              as SRGBColor,
      topLeftCornerRadius: null == topLeftCornerRadius
          ? _self.topLeftCornerRadius
          : topLeftCornerRadius // ignore: cast_nullable_to_non_nullable
              as double,
      topRightCornerRadius: null == topRightCornerRadius
          ? _self.topRightCornerRadius
          : topRightCornerRadius // ignore: cast_nullable_to_non_nullable
              as double,
      bottomLeftCornerRadius: null == bottomLeftCornerRadius
          ? _self.bottomLeftCornerRadius
          : bottomLeftCornerRadius // ignore: cast_nullable_to_non_nullable
              as double,
      bottomRightCornerRadius: null == bottomRightCornerRadius
          ? _self.bottomRightCornerRadius
          : bottomRightCornerRadius // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class LineShape extends PathShape {
  const LineShape({final String? $type})
      : $type = $type ?? 'line',
        super._();
  factory LineShape.fromJson(Map<String, dynamic> json) =>
      _$LineShapeFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  Map<String, dynamic> toJson() {
    return _$LineShapeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LineShape);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'PathShape.line()';
  }
}

/// @nodoc
@JsonSerializable()
class TriangleShape extends PathShape {
  const TriangleShape(
      {@ColorJsonConverter() this.fillColor = SRGBColor.transparent,
      final String? $type})
      : $type = $type ?? 'triangle',
        super._();
  factory TriangleShape.fromJson(Map<String, dynamic> json) =>
      _$TriangleShapeFromJson(json);

  @JsonKey()
  @ColorJsonConverter()
  final SRGBColor fillColor;

  @JsonKey(name: 'type')
  final String $type;

  /// Create a copy of PathShape
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TriangleShapeCopyWith<TriangleShape> get copyWith =>
      _$TriangleShapeCopyWithImpl<TriangleShape>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TriangleShapeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TriangleShape &&
            (identical(other.fillColor, fillColor) ||
                other.fillColor == fillColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fillColor);

  @override
  String toString() {
    return 'PathShape.triangle(fillColor: $fillColor)';
  }
}

/// @nodoc
abstract mixin class $TriangleShapeCopyWith<$Res>
    implements $PathShapeCopyWith<$Res> {
  factory $TriangleShapeCopyWith(
          TriangleShape value, $Res Function(TriangleShape) _then) =
      _$TriangleShapeCopyWithImpl;
  @useResult
  $Res call({@ColorJsonConverter() SRGBColor fillColor});
}

/// @nodoc
class _$TriangleShapeCopyWithImpl<$Res>
    implements $TriangleShapeCopyWith<$Res> {
  _$TriangleShapeCopyWithImpl(this._self, this._then);

  final TriangleShape _self;
  final $Res Function(TriangleShape) _then;

  /// Create a copy of PathShape
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fillColor = null,
  }) {
    return _then(TriangleShape(
      fillColor: null == fillColor
          ? _self.fillColor
          : fillColor // ignore: cast_nullable_to_non_nullable
              as SRGBColor,
    ));
  }
}

// dart format on
