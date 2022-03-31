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
      dynamic property = const LabelProperty()}) {
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
      int scale = 1,
      @Uint8ListJsonConverter() required Uint8List pixels,
      required int width,
      required int height}) {
    return ImageElement(
      layer: layer,
      position: position,
      scale: scale,
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
            dynamic property)
        label,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
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
            String text, dynamic property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
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
            String text, dynamic property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
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
            dynamic property)
        label,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
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
            String text, dynamic property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
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
            String text, dynamic property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
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

abstract class PenElement implements PadElement {
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
            dynamic property)
        label,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
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
            String text, dynamic property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
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
            String text, dynamic property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
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

abstract class EraserElement implements PadElement {
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
      dynamic property});
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
      property: property == freezed ? _value.property : property,
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
  final dynamic property;

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
            dynamic property)
        label,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
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
            String text, dynamic property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
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
            String text, dynamic property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
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
      dynamic property}) = _$LabelElement;

  factory LabelElement.fromJson(Map<String, dynamic> json) =
      _$LabelElement.fromJson;

  @override
  String get layer;
  @OffsetJsonConverter()
  Offset get position;
  String get text;
  dynamic get property;
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
      int scale,
      @Uint8ListJsonConverter() Uint8List pixels,
      int width,
      int height});
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
    Object? scale = freezed,
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
      scale: scale == freezed
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as int,
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
}

/// @nodoc
@JsonSerializable()
class _$ImageElement implements ImageElement {
  const _$ImageElement(
      {this.layer = '',
      @OffsetJsonConverter() this.position = Offset.zero,
      this.scale = 1,
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
  final int scale;
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
    return 'PadElement.image(layer: $layer, position: $position, scale: $scale, pixels: $pixels, width: $width, height: $height)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ImageElement &&
            const DeepCollectionEquality().equals(other.layer, layer) &&
            const DeepCollectionEquality().equals(other.position, position) &&
            const DeepCollectionEquality().equals(other.scale, scale) &&
            const DeepCollectionEquality().equals(other.pixels, pixels) &&
            const DeepCollectionEquality().equals(other.width, width) &&
            const DeepCollectionEquality().equals(other.height, height));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(layer),
      const DeepCollectionEquality().hash(position),
      const DeepCollectionEquality().hash(scale),
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
            dynamic property)
        label,
    required TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)
        image,
  }) {
    return image(layer, position, scale, pixels, width, height);
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
            String text, dynamic property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)?
        image,
  }) {
    return image?.call(layer, position, scale, pixels, width, height);
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
            String text, dynamic property)?
        label,
    TResult Function(
            String layer,
            @OffsetJsonConverter() Offset position,
            int scale,
            @Uint8ListJsonConverter() Uint8List pixels,
            int width,
            int height)?
        image,
    required TResult orElse(),
  }) {
    if (image != null) {
      return image(layer, position, scale, pixels, width, height);
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
      int scale,
      @Uint8ListJsonConverter() required Uint8List pixels,
      required int width,
      required int height}) = _$ImageElement;

  factory ImageElement.fromJson(Map<String, dynamic> json) =
      _$ImageElement.fromJson;

  @override
  String get layer;
  @OffsetJsonConverter()
  Offset get position;
  int get scale;
  @Uint8ListJsonConverter()
  Uint8List get pixels;
  int get width;
  int get height;
  @override
  @JsonKey(ignore: true)
  $ImageElementCopyWith<ImageElement> get copyWith =>
      throw _privateConstructorUsedError;
}
