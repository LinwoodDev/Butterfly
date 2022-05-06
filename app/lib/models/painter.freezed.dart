// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'painter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Painter _$PainterFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'label':
      return LabelPainter.fromJson(json);
    case 'pen':
      return PenPainter.fromJson(json);
    case 'eraser':
      return EraserPainter.fromJson(json);
    case 'pathEraser':
      return PathEraserPainter.fromJson(json);
    case 'layer':
      return LayerPainter.fromJson(json);
    case 'area':
      return AreaPainter.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'Painter', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$Painter {
  String get name => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, LabelProperty property) label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, EraserProperty property) eraser,
    required TResult Function(String name, double strokeWidth,
            bool includeEraser, bool deleteWholeStroke)
        pathEraser,
    required TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)
        layer,
    required TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)
        area,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PainterCopyWith<Painter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PainterCopyWith<$Res> {
  factory $PainterCopyWith(Painter value, $Res Function(Painter) then) =
      _$PainterCopyWithImpl<$Res>;
  $Res call({String name});
}

/// @nodoc
class _$PainterCopyWithImpl<$Res> implements $PainterCopyWith<$Res> {
  _$PainterCopyWithImpl(this._value, this._then);

  final Painter _value;
  // ignore: unused_field
  final $Res Function(Painter) _then;

  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$LabelPainterCopyWith<$Res> implements $PainterCopyWith<$Res> {
  factory _$$LabelPainterCopyWith(
          _$LabelPainter value, $Res Function(_$LabelPainter) then) =
      __$$LabelPainterCopyWithImpl<$Res>;
  @override
  $Res call({String name, LabelProperty property});
}

/// @nodoc
class __$$LabelPainterCopyWithImpl<$Res> extends _$PainterCopyWithImpl<$Res>
    implements _$$LabelPainterCopyWith<$Res> {
  __$$LabelPainterCopyWithImpl(
      _$LabelPainter _value, $Res Function(_$LabelPainter) _then)
      : super(_value, (v) => _then(v as _$LabelPainter));

  @override
  _$LabelPainter get _value => super._value as _$LabelPainter;

  @override
  $Res call({
    Object? name = freezed,
    Object? property = freezed,
  }) {
    return _then(_$LabelPainter(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
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
class _$LabelPainter implements LabelPainter {
  const _$LabelPainter(
      {this.name = '',
      this.property = const LabelProperty(),
      final String? $type})
      : $type = $type ?? 'label';

  factory _$LabelPainter.fromJson(Map<String, dynamic> json) =>
      _$$LabelPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final LabelProperty property;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.label(name: $name, property: $property)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LabelPainter &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.property, property));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(property));

  @JsonKey(ignore: true)
  @override
  _$$LabelPainterCopyWith<_$LabelPainter> get copyWith =>
      __$$LabelPainterCopyWithImpl<_$LabelPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, LabelProperty property) label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, EraserProperty property) eraser,
    required TResult Function(String name, double strokeWidth,
            bool includeEraser, bool deleteWholeStroke)
        pathEraser,
    required TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)
        layer,
    required TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)
        area,
  }) {
    return label(name, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
  }) {
    return label?.call(name, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
    required TResult orElse(),
  }) {
    if (label != null) {
      return label(name, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
  }) {
    return label(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
  }) {
    return label?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    required TResult orElse(),
  }) {
    if (label != null) {
      return label(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LabelPainterToJson(this);
  }
}

abstract class LabelPainter implements Painter {
  const factory LabelPainter(
      {final String name, final LabelProperty property}) = _$LabelPainter;

  factory LabelPainter.fromJson(Map<String, dynamic> json) =
      _$LabelPainter.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  LabelProperty get property => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$LabelPainterCopyWith<_$LabelPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PenPainterCopyWith<$Res> implements $PainterCopyWith<$Res> {
  factory _$$PenPainterCopyWith(
          _$PenPainter value, $Res Function(_$PenPainter) then) =
      __$$PenPainterCopyWithImpl<$Res>;
  @override
  $Res call({String name, bool zoomDependent, PenProperty property});
}

/// @nodoc
class __$$PenPainterCopyWithImpl<$Res> extends _$PainterCopyWithImpl<$Res>
    implements _$$PenPainterCopyWith<$Res> {
  __$$PenPainterCopyWithImpl(
      _$PenPainter _value, $Res Function(_$PenPainter) _then)
      : super(_value, (v) => _then(v as _$PenPainter));

  @override
  _$PenPainter get _value => super._value as _$PenPainter;

  @override
  $Res call({
    Object? name = freezed,
    Object? zoomDependent = freezed,
    Object? property = freezed,
  }) {
    return _then(_$PenPainter(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      zoomDependent: zoomDependent == freezed
          ? _value.zoomDependent
          : zoomDependent // ignore: cast_nullable_to_non_nullable
              as bool,
      property: property == freezed
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as PenProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PenPainter implements PenPainter {
  const _$PenPainter(
      {this.name = '',
      this.zoomDependent = false,
      this.property = const PenProperty(),
      final String? $type})
      : $type = $type ?? 'pen';

  factory _$PenPainter.fromJson(Map<String, dynamic> json) =>
      _$$PenPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final bool zoomDependent;
  @override
  @JsonKey()
  final PenProperty property;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.pen(name: $name, zoomDependent: $zoomDependent, property: $property)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PenPainter &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.zoomDependent, zoomDependent) &&
            const DeepCollectionEquality().equals(other.property, property));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(zoomDependent),
      const DeepCollectionEquality().hash(property));

  @JsonKey(ignore: true)
  @override
  _$$PenPainterCopyWith<_$PenPainter> get copyWith =>
      __$$PenPainterCopyWithImpl<_$PenPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, LabelProperty property) label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, EraserProperty property) eraser,
    required TResult Function(String name, double strokeWidth,
            bool includeEraser, bool deleteWholeStroke)
        pathEraser,
    required TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)
        layer,
    required TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)
        area,
  }) {
    return pen(name, zoomDependent, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
  }) {
    return pen?.call(name, zoomDependent, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(name, zoomDependent, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
  }) {
    return pen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
  }) {
    return pen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PenPainterToJson(this);
  }
}

abstract class PenPainter implements Painter {
  const factory PenPainter(
      {final String name,
      final bool zoomDependent,
      final PenProperty property}) = _$PenPainter;

  factory PenPainter.fromJson(Map<String, dynamic> json) =
      _$PenPainter.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  bool get zoomDependent => throw _privateConstructorUsedError;
  PenProperty get property => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$PenPainterCopyWith<_$PenPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EraserPainterCopyWith<$Res>
    implements $PainterCopyWith<$Res> {
  factory _$$EraserPainterCopyWith(
          _$EraserPainter value, $Res Function(_$EraserPainter) then) =
      __$$EraserPainterCopyWithImpl<$Res>;
  @override
  $Res call({String name, EraserProperty property});
}

/// @nodoc
class __$$EraserPainterCopyWithImpl<$Res> extends _$PainterCopyWithImpl<$Res>
    implements _$$EraserPainterCopyWith<$Res> {
  __$$EraserPainterCopyWithImpl(
      _$EraserPainter _value, $Res Function(_$EraserPainter) _then)
      : super(_value, (v) => _then(v as _$EraserPainter));

  @override
  _$EraserPainter get _value => super._value as _$EraserPainter;

  @override
  $Res call({
    Object? name = freezed,
    Object? property = freezed,
  }) {
    return _then(_$EraserPainter(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      property: property == freezed
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as EraserProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EraserPainter implements EraserPainter {
  const _$EraserPainter(
      {this.name = '',
      this.property = const EraserProperty(),
      final String? $type})
      : $type = $type ?? 'eraser';

  factory _$EraserPainter.fromJson(Map<String, dynamic> json) =>
      _$$EraserPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final EraserProperty property;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.eraser(name: $name, property: $property)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EraserPainter &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.property, property));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(property));

  @JsonKey(ignore: true)
  @override
  _$$EraserPainterCopyWith<_$EraserPainter> get copyWith =>
      __$$EraserPainterCopyWithImpl<_$EraserPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, LabelProperty property) label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, EraserProperty property) eraser,
    required TResult Function(String name, double strokeWidth,
            bool includeEraser, bool deleteWholeStroke)
        pathEraser,
    required TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)
        layer,
    required TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)
        area,
  }) {
    return eraser(name, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
  }) {
    return eraser?.call(name, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
    required TResult orElse(),
  }) {
    if (eraser != null) {
      return eraser(name, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
  }) {
    return eraser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
  }) {
    return eraser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    required TResult orElse(),
  }) {
    if (eraser != null) {
      return eraser(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EraserPainterToJson(this);
  }
}

abstract class EraserPainter implements Painter {
  const factory EraserPainter(
      {final String name, final EraserProperty property}) = _$EraserPainter;

  factory EraserPainter.fromJson(Map<String, dynamic> json) =
      _$EraserPainter.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  EraserProperty get property => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$EraserPainterCopyWith<_$EraserPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PathEraserPainterCopyWith<$Res>
    implements $PainterCopyWith<$Res> {
  factory _$$PathEraserPainterCopyWith(
          _$PathEraserPainter value, $Res Function(_$PathEraserPainter) then) =
      __$$PathEraserPainterCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      double strokeWidth,
      bool includeEraser,
      bool deleteWholeStroke});
}

/// @nodoc
class __$$PathEraserPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res>
    implements _$$PathEraserPainterCopyWith<$Res> {
  __$$PathEraserPainterCopyWithImpl(
      _$PathEraserPainter _value, $Res Function(_$PathEraserPainter) _then)
      : super(_value, (v) => _then(v as _$PathEraserPainter));

  @override
  _$PathEraserPainter get _value => super._value as _$PathEraserPainter;

  @override
  $Res call({
    Object? name = freezed,
    Object? strokeWidth = freezed,
    Object? includeEraser = freezed,
    Object? deleteWholeStroke = freezed,
  }) {
    return _then(_$PathEraserPainter(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      strokeWidth: strokeWidth == freezed
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      includeEraser: includeEraser == freezed
          ? _value.includeEraser
          : includeEraser // ignore: cast_nullable_to_non_nullable
              as bool,
      deleteWholeStroke: deleteWholeStroke == freezed
          ? _value.deleteWholeStroke
          : deleteWholeStroke // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PathEraserPainter implements PathEraserPainter {
  const _$PathEraserPainter(
      {this.name = '',
      this.strokeWidth = 5,
      this.includeEraser = false,
      this.deleteWholeStroke = false,
      final String? $type})
      : $type = $type ?? 'pathEraser';

  factory _$PathEraserPainter.fromJson(Map<String, dynamic> json) =>
      _$$PathEraserPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final bool includeEraser;
  @override
  @JsonKey()
  final bool deleteWholeStroke;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.pathEraser(name: $name, strokeWidth: $strokeWidth, includeEraser: $includeEraser, deleteWholeStroke: $deleteWholeStroke)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PathEraserPainter &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.strokeWidth, strokeWidth) &&
            const DeepCollectionEquality()
                .equals(other.includeEraser, includeEraser) &&
            const DeepCollectionEquality()
                .equals(other.deleteWholeStroke, deleteWholeStroke));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(strokeWidth),
      const DeepCollectionEquality().hash(includeEraser),
      const DeepCollectionEquality().hash(deleteWholeStroke));

  @JsonKey(ignore: true)
  @override
  _$$PathEraserPainterCopyWith<_$PathEraserPainter> get copyWith =>
      __$$PathEraserPainterCopyWithImpl<_$PathEraserPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, LabelProperty property) label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, EraserProperty property) eraser,
    required TResult Function(String name, double strokeWidth,
            bool includeEraser, bool deleteWholeStroke)
        pathEraser,
    required TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)
        layer,
    required TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)
        area,
  }) {
    return pathEraser(name, strokeWidth, includeEraser, deleteWholeStroke);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
  }) {
    return pathEraser?.call(
        name, strokeWidth, includeEraser, deleteWholeStroke);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
    required TResult orElse(),
  }) {
    if (pathEraser != null) {
      return pathEraser(name, strokeWidth, includeEraser, deleteWholeStroke);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
  }) {
    return pathEraser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
  }) {
    return pathEraser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    required TResult orElse(),
  }) {
    if (pathEraser != null) {
      return pathEraser(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PathEraserPainterToJson(this);
  }
}

abstract class PathEraserPainter implements Painter {
  const factory PathEraserPainter(
      {final String name,
      final double strokeWidth,
      final bool includeEraser,
      final bool deleteWholeStroke}) = _$PathEraserPainter;

  factory PathEraserPainter.fromJson(Map<String, dynamic> json) =
      _$PathEraserPainter.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  double get strokeWidth => throw _privateConstructorUsedError;
  bool get includeEraser => throw _privateConstructorUsedError;
  bool get deleteWholeStroke => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$PathEraserPainterCopyWith<_$PathEraserPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LayerPainterCopyWith<$Res> implements $PainterCopyWith<$Res> {
  factory _$$LayerPainterCopyWith(
          _$LayerPainter value, $Res Function(_$LayerPainter) then) =
      __$$LayerPainterCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name, double strokeWidth, String layer, bool includeEraser});
}

/// @nodoc
class __$$LayerPainterCopyWithImpl<$Res> extends _$PainterCopyWithImpl<$Res>
    implements _$$LayerPainterCopyWith<$Res> {
  __$$LayerPainterCopyWithImpl(
      _$LayerPainter _value, $Res Function(_$LayerPainter) _then)
      : super(_value, (v) => _then(v as _$LayerPainter));

  @override
  _$LayerPainter get _value => super._value as _$LayerPainter;

  @override
  $Res call({
    Object? name = freezed,
    Object? strokeWidth = freezed,
    Object? layer = freezed,
    Object? includeEraser = freezed,
  }) {
    return _then(_$LayerPainter(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      strokeWidth: strokeWidth == freezed
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
      layer: layer == freezed
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      includeEraser: includeEraser == freezed
          ? _value.includeEraser
          : includeEraser // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LayerPainter implements LayerPainter {
  const _$LayerPainter(
      {this.name = '',
      this.strokeWidth = 5,
      this.layer = '',
      this.includeEraser = false,
      final String? $type})
      : $type = $type ?? 'layer';

  factory _$LayerPainter.fromJson(Map<String, dynamic> json) =>
      _$$LayerPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final String layer;
  @override
  @JsonKey()
  final bool includeEraser;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.layer(name: $name, strokeWidth: $strokeWidth, layer: $layer, includeEraser: $includeEraser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LayerPainter &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.strokeWidth, strokeWidth) &&
            const DeepCollectionEquality().equals(other.layer, layer) &&
            const DeepCollectionEquality()
                .equals(other.includeEraser, includeEraser));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(strokeWidth),
      const DeepCollectionEquality().hash(layer),
      const DeepCollectionEquality().hash(includeEraser));

  @JsonKey(ignore: true)
  @override
  _$$LayerPainterCopyWith<_$LayerPainter> get copyWith =>
      __$$LayerPainterCopyWithImpl<_$LayerPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, LabelProperty property) label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, EraserProperty property) eraser,
    required TResult Function(String name, double strokeWidth,
            bool includeEraser, bool deleteWholeStroke)
        pathEraser,
    required TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)
        layer,
    required TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)
        area,
  }) {
    return layer(name, strokeWidth, this.layer, includeEraser);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
  }) {
    return layer?.call(name, strokeWidth, this.layer, includeEraser);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
    required TResult orElse(),
  }) {
    if (layer != null) {
      return layer(name, strokeWidth, this.layer, includeEraser);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
  }) {
    return layer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
  }) {
    return layer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    required TResult orElse(),
  }) {
    if (layer != null) {
      return layer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LayerPainterToJson(this);
  }
}

abstract class LayerPainter implements Painter {
  const factory LayerPainter(
      {final String name,
      final double strokeWidth,
      final String layer,
      final bool includeEraser}) = _$LayerPainter;

  factory LayerPainter.fromJson(Map<String, dynamic> json) =
      _$LayerPainter.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  double get strokeWidth => throw _privateConstructorUsedError;
  String get layer => throw _privateConstructorUsedError;
  bool get includeEraser => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$LayerPainterCopyWith<_$LayerPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AreaPainterCopyWith<$Res> implements $PainterCopyWith<$Res> {
  factory _$$AreaPainterCopyWith(
          _$AreaPainter value, $Res Function(_$AreaPainter) then) =
      __$$AreaPainterCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      double constrainedWidth,
      double constrainedHeight,
      double constrainedAspectRatio});
}

/// @nodoc
class __$$AreaPainterCopyWithImpl<$Res> extends _$PainterCopyWithImpl<$Res>
    implements _$$AreaPainterCopyWith<$Res> {
  __$$AreaPainterCopyWithImpl(
      _$AreaPainter _value, $Res Function(_$AreaPainter) _then)
      : super(_value, (v) => _then(v as _$AreaPainter));

  @override
  _$AreaPainter get _value => super._value as _$AreaPainter;

  @override
  $Res call({
    Object? name = freezed,
    Object? constrainedWidth = freezed,
    Object? constrainedHeight = freezed,
    Object? constrainedAspectRatio = freezed,
  }) {
    return _then(_$AreaPainter(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      constrainedWidth: constrainedWidth == freezed
          ? _value.constrainedWidth
          : constrainedWidth // ignore: cast_nullable_to_non_nullable
              as double,
      constrainedHeight: constrainedHeight == freezed
          ? _value.constrainedHeight
          : constrainedHeight // ignore: cast_nullable_to_non_nullable
              as double,
      constrainedAspectRatio: constrainedAspectRatio == freezed
          ? _value.constrainedAspectRatio
          : constrainedAspectRatio // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaPainter implements AreaPainter {
  const _$AreaPainter(
      {this.name = '',
      this.constrainedWidth = 0,
      this.constrainedHeight = 0,
      this.constrainedAspectRatio = 0,
      final String? $type})
      : $type = $type ?? 'area';

  factory _$AreaPainter.fromJson(Map<String, dynamic> json) =>
      _$$AreaPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double constrainedWidth;
  @override
  @JsonKey()
  final double constrainedHeight;
  @override
  @JsonKey()
  final double constrainedAspectRatio;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.area(name: $name, constrainedWidth: $constrainedWidth, constrainedHeight: $constrainedHeight, constrainedAspectRatio: $constrainedAspectRatio)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaPainter &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.constrainedWidth, constrainedWidth) &&
            const DeepCollectionEquality()
                .equals(other.constrainedHeight, constrainedHeight) &&
            const DeepCollectionEquality()
                .equals(other.constrainedAspectRatio, constrainedAspectRatio));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(constrainedWidth),
      const DeepCollectionEquality().hash(constrainedHeight),
      const DeepCollectionEquality().hash(constrainedAspectRatio));

  @JsonKey(ignore: true)
  @override
  _$$AreaPainterCopyWith<_$AreaPainter> get copyWith =>
      __$$AreaPainterCopyWithImpl<_$AreaPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, LabelProperty property) label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, EraserProperty property) eraser,
    required TResult Function(String name, double strokeWidth,
            bool includeEraser, bool deleteWholeStroke)
        pathEraser,
    required TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)
        layer,
    required TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)
        area,
  }) {
    return area(
        name, constrainedWidth, constrainedHeight, constrainedAspectRatio);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
  }) {
    return area?.call(
        name, constrainedWidth, constrainedHeight, constrainedAspectRatio);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, LabelProperty property)? label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, EraserProperty property)? eraser,
    TResult Function(String name, double strokeWidth, bool includeEraser,
            bool deleteWholeStroke)?
        pathEraser,
    TResult Function(
            String name, double strokeWidth, String layer, bool includeEraser)?
        layer,
    TResult Function(String name, double constrainedWidth,
            double constrainedHeight, double constrainedAspectRatio)?
        area,
    required TResult orElse(),
  }) {
    if (area != null) {
      return area(
          name, constrainedWidth, constrainedHeight, constrainedAspectRatio);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
  }) {
    return area(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
  }) {
    return area?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    required TResult orElse(),
  }) {
    if (area != null) {
      return area(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaPainterToJson(this);
  }
}

abstract class AreaPainter implements Painter {
  const factory AreaPainter(
      {final String name,
      final double constrainedWidth,
      final double constrainedHeight,
      final double constrainedAspectRatio}) = _$AreaPainter;

  factory AreaPainter.fromJson(Map<String, dynamic> json) =
      _$AreaPainter.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  double get constrainedWidth => throw _privateConstructorUsedError;
  double get constrainedHeight => throw _privateConstructorUsedError;
  double get constrainedAspectRatio => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$AreaPainterCopyWith<_$AreaPainter> get copyWith =>
      throw _privateConstructorUsedError;
}
