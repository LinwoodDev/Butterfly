// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'element.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PadConstraints _$PadConstraintsFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'scaled':
      return ScaledPadConstraints.fromJson(json);
    case 'fixed':
      return FixedPadConstraints.fromJson(json);
    case 'dynamic':
      return DynamicPadConstraints.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'PadConstraints',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
class _$PadConstraintsTearOff {
  const _$PadConstraintsTearOff();

  ScaledPadConstraints scaled(double scale) {
    return ScaledPadConstraints(
      scale,
    );
  }

  FixedPadConstraints fixed(double height, double width) {
    return FixedPadConstraints(
      height,
      width,
    );
  }

  DynamicPadConstraints dynamic(
      {double height = 0,
      double width = 0,
      double aspectRatio = null,
      bool includeArea = true}) {
    return DynamicPadConstraints(
      height: height,
      width: width,
      aspectRatio: aspectRatio,
      includeArea: includeArea,
    );
  }

  PadConstraints fromJson(Map<String, Object?> json) {
    return PadConstraints.fromJson(json);
  }
}

/// @nodoc
const $PadConstraints = _$PadConstraintsTearOff();

/// @nodoc
mixin _$PadConstraints {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double scale) scaled,
    required TResult Function(double height, double width) fixed,
    required TResult Function(
            double height, double width, double aspectRatio, bool includeArea)
        dynamic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(double scale)? scaled,
    TResult Function(double height, double width)? fixed,
    TResult Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double scale)? scaled,
    TResult Function(double height, double width)? fixed,
    TResult Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScaledPadConstraints value) scaled,
    required TResult Function(FixedPadConstraints value) fixed,
    required TResult Function(DynamicPadConstraints value) dynamic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScaledPadConstraints value)? scaled,
    TResult Function(FixedPadConstraints value)? fixed,
    TResult Function(DynamicPadConstraints value)? dynamic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScaledPadConstraints value)? scaled,
    TResult Function(FixedPadConstraints value)? fixed,
    TResult Function(DynamicPadConstraints value)? dynamic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PadConstraintsCopyWith<$Res> {
  factory $PadConstraintsCopyWith(
          PadConstraints value, $Res Function(PadConstraints) then) =
      _$PadConstraintsCopyWithImpl<$Res>;
}

/// @nodoc
class _$PadConstraintsCopyWithImpl<$Res>
    implements $PadConstraintsCopyWith<$Res> {
  _$PadConstraintsCopyWithImpl(this._value, this._then);

  final PadConstraints _value;
  // ignore: unused_field
  final $Res Function(PadConstraints) _then;
}

/// @nodoc
abstract class $ScaledPadConstraintsCopyWith<$Res> {
  factory $ScaledPadConstraintsCopyWith(ScaledPadConstraints value,
          $Res Function(ScaledPadConstraints) then) =
      _$ScaledPadConstraintsCopyWithImpl<$Res>;
  $Res call({double scale});
}

/// @nodoc
class _$ScaledPadConstraintsCopyWithImpl<$Res>
    extends _$PadConstraintsCopyWithImpl<$Res>
    implements $ScaledPadConstraintsCopyWith<$Res> {
  _$ScaledPadConstraintsCopyWithImpl(
      ScaledPadConstraints _value, $Res Function(ScaledPadConstraints) _then)
      : super(_value, (v) => _then(v as ScaledPadConstraints));

  @override
  ScaledPadConstraints get _value => super._value as ScaledPadConstraints;

  @override
  $Res call({
    Object? scale = freezed,
  }) {
    return _then(ScaledPadConstraints(
      scale == freezed
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScaledPadConstraints implements ScaledPadConstraints {
  const _$ScaledPadConstraints(this.scale, {String? $type})
      : $type = $type ?? 'scaled';

  factory _$ScaledPadConstraints.fromJson(Map<String, dynamic> json) =>
      _$$ScaledPadConstraintsFromJson(json);

  @override
  final double scale;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadConstraints.scaled(scale: $scale)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ScaledPadConstraints &&
            const DeepCollectionEquality().equals(other.scale, scale));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(scale));

  @JsonKey(ignore: true)
  @override
  $ScaledPadConstraintsCopyWith<ScaledPadConstraints> get copyWith =>
      _$ScaledPadConstraintsCopyWithImpl<ScaledPadConstraints>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double scale) scaled,
    required TResult Function(double height, double width) fixed,
    required TResult Function(
            double height, double width, double aspectRatio, bool includeArea)
        dynamic,
  }) {
    return scaled(scale);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(double scale)? scaled,
    TResult Function(double height, double width)? fixed,
    TResult Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
  }) {
    return scaled?.call(scale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double scale)? scaled,
    TResult Function(double height, double width)? fixed,
    TResult Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
    required TResult orElse(),
  }) {
    if (scaled != null) {
      return scaled(scale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScaledPadConstraints value) scaled,
    required TResult Function(FixedPadConstraints value) fixed,
    required TResult Function(DynamicPadConstraints value) dynamic,
  }) {
    return scaled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScaledPadConstraints value)? scaled,
    TResult Function(FixedPadConstraints value)? fixed,
    TResult Function(DynamicPadConstraints value)? dynamic,
  }) {
    return scaled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScaledPadConstraints value)? scaled,
    TResult Function(FixedPadConstraints value)? fixed,
    TResult Function(DynamicPadConstraints value)? dynamic,
    required TResult orElse(),
  }) {
    if (scaled != null) {
      return scaled(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ScaledPadConstraintsToJson(this);
  }
}

abstract class ScaledPadConstraints implements PadConstraints {
  const factory ScaledPadConstraints(double scale) = _$ScaledPadConstraints;

  factory ScaledPadConstraints.fromJson(Map<String, dynamic> json) =
      _$ScaledPadConstraints.fromJson;

  double get scale;
  @JsonKey(ignore: true)
  $ScaledPadConstraintsCopyWith<ScaledPadConstraints> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FixedPadConstraintsCopyWith<$Res> {
  factory $FixedPadConstraintsCopyWith(
          FixedPadConstraints value, $Res Function(FixedPadConstraints) then) =
      _$FixedPadConstraintsCopyWithImpl<$Res>;
  $Res call({double height, double width});
}

/// @nodoc
class _$FixedPadConstraintsCopyWithImpl<$Res>
    extends _$PadConstraintsCopyWithImpl<$Res>
    implements $FixedPadConstraintsCopyWith<$Res> {
  _$FixedPadConstraintsCopyWithImpl(
      FixedPadConstraints _value, $Res Function(FixedPadConstraints) _then)
      : super(_value, (v) => _then(v as FixedPadConstraints));

  @override
  FixedPadConstraints get _value => super._value as FixedPadConstraints;

  @override
  $Res call({
    Object? height = freezed,
    Object? width = freezed,
  }) {
    return _then(FixedPadConstraints(
      height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FixedPadConstraints implements FixedPadConstraints {
  const _$FixedPadConstraints(this.height, this.width, {String? $type})
      : $type = $type ?? 'fixed';

  factory _$FixedPadConstraints.fromJson(Map<String, dynamic> json) =>
      _$$FixedPadConstraintsFromJson(json);

  @override
  final double height;
  @override
  final double width;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadConstraints.fixed(height: $height, width: $width)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FixedPadConstraints &&
            const DeepCollectionEquality().equals(other.height, height) &&
            const DeepCollectionEquality().equals(other.width, width));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(height),
      const DeepCollectionEquality().hash(width));

  @JsonKey(ignore: true)
  @override
  $FixedPadConstraintsCopyWith<FixedPadConstraints> get copyWith =>
      _$FixedPadConstraintsCopyWithImpl<FixedPadConstraints>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double scale) scaled,
    required TResult Function(double height, double width) fixed,
    required TResult Function(
            double height, double width, double aspectRatio, bool includeArea)
        dynamic,
  }) {
    return fixed(height, width);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(double scale)? scaled,
    TResult Function(double height, double width)? fixed,
    TResult Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
  }) {
    return fixed?.call(height, width);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double scale)? scaled,
    TResult Function(double height, double width)? fixed,
    TResult Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
    required TResult orElse(),
  }) {
    if (fixed != null) {
      return fixed(height, width);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScaledPadConstraints value) scaled,
    required TResult Function(FixedPadConstraints value) fixed,
    required TResult Function(DynamicPadConstraints value) dynamic,
  }) {
    return fixed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScaledPadConstraints value)? scaled,
    TResult Function(FixedPadConstraints value)? fixed,
    TResult Function(DynamicPadConstraints value)? dynamic,
  }) {
    return fixed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScaledPadConstraints value)? scaled,
    TResult Function(FixedPadConstraints value)? fixed,
    TResult Function(DynamicPadConstraints value)? dynamic,
    required TResult orElse(),
  }) {
    if (fixed != null) {
      return fixed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FixedPadConstraintsToJson(this);
  }
}

abstract class FixedPadConstraints implements PadConstraints {
  const factory FixedPadConstraints(double height, double width) =
      _$FixedPadConstraints;

  factory FixedPadConstraints.fromJson(Map<String, dynamic> json) =
      _$FixedPadConstraints.fromJson;

  double get height;
  double get width;
  @JsonKey(ignore: true)
  $FixedPadConstraintsCopyWith<FixedPadConstraints> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DynamicPadConstraintsCopyWith<$Res> {
  factory $DynamicPadConstraintsCopyWith(DynamicPadConstraints value,
          $Res Function(DynamicPadConstraints) then) =
      _$DynamicPadConstraintsCopyWithImpl<$Res>;
  $Res call(
      {double height, double width, double aspectRatio, bool includeArea});
}

/// @nodoc
class _$DynamicPadConstraintsCopyWithImpl<$Res>
    extends _$PadConstraintsCopyWithImpl<$Res>
    implements $DynamicPadConstraintsCopyWith<$Res> {
  _$DynamicPadConstraintsCopyWithImpl(
      DynamicPadConstraints _value, $Res Function(DynamicPadConstraints) _then)
      : super(_value, (v) => _then(v as DynamicPadConstraints));

  @override
  DynamicPadConstraints get _value => super._value as DynamicPadConstraints;

  @override
  $Res call({
    Object? height = freezed,
    Object? width = freezed,
    Object? aspectRatio = freezed,
    Object? includeArea = freezed,
  }) {
    return _then(DynamicPadConstraints(
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as double,
      aspectRatio: aspectRatio == freezed
          ? _value.aspectRatio
          : aspectRatio // ignore: cast_nullable_to_non_nullable
              as double,
      includeArea: includeArea == freezed
          ? _value.includeArea
          : includeArea // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DynamicPadConstraints implements DynamicPadConstraints {
  const _$DynamicPadConstraints(
      {this.height = 0,
      this.width = 0,
      this.aspectRatio = null,
      this.includeArea = true,
      String? $type})
      : $type = $type ?? 'dynamic';

  factory _$DynamicPadConstraints.fromJson(Map<String, dynamic> json) =>
      _$$DynamicPadConstraintsFromJson(json);

  @JsonKey()
  @override
  final double height;
  @JsonKey()
  @override
  final double width;
  @JsonKey()
  @override
  final double aspectRatio;
  @JsonKey()
  @override
  final bool includeArea;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadConstraints.dynamic(height: $height, width: $width, aspectRatio: $aspectRatio, includeArea: $includeArea)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DynamicPadConstraints &&
            const DeepCollectionEquality().equals(other.height, height) &&
            const DeepCollectionEquality().equals(other.width, width) &&
            const DeepCollectionEquality()
                .equals(other.aspectRatio, aspectRatio) &&
            const DeepCollectionEquality()
                .equals(other.includeArea, includeArea));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(height),
      const DeepCollectionEquality().hash(width),
      const DeepCollectionEquality().hash(aspectRatio),
      const DeepCollectionEquality().hash(includeArea));

  @JsonKey(ignore: true)
  @override
  $DynamicPadConstraintsCopyWith<DynamicPadConstraints> get copyWith =>
      _$DynamicPadConstraintsCopyWithImpl<DynamicPadConstraints>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double scale) scaled,
    required TResult Function(double height, double width) fixed,
    required TResult Function(
            double height, double width, double aspectRatio, bool includeArea)
        dynamic,
  }) {
    return dynamic(height, width, aspectRatio, includeArea);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(double scale)? scaled,
    TResult Function(double height, double width)? fixed,
    TResult Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
  }) {
    return dynamic?.call(height, width, aspectRatio, includeArea);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double scale)? scaled,
    TResult Function(double height, double width)? fixed,
    TResult Function(
            double height, double width, double aspectRatio, bool includeArea)?
        dynamic,
    required TResult orElse(),
  }) {
    if (dynamic != null) {
      return dynamic(height, width, aspectRatio, includeArea);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScaledPadConstraints value) scaled,
    required TResult Function(FixedPadConstraints value) fixed,
    required TResult Function(DynamicPadConstraints value) dynamic,
  }) {
    return dynamic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ScaledPadConstraints value)? scaled,
    TResult Function(FixedPadConstraints value)? fixed,
    TResult Function(DynamicPadConstraints value)? dynamic,
  }) {
    return dynamic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScaledPadConstraints value)? scaled,
    TResult Function(FixedPadConstraints value)? fixed,
    TResult Function(DynamicPadConstraints value)? dynamic,
    required TResult orElse(),
  }) {
    if (dynamic != null) {
      return dynamic(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DynamicPadConstraintsToJson(this);
  }
}

abstract class DynamicPadConstraints implements PadConstraints {
  const factory DynamicPadConstraints(
      {double height,
      double width,
      double aspectRatio,
      bool includeArea}) = _$DynamicPadConstraints;

  factory DynamicPadConstraints.fromJson(Map<String, dynamic> json) =
      _$DynamicPadConstraints.fromJson;

  double get height;
  double get width;
  double get aspectRatio;
  bool get includeArea;
  @JsonKey(ignore: true)
  $DynamicPadConstraintsCopyWith<DynamicPadConstraints> get copyWith =>
      throw _privateConstructorUsedError;
}

PadElement _$PadElementFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'pen':
      return PenElement.fromJson(json);
    case 'eraser':
      return EraserElement.fromJson(json);
    case 'label':
      return LabelElement.fromJson(json);
    case 'image':
      return ImageElement.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'PadElement', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
class _$PadElementTearOff {
  const _$PadElementTearOff();

  PenElement pen(
      {String layer = '',
      List<PathPoint> points = const [],
      PenProperty property = const PenProperty()}) {
    return PenElement(
      layer: layer,
      points: points,
      property: property,
    );
  }

  EraserElement eraser(
      {String layer = '',
      List<PathPoint> points = const [],
      EraserProperty property = const EraserProperty()}) {
    return EraserElement(
      layer: layer,
      points: points,
      property: property,
    );
  }

  LabelElement label(
      {String layer = '',
      @OffsetJsonConverter() Offset position = Offset.zero,
      String text = '',
      LabelProperty property = const LabelProperty()}) {
    return LabelElement(
      layer: layer,
      position: position,
      text: text,
      property: property,
    );
  }

  ImageElement image(
      {String layer = '',
      @OffsetJsonConverter() Offset position = Offset.zero,
      PadConstraints? constraints = const ScaledPadConstraints(1),
      @Uint8ListJsonConverter() required Uint8List pixels,
      required int width,
      required int height}) {
    return ImageElement(
      layer: layer,
      position: position,
      constraints: constraints,
      pixels: pixels,
      width: width,
      height: height,
    );
  }

  PadElement fromJson(Map<String, Object?> json) {
    return PadElement.fromJson(json);
  }
}

/// @nodoc
const $PadElement = _$PadElementTearOff();

/// @nodoc
mixin _$PadElement {
  String get layer => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String layer, List<PathPoint> points, PenProperty property)
        pen,
    required TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)
        eraser,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            String text,
            LabelProperty property)
        label,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)
        image,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String layer, List<PathPoint> points, PenProperty property)?
        pen,
    TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)?
        eraser,
    TResult Function(String layer, @OffsetJsonConverter() Offset position,
            String text, LabelProperty property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)?
        image,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String layer, List<PathPoint> points, PenProperty property)?
        pen,
    TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)?
        eraser,
    TResult Function(String layer, @OffsetJsonConverter() Offset position,
            String text, LabelProperty property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)?
        image,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenElement value) pen,
    required TResult Function(EraserElement value) eraser,
    required TResult Function(LabelElement value) label,
    required TResult Function(ImageElement value) image,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(EraserElement value)? eraser,
    TResult Function(LabelElement value)? label,
    TResult Function(ImageElement value)? image,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(EraserElement value)? eraser,
    TResult Function(LabelElement value)? label,
    TResult Function(ImageElement value)? image,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PadElementCopyWith<PadElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PadElementCopyWith<$Res> {
  factory $PadElementCopyWith(
          PadElement value, $Res Function(PadElement) then) =
      _$PadElementCopyWithImpl<$Res>;
  $Res call({String layer});
}

/// @nodoc
class _$PadElementCopyWithImpl<$Res> implements $PadElementCopyWith<$Res> {
  _$PadElementCopyWithImpl(this._value, this._then);

  final PadElement _value;
  // ignore: unused_field
  final $Res Function(PadElement) _then;

  @override
  $Res call({
    Object? layer = freezed,
  }) {
    return _then(_value.copyWith(
      layer: layer == freezed
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $PenElementCopyWith<$Res> implements $PadElementCopyWith<$Res> {
  factory $PenElementCopyWith(
          PenElement value, $Res Function(PenElement) then) =
      _$PenElementCopyWithImpl<$Res>;
  @override
  $Res call({String layer, List<PathPoint> points, PenProperty property});
}

/// @nodoc
class _$PenElementCopyWithImpl<$Res> extends _$PadElementCopyWithImpl<$Res>
    implements $PenElementCopyWith<$Res> {
  _$PenElementCopyWithImpl(PenElement _value, $Res Function(PenElement) _then)
      : super(_value, (v) => _then(v as PenElement));

  @override
  PenElement get _value => super._value as PenElement;

  @override
  $Res call({
    Object? layer = freezed,
    Object? points = freezed,
    Object? property = freezed,
  }) {
    return _then(PenElement(
      layer: layer == freezed
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as List<PathPoint>,
      property: property == freezed
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as PenProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@Implements<PathElement>()
class _$PenElement implements PenElement {
  const _$PenElement(
      {this.layer = '',
      this.points = const [],
      this.property = const PenProperty(),
      String? $type})
      : $type = $type ?? 'pen';

  factory _$PenElement.fromJson(Map<String, dynamic> json) =>
      _$$PenElementFromJson(json);

  @JsonKey()
  @override
  final String layer;
  @JsonKey()
  @override
  final List<PathPoint> points;
  @JsonKey()
  @override
  final PenProperty property;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.pen(layer: $layer, points: $points, property: $property)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PenElement &&
            const DeepCollectionEquality().equals(other.layer, layer) &&
            const DeepCollectionEquality().equals(other.points, points) &&
            const DeepCollectionEquality().equals(other.property, property));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(layer),
      const DeepCollectionEquality().hash(points),
      const DeepCollectionEquality().hash(property));

  @JsonKey(ignore: true)
  @override
  $PenElementCopyWith<PenElement> get copyWith =>
      _$PenElementCopyWithImpl<PenElement>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String layer, List<PathPoint> points, PenProperty property)
        pen,
    required TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)
        eraser,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            String text,
            LabelProperty property)
        label,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)
        image,
  }) {
    return pen(layer, points, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String layer, List<PathPoint> points, PenProperty property)?
        pen,
    TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)?
        eraser,
    TResult Function(String layer, @OffsetJsonConverter() Offset position,
            String text, LabelProperty property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)?
        image,
  }) {
    return pen?.call(layer, points, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String layer, List<PathPoint> points, PenProperty property)?
        pen,
    TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)?
        eraser,
    TResult Function(String layer, @OffsetJsonConverter() Offset position,
            String text, LabelProperty property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)?
        image,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(layer, points, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenElement value) pen,
    required TResult Function(EraserElement value) eraser,
    required TResult Function(LabelElement value) label,
    required TResult Function(ImageElement value) image,
  }) {
    return pen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(EraserElement value)? eraser,
    TResult Function(LabelElement value)? label,
    TResult Function(ImageElement value)? image,
  }) {
    return pen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(EraserElement value)? eraser,
    TResult Function(LabelElement value)? label,
    TResult Function(ImageElement value)? image,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PenElementToJson(this);
  }
}

abstract class PenElement implements PadElement, PathElement {
  const factory PenElement(
      {String layer,
      List<PathPoint> points,
      PenProperty property}) = _$PenElement;

  factory PenElement.fromJson(Map<String, dynamic> json) =
      _$PenElement.fromJson;

  @override
  String get layer;
  List<PathPoint> get points;
  PenProperty get property;
  @override
  @JsonKey(ignore: true)
  $PenElementCopyWith<PenElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EraserElementCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory $EraserElementCopyWith(
          EraserElement value, $Res Function(EraserElement) then) =
      _$EraserElementCopyWithImpl<$Res>;
  @override
  $Res call({String layer, List<PathPoint> points, EraserProperty property});
}

/// @nodoc
class _$EraserElementCopyWithImpl<$Res> extends _$PadElementCopyWithImpl<$Res>
    implements $EraserElementCopyWith<$Res> {
  _$EraserElementCopyWithImpl(
      EraserElement _value, $Res Function(EraserElement) _then)
      : super(_value, (v) => _then(v as EraserElement));

  @override
  EraserElement get _value => super._value as EraserElement;

  @override
  $Res call({
    Object? layer = freezed,
    Object? points = freezed,
    Object? property = freezed,
  }) {
    return _then(EraserElement(
      layer: layer == freezed
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      points: points == freezed
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as List<PathPoint>,
      property: property == freezed
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as EraserProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@Implements<PathElement>()
class _$EraserElement implements EraserElement {
  const _$EraserElement(
      {this.layer = '',
      this.points = const [],
      this.property = const EraserProperty(),
      String? $type})
      : $type = $type ?? 'eraser';

  factory _$EraserElement.fromJson(Map<String, dynamic> json) =>
      _$$EraserElementFromJson(json);

  @JsonKey()
  @override
  final String layer;
  @JsonKey()
  @override
  final List<PathPoint> points;
  @JsonKey()
  @override
  final EraserProperty property;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.eraser(layer: $layer, points: $points, property: $property)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EraserElement &&
            const DeepCollectionEquality().equals(other.layer, layer) &&
            const DeepCollectionEquality().equals(other.points, points) &&
            const DeepCollectionEquality().equals(other.property, property));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(layer),
      const DeepCollectionEquality().hash(points),
      const DeepCollectionEquality().hash(property));

  @JsonKey(ignore: true)
  @override
  $EraserElementCopyWith<EraserElement> get copyWith =>
      _$EraserElementCopyWithImpl<EraserElement>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String layer, List<PathPoint> points, PenProperty property)
        pen,
    required TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)
        eraser,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            String text,
            LabelProperty property)
        label,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)
        image,
  }) {
    return eraser(layer, points, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String layer, List<PathPoint> points, PenProperty property)?
        pen,
    TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)?
        eraser,
    TResult Function(String layer, @OffsetJsonConverter() Offset position,
            String text, LabelProperty property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)?
        image,
  }) {
    return eraser?.call(layer, points, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String layer, List<PathPoint> points, PenProperty property)?
        pen,
    TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)?
        eraser,
    TResult Function(String layer, @OffsetJsonConverter() Offset position,
            String text, LabelProperty property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)?
        image,
    required TResult orElse(),
  }) {
    if (eraser != null) {
      return eraser(layer, points, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenElement value) pen,
    required TResult Function(EraserElement value) eraser,
    required TResult Function(LabelElement value) label,
    required TResult Function(ImageElement value) image,
  }) {
    return eraser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(EraserElement value)? eraser,
    TResult Function(LabelElement value)? label,
    TResult Function(ImageElement value)? image,
  }) {
    return eraser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(EraserElement value)? eraser,
    TResult Function(LabelElement value)? label,
    TResult Function(ImageElement value)? image,
    required TResult orElse(),
  }) {
    if (eraser != null) {
      return eraser(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EraserElementToJson(this);
  }
}

abstract class EraserElement implements PadElement, PathElement {
  const factory EraserElement(
      {String layer,
      List<PathPoint> points,
      EraserProperty property}) = _$EraserElement;

  factory EraserElement.fromJson(Map<String, dynamic> json) =
      _$EraserElement.fromJson;

  @override
  String get layer;
  List<PathPoint> get points;
  EraserProperty get property;
  @override
  @JsonKey(ignore: true)
  $EraserElementCopyWith<EraserElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabelElementCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory $LabelElementCopyWith(
          LabelElement value, $Res Function(LabelElement) then) =
      _$LabelElementCopyWithImpl<$Res>;
  @override
  $Res call(
      {String layer,
      @OffsetJsonConverter() Offset position,
      String text,
      LabelProperty property});
}

/// @nodoc
class _$LabelElementCopyWithImpl<$Res> extends _$PadElementCopyWithImpl<$Res>
    implements $LabelElementCopyWith<$Res> {
  _$LabelElementCopyWithImpl(
      LabelElement _value, $Res Function(LabelElement) _then)
      : super(_value, (v) => _then(v as LabelElement));

  @override
  LabelElement get _value => super._value as LabelElement;

  @override
  $Res call({
    Object? layer = freezed,
    Object? position = freezed,
    Object? text = freezed,
    Object? property = freezed,
  }) {
    return _then(LabelElement(
      layer: layer == freezed
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      property: property == freezed
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as LabelProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LabelElement implements LabelElement {
  const _$LabelElement(
      {this.layer = '',
      @OffsetJsonConverter() this.position = Offset.zero,
      this.text = '',
      this.property = const LabelProperty(),
      String? $type})
      : $type = $type ?? 'label';

  factory _$LabelElement.fromJson(Map<String, dynamic> json) =>
      _$$LabelElementFromJson(json);

  @JsonKey()
  @override
  final String layer;
  @JsonKey()
  @override
  @OffsetJsonConverter()
  final Offset position;
  @JsonKey()
  @override
  final String text;
  @JsonKey()
  @override
  final LabelProperty property;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.label(layer: $layer, position: $position, text: $text, property: $property)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LabelElement &&
            const DeepCollectionEquality().equals(other.layer, layer) &&
            const DeepCollectionEquality().equals(other.position, position) &&
            const DeepCollectionEquality().equals(other.text, text) &&
            const DeepCollectionEquality().equals(other.property, property));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(layer),
      const DeepCollectionEquality().hash(position),
      const DeepCollectionEquality().hash(text),
      const DeepCollectionEquality().hash(property));

  @JsonKey(ignore: true)
  @override
  $LabelElementCopyWith<LabelElement> get copyWith =>
      _$LabelElementCopyWithImpl<LabelElement>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String layer, List<PathPoint> points, PenProperty property)
        pen,
    required TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)
        eraser,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            String text,
            LabelProperty property)
        label,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)
        image,
  }) {
    return label(layer, position, text, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String layer, List<PathPoint> points, PenProperty property)?
        pen,
    TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)?
        eraser,
    TResult Function(String layer, @OffsetJsonConverter() Offset position,
            String text, LabelProperty property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)?
        image,
  }) {
    return label?.call(layer, position, text, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String layer, List<PathPoint> points, PenProperty property)?
        pen,
    TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)?
        eraser,
    TResult Function(String layer, @OffsetJsonConverter() Offset position,
            String text, LabelProperty property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)?
        image,
    required TResult orElse(),
  }) {
    if (label != null) {
      return label(layer, position, text, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenElement value) pen,
    required TResult Function(EraserElement value) eraser,
    required TResult Function(LabelElement value) label,
    required TResult Function(ImageElement value) image,
  }) {
    return label(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(EraserElement value)? eraser,
    TResult Function(LabelElement value)? label,
    TResult Function(ImageElement value)? image,
  }) {
    return label?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(EraserElement value)? eraser,
    TResult Function(LabelElement value)? label,
    TResult Function(ImageElement value)? image,
    required TResult orElse(),
  }) {
    if (label != null) {
      return label(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LabelElementToJson(this);
  }
}

abstract class LabelElement implements PadElement {
  const factory LabelElement(
      {String layer,
      @OffsetJsonConverter() Offset position,
      String text,
      LabelProperty property}) = _$LabelElement;

  factory LabelElement.fromJson(Map<String, dynamic> json) =
      _$LabelElement.fromJson;

  @override
  String get layer;
  @OffsetJsonConverter()
  Offset get position;
  String get text;
  LabelProperty get property;
  @override
  @JsonKey(ignore: true)
  $LabelElementCopyWith<LabelElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageElementCopyWith<$Res>
    implements $PadElementCopyWith<$Res> {
  factory $ImageElementCopyWith(
          ImageElement value, $Res Function(ImageElement) then) =
      _$ImageElementCopyWithImpl<$Res>;
  @override
  $Res call(
      {String layer,
      @OffsetJsonConverter() Offset position,
      PadConstraints? constraints,
      @Uint8ListJsonConverter() Uint8List pixels,
      int width,
      int height});

  $PadConstraintsCopyWith<$Res>? get constraints;
}

/// @nodoc
class _$ImageElementCopyWithImpl<$Res> extends _$PadElementCopyWithImpl<$Res>
    implements $ImageElementCopyWith<$Res> {
  _$ImageElementCopyWithImpl(
      ImageElement _value, $Res Function(ImageElement) _then)
      : super(_value, (v) => _then(v as ImageElement));

  @override
  ImageElement get _value => super._value as ImageElement;

  @override
  $Res call({
    Object? layer = freezed,
    Object? position = freezed,
    Object? constraints = freezed,
    Object? pixels = freezed,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(ImageElement(
      layer: layer == freezed
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Offset,
      constraints: constraints == freezed
          ? _value.constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as PadConstraints?,
      pixels: pixels == freezed
          ? _value.pixels
          : pixels // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  $PadConstraintsCopyWith<$Res>? get constraints {
    if (_value.constraints == null) {
      return null;
    }

    return $PadConstraintsCopyWith<$Res>(_value.constraints!, (value) {
      return _then(_value.copyWith(constraints: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageElement implements ImageElement {
  const _$ImageElement(
      {this.layer = '',
      @OffsetJsonConverter() this.position = Offset.zero,
      this.constraints = const ScaledPadConstraints(1),
      @Uint8ListJsonConverter() required this.pixels,
      required this.width,
      required this.height,
      String? $type})
      : $type = $type ?? 'image';

  factory _$ImageElement.fromJson(Map<String, dynamic> json) =>
      _$$ImageElementFromJson(json);

  @JsonKey()
  @override
  final String layer;
  @JsonKey()
  @override
  @OffsetJsonConverter()
  final Offset position;
  @JsonKey()
  @override
  final PadConstraints? constraints;
  @override
  @Uint8ListJsonConverter()
  final Uint8List pixels;
  @override
  final int width;
  @override
  final int height;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'PadElement.image(layer: $layer, position: $position, constraints: $constraints, pixels: $pixels, width: $width, height: $height)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageElement &&
            const DeepCollectionEquality().equals(other.layer, layer) &&
            const DeepCollectionEquality().equals(other.position, position) &&
            const DeepCollectionEquality()
                .equals(other.constraints, constraints) &&
            const DeepCollectionEquality().equals(other.pixels, pixels) &&
            const DeepCollectionEquality().equals(other.width, width) &&
            const DeepCollectionEquality().equals(other.height, height));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(layer),
      const DeepCollectionEquality().hash(position),
      const DeepCollectionEquality().hash(constraints),
      const DeepCollectionEquality().hash(pixels),
      const DeepCollectionEquality().hash(width),
      const DeepCollectionEquality().hash(height));

  @JsonKey(ignore: true)
  @override
  $ImageElementCopyWith<ImageElement> get copyWith =>
      _$ImageElementCopyWithImpl<ImageElement>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String layer, List<PathPoint> points, PenProperty property)
        pen,
    required TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)
        eraser,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            String text,
            LabelProperty property)
        label,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)
        image,
  }) {
    return image(layer, position, constraints, pixels, width, height);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            String layer, List<PathPoint> points, PenProperty property)?
        pen,
    TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)?
        eraser,
    TResult Function(String layer, @OffsetJsonConverter() Offset position,
            String text, LabelProperty property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)?
        image,
  }) {
    return image?.call(layer, position, constraints, pixels, width, height);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String layer, List<PathPoint> points, PenProperty property)?
        pen,
    TResult Function(
            String layer, List<PathPoint> points, EraserProperty property)?
        eraser,
    TResult Function(String layer, @OffsetJsonConverter() Offset position,
            String text, LabelProperty property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            PadConstraints? constraints,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)?
        image,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(layer, position, constraints, pixels, width, height);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PenElement value) pen,
    required TResult Function(EraserElement value) eraser,
    required TResult Function(LabelElement value) label,
    required TResult Function(ImageElement value) image,
  }) {
    return image(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(EraserElement value)? eraser,
    TResult Function(LabelElement value)? label,
    TResult Function(ImageElement value)? image,
  }) {
    return image?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PenElement value)? pen,
    TResult Function(EraserElement value)? eraser,
    TResult Function(LabelElement value)? label,
    TResult Function(ImageElement value)? image,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageElementToJson(this);
  }
}

abstract class ImageElement implements PadElement {
  const factory ImageElement(
      {String layer,
      @OffsetJsonConverter() Offset position,
      PadConstraints? constraints,
      @Uint8ListJsonConverter() required Uint8List pixels,
      required int width,
      required int height}) = _$ImageElement;

  factory ImageElement.fromJson(Map<String, dynamic> json) =
      _$ImageElement.fromJson;

  @override
  String get layer;
  @OffsetJsonConverter()
  Offset get position;
  PadConstraints? get constraints;
  @Uint8ListJsonConverter()
  Uint8List get pixels;
  int get width;
  int get height;
  @override
  @JsonKey(ignore: true)
  $ImageElementCopyWith<ImageElement> get copyWith =>
      throw _privateConstructorUsedError;
}
