// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Tool _$ToolFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'select':
      return SelectTool.fromJson(json);
    case 'hand':
      return HandTool.fromJson(json);
    case 'import':
      return ImportTool.fromJson(json);
    case 'undo':
      return UndoTool.fromJson(json);
    case 'redo':
      return RedoTool.fromJson(json);
    case 'label':
      return LabelTool.fromJson(json);
    case 'pen':
      return PenTool.fromJson(json);
    case 'eraser':
      return EraserTool.fromJson(json);
    case 'pathEraser':
      return PathEraserTool.fromJson(json);
    case 'layer':
      return LayerTool.fromJson(json);
    case 'area':
      return AreaTool.fromJson(json);
    case 'laser':
      return LaserTool.fromJson(json);
    case 'shape':
      return ShapeTool.fromJson(json);
    case 'stamp':
      return StampTool.fromJson(json);
    case 'presentation':
      return PresentationTool.fromJson(json);
    case 'spacer':
      return SpacerTool.fromJson(json);
    case 'fullSceen':
      return FullScreenTool.fromJson(json);
    case 'asset':
      return AssetTool.fromJson(json);
    case 'texture':
      return TextureTool.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'Tool', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$Tool {
  String get name => throw _privateConstructorUsedError;
  String get displayIcon => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ToolCopyWith<Tool> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToolCopyWith<$Res> {
  factory $ToolCopyWith(Tool value, $Res Function(Tool) then) =
      _$ToolCopyWithImpl<$Res, Tool>;
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class _$ToolCopyWithImpl<$Res, $Val extends Tool>
    implements $ToolCopyWith<$Res> {
  _$ToolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SelectToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$SelectToolCopyWith(
          _$SelectTool value, $Res Function(_$SelectTool) then) =
      __$$SelectToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class __$$SelectToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$SelectTool>
    implements _$$SelectToolCopyWith<$Res> {
  __$$SelectToolCopyWithImpl(
      _$SelectTool _value, $Res Function(_$SelectTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_$SelectTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SelectTool extends SelectTool {
  _$SelectTool({this.name = '', this.displayIcon = '', final String? $type})
      : $type = $type ?? 'select',
        super._();

  factory _$SelectTool.fromJson(Map<String, dynamic> json) =>
      _$$SelectToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.select(name: $name, displayIcon: $displayIcon)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SelectToolCopyWith<_$SelectTool> get copyWith =>
      __$$SelectToolCopyWithImpl<_$SelectTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return select(name, displayIcon);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return select?.call(name, displayIcon);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(name, displayIcon);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return select(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return select?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (select != null) {
      return select(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SelectToolToJson(
      this,
    );
  }
}

abstract class SelectTool extends Tool {
  factory SelectTool({final String name, final String displayIcon}) =
      _$SelectTool;
  SelectTool._() : super._();

  factory SelectTool.fromJson(Map<String, dynamic> json) =
      _$SelectTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  @override
  @JsonKey(ignore: true)
  _$$SelectToolCopyWith<_$SelectTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$HandToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$HandToolCopyWith(
          _$HandTool value, $Res Function(_$HandTool) then) =
      __$$HandToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class __$$HandToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$HandTool>
    implements _$$HandToolCopyWith<$Res> {
  __$$HandToolCopyWithImpl(_$HandTool _value, $Res Function(_$HandTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_$HandTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HandTool extends HandTool {
  _$HandTool({this.name = '', this.displayIcon = '', final String? $type})
      : $type = $type ?? 'hand',
        super._();

  factory _$HandTool.fromJson(Map<String, dynamic> json) =>
      _$$HandToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.hand(name: $name, displayIcon: $displayIcon)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HandToolCopyWith<_$HandTool> get copyWith =>
      __$$HandToolCopyWithImpl<_$HandTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return hand(name, displayIcon);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return hand?.call(name, displayIcon);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (hand != null) {
      return hand(name, displayIcon);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return hand(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return hand?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (hand != null) {
      return hand(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$HandToolToJson(
      this,
    );
  }
}

abstract class HandTool extends Tool {
  factory HandTool({final String name, final String displayIcon}) = _$HandTool;
  HandTool._() : super._();

  factory HandTool.fromJson(Map<String, dynamic> json) = _$HandTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  @override
  @JsonKey(ignore: true)
  _$$HandToolCopyWith<_$HandTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ImportToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$ImportToolCopyWith(
          _$ImportTool value, $Res Function(_$ImportTool) then) =
      __$$ImportToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      List<PadElement> elements,
      List<Area> areas});
}

/// @nodoc
class __$$ImportToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$ImportTool>
    implements _$$ImportToolCopyWith<$Res> {
  __$$ImportToolCopyWithImpl(
      _$ImportTool _value, $Res Function(_$ImportTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? elements = null,
    Object? areas = null,
  }) {
    return _then(_$ImportTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
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
class _$ImportTool extends ImportTool {
  _$ImportTool(
      {this.name = '',
      this.displayIcon = '',
      required final List<PadElement> elements,
      required final List<Area> areas,
      final String? $type})
      : _elements = elements,
        _areas = areas,
        $type = $type ?? 'import',
        super._();

  factory _$ImportTool.fromJson(Map<String, dynamic> json) =>
      _$$ImportToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
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
    return 'Tool.import(name: $name, displayIcon: $displayIcon, elements: $elements, areas: $areas)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImportToolCopyWith<_$ImportTool> get copyWith =>
      __$$ImportToolCopyWithImpl<_$ImportTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return import(name, displayIcon, elements, areas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return import?.call(name, displayIcon, elements, areas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (import != null) {
      return import(name, displayIcon, elements, areas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return import(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return import?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (import != null) {
      return import(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ImportToolToJson(
      this,
    );
  }
}

abstract class ImportTool extends Tool {
  factory ImportTool(
      {final String name,
      final String displayIcon,
      required final List<PadElement> elements,
      required final List<Area> areas}) = _$ImportTool;
  ImportTool._() : super._();

  factory ImportTool.fromJson(Map<String, dynamic> json) =
      _$ImportTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  List<PadElement> get elements;
  List<Area> get areas;
  @override
  @JsonKey(ignore: true)
  _$$ImportToolCopyWith<_$ImportTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UndoToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$UndoToolCopyWith(
          _$UndoTool value, $Res Function(_$UndoTool) then) =
      __$$UndoToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class __$$UndoToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$UndoTool>
    implements _$$UndoToolCopyWith<$Res> {
  __$$UndoToolCopyWithImpl(_$UndoTool _value, $Res Function(_$UndoTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_$UndoTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UndoTool extends UndoTool {
  _$UndoTool({this.name = '', this.displayIcon = '', final String? $type})
      : $type = $type ?? 'undo',
        super._();

  factory _$UndoTool.fromJson(Map<String, dynamic> json) =>
      _$$UndoToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.undo(name: $name, displayIcon: $displayIcon)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UndoToolCopyWith<_$UndoTool> get copyWith =>
      __$$UndoToolCopyWithImpl<_$UndoTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return undo(name, displayIcon);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return undo?.call(name, displayIcon);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (undo != null) {
      return undo(name, displayIcon);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return undo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return undo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (undo != null) {
      return undo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UndoToolToJson(
      this,
    );
  }
}

abstract class UndoTool extends Tool {
  factory UndoTool({final String name, final String displayIcon}) = _$UndoTool;
  UndoTool._() : super._();

  factory UndoTool.fromJson(Map<String, dynamic> json) = _$UndoTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  @override
  @JsonKey(ignore: true)
  _$$UndoToolCopyWith<_$UndoTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RedoToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$RedoToolCopyWith(
          _$RedoTool value, $Res Function(_$RedoTool) then) =
      __$$RedoToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class __$$RedoToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$RedoTool>
    implements _$$RedoToolCopyWith<$Res> {
  __$$RedoToolCopyWithImpl(_$RedoTool _value, $Res Function(_$RedoTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_$RedoTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RedoTool extends RedoTool {
  _$RedoTool({this.name = '', this.displayIcon = '', final String? $type})
      : $type = $type ?? 'redo',
        super._();

  factory _$RedoTool.fromJson(Map<String, dynamic> json) =>
      _$$RedoToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.redo(name: $name, displayIcon: $displayIcon)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RedoToolCopyWith<_$RedoTool> get copyWith =>
      __$$RedoToolCopyWithImpl<_$RedoTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return redo(name, displayIcon);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return redo?.call(name, displayIcon);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (redo != null) {
      return redo(name, displayIcon);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return redo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return redo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (redo != null) {
      return redo(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RedoToolToJson(
      this,
    );
  }
}

abstract class RedoTool extends Tool {
  factory RedoTool({final String name, final String displayIcon}) = _$RedoTool;
  RedoTool._() : super._();

  factory RedoTool.fromJson(Map<String, dynamic> json) = _$RedoTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  @override
  @JsonKey(ignore: true)
  _$$RedoToolCopyWith<_$RedoTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LabelToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$LabelToolCopyWith(
          _$LabelTool value, $Res Function(_$LabelTool) then) =
      __$$LabelToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      LabelMode mode,
      bool zoomDependent,
      int foreground,
      PackAssetLocation styleSheet,
      double scale});

  $PackAssetLocationCopyWith<$Res> get styleSheet;
}

/// @nodoc
class __$$LabelToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$LabelTool>
    implements _$$LabelToolCopyWith<$Res> {
  __$$LabelToolCopyWithImpl(
      _$LabelTool _value, $Res Function(_$LabelTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? mode = null,
    Object? zoomDependent = null,
    Object? foreground = null,
    Object? styleSheet = null,
    Object? scale = null,
  }) {
    return _then(_$LabelTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
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
      scale: null == scale
          ? _value.scale
          : scale // ignore: cast_nullable_to_non_nullable
              as double,
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
class _$LabelTool extends LabelTool {
  _$LabelTool(
      {this.name = '',
      this.displayIcon = '',
      this.mode = LabelMode.text,
      this.zoomDependent = true,
      this.foreground = kColorBlack,
      this.styleSheet = const PackAssetLocation(),
      this.scale = 1.0,
      final String? $type})
      : $type = $type ?? 'label',
        super._();

  factory _$LabelTool.fromJson(Map<String, dynamic> json) =>
      _$$LabelToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
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
  @override
  @JsonKey()
  final double scale;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.label(name: $name, displayIcon: $displayIcon, mode: $mode, zoomDependent: $zoomDependent, foreground: $foreground, styleSheet: $styleSheet, scale: $scale)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LabelToolCopyWith<_$LabelTool> get copyWith =>
      __$$LabelToolCopyWithImpl<_$LabelTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return label(
        name, displayIcon, mode, zoomDependent, foreground, styleSheet, scale);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return label?.call(
        name, displayIcon, mode, zoomDependent, foreground, styleSheet, scale);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (label != null) {
      return label(name, displayIcon, mode, zoomDependent, foreground,
          styleSheet, scale);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return label(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return label?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (label != null) {
      return label(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LabelToolToJson(
      this,
    );
  }
}

abstract class LabelTool extends Tool {
  factory LabelTool(
      {final String name,
      final String displayIcon,
      final LabelMode mode,
      final bool zoomDependent,
      final int foreground,
      final PackAssetLocation styleSheet,
      final double scale}) = _$LabelTool;
  LabelTool._() : super._();

  factory LabelTool.fromJson(Map<String, dynamic> json) = _$LabelTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  LabelMode get mode;
  bool get zoomDependent;
  int get foreground;
  PackAssetLocation get styleSheet;
  double get scale;
  @override
  @JsonKey(ignore: true)
  _$$LabelToolCopyWith<_$LabelTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PenToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$PenToolCopyWith(_$PenTool value, $Res Function(_$PenTool) then) =
      __$$PenToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      bool zoomDependent,
      PenProperty property});
}

/// @nodoc
class __$$PenToolCopyWithImpl<$Res> extends _$ToolCopyWithImpl<$Res, _$PenTool>
    implements _$$PenToolCopyWith<$Res> {
  __$$PenToolCopyWithImpl(_$PenTool _value, $Res Function(_$PenTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? zoomDependent = null,
    Object? property = freezed,
  }) {
    return _then(_$PenTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
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
class _$PenTool extends PenTool {
  _$PenTool(
      {this.name = '',
      this.displayIcon = '',
      this.zoomDependent = true,
      this.property = const PenProperty(),
      final String? $type})
      : $type = $type ?? 'pen',
        super._();

  factory _$PenTool.fromJson(Map<String, dynamic> json) =>
      _$$PenToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
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
    return 'Tool.pen(name: $name, displayIcon: $displayIcon, zoomDependent: $zoomDependent, property: $property)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PenToolCopyWith<_$PenTool> get copyWith =>
      __$$PenToolCopyWithImpl<_$PenTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return pen(name, displayIcon, zoomDependent, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return pen?.call(name, displayIcon, zoomDependent, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(name, displayIcon, zoomDependent, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return pen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return pen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (pen != null) {
      return pen(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PenToolToJson(
      this,
    );
  }
}

abstract class PenTool extends Tool {
  factory PenTool(
      {final String name,
      final String displayIcon,
      final bool zoomDependent,
      final PenProperty property}) = _$PenTool;
  PenTool._() : super._();

  factory PenTool.fromJson(Map<String, dynamic> json) = _$PenTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  bool get zoomDependent;
  PenProperty get property;
  @override
  @JsonKey(ignore: true)
  _$$PenToolCopyWith<_$PenTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EraserToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$EraserToolCopyWith(
          _$EraserTool value, $Res Function(_$EraserTool) then) =
      __$$EraserToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon, double strokeWidth});
}

/// @nodoc
class __$$EraserToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$EraserTool>
    implements _$$EraserToolCopyWith<$Res> {
  __$$EraserToolCopyWithImpl(
      _$EraserTool _value, $Res Function(_$EraserTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? strokeWidth = null,
  }) {
    return _then(_$EraserTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
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
class _$EraserTool extends EraserTool {
  _$EraserTool(
      {this.name = '',
      this.displayIcon = '',
      this.strokeWidth = 5,
      final String? $type})
      : $type = $type ?? 'eraser',
        super._();

  factory _$EraserTool.fromJson(Map<String, dynamic> json) =>
      _$$EraserToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final double strokeWidth;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.eraser(name: $name, displayIcon: $displayIcon, strokeWidth: $strokeWidth)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EraserToolCopyWith<_$EraserTool> get copyWith =>
      __$$EraserToolCopyWithImpl<_$EraserTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return eraser(name, displayIcon, strokeWidth);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return eraser?.call(name, displayIcon, strokeWidth);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (eraser != null) {
      return eraser(name, displayIcon, strokeWidth);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return eraser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return eraser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (eraser != null) {
      return eraser(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EraserToolToJson(
      this,
    );
  }
}

abstract class EraserTool extends Tool {
  factory EraserTool(
      {final String name,
      final String displayIcon,
      final double strokeWidth}) = _$EraserTool;
  EraserTool._() : super._();

  factory EraserTool.fromJson(Map<String, dynamic> json) =
      _$EraserTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  double get strokeWidth;
  @override
  @JsonKey(ignore: true)
  _$$EraserToolCopyWith<_$EraserTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PathEraserToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$PathEraserToolCopyWith(
          _$PathEraserTool value, $Res Function(_$PathEraserTool) then) =
      __$$PathEraserToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon, double strokeWidth});
}

/// @nodoc
class __$$PathEraserToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$PathEraserTool>
    implements _$$PathEraserToolCopyWith<$Res> {
  __$$PathEraserToolCopyWithImpl(
      _$PathEraserTool _value, $Res Function(_$PathEraserTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? strokeWidth = null,
  }) {
    return _then(_$PathEraserTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
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
class _$PathEraserTool extends PathEraserTool {
  _$PathEraserTool(
      {this.name = '',
      this.displayIcon = '',
      this.strokeWidth = 5,
      final String? $type})
      : $type = $type ?? 'pathEraser',
        super._();

  factory _$PathEraserTool.fromJson(Map<String, dynamic> json) =>
      _$$PathEraserToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final double strokeWidth;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.pathEraser(name: $name, displayIcon: $displayIcon, strokeWidth: $strokeWidth)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PathEraserToolCopyWith<_$PathEraserTool> get copyWith =>
      __$$PathEraserToolCopyWithImpl<_$PathEraserTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return pathEraser(name, displayIcon, strokeWidth);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return pathEraser?.call(name, displayIcon, strokeWidth);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (pathEraser != null) {
      return pathEraser(name, displayIcon, strokeWidth);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return pathEraser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return pathEraser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (pathEraser != null) {
      return pathEraser(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PathEraserToolToJson(
      this,
    );
  }
}

abstract class PathEraserTool extends Tool {
  factory PathEraserTool(
      {final String name,
      final String displayIcon,
      final double strokeWidth}) = _$PathEraserTool;
  PathEraserTool._() : super._();

  factory PathEraserTool.fromJson(Map<String, dynamic> json) =
      _$PathEraserTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  double get strokeWidth;
  @override
  @JsonKey(ignore: true)
  _$$PathEraserToolCopyWith<_$PathEraserTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LayerToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$LayerToolCopyWith(
          _$LayerTool value, $Res Function(_$LayerTool) then) =
      __$$LayerToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon, double strokeWidth});
}

/// @nodoc
class __$$LayerToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$LayerTool>
    implements _$$LayerToolCopyWith<$Res> {
  __$$LayerToolCopyWithImpl(
      _$LayerTool _value, $Res Function(_$LayerTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? strokeWidth = null,
  }) {
    return _then(_$LayerTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
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
class _$LayerTool extends LayerTool {
  _$LayerTool(
      {this.name = '',
      this.displayIcon = '',
      this.strokeWidth = 5,
      final String? $type})
      : $type = $type ?? 'layer',
        super._();

  factory _$LayerTool.fromJson(Map<String, dynamic> json) =>
      _$$LayerToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final double strokeWidth;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.layer(name: $name, displayIcon: $displayIcon, strokeWidth: $strokeWidth)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LayerToolCopyWith<_$LayerTool> get copyWith =>
      __$$LayerToolCopyWithImpl<_$LayerTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return layer(name, displayIcon, strokeWidth);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return layer?.call(name, displayIcon, strokeWidth);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (layer != null) {
      return layer(name, displayIcon, strokeWidth);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return layer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return layer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (layer != null) {
      return layer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LayerToolToJson(
      this,
    );
  }
}

abstract class LayerTool extends Tool {
  factory LayerTool(
      {final String name,
      final String displayIcon,
      final double strokeWidth}) = _$LayerTool;
  LayerTool._() : super._();

  factory LayerTool.fromJson(Map<String, dynamic> json) = _$LayerTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  double get strokeWidth;
  @override
  @JsonKey(ignore: true)
  _$$LayerToolCopyWith<_$LayerTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AreaToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$AreaToolCopyWith(
          _$AreaTool value, $Res Function(_$AreaTool) then) =
      __$$AreaToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      double constrainedWidth,
      double constrainedHeight,
      double constrainedAspectRatio,
      bool askForName});
}

/// @nodoc
class __$$AreaToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$AreaTool>
    implements _$$AreaToolCopyWith<$Res> {
  __$$AreaToolCopyWithImpl(_$AreaTool _value, $Res Function(_$AreaTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? constrainedWidth = null,
    Object? constrainedHeight = null,
    Object? constrainedAspectRatio = null,
    Object? askForName = null,
  }) {
    return _then(_$AreaTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
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
class _$AreaTool extends AreaTool {
  _$AreaTool(
      {this.name = '',
      this.displayIcon = '',
      this.constrainedWidth = 0,
      this.constrainedHeight = 0,
      this.constrainedAspectRatio = 0,
      this.askForName = false,
      final String? $type})
      : $type = $type ?? 'area',
        super._();

  factory _$AreaTool.fromJson(Map<String, dynamic> json) =>
      _$$AreaToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
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
    return 'Tool.area(name: $name, displayIcon: $displayIcon, constrainedWidth: $constrainedWidth, constrainedHeight: $constrainedHeight, constrainedAspectRatio: $constrainedAspectRatio, askForName: $askForName)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaToolCopyWith<_$AreaTool> get copyWith =>
      __$$AreaToolCopyWithImpl<_$AreaTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return area(name, displayIcon, constrainedWidth, constrainedHeight,
        constrainedAspectRatio, askForName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return area?.call(name, displayIcon, constrainedWidth, constrainedHeight,
        constrainedAspectRatio, askForName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (area != null) {
      return area(name, displayIcon, constrainedWidth, constrainedHeight,
          constrainedAspectRatio, askForName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return area(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return area?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (area != null) {
      return area(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaToolToJson(
      this,
    );
  }
}

abstract class AreaTool extends Tool {
  factory AreaTool(
      {final String name,
      final String displayIcon,
      final double constrainedWidth,
      final double constrainedHeight,
      final double constrainedAspectRatio,
      final bool askForName}) = _$AreaTool;
  AreaTool._() : super._();

  factory AreaTool.fromJson(Map<String, dynamic> json) = _$AreaTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  double get constrainedWidth;
  double get constrainedHeight;
  double get constrainedAspectRatio;
  bool get askForName;
  @override
  @JsonKey(ignore: true)
  _$$AreaToolCopyWith<_$AreaTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LaserToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$LaserToolCopyWith(
          _$LaserTool value, $Res Function(_$LaserTool) then) =
      __$$LaserToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      double duration,
      double strokeWidth,
      double thinning,
      int color});
}

/// @nodoc
class __$$LaserToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$LaserTool>
    implements _$$LaserToolCopyWith<$Res> {
  __$$LaserToolCopyWithImpl(
      _$LaserTool _value, $Res Function(_$LaserTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? duration = null,
    Object? strokeWidth = null,
    Object? thinning = null,
    Object? color = null,
  }) {
    return _then(_$LaserTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
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
class _$LaserTool extends LaserTool {
  _$LaserTool(
      {this.name = '',
      this.displayIcon = '',
      this.duration = 5,
      this.strokeWidth = 5,
      this.thinning = 0.4,
      this.color = kColorRed,
      final String? $type})
      : $type = $type ?? 'laser',
        super._();

  factory _$LaserTool.fromJson(Map<String, dynamic> json) =>
      _$$LaserToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
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
    return 'Tool.laser(name: $name, displayIcon: $displayIcon, duration: $duration, strokeWidth: $strokeWidth, thinning: $thinning, color: $color)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LaserToolCopyWith<_$LaserTool> get copyWith =>
      __$$LaserToolCopyWithImpl<_$LaserTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return laser(name, displayIcon, duration, strokeWidth, thinning, color);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return laser?.call(
        name, displayIcon, duration, strokeWidth, thinning, color);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (laser != null) {
      return laser(name, displayIcon, duration, strokeWidth, thinning, color);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return laser(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return laser?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (laser != null) {
      return laser(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LaserToolToJson(
      this,
    );
  }
}

abstract class LaserTool extends Tool {
  factory LaserTool(
      {final String name,
      final String displayIcon,
      final double duration,
      final double strokeWidth,
      final double thinning,
      final int color}) = _$LaserTool;
  LaserTool._() : super._();

  factory LaserTool.fromJson(Map<String, dynamic> json) = _$LaserTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  double get duration;
  double get strokeWidth;
  double get thinning;
  int get color;
  @override
  @JsonKey(ignore: true)
  _$$LaserToolCopyWith<_$LaserTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShapeToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$ShapeToolCopyWith(
          _$ShapeTool value, $Res Function(_$ShapeTool) then) =
      __$$ShapeToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      bool zoomDependent,
      double constrainedWidth,
      double constrainedHeight,
      double constrainedAspectRatio,
      ShapeProperty property});
}

/// @nodoc
class __$$ShapeToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$ShapeTool>
    implements _$$ShapeToolCopyWith<$Res> {
  __$$ShapeToolCopyWithImpl(
      _$ShapeTool _value, $Res Function(_$ShapeTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? zoomDependent = null,
    Object? constrainedWidth = null,
    Object? constrainedHeight = null,
    Object? constrainedAspectRatio = null,
    Object? property = freezed,
  }) {
    return _then(_$ShapeTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
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
class _$ShapeTool extends ShapeTool {
  _$ShapeTool(
      {this.name = '',
      this.displayIcon = '',
      this.zoomDependent = true,
      this.constrainedWidth = 0,
      this.constrainedHeight = 0,
      this.constrainedAspectRatio = 0,
      this.property = const ShapeProperty(shape: RectangleShape()),
      final String? $type})
      : $type = $type ?? 'shape',
        super._();

  factory _$ShapeTool.fromJson(Map<String, dynamic> json) =>
      _$$ShapeToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
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
    return 'Tool.shape(name: $name, displayIcon: $displayIcon, zoomDependent: $zoomDependent, constrainedWidth: $constrainedWidth, constrainedHeight: $constrainedHeight, constrainedAspectRatio: $constrainedAspectRatio, property: $property)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShapeToolCopyWith<_$ShapeTool> get copyWith =>
      __$$ShapeToolCopyWithImpl<_$ShapeTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return shape(name, displayIcon, zoomDependent, constrainedWidth,
        constrainedHeight, constrainedAspectRatio, property);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return shape?.call(name, displayIcon, zoomDependent, constrainedWidth,
        constrainedHeight, constrainedAspectRatio, property);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (shape != null) {
      return shape(name, displayIcon, zoomDependent, constrainedWidth,
          constrainedHeight, constrainedAspectRatio, property);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return shape(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return shape?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (shape != null) {
      return shape(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ShapeToolToJson(
      this,
    );
  }
}

abstract class ShapeTool extends Tool {
  factory ShapeTool(
      {final String name,
      final String displayIcon,
      final bool zoomDependent,
      final double constrainedWidth,
      final double constrainedHeight,
      final double constrainedAspectRatio,
      final ShapeProperty property}) = _$ShapeTool;
  ShapeTool._() : super._();

  factory ShapeTool.fromJson(Map<String, dynamic> json) = _$ShapeTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  bool get zoomDependent;
  double get constrainedWidth;
  double get constrainedHeight;
  double get constrainedAspectRatio;
  ShapeProperty get property;
  @override
  @JsonKey(ignore: true)
  _$$ShapeToolCopyWith<_$ShapeTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StampToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$StampToolCopyWith(
          _$StampTool value, $Res Function(_$StampTool) then) =
      __$$StampToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon, PackAssetLocation component});

  $PackAssetLocationCopyWith<$Res> get component;
}

/// @nodoc
class __$$StampToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$StampTool>
    implements _$$StampToolCopyWith<$Res> {
  __$$StampToolCopyWithImpl(
      _$StampTool _value, $Res Function(_$StampTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? component = null,
  }) {
    return _then(_$StampTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
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
class _$StampTool extends StampTool {
  _$StampTool(
      {this.name = '',
      this.displayIcon = '',
      this.component = const PackAssetLocation(),
      final String? $type})
      : $type = $type ?? 'stamp',
        super._();

  factory _$StampTool.fromJson(Map<String, dynamic> json) =>
      _$$StampToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final PackAssetLocation component;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.stamp(name: $name, displayIcon: $displayIcon, component: $component)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StampToolCopyWith<_$StampTool> get copyWith =>
      __$$StampToolCopyWithImpl<_$StampTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return stamp(name, displayIcon, component);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return stamp?.call(name, displayIcon, component);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (stamp != null) {
      return stamp(name, displayIcon, component);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return stamp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return stamp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (stamp != null) {
      return stamp(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$StampToolToJson(
      this,
    );
  }
}

abstract class StampTool extends Tool {
  factory StampTool(
      {final String name,
      final String displayIcon,
      final PackAssetLocation component}) = _$StampTool;
  StampTool._() : super._();

  factory StampTool.fromJson(Map<String, dynamic> json) = _$StampTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  PackAssetLocation get component;
  @override
  @JsonKey(ignore: true)
  _$$StampToolCopyWith<_$StampTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PresentationToolCopyWith<$Res>
    implements $ToolCopyWith<$Res> {
  factory _$$PresentationToolCopyWith(
          _$PresentationTool value, $Res Function(_$PresentationTool) then) =
      __$$PresentationToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class __$$PresentationToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$PresentationTool>
    implements _$$PresentationToolCopyWith<$Res> {
  __$$PresentationToolCopyWithImpl(
      _$PresentationTool _value, $Res Function(_$PresentationTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_$PresentationTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresentationTool extends PresentationTool {
  _$PresentationTool(
      {this.name = '', this.displayIcon = '', final String? $type})
      : $type = $type ?? 'presentation',
        super._();

  factory _$PresentationTool.fromJson(Map<String, dynamic> json) =>
      _$$PresentationToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.presentation(name: $name, displayIcon: $displayIcon)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentationToolCopyWith<_$PresentationTool> get copyWith =>
      __$$PresentationToolCopyWithImpl<_$PresentationTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return presentation(name, displayIcon);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return presentation?.call(name, displayIcon);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (presentation != null) {
      return presentation(name, displayIcon);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return presentation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return presentation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (presentation != null) {
      return presentation(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PresentationToolToJson(
      this,
    );
  }
}

abstract class PresentationTool extends Tool {
  factory PresentationTool({final String name, final String displayIcon}) =
      _$PresentationTool;
  PresentationTool._() : super._();

  factory PresentationTool.fromJson(Map<String, dynamic> json) =
      _$PresentationTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  @override
  @JsonKey(ignore: true)
  _$$PresentationToolCopyWith<_$PresentationTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SpacerToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$SpacerToolCopyWith(
          _$SpacerTool value, $Res Function(_$SpacerTool) then) =
      __$$SpacerToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon, Axis2D axis});
}

/// @nodoc
class __$$SpacerToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$SpacerTool>
    implements _$$SpacerToolCopyWith<$Res> {
  __$$SpacerToolCopyWithImpl(
      _$SpacerTool _value, $Res Function(_$SpacerTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? axis = null,
  }) {
    return _then(_$SpacerTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      axis: null == axis
          ? _value.axis
          : axis // ignore: cast_nullable_to_non_nullable
              as Axis2D,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpacerTool extends SpacerTool {
  _$SpacerTool(
      {this.name = '',
      this.displayIcon = '',
      this.axis = Axis2D.horizontal,
      final String? $type})
      : $type = $type ?? 'spacer',
        super._();

  factory _$SpacerTool.fromJson(Map<String, dynamic> json) =>
      _$$SpacerToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final Axis2D axis;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.spacer(name: $name, displayIcon: $displayIcon, axis: $axis)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SpacerToolCopyWith<_$SpacerTool> get copyWith =>
      __$$SpacerToolCopyWithImpl<_$SpacerTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return spacer(name, displayIcon, axis);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return spacer?.call(name, displayIcon, axis);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (spacer != null) {
      return spacer(name, displayIcon, axis);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return spacer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return spacer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (spacer != null) {
      return spacer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SpacerToolToJson(
      this,
    );
  }
}

abstract class SpacerTool extends Tool {
  factory SpacerTool(
      {final String name,
      final String displayIcon,
      final Axis2D axis}) = _$SpacerTool;
  SpacerTool._() : super._();

  factory SpacerTool.fromJson(Map<String, dynamic> json) =
      _$SpacerTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  Axis2D get axis;
  @override
  @JsonKey(ignore: true)
  _$$SpacerToolCopyWith<_$SpacerTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FullScreenToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$FullScreenToolCopyWith(
          _$FullScreenTool value, $Res Function(_$FullScreenTool) then) =
      __$$FullScreenToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon});
}

/// @nodoc
class __$$FullScreenToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$FullScreenTool>
    implements _$$FullScreenToolCopyWith<$Res> {
  __$$FullScreenToolCopyWithImpl(
      _$FullScreenTool _value, $Res Function(_$FullScreenTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
  }) {
    return _then(_$FullScreenTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FullScreenTool extends FullScreenTool {
  _$FullScreenTool({this.name = '', this.displayIcon = '', final String? $type})
      : $type = $type ?? 'fullSceen',
        super._();

  factory _$FullScreenTool.fromJson(Map<String, dynamic> json) =>
      _$$FullScreenToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.fullSceen(name: $name, displayIcon: $displayIcon)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FullScreenToolCopyWith<_$FullScreenTool> get copyWith =>
      __$$FullScreenToolCopyWithImpl<_$FullScreenTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return fullSceen(name, displayIcon);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return fullSceen?.call(name, displayIcon);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (fullSceen != null) {
      return fullSceen(name, displayIcon);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return fullSceen(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return fullSceen?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (fullSceen != null) {
      return fullSceen(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FullScreenToolToJson(
      this,
    );
  }
}

abstract class FullScreenTool extends Tool {
  factory FullScreenTool({final String name, final String displayIcon}) =
      _$FullScreenTool;
  FullScreenTool._() : super._();

  factory FullScreenTool.fromJson(Map<String, dynamic> json) =
      _$FullScreenTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  @override
  @JsonKey(ignore: true)
  _$$FullScreenToolCopyWith<_$FullScreenTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AssetToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$AssetToolCopyWith(
          _$AssetTool value, $Res Function(_$AssetTool) then) =
      __$$AssetToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String displayIcon, ImportType importType});
}

/// @nodoc
class __$$AssetToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$AssetTool>
    implements _$$AssetToolCopyWith<$Res> {
  __$$AssetToolCopyWithImpl(
      _$AssetTool _value, $Res Function(_$AssetTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? importType = null,
  }) {
    return _then(_$AssetTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
              as String,
      importType: null == importType
          ? _value.importType
          : importType // ignore: cast_nullable_to_non_nullable
              as ImportType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssetTool extends AssetTool {
  _$AssetTool(
      {this.name = '',
      this.displayIcon = '',
      this.importType = ImportType.document,
      final String? $type})
      : $type = $type ?? 'asset',
        super._();

  factory _$AssetTool.fromJson(Map<String, dynamic> json) =>
      _$$AssetToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
  @override
  @JsonKey()
  final ImportType importType;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.asset(name: $name, displayIcon: $displayIcon, importType: $importType)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetToolCopyWith<_$AssetTool> get copyWith =>
      __$$AssetToolCopyWithImpl<_$AssetTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return asset(name, displayIcon, importType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return asset?.call(name, displayIcon, importType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (asset != null) {
      return asset(name, displayIcon, importType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return asset(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return asset?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (asset != null) {
      return asset(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetToolToJson(
      this,
    );
  }
}

abstract class AssetTool extends Tool {
  factory AssetTool(
      {final String name,
      final String displayIcon,
      final ImportType importType}) = _$AssetTool;
  AssetTool._() : super._();

  factory AssetTool.fromJson(Map<String, dynamic> json) = _$AssetTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  ImportType get importType;
  @override
  @JsonKey(ignore: true)
  _$$AssetToolCopyWith<_$AssetTool> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TextureToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory _$$TextureToolCopyWith(
          _$TextureTool value, $Res Function(_$TextureTool) then) =
      __$$TextureToolCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String displayIcon,
      bool zoomDependent,
      double constrainedWidth,
      double constrainedHeight,
      double constrainedAspectRatio,
      SurfaceTexture texture});

  $SurfaceTextureCopyWith<$Res> get texture;
}

/// @nodoc
class __$$TextureToolCopyWithImpl<$Res>
    extends _$ToolCopyWithImpl<$Res, _$TextureTool>
    implements _$$TextureToolCopyWith<$Res> {
  __$$TextureToolCopyWithImpl(
      _$TextureTool _value, $Res Function(_$TextureTool) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? displayIcon = null,
    Object? zoomDependent = null,
    Object? constrainedWidth = null,
    Object? constrainedHeight = null,
    Object? constrainedAspectRatio = null,
    Object? texture = null,
  }) {
    return _then(_$TextureTool(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayIcon: null == displayIcon
          ? _value.displayIcon
          : displayIcon // ignore: cast_nullable_to_non_nullable
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
      texture: null == texture
          ? _value.texture
          : texture // ignore: cast_nullable_to_non_nullable
              as SurfaceTexture,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SurfaceTextureCopyWith<$Res> get texture {
    return $SurfaceTextureCopyWith<$Res>(_value.texture, (value) {
      return _then(_value.copyWith(texture: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$TextureTool extends TextureTool {
  _$TextureTool(
      {this.name = '',
      this.displayIcon = '',
      this.zoomDependent = true,
      this.constrainedWidth = 0,
      this.constrainedHeight = 0,
      this.constrainedAspectRatio = 0,
      this.texture = const SurfaceTexture.pattern(),
      final String? $type})
      : $type = $type ?? 'texture',
        super._();

  factory _$TextureTool.fromJson(Map<String, dynamic> json) =>
      _$$TextureToolFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String displayIcon;
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
  final SurfaceTexture texture;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Tool.texture(name: $name, displayIcon: $displayIcon, zoomDependent: $zoomDependent, constrainedWidth: $constrainedWidth, constrainedHeight: $constrainedHeight, constrainedAspectRatio: $constrainedAspectRatio, texture: $texture)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextureToolCopyWith<_$TextureTool> get copyWith =>
      __$$TextureToolCopyWithImpl<_$TextureTool>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String name, String displayIcon) select,
    required TResult Function(String name, String displayIcon) hand,
    required TResult Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)
        import,
    required TResult Function(String name, String displayIcon) undo,
    required TResult Function(String name, String displayIcon) redo,
    required TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)
        label,
    required TResult Function(String name, String displayIcon,
            bool zoomDependent, PenProperty property)
        pen,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        eraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        pathEraser,
    required TResult Function(
            String name, String displayIcon, double strokeWidth)
        layer,
    required TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)
        area,
    required TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)
        laser,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)
        shape,
    required TResult Function(
            String name, String displayIcon, PackAssetLocation component)
        stamp,
    required TResult Function(String name, String displayIcon) presentation,
    required TResult Function(String name, String displayIcon, Axis2D axis)
        spacer,
    required TResult Function(String name, String displayIcon) fullSceen,
    required TResult Function(
            String name, String displayIcon, ImportType importType)
        asset,
    required TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)
        texture,
  }) {
    return texture(name, displayIcon, zoomDependent, constrainedWidth,
        constrainedHeight, constrainedAspectRatio, this.texture);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String name, String displayIcon)? select,
    TResult? Function(String name, String displayIcon)? hand,
    TResult? Function(String name, String displayIcon,
            List<PadElement> elements, List<Area> areas)?
        import,
    TResult? Function(String name, String displayIcon)? undo,
    TResult? Function(String name, String displayIcon)? redo,
    TResult? Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult? Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult? Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult? Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult? Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult? Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult? Function(String name, String displayIcon)? presentation,
    TResult? Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult? Function(String name, String displayIcon)? fullSceen,
    TResult? Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult? Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
  }) {
    return texture?.call(name, displayIcon, zoomDependent, constrainedWidth,
        constrainedHeight, constrainedAspectRatio, this.texture);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String name, String displayIcon)? select,
    TResult Function(String name, String displayIcon)? hand,
    TResult Function(String name, String displayIcon, List<PadElement> elements,
            List<Area> areas)?
        import,
    TResult Function(String name, String displayIcon)? undo,
    TResult Function(String name, String displayIcon)? redo,
    TResult Function(
            String name,
            String displayIcon,
            LabelMode mode,
            bool zoomDependent,
            int foreground,
            PackAssetLocation styleSheet,
            double scale)?
        label,
    TResult Function(String name, String displayIcon, bool zoomDependent,
            PenProperty property)?
        pen,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        eraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        pathEraser,
    TResult Function(String name, String displayIcon, double strokeWidth)?
        layer,
    TResult Function(
            String name,
            String displayIcon,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            bool askForName)?
        area,
    TResult Function(String name, String displayIcon, double duration,
            double strokeWidth, double thinning, int color)?
        laser,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            ShapeProperty property)?
        shape,
    TResult Function(
            String name, String displayIcon, PackAssetLocation component)?
        stamp,
    TResult Function(String name, String displayIcon)? presentation,
    TResult Function(String name, String displayIcon, Axis2D axis)? spacer,
    TResult Function(String name, String displayIcon)? fullSceen,
    TResult Function(String name, String displayIcon, ImportType importType)?
        asset,
    TResult Function(
            String name,
            String displayIcon,
            bool zoomDependent,
            double constrainedWidth,
            double constrainedHeight,
            double constrainedAspectRatio,
            SurfaceTexture texture)?
        texture,
    required TResult orElse(),
  }) {
    if (texture != null) {
      return texture(name, displayIcon, zoomDependent, constrainedWidth,
          constrainedHeight, constrainedAspectRatio, this.texture);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SelectTool value) select,
    required TResult Function(HandTool value) hand,
    required TResult Function(ImportTool value) import,
    required TResult Function(UndoTool value) undo,
    required TResult Function(RedoTool value) redo,
    required TResult Function(LabelTool value) label,
    required TResult Function(PenTool value) pen,
    required TResult Function(EraserTool value) eraser,
    required TResult Function(PathEraserTool value) pathEraser,
    required TResult Function(LayerTool value) layer,
    required TResult Function(AreaTool value) area,
    required TResult Function(LaserTool value) laser,
    required TResult Function(ShapeTool value) shape,
    required TResult Function(StampTool value) stamp,
    required TResult Function(PresentationTool value) presentation,
    required TResult Function(SpacerTool value) spacer,
    required TResult Function(FullScreenTool value) fullSceen,
    required TResult Function(AssetTool value) asset,
    required TResult Function(TextureTool value) texture,
  }) {
    return texture(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SelectTool value)? select,
    TResult? Function(HandTool value)? hand,
    TResult? Function(ImportTool value)? import,
    TResult? Function(UndoTool value)? undo,
    TResult? Function(RedoTool value)? redo,
    TResult? Function(LabelTool value)? label,
    TResult? Function(PenTool value)? pen,
    TResult? Function(EraserTool value)? eraser,
    TResult? Function(PathEraserTool value)? pathEraser,
    TResult? Function(LayerTool value)? layer,
    TResult? Function(AreaTool value)? area,
    TResult? Function(LaserTool value)? laser,
    TResult? Function(ShapeTool value)? shape,
    TResult? Function(StampTool value)? stamp,
    TResult? Function(PresentationTool value)? presentation,
    TResult? Function(SpacerTool value)? spacer,
    TResult? Function(FullScreenTool value)? fullSceen,
    TResult? Function(AssetTool value)? asset,
    TResult? Function(TextureTool value)? texture,
  }) {
    return texture?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SelectTool value)? select,
    TResult Function(HandTool value)? hand,
    TResult Function(ImportTool value)? import,
    TResult Function(UndoTool value)? undo,
    TResult Function(RedoTool value)? redo,
    TResult Function(LabelTool value)? label,
    TResult Function(PenTool value)? pen,
    TResult Function(EraserTool value)? eraser,
    TResult Function(PathEraserTool value)? pathEraser,
    TResult Function(LayerTool value)? layer,
    TResult Function(AreaTool value)? area,
    TResult Function(LaserTool value)? laser,
    TResult Function(ShapeTool value)? shape,
    TResult Function(StampTool value)? stamp,
    TResult Function(PresentationTool value)? presentation,
    TResult Function(SpacerTool value)? spacer,
    TResult Function(FullScreenTool value)? fullSceen,
    TResult Function(AssetTool value)? asset,
    TResult Function(TextureTool value)? texture,
    required TResult orElse(),
  }) {
    if (texture != null) {
      return texture(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TextureToolToJson(
      this,
    );
  }
}

abstract class TextureTool extends Tool {
  factory TextureTool(
      {final String name,
      final String displayIcon,
      final bool zoomDependent,
      final double constrainedWidth,
      final double constrainedHeight,
      final double constrainedAspectRatio,
      final SurfaceTexture texture}) = _$TextureTool;
  TextureTool._() : super._();

  factory TextureTool.fromJson(Map<String, dynamic> json) =
      _$TextureTool.fromJson;

  @override
  String get name;
  @override
  String get displayIcon;
  bool get zoomDependent;
  double get constrainedWidth;
  double get constrainedHeight;
  double get constrainedAspectRatio;
  SurfaceTexture get texture;
  @override
  @JsonKey(ignore: true)
  _$$TextureToolCopyWith<_$TextureTool> get copyWith =>
      throw _privateConstructorUsedError;
}
