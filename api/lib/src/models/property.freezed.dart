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
    required TResult Function(double strokeWidth, double thinning, int color,
            bool fill, double smoothing, double streamline)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double strokeWidth, double thinning, int color, bool fill,
            double smoothing, double streamline)?
        pen,
    TResult? Function(double strokeWidth, PathShape shape, int color)? shape,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double strokeWidth, double thinning, int color, bool fill,
            double smoothing, double streamline)?
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
abstract class _$$PenPropertyImplCopyWith<$Res>
    implements $PropertyCopyWith<$Res> {
  factory _$$PenPropertyImplCopyWith(
          _$PenPropertyImpl value, $Res Function(_$PenPropertyImpl) then) =
      __$$PenPropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double strokeWidth,
      double thinning,
      int color,
      bool fill,
      double smoothing,
      double streamline});
}

/// @nodoc
class __$$PenPropertyImplCopyWithImpl<$Res>
    extends _$PropertyCopyWithImpl<$Res, _$PenPropertyImpl>
    implements _$$PenPropertyImplCopyWith<$Res> {
  __$$PenPropertyImplCopyWithImpl(
      _$PenPropertyImpl _value, $Res Function(_$PenPropertyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strokeWidth = null,
    Object? thinning = null,
    Object? color = null,
    Object? fill = null,
    Object? smoothing = null,
    Object? streamline = null,
  }) {
    return _then(_$PenPropertyImpl(
      strokeWidth: null == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      thinning: null == thinning
          ? _value.thinning
          : thinning // ignore: cast_nullable_to_non_nullable
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
class _$PenPropertyImpl implements PenProperty {
  const _$PenPropertyImpl(
      {this.strokeWidth = 5,
      this.thinning = 0.4,
      this.color = BasicColors.black,
      this.fill = false,
      this.smoothing = 0.5,
      this.streamline = 0.3,
      final String? $type})
      : $type = $type ?? 'pen';

  factory _$PenPropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PenPropertyImplFromJson(json);

  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final double thinning;
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
    return 'Property.pen(strokeWidth: $strokeWidth, thinning: $thinning, color: $color, fill: $fill, smoothing: $smoothing, streamline: $streamline)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PenPropertyImpl &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, strokeWidth, thinning, color, fill, smoothing, streamline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PenPropertyImplCopyWith<_$PenPropertyImpl> get copyWith =>
      __$$PenPropertyImplCopyWithImpl<_$PenPropertyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double strokeWidth, double thinning, int color,
            bool fill, double smoothing, double streamline)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) {
    return pen(strokeWidth, thinning, color, fill, smoothing, streamline);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double strokeWidth, double thinning, int color, bool fill,
            double smoothing, double streamline)?
        pen,
    TResult? Function(double strokeWidth, PathShape shape, int color)? shape,
  }) {
    return pen?.call(strokeWidth, thinning, color, fill, smoothing, streamline);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double strokeWidth, double thinning, int color, bool fill,
            double smoothing, double streamline)?
        pen,
    TResult Function(double strokeWidth, PathShape shape, int color)? shape,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(strokeWidth, thinning, color, fill, smoothing, streamline);
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
    return _$$PenPropertyImplToJson(
      this,
    );
  }
}

abstract class PenProperty implements Property, PathProperty {
  const factory PenProperty(
      {final double strokeWidth,
      final double thinning,
      final int color,
      final bool fill,
      final double smoothing,
      final double streamline}) = _$PenPropertyImpl;

  factory PenProperty.fromJson(Map<String, dynamic> json) =
      _$PenPropertyImpl.fromJson;

  @override
  double get strokeWidth;
  double get thinning;
  @override
  int get color;
  bool get fill;
  double get smoothing;
  double get streamline;
  @override
  @JsonKey(ignore: true)
  _$$PenPropertyImplCopyWith<_$PenPropertyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShapePropertyImplCopyWith<$Res>
    implements $PropertyCopyWith<$Res> {
  factory _$$ShapePropertyImplCopyWith(
          _$ShapePropertyImpl value, $Res Function(_$ShapePropertyImpl) then) =
      __$$ShapePropertyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double strokeWidth, PathShape shape, int color});

  $PathShapeCopyWith<$Res> get shape;
}

/// @nodoc
class __$$ShapePropertyImplCopyWithImpl<$Res>
    extends _$PropertyCopyWithImpl<$Res, _$ShapePropertyImpl>
    implements _$$ShapePropertyImplCopyWith<$Res> {
  __$$ShapePropertyImplCopyWithImpl(
      _$ShapePropertyImpl _value, $Res Function(_$ShapePropertyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strokeWidth = null,
    Object? shape = null,
    Object? color = null,
  }) {
    return _then(_$ShapePropertyImpl(
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
class _$ShapePropertyImpl implements ShapeProperty {
  const _$ShapePropertyImpl(
      {this.strokeWidth = 5,
      required this.shape,
      this.color = BasicColors.black,
      final String? $type})
      : $type = $type ?? 'shape';

  factory _$ShapePropertyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShapePropertyImplFromJson(json);

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
            other is _$ShapePropertyImpl &&
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
  _$$ShapePropertyImplCopyWith<_$ShapePropertyImpl> get copyWith =>
      __$$ShapePropertyImplCopyWithImpl<_$ShapePropertyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double strokeWidth, double thinning, int color,
            bool fill, double smoothing, double streamline)
        pen,
    required TResult Function(double strokeWidth, PathShape shape, int color)
        shape,
  }) {
    return shape(strokeWidth, this.shape, color);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double strokeWidth, double thinning, int color, bool fill,
            double smoothing, double streamline)?
        pen,
    TResult? Function(double strokeWidth, PathShape shape, int color)? shape,
  }) {
    return shape?.call(strokeWidth, this.shape, color);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double strokeWidth, double thinning, int color, bool fill,
            double smoothing, double streamline)?
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
    return _$$ShapePropertyImplToJson(
      this,
    );
  }
}

abstract class ShapeProperty implements Property {
  const factory ShapeProperty(
      {final double strokeWidth,
      required final PathShape shape,
      final int color}) = _$ShapePropertyImpl;

  factory ShapeProperty.fromJson(Map<String, dynamic> json) =
      _$ShapePropertyImpl.fromJson;

  @override
  double get strokeWidth;
  PathShape get shape;
  @override
  int get color;
  @override
  @JsonKey(ignore: true)
  _$$ShapePropertyImplCopyWith<_$ShapePropertyImpl> get copyWith =>
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
abstract class _$$CircleShapeImplCopyWith<$Res> {
  factory _$$CircleShapeImplCopyWith(
          _$CircleShapeImpl value, $Res Function(_$CircleShapeImpl) then) =
      __$$CircleShapeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int fillColor});
}

/// @nodoc
class __$$CircleShapeImplCopyWithImpl<$Res>
    extends _$PathShapeCopyWithImpl<$Res, _$CircleShapeImpl>
    implements _$$CircleShapeImplCopyWith<$Res> {
  __$$CircleShapeImplCopyWithImpl(
      _$CircleShapeImpl _value, $Res Function(_$CircleShapeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fillColor = null,
  }) {
    return _then(_$CircleShapeImpl(
      fillColor: null == fillColor
          ? _value.fillColor
          : fillColor // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CircleShapeImpl extends CircleShape {
  const _$CircleShapeImpl(
      {this.fillColor = BasicColors.transparent, final String? $type})
      : $type = $type ?? 'circle',
        super._();

  factory _$CircleShapeImpl.fromJson(Map<String, dynamic> json) =>
      _$$CircleShapeImplFromJson(json);

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
            other is _$CircleShapeImpl &&
            (identical(other.fillColor, fillColor) ||
                other.fillColor == fillColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fillColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CircleShapeImplCopyWith<_$CircleShapeImpl> get copyWith =>
      __$$CircleShapeImplCopyWithImpl<_$CircleShapeImpl>(this, _$identity);

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
    return _$$CircleShapeImplToJson(
      this,
    );
  }
}

abstract class CircleShape extends PathShape {
  const factory CircleShape({final int fillColor}) = _$CircleShapeImpl;
  const CircleShape._() : super._();

  factory CircleShape.fromJson(Map<String, dynamic> json) =
      _$CircleShapeImpl.fromJson;

  int get fillColor;
  @JsonKey(ignore: true)
  _$$CircleShapeImplCopyWith<_$CircleShapeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RectangleShapeImplCopyWith<$Res> {
  factory _$$RectangleShapeImplCopyWith(_$RectangleShapeImpl value,
          $Res Function(_$RectangleShapeImpl) then) =
      __$$RectangleShapeImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {int fillColor,
      double topLeftCornerRadius,
      double topRightCornerRadius,
      double bottomLeftCornerRadius,
      double bottomRightCornerRadius});
}

/// @nodoc
class __$$RectangleShapeImplCopyWithImpl<$Res>
    extends _$PathShapeCopyWithImpl<$Res, _$RectangleShapeImpl>
    implements _$$RectangleShapeImplCopyWith<$Res> {
  __$$RectangleShapeImplCopyWithImpl(
      _$RectangleShapeImpl _value, $Res Function(_$RectangleShapeImpl) _then)
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
    return _then(_$RectangleShapeImpl(
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
class _$RectangleShapeImpl extends RectangleShape {
  const _$RectangleShapeImpl(
      {this.fillColor = BasicColors.transparent,
      this.topLeftCornerRadius = 0,
      this.topRightCornerRadius = 0,
      this.bottomLeftCornerRadius = 0,
      this.bottomRightCornerRadius = 0,
      final String? $type})
      : $type = $type ?? 'rectangle',
        super._();

  factory _$RectangleShapeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RectangleShapeImplFromJson(json);

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
            other is _$RectangleShapeImpl &&
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
  _$$RectangleShapeImplCopyWith<_$RectangleShapeImpl> get copyWith =>
      __$$RectangleShapeImplCopyWithImpl<_$RectangleShapeImpl>(
          this, _$identity);

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
    return _$$RectangleShapeImplToJson(
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
      final double bottomRightCornerRadius}) = _$RectangleShapeImpl;
  const RectangleShape._() : super._();

  factory RectangleShape.fromJson(Map<String, dynamic> json) =
      _$RectangleShapeImpl.fromJson;

  int get fillColor;
  double get topLeftCornerRadius;
  double get topRightCornerRadius;
  double get bottomLeftCornerRadius;
  double get bottomRightCornerRadius;
  @JsonKey(ignore: true)
  _$$RectangleShapeImplCopyWith<_$RectangleShapeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LineShapeImplCopyWith<$Res> {
  factory _$$LineShapeImplCopyWith(
          _$LineShapeImpl value, $Res Function(_$LineShapeImpl) then) =
      __$$LineShapeImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LineShapeImplCopyWithImpl<$Res>
    extends _$PathShapeCopyWithImpl<$Res, _$LineShapeImpl>
    implements _$$LineShapeImplCopyWith<$Res> {
  __$$LineShapeImplCopyWithImpl(
      _$LineShapeImpl _value, $Res Function(_$LineShapeImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$LineShapeImpl extends LineShape {
  const _$LineShapeImpl({final String? $type})
      : $type = $type ?? 'line',
        super._();

  factory _$LineShapeImpl.fromJson(Map<String, dynamic> json) =>
      _$$LineShapeImplFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PathShape.line()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LineShapeImpl);
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
    return _$$LineShapeImplToJson(
      this,
    );
  }
}

abstract class LineShape extends PathShape {
  const factory LineShape() = _$LineShapeImpl;
  const LineShape._() : super._();

  factory LineShape.fromJson(Map<String, dynamic> json) =
      _$LineShapeImpl.fromJson;
}
