// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'painter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Painter _$PainterFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'hand':
      return HandPainter.fromJson(json);
    case 'import':
      return ImportPainter.fromJson(json);
    case 'undo':
      return UndoPainter.fromJson(json);
    case 'redo':
      return RedoPainter.fromJson(json);
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
    case 'waypoint':
      return WaypointPainter.fromJson(json);
    case 'laser':
      return LaserPainter.fromJson(json);
    case 'shape':
      return ShapePainter.fromJson(json);
    case 'stamp':
      return StampPainter.fromJson(json);
    case 'presentation':
      return PresentationPainter.fromJson(json);

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
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
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
      _$PainterCopyWithImpl<$Res, Painter>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$PainterCopyWithImpl<$Res, $Val extends Painter>
    implements $PainterCopyWith<$Res> {
  _$PainterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HandPainterCopyWith<$Res> implements $PainterCopyWith<$Res> {
  factory _$$HandPainterCopyWith(
          _$HandPainter value, $Res Function(_$HandPainter) then) =
      __$$HandPainterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$HandPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$HandPainter>
    implements _$$HandPainterCopyWith<$Res> {
  __$$HandPainterCopyWithImpl(
      _$HandPainter _value, $Res Function(_$HandPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$HandPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HandPainter implements HandPainter {
  _$HandPainter({this.name = '', final String? $type})
      : $type = $type ?? 'hand';

  factory _$HandPainter.fromJson(Map<String, dynamic> json) =>
      _$$HandPainterFromJson(json);

  @override
  @JsonKey()
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.hand(name: $name)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HandPainterCopyWith<_$HandPainter> get copyWith =>
      __$$HandPainterCopyWithImpl<_$HandPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return hand(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return hand?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (hand != null) {
      return hand(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return hand(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return hand?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (hand != null) {
      return hand(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$HandPainterToJson(
      this,
    );
  }
}

abstract class HandPainter implements Painter {
  factory HandPainter({final String name}) = _$HandPainter;

  factory HandPainter.fromJson(Map<String, dynamic> json) =
      _$HandPainter.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$HandPainterCopyWith<_$HandPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImportPainterCopyWith<$Res>
    implements $PainterCopyWith<$Res> {
  factory _$$ImportPainterCopyWith(
          _$ImportPainter value, $Res Function(_$ImportPainter) then) =
      __$$ImportPainterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<PadElement> elements, List<Area> areas});
}

/// @nodoc
class __$$ImportPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$ImportPainter>
    implements _$$ImportPainterCopyWith<$Res> {
  __$$ImportPainterCopyWithImpl(
      _$ImportPainter _value, $Res Function(_$ImportPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? elements = null,
    Object? areas = null,
  }) {
    return _then(_$ImportPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      elements: null == elements
          ? _value._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
      areas: null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<Area>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImportPainter implements ImportPainter {
  _$ImportPainter(
      {this.name = '',
      required final List<PadElement> elements,
      required final List<Area> areas,
      final String? $type})
      : _elements = elements,
        _areas = areas,
        $type = $type ?? 'import';

  factory _$ImportPainter.fromJson(Map<String, dynamic> json) =>
      _$$ImportPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  final List<PadElement> _elements;
  @override
  List<PadElement> get elements {
    if (_elements is EqualUnmodifiableListView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_elements);
  }

  final List<Area> _areas;
  @override
  List<Area> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.import(name: $name, elements: $elements, areas: $areas)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImportPainterCopyWith<_$ImportPainter> get copyWith =>
      __$$ImportPainterCopyWithImpl<_$ImportPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return import(name, elements, areas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return import?.call(name, elements, areas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (import != null) {
      return import(name, elements, areas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return import(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return import?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (import != null) {
      return import(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ImportPainterToJson(
      this,
    );
  }
}

abstract class ImportPainter implements Painter {
  factory ImportPainter(
      {final String name,
      required final List<PadElement> elements,
      required final List<Area> areas}) = _$ImportPainter;

  factory ImportPainter.fromJson(Map<String, dynamic> json) =
      _$ImportPainter.fromJson;

  @override
  String get name;
  List<PadElement> get elements;
  List<Area> get areas;
  @override
  @JsonKey(ignore: true)
  _$$ImportPainterCopyWith<_$ImportPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UndoPainterCopyWith<$Res> implements $PainterCopyWith<$Res> {
  factory _$$UndoPainterCopyWith(
          _$UndoPainter value, $Res Function(_$UndoPainter) then) =
      __$$UndoPainterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$UndoPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$UndoPainter>
    implements _$$UndoPainterCopyWith<$Res> {
  __$$UndoPainterCopyWithImpl(
      _$UndoPainter _value, $Res Function(_$UndoPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$UndoPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UndoPainter implements UndoPainter {
  _$UndoPainter({this.name = '', final String? $type})
      : $type = $type ?? 'undo';

  factory _$UndoPainter.fromJson(Map<String, dynamic> json) =>
      _$$UndoPainterFromJson(json);

  @override
  @JsonKey()
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.undo(name: $name)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UndoPainterCopyWith<_$UndoPainter> get copyWith =>
      __$$UndoPainterCopyWithImpl<_$UndoPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return undo(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return undo?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (undo != null) {
      return undo(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return undo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return undo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (undo != null) {
      return undo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UndoPainterToJson(
      this,
    );
  }
}

abstract class UndoPainter implements Painter {
  factory UndoPainter({final String name}) = _$UndoPainter;

  factory UndoPainter.fromJson(Map<String, dynamic> json) =
      _$UndoPainter.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$UndoPainterCopyWith<_$UndoPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RedoPainterCopyWith<$Res> implements $PainterCopyWith<$Res> {
  factory _$$RedoPainterCopyWith(
          _$RedoPainter value, $Res Function(_$RedoPainter) then) =
      __$$RedoPainterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$RedoPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$RedoPainter>
    implements _$$RedoPainterCopyWith<$Res> {
  __$$RedoPainterCopyWithImpl(
      _$RedoPainter _value, $Res Function(_$RedoPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$RedoPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RedoPainter implements RedoPainter {
  _$RedoPainter({this.name = '', final String? $type})
      : $type = $type ?? 'redo';

  factory _$RedoPainter.fromJson(Map<String, dynamic> json) =>
      _$$RedoPainterFromJson(json);

  @override
  @JsonKey()
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.redo(name: $name)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RedoPainterCopyWith<_$RedoPainter> get copyWith =>
      __$$RedoPainterCopyWithImpl<_$RedoPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return redo(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return redo?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (redo != null) {
      return redo(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return redo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return redo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (redo != null) {
      return redo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RedoPainterToJson(
      this,
    );
  }
}

abstract class RedoPainter implements Painter {
  factory RedoPainter({final String name}) = _$RedoPainter;

  factory RedoPainter.fromJson(Map<String, dynamic> json) =
      _$RedoPainter.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$RedoPainterCopyWith<_$RedoPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LabelPainterCopyWith<$Res> implements $PainterCopyWith<$Res> {
  factory _$$LabelPainterCopyWith(
          _$LabelPainter value, $Res Function(_$LabelPainter) then) =
      __$$LabelPainterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      LabelMode mode,
      bool zoomDependent,
      int foreground,
      PackAssetLocation styleSheet});

  $PackAssetLocationCopyWith<$Res> get styleSheet;
}

/// @nodoc
class __$$LabelPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$LabelPainter>
    implements _$$LabelPainterCopyWith<$Res> {
  __$$LabelPainterCopyWithImpl(
      _$LabelPainter _value, $Res Function(_$LabelPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? mode = null,
    Object? zoomDependent = null,
    Object? foreground = null,
    Object? styleSheet = null,
  }) {
    return _then(_$LabelPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as LabelMode,
      zoomDependent: null == zoomDependent
          ? _value.zoomDependent
          : zoomDependent // ignore: cast_nullable_to_non_nullable
              as bool,
      foreground: null == foreground
          ? _value.foreground
          : foreground // ignore: cast_nullable_to_non_nullable
              as int,
      styleSheet: null == styleSheet
          ? _value.styleSheet
          : styleSheet // ignore: cast_nullable_to_non_nullable
              as PackAssetLocation,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $PackAssetLocationCopyWith<$Res> get styleSheet {
    return $PackAssetLocationCopyWith<$Res>(_value.styleSheet, (value) {
      return _then(_value.copyWith(styleSheet: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$LabelPainter implements LabelPainter {
  _$LabelPainter(
      {this.name = '',
      this.mode = LabelMode.text,
      this.zoomDependent = true,
      this.foreground = kColorBlack,
      this.styleSheet = const PackAssetLocation(),
      final String? $type})
      : $type = $type ?? 'label';

  factory _$LabelPainter.fromJson(Map<String, dynamic> json) =>
      _$$LabelPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final LabelMode mode;
  @override
  @JsonKey()
  final bool zoomDependent;
  @override
  @JsonKey()
  final int foreground;
  @override
  @JsonKey()
  final PackAssetLocation styleSheet;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.label(name: $name, mode: $mode, zoomDependent: $zoomDependent, foreground: $foreground, styleSheet: $styleSheet)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LabelPainterCopyWith<_$LabelPainter> get copyWith =>
      __$$LabelPainterCopyWithImpl<_$LabelPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return label(name, mode, zoomDependent, foreground, styleSheet);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return label?.call(name, mode, zoomDependent, foreground, styleSheet);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (label != null) {
      return label(name, mode, zoomDependent, foreground, styleSheet);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return label(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return label?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (label != null) {
      return label(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LabelPainterToJson(
      this,
    );
  }
}

abstract class LabelPainter implements Painter {
  factory LabelPainter(
      {final String name,
      final LabelMode mode,
      final bool zoomDependent,
      final int foreground,
      final PackAssetLocation styleSheet}) = _$LabelPainter;

  factory LabelPainter.fromJson(Map<String, dynamic> json) =
      _$LabelPainter.fromJson;

  @override
  String get name;
  LabelMode get mode;
  bool get zoomDependent;
  int get foreground;
  PackAssetLocation get styleSheet;
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
  @useResult
  $Res call({String name, bool zoomDependent, PenProperty property});
}

/// @nodoc
class __$$PenPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$PenPainter>
    implements _$$PenPainterCopyWith<$Res> {
  __$$PenPainterCopyWithImpl(
      _$PenPainter _value, $Res Function(_$PenPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? zoomDependent = null,
    Object? property = freezed,
  }) {
    return _then(_$PenPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      zoomDependent: null == zoomDependent
          ? _value.zoomDependent
          : zoomDependent // ignore: cast_nullable_to_non_nullable
              as bool,
      property: freezed == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as PenProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PenPainter implements PenPainter {
  _$PenPainter(
      {this.name = '',
      this.zoomDependent = true,
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

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PenPainterCopyWith<_$PenPainter> get copyWith =>
      __$$PenPainterCopyWithImpl<_$PenPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return pen(name, zoomDependent, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return pen?.call(name, zoomDependent, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
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
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return pen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return pen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PenPainterToJson(
      this,
    );
  }
}

abstract class PenPainter implements Painter {
  factory PenPainter(
      {final String name,
      final bool zoomDependent,
      final PenProperty property}) = _$PenPainter;

  factory PenPainter.fromJson(Map<String, dynamic> json) =
      _$PenPainter.fromJson;

  @override
  String get name;
  bool get zoomDependent;
  PenProperty get property;
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
  @useResult
  $Res call({String name, double strokeWidth});
}

/// @nodoc
class __$$EraserPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$EraserPainter>
    implements _$$EraserPainterCopyWith<$Res> {
  __$$EraserPainterCopyWithImpl(
      _$EraserPainter _value, $Res Function(_$EraserPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? strokeWidth = null,
  }) {
    return _then(_$EraserPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      strokeWidth: null == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EraserPainter implements EraserPainter {
  _$EraserPainter({this.name = '', this.strokeWidth = 5, final String? $type})
      : $type = $type ?? 'eraser';

  factory _$EraserPainter.fromJson(Map<String, dynamic> json) =>
      _$$EraserPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double strokeWidth;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.eraser(name: $name, strokeWidth: $strokeWidth)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EraserPainterCopyWith<_$EraserPainter> get copyWith =>
      __$$EraserPainterCopyWithImpl<_$EraserPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return eraser(name, strokeWidth);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return eraser?.call(name, strokeWidth);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (eraser != null) {
      return eraser(name, strokeWidth);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return eraser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return eraser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (eraser != null) {
      return eraser(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EraserPainterToJson(
      this,
    );
  }
}

abstract class EraserPainter implements Painter {
  factory EraserPainter({final String name, final double strokeWidth}) =
      _$EraserPainter;

  factory EraserPainter.fromJson(Map<String, dynamic> json) =
      _$EraserPainter.fromJson;

  @override
  String get name;
  double get strokeWidth;
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
  @useResult
  $Res call({String name, double strokeWidth});
}

/// @nodoc
class __$$PathEraserPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$PathEraserPainter>
    implements _$$PathEraserPainterCopyWith<$Res> {
  __$$PathEraserPainterCopyWithImpl(
      _$PathEraserPainter _value, $Res Function(_$PathEraserPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? strokeWidth = null,
  }) {
    return _then(_$PathEraserPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      strokeWidth: null == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PathEraserPainter implements PathEraserPainter {
  _$PathEraserPainter(
      {this.name = '', this.strokeWidth = 5, final String? $type})
      : $type = $type ?? 'pathEraser';

  factory _$PathEraserPainter.fromJson(Map<String, dynamic> json) =>
      _$$PathEraserPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double strokeWidth;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.pathEraser(name: $name, strokeWidth: $strokeWidth)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PathEraserPainterCopyWith<_$PathEraserPainter> get copyWith =>
      __$$PathEraserPainterCopyWithImpl<_$PathEraserPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return pathEraser(name, strokeWidth);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return pathEraser?.call(name, strokeWidth);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (pathEraser != null) {
      return pathEraser(name, strokeWidth);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return pathEraser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return pathEraser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (pathEraser != null) {
      return pathEraser(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PathEraserPainterToJson(
      this,
    );
  }
}

abstract class PathEraserPainter implements Painter {
  factory PathEraserPainter({final String name, final double strokeWidth}) =
      _$PathEraserPainter;

  factory PathEraserPainter.fromJson(Map<String, dynamic> json) =
      _$PathEraserPainter.fromJson;

  @override
  String get name;
  double get strokeWidth;
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
  @useResult
  $Res call({String name, double strokeWidth});
}

/// @nodoc
class __$$LayerPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$LayerPainter>
    implements _$$LayerPainterCopyWith<$Res> {
  __$$LayerPainterCopyWithImpl(
      _$LayerPainter _value, $Res Function(_$LayerPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? strokeWidth = null,
  }) {
    return _then(_$LayerPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      strokeWidth: null == strokeWidth
          ? _value.strokeWidth
          : strokeWidth // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LayerPainter implements LayerPainter {
  _$LayerPainter({this.name = '', this.strokeWidth = 5, final String? $type})
      : $type = $type ?? 'layer';

  factory _$LayerPainter.fromJson(Map<String, dynamic> json) =>
      _$$LayerPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double strokeWidth;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.layer(name: $name, strokeWidth: $strokeWidth)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LayerPainterCopyWith<_$LayerPainter> get copyWith =>
      __$$LayerPainterCopyWithImpl<_$LayerPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return layer(name, strokeWidth);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return layer?.call(name, strokeWidth);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (layer != null) {
      return layer(name, strokeWidth);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return layer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return layer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (layer != null) {
      return layer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LayerPainterToJson(
      this,
    );
  }
}

abstract class LayerPainter implements Painter {
  factory LayerPainter({final String name, final double strokeWidth}) =
      _$LayerPainter;

  factory LayerPainter.fromJson(Map<String, dynamic> json) =
      _$LayerPainter.fromJson;

  @override
  String get name;
  double get strokeWidth;
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
  @useResult
  $Res call(
      {String name,
      double constrainedWidth,
      double constrainedHeight,
      double constrainedAspectRatio,
      bool askForName});
}

/// @nodoc
class __$$AreaPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$AreaPainter>
    implements _$$AreaPainterCopyWith<$Res> {
  __$$AreaPainterCopyWithImpl(
      _$AreaPainter _value, $Res Function(_$AreaPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? constrainedWidth = null,
    Object? constrainedHeight = null,
    Object? constrainedAspectRatio = null,
    Object? askForName = null,
  }) {
    return _then(_$AreaPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      constrainedWidth: null == constrainedWidth
          ? _value.constrainedWidth
          : constrainedWidth // ignore: cast_nullable_to_non_nullable
              as double,
      constrainedHeight: null == constrainedHeight
          ? _value.constrainedHeight
          : constrainedHeight // ignore: cast_nullable_to_non_nullable
              as double,
      constrainedAspectRatio: null == constrainedAspectRatio
          ? _value.constrainedAspectRatio
          : constrainedAspectRatio // ignore: cast_nullable_to_non_nullable
              as double,
      askForName: null == askForName
          ? _value.askForName
          : askForName // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaPainter implements AreaPainter {
  _$AreaPainter(
      {this.name = '',
      this.constrainedWidth = 0,
      this.constrainedHeight = 0,
      this.constrainedAspectRatio = 0,
      this.askForName = false,
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
  @override
  @JsonKey()
  final bool askForName;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.area(name: $name, constrainedWidth: $constrainedWidth, constrainedHeight: $constrainedHeight, constrainedAspectRatio: $constrainedAspectRatio, askForName: $askForName)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaPainterCopyWith<_$AreaPainter> get copyWith =>
      __$$AreaPainterCopyWithImpl<_$AreaPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return area(name, constrainedWidth, constrainedHeight,
        constrainedAspectRatio, askForName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return area?.call(name, constrainedWidth, constrainedHeight,
        constrainedAspectRatio, askForName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (area != null) {
      return area(name, constrainedWidth, constrainedHeight,
          constrainedAspectRatio, askForName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return area(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return area?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (area != null) {
      return area(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaPainterToJson(
      this,
    );
  }
}

abstract class AreaPainter implements Painter {
  factory AreaPainter(
      {final String name,
      final double constrainedWidth,
      final double constrainedHeight,
      final double constrainedAspectRatio,
      final bool askForName}) = _$AreaPainter;

  factory AreaPainter.fromJson(Map<String, dynamic> json) =
      _$AreaPainter.fromJson;

  @override
  String get name;
  double get constrainedWidth;
  double get constrainedHeight;
  double get constrainedAspectRatio;
  bool get askForName;
  @override
  @JsonKey(ignore: true)
  _$$AreaPainterCopyWith<_$AreaPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WaypointPainterCopyWith<$Res>
    implements $PainterCopyWith<$Res> {
  factory _$$WaypointPainterCopyWith(
          _$WaypointPainter value, $Res Function(_$WaypointPainter) then) =
      __$$WaypointPainterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$WaypointPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$WaypointPainter>
    implements _$$WaypointPainterCopyWith<$Res> {
  __$$WaypointPainterCopyWithImpl(
      _$WaypointPainter _value, $Res Function(_$WaypointPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$WaypointPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WaypointPainter implements WaypointPainter {
  _$WaypointPainter({this.name = '', final String? $type})
      : $type = $type ?? 'waypoint';

  factory _$WaypointPainter.fromJson(Map<String, dynamic> json) =>
      _$$WaypointPainterFromJson(json);

  @override
  @JsonKey()
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.waypoint(name: $name)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaypointPainterCopyWith<_$WaypointPainter> get copyWith =>
      __$$WaypointPainterCopyWithImpl<_$WaypointPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return waypoint(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return waypoint?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (waypoint != null) {
      return waypoint(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return waypoint(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return waypoint?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (waypoint != null) {
      return waypoint(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WaypointPainterToJson(
      this,
    );
  }
}

abstract class WaypointPainter implements Painter {
  factory WaypointPainter({final String name}) = _$WaypointPainter;

  factory WaypointPainter.fromJson(Map<String, dynamic> json) =
      _$WaypointPainter.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$WaypointPainterCopyWith<_$WaypointPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LaserPainterCopyWith<$Res> implements $PainterCopyWith<$Res> {
  factory _$$LaserPainterCopyWith(
          _$LaserPainter value, $Res Function(_$LaserPainter) then) =
      __$$LaserPainterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      double duration,
      double strokeWidth,
      double thinning,
      int color});
}

/// @nodoc
class __$$LaserPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$LaserPainter>
    implements _$$LaserPainterCopyWith<$Res> {
  __$$LaserPainterCopyWithImpl(
      _$LaserPainter _value, $Res Function(_$LaserPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? duration = null,
    Object? strokeWidth = null,
    Object? thinning = null,
    Object? color = null,
  }) {
    return _then(_$LaserPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LaserPainter implements LaserPainter {
  _$LaserPainter(
      {this.name = '',
      this.duration = 5,
      this.strokeWidth = 5,
      this.thinning = 0.4,
      this.color = kColorRed,
      final String? $type})
      : $type = $type ?? 'laser';

  factory _$LaserPainter.fromJson(Map<String, dynamic> json) =>
      _$$LaserPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double duration;
  @override
  @JsonKey()
  final double strokeWidth;
  @override
  @JsonKey()
  final double thinning;
  @override
  @JsonKey()
  final int color;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.laser(name: $name, duration: $duration, strokeWidth: $strokeWidth, thinning: $thinning, color: $color)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LaserPainterCopyWith<_$LaserPainter> get copyWith =>
      __$$LaserPainterCopyWithImpl<_$LaserPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return laser(name, duration, strokeWidth, thinning, color);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return laser?.call(name, duration, strokeWidth, thinning, color);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (laser != null) {
      return laser(name, duration, strokeWidth, thinning, color);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return laser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return laser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (laser != null) {
      return laser(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LaserPainterToJson(
      this,
    );
  }
}

abstract class LaserPainter implements Painter {
  factory LaserPainter(
      {final String name,
      final double duration,
      final double strokeWidth,
      final double thinning,
      final int color}) = _$LaserPainter;

  factory LaserPainter.fromJson(Map<String, dynamic> json) =
      _$LaserPainter.fromJson;

  @override
  String get name;
  double get duration;
  double get strokeWidth;
  double get thinning;
  int get color;
  @override
  @JsonKey(ignore: true)
  _$$LaserPainterCopyWith<_$LaserPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShapePainterCopyWith<$Res> implements $PainterCopyWith<$Res> {
  factory _$$ShapePainterCopyWith(
          _$ShapePainter value, $Res Function(_$ShapePainter) then) =
      __$$ShapePainterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      bool zoomDependent,
      double constrainedWidth,
      double constrainedHeight,
      double constrainedAspectRatio,
      ShapeProperty property});
}

/// @nodoc
class __$$ShapePainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$ShapePainter>
    implements _$$ShapePainterCopyWith<$Res> {
  __$$ShapePainterCopyWithImpl(
      _$ShapePainter _value, $Res Function(_$ShapePainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? zoomDependent = null,
    Object? constrainedWidth = null,
    Object? constrainedHeight = null,
    Object? constrainedAspectRatio = null,
    Object? property = freezed,
  }) {
    return _then(_$ShapePainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      zoomDependent: null == zoomDependent
          ? _value.zoomDependent
          : zoomDependent // ignore: cast_nullable_to_non_nullable
              as bool,
      constrainedWidth: null == constrainedWidth
          ? _value.constrainedWidth
          : constrainedWidth // ignore: cast_nullable_to_non_nullable
              as double,
      constrainedHeight: null == constrainedHeight
          ? _value.constrainedHeight
          : constrainedHeight // ignore: cast_nullable_to_non_nullable
              as double,
      constrainedAspectRatio: null == constrainedAspectRatio
          ? _value.constrainedAspectRatio
          : constrainedAspectRatio // ignore: cast_nullable_to_non_nullable
              as double,
      property: freezed == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as ShapeProperty,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShapePainter implements ShapePainter {
  _$ShapePainter(
      {this.name = '',
      this.zoomDependent = true,
      this.constrainedWidth = 0,
      this.constrainedHeight = 0,
      this.constrainedAspectRatio = 0,
      this.property = const ShapeProperty(shape: RectangleShape()),
      final String? $type})
      : $type = $type ?? 'shape';

  factory _$ShapePainter.fromJson(Map<String, dynamic> json) =>
      _$$ShapePainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final bool zoomDependent;
  @override
  @JsonKey()
  final double constrainedWidth;
  @override
  @JsonKey()
  final double constrainedHeight;
  @override
  @JsonKey()
  final double constrainedAspectRatio;
  @override
  @JsonKey()
  final ShapeProperty property;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.shape(name: $name, zoomDependent: $zoomDependent, constrainedWidth: $constrainedWidth, constrainedHeight: $constrainedHeight, constrainedAspectRatio: $constrainedAspectRatio, property: $property)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShapePainterCopyWith<_$ShapePainter> get copyWith =>
      __$$ShapePainterCopyWithImpl<_$ShapePainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return shape(name, zoomDependent, constrainedWidth, constrainedHeight,
        constrainedAspectRatio, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return shape?.call(name, zoomDependent, constrainedWidth, constrainedHeight,
        constrainedAspectRatio, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (shape != null) {
      return shape(name, zoomDependent, constrainedWidth, constrainedHeight,
          constrainedAspectRatio, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return shape(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return shape?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (shape != null) {
      return shape(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ShapePainterToJson(
      this,
    );
  }
}

abstract class ShapePainter implements Painter {
  factory ShapePainter(
      {final String name,
      final bool zoomDependent,
      final double constrainedWidth,
      final double constrainedHeight,
      final double constrainedAspectRatio,
      final ShapeProperty property}) = _$ShapePainter;

  factory ShapePainter.fromJson(Map<String, dynamic> json) =
      _$ShapePainter.fromJson;

  @override
  String get name;
  bool get zoomDependent;
  double get constrainedWidth;
  double get constrainedHeight;
  double get constrainedAspectRatio;
  ShapeProperty get property;
  @override
  @JsonKey(ignore: true)
  _$$ShapePainterCopyWith<_$ShapePainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StampPainterCopyWith<$Res> implements $PainterCopyWith<$Res> {
  factory _$$StampPainterCopyWith(
          _$StampPainter value, $Res Function(_$StampPainter) then) =
      __$$StampPainterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, PackAssetLocation component});

  $PackAssetLocationCopyWith<$Res> get component;
}

/// @nodoc
class __$$StampPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$StampPainter>
    implements _$$StampPainterCopyWith<$Res> {
  __$$StampPainterCopyWithImpl(
      _$StampPainter _value, $Res Function(_$StampPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? component = null,
  }) {
    return _then(_$StampPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      component: null == component
          ? _value.component
          : component // ignore: cast_nullable_to_non_nullable
              as PackAssetLocation,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $PackAssetLocationCopyWith<$Res> get component {
    return $PackAssetLocationCopyWith<$Res>(_value.component, (value) {
      return _then(_value.copyWith(component: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$StampPainter implements StampPainter {
  _$StampPainter(
      {this.name = '',
      this.component = const PackAssetLocation(),
      final String? $type})
      : $type = $type ?? 'stamp';

  factory _$StampPainter.fromJson(Map<String, dynamic> json) =>
      _$$StampPainterFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final PackAssetLocation component;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.stamp(name: $name, component: $component)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StampPainterCopyWith<_$StampPainter> get copyWith =>
      __$$StampPainterCopyWithImpl<_$StampPainter>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return stamp(name, component);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return stamp?.call(name, component);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (stamp != null) {
      return stamp(name, component);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return stamp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return stamp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (stamp != null) {
      return stamp(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StampPainterToJson(
      this,
    );
  }
}

abstract class StampPainter implements Painter {
  factory StampPainter({final String name, final PackAssetLocation component}) =
      _$StampPainter;

  factory StampPainter.fromJson(Map<String, dynamic> json) =
      _$StampPainter.fromJson;

  @override
  String get name;
  PackAssetLocation get component;
  @override
  @JsonKey(ignore: true)
  _$$StampPainterCopyWith<_$StampPainter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PresentationPainterCopyWith<$Res>
    implements $PainterCopyWith<$Res> {
  factory _$$PresentationPainterCopyWith(_$PresentationPainter value,
          $Res Function(_$PresentationPainter) then) =
      __$$PresentationPainterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$PresentationPainterCopyWithImpl<$Res>
    extends _$PainterCopyWithImpl<$Res, _$PresentationPainter>
    implements _$$PresentationPainterCopyWith<$Res> {
  __$$PresentationPainterCopyWithImpl(
      _$PresentationPainter _value, $Res Function(_$PresentationPainter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$PresentationPainter(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresentationPainter implements PresentationPainter {
  _$PresentationPainter({this.name = '', final String? $type})
      : $type = $type ?? 'presentation';

  factory _$PresentationPainter.fromJson(Map<String, dynamic> json) =>
      _$$PresentationPainterFromJson(json);

  @override
  @JsonKey()
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Painter.presentation(name: $name)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentationPainterCopyWith<_$PresentationPainter> get copyWith =>
      __$$PresentationPainterCopyWithImpl<_$PresentationPainter>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name) hand,
    required TResult Function(
            String name, List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name) undo,
    required TResult Function(String name) redo,
    required TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)
        label,
    required TResult Function(
            String name, bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(String name, double strokeWidth) eraser,
    required TResult Function(String name, double strokeWidth) pathEraser,
    required TResult Function(String name, double strokeWidth) layer,
    required TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name) waypoint,
    required TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)
        laser,
    required TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(String name, PackAssetLocation component) stamp,
    required TResult Function(String name) presentation,
  }) {
    return presentation(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name)? hand,
    TResult? Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name)? undo,
    TResult? Function(String name)? redo,
    TResult? Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult? Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult? Function(String name, double strokeWidth)? eraser,
    TResult? Function(String name, double strokeWidth)? pathEraser,
    TResult? Function(String name, double strokeWidth)? layer,
    TResult? Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name)? waypoint,
    TResult? Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(String name, PackAssetLocation component)? stamp,
    TResult? Function(String name)? presentation,
  }) {
    return presentation?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name)? hand,
    TResult Function(String name, List<PadElement> elements, List<Area> areas)?
        import,
    TResult Function(String name)? undo,
    TResult Function(String name)? redo,
    TResult Function(String name, LabelMode mode, bool zoomDependent,
            int foreground, PackAssetLocation styleSheet)?
        label,
    TResult Function(String name, bool zoomDependent, PenProperty property)?
        pen,
    TResult Function(String name, double strokeWidth)? eraser,
    TResult Function(String name, double strokeWidth)? pathEraser,
    TResult Function(String name, double strokeWidth)? layer,
    TResult Function(
            String name,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name)? waypoint,
    TResult Function(String name, double duration, double strokeWidth,
            double thinning, int color)?
        laser,
    TResult Function(
            String name,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(String name, PackAssetLocation component)? stamp,
    TResult Function(String name)? presentation,
    required TResult orElse(),
  }) {
    if (presentation != null) {
      return presentation(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HandPainter value) hand,
    required TResult Function(ImportPainter value) import,
    required TResult Function(UndoPainter value) undo,
    required TResult Function(RedoPainter value) redo,
    required TResult Function(LabelPainter value) label,
    required TResult Function(PenPainter value) pen,
    required TResult Function(EraserPainter value) eraser,
    required TResult Function(PathEraserPainter value) pathEraser,
    required TResult Function(LayerPainter value) layer,
    required TResult Function(AreaPainter value) area,
    required TResult Function(WaypointPainter value) waypoint,
    required TResult Function(LaserPainter value) laser,
    required TResult Function(ShapePainter value) shape,
    required TResult Function(StampPainter value) stamp,
    required TResult Function(PresentationPainter value) presentation,
  }) {
    return presentation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HandPainter value)? hand,
    TResult? Function(ImportPainter value)? import,
    TResult? Function(UndoPainter value)? undo,
    TResult? Function(RedoPainter value)? redo,
    TResult? Function(LabelPainter value)? label,
    TResult? Function(PenPainter value)? pen,
    TResult? Function(EraserPainter value)? eraser,
    TResult? Function(PathEraserPainter value)? pathEraser,
    TResult? Function(LayerPainter value)? layer,
    TResult? Function(AreaPainter value)? area,
    TResult? Function(WaypointPainter value)? waypoint,
    TResult? Function(LaserPainter value)? laser,
    TResult? Function(ShapePainter value)? shape,
    TResult? Function(StampPainter value)? stamp,
    TResult? Function(PresentationPainter value)? presentation,
  }) {
    return presentation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HandPainter value)? hand,
    TResult Function(ImportPainter value)? import,
    TResult Function(UndoPainter value)? undo,
    TResult Function(RedoPainter value)? redo,
    TResult Function(LabelPainter value)? label,
    TResult Function(PenPainter value)? pen,
    TResult Function(EraserPainter value)? eraser,
    TResult Function(PathEraserPainter value)? pathEraser,
    TResult Function(LayerPainter value)? layer,
    TResult Function(AreaPainter value)? area,
    TResult Function(WaypointPainter value)? waypoint,
    TResult Function(LaserPainter value)? laser,
    TResult Function(ShapePainter value)? shape,
    TResult Function(StampPainter value)? stamp,
    TResult Function(PresentationPainter value)? presentation,
    required TResult orElse(),
  }) {
    if (presentation != null) {
      return presentation(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PresentationPainterToJson(
      this,
    );
  }
}

abstract class PresentationPainter implements Painter {
  factory PresentationPainter({final String name}) = _$PresentationPainter;

  factory PresentationPainter.fromJson(Map<String, dynamic> json) =
      _$PresentationPainter.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$PresentationPainterCopyWith<_$PresentationPainter> get copyWith =>
      throw _privateConstructorUsedError;
}
