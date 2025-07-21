// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Tool _$ToolFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'select':
          return SelectTool.fromJson(
            json
          );
                case 'hand':
          return HandTool.fromJson(
            json
          );
                case 'import':
          return ImportTool.fromJson(
            json
          );
                case 'undo':
          return UndoTool.fromJson(
            json
          );
                case 'redo':
          return RedoTool.fromJson(
            json
          );
                case 'label':
          return LabelTool.fromJson(
            json
          );
                case 'pen':
          return PenTool.fromJson(
            json
          );
                case 'eraser':
          return EraserTool.fromJson(
            json
          );
                case 'pathEraser':
          return PathEraserTool.fromJson(
            json
          );
                case 'collection':
          return CollectionTool.fromJson(
            json
          );
                case 'area':
          return AreaTool.fromJson(
            json
          );
                case 'laser':
          return LaserTool.fromJson(
            json
          );
                case 'shape':
          return ShapeTool.fromJson(
            json
          );
                case 'stamp':
          return StampTool.fromJson(
            json
          );
                case 'presentation':
          return PresentationTool.fromJson(
            json
          );
                case 'spacer':
          return SpacerTool.fromJson(
            json
          );
                case 'fullSceen':
          return FullScreenTool.fromJson(
            json
          );
                case 'asset':
          return AssetTool.fromJson(
            json
          );
                case 'export':
          return ExportTool.fromJson(
            json
          );
                case 'texture':
          return TextureTool.fromJson(
            json
          );
                case 'ruler':
          return RulerTool.fromJson(
            json
          );
                case 'grid':
          return GridTool.fromJson(
            json
          );
                case 'eyeDropper':
          return EyeDropperTool.fromJson(
            json
          );
                case 'barcode':
          return BarcodeTool.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'Tool',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$Tool {

 String get name; String get displayIcon;
/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolCopyWith<Tool> get copyWith => _$ToolCopyWithImpl<Tool>(this as Tool, _$identity);

  /// Serializes this Tool to a JSON map.
  Map<String, dynamic> toJson();




@override
String toString() {
  return 'Tool(name: $name, displayIcon: $displayIcon)';
}


}

/// @nodoc
abstract mixin class $ToolCopyWith<$Res>  {
  factory $ToolCopyWith(Tool value, $Res Function(Tool) _then) = _$ToolCopyWithImpl;
@useResult
$Res call({
 String name, String displayIcon
});




}
/// @nodoc
class _$ToolCopyWithImpl<$Res>
    implements $ToolCopyWith<$Res> {
  _$ToolCopyWithImpl(this._self, this._then);

  final Tool _self;
  final $Res Function(Tool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? displayIcon = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
@JsonSerializable()

class SelectTool extends Tool {
   SelectTool({this.name = '', this.displayIcon = '', this.mode = SelectMode.rectangle, final  String? $type}): $type = $type ?? 'select',super._();
  factory SelectTool.fromJson(Map<String, dynamic> json) => _$SelectToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  SelectMode mode;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectToolCopyWith<SelectTool> get copyWith => _$SelectToolCopyWithImpl<SelectTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectToolToJson(this, );
}



@override
String toString() {
  return 'Tool.select(name: $name, displayIcon: $displayIcon, mode: $mode)';
}


}

/// @nodoc
abstract mixin class $SelectToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $SelectToolCopyWith(SelectTool value, $Res Function(SelectTool) _then) = _$SelectToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, SelectMode mode
});




}
/// @nodoc
class _$SelectToolCopyWithImpl<$Res>
    implements $SelectToolCopyWith<$Res> {
  _$SelectToolCopyWithImpl(this._self, this._then);

  final SelectTool _self;
  final $Res Function(SelectTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? mode = null,}) {
  return _then(SelectTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as SelectMode,
  ));
}


}

/// @nodoc
@JsonSerializable()

class HandTool extends Tool {
   HandTool({this.name = '', this.displayIcon = '', final  String? $type}): $type = $type ?? 'hand',super._();
  factory HandTool.fromJson(Map<String, dynamic> json) => _$HandToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HandToolCopyWith<HandTool> get copyWith => _$HandToolCopyWithImpl<HandTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HandToolToJson(this, );
}



@override
String toString() {
  return 'Tool.hand(name: $name, displayIcon: $displayIcon)';
}


}

/// @nodoc
abstract mixin class $HandToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $HandToolCopyWith(HandTool value, $Res Function(HandTool) _then) = _$HandToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon
});




}
/// @nodoc
class _$HandToolCopyWithImpl<$Res>
    implements $HandToolCopyWith<$Res> {
  _$HandToolCopyWithImpl(this._self, this._then);

  final HandTool _self;
  final $Res Function(HandTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,}) {
  return _then(HandTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ImportTool extends Tool {
   ImportTool({this.name = '', this.displayIcon = '', required final  List<PadElement> elements, required final  List<Area> areas, final  String? $type}): _elements = elements,_areas = areas,$type = $type ?? 'import',super._();
  factory ImportTool.fromJson(Map<String, dynamic> json) => _$ImportToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
 final  List<PadElement> _elements;
 List<PadElement> get elements {
  if (_elements is EqualUnmodifiableListView) return _elements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_elements);
}

 final  List<Area> _areas;
 List<Area> get areas {
  if (_areas is EqualUnmodifiableListView) return _areas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_areas);
}


@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportToolCopyWith<ImportTool> get copyWith => _$ImportToolCopyWithImpl<ImportTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImportToolToJson(this, );
}



@override
String toString() {
  return 'Tool.import(name: $name, displayIcon: $displayIcon, elements: $elements, areas: $areas)';
}


}

/// @nodoc
abstract mixin class $ImportToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $ImportToolCopyWith(ImportTool value, $Res Function(ImportTool) _then) = _$ImportToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, List<PadElement> elements, List<Area> areas
});




}
/// @nodoc
class _$ImportToolCopyWithImpl<$Res>
    implements $ImportToolCopyWith<$Res> {
  _$ImportToolCopyWithImpl(this._self, this._then);

  final ImportTool _self;
  final $Res Function(ImportTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? elements = null,Object? areas = null,}) {
  return _then(ImportTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,elements: null == elements ? _self._elements : elements // ignore: cast_nullable_to_non_nullable
as List<PadElement>,areas: null == areas ? _self._areas : areas // ignore: cast_nullable_to_non_nullable
as List<Area>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class UndoTool extends Tool {
   UndoTool({this.name = '', this.displayIcon = '', final  String? $type}): $type = $type ?? 'undo',super._();
  factory UndoTool.fromJson(Map<String, dynamic> json) => _$UndoToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UndoToolCopyWith<UndoTool> get copyWith => _$UndoToolCopyWithImpl<UndoTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UndoToolToJson(this, );
}



@override
String toString() {
  return 'Tool.undo(name: $name, displayIcon: $displayIcon)';
}


}

/// @nodoc
abstract mixin class $UndoToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $UndoToolCopyWith(UndoTool value, $Res Function(UndoTool) _then) = _$UndoToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon
});




}
/// @nodoc
class _$UndoToolCopyWithImpl<$Res>
    implements $UndoToolCopyWith<$Res> {
  _$UndoToolCopyWithImpl(this._self, this._then);

  final UndoTool _self;
  final $Res Function(UndoTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,}) {
  return _then(UndoTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class RedoTool extends Tool {
   RedoTool({this.name = '', this.displayIcon = '', final  String? $type}): $type = $type ?? 'redo',super._();
  factory RedoTool.fromJson(Map<String, dynamic> json) => _$RedoToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RedoToolCopyWith<RedoTool> get copyWith => _$RedoToolCopyWithImpl<RedoTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RedoToolToJson(this, );
}



@override
String toString() {
  return 'Tool.redo(name: $name, displayIcon: $displayIcon)';
}


}

/// @nodoc
abstract mixin class $RedoToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $RedoToolCopyWith(RedoTool value, $Res Function(RedoTool) _then) = _$RedoToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon
});




}
/// @nodoc
class _$RedoToolCopyWithImpl<$Res>
    implements $RedoToolCopyWith<$Res> {
  _$RedoToolCopyWithImpl(this._self, this._then);

  final RedoTool _self;
  final $Res Function(RedoTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,}) {
  return _then(RedoTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LabelTool extends Tool {
   LabelTool({this.name = '', this.displayIcon = '', this.mode = LabelMode.text, this.zoomDependent = false, @ColorJsonConverter() this.foreground = SRGBColor.black, this.styleSheet = const PackAssetLocation(), this.scale = 2.0, final  String? $type}): $type = $type ?? 'label',super._();
  factory LabelTool.fromJson(Map<String, dynamic> json) => _$LabelToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  LabelMode mode;
@JsonKey() final  bool zoomDependent;
@JsonKey()@ColorJsonConverter() final  SRGBColor foreground;
@JsonKey() final  PackAssetLocation styleSheet;
@JsonKey() final  double scale;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabelToolCopyWith<LabelTool> get copyWith => _$LabelToolCopyWithImpl<LabelTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LabelToolToJson(this, );
}



@override
String toString() {
  return 'Tool.label(name: $name, displayIcon: $displayIcon, mode: $mode, zoomDependent: $zoomDependent, foreground: $foreground, styleSheet: $styleSheet, scale: $scale)';
}


}

/// @nodoc
abstract mixin class $LabelToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $LabelToolCopyWith(LabelTool value, $Res Function(LabelTool) _then) = _$LabelToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, LabelMode mode, bool zoomDependent,@ColorJsonConverter() SRGBColor foreground, PackAssetLocation styleSheet, double scale
});


$PackAssetLocationCopyWith<$Res> get styleSheet;

}
/// @nodoc
class _$LabelToolCopyWithImpl<$Res>
    implements $LabelToolCopyWith<$Res> {
  _$LabelToolCopyWithImpl(this._self, this._then);

  final LabelTool _self;
  final $Res Function(LabelTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? mode = null,Object? zoomDependent = null,Object? foreground = null,Object? styleSheet = null,Object? scale = null,}) {
  return _then(LabelTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as LabelMode,zoomDependent: null == zoomDependent ? _self.zoomDependent : zoomDependent // ignore: cast_nullable_to_non_nullable
as bool,foreground: null == foreground ? _self.foreground : foreground // ignore: cast_nullable_to_non_nullable
as SRGBColor,styleSheet: null == styleSheet ? _self.styleSheet : styleSheet // ignore: cast_nullable_to_non_nullable
as PackAssetLocation,scale: null == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PackAssetLocationCopyWith<$Res> get styleSheet {
  
  return $PackAssetLocationCopyWith<$Res>(_self.styleSheet, (value) {
    return _then(_self.copyWith(styleSheet: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class PenTool extends Tool {
   PenTool({this.name = '', this.displayIcon = '', this.zoomDependent = false, this.shapeDetectionTime = 0.5, this.shapeDetectionEnabled = false, this.property = const PenProperty(), final  String? $type}): $type = $type ?? 'pen',super._();
  factory PenTool.fromJson(Map<String, dynamic> json) => _$PenToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  bool zoomDependent;
@JsonKey() final  double shapeDetectionTime;
@JsonKey() final  bool shapeDetectionEnabled;
@JsonKey() final  PenProperty property;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PenToolCopyWith<PenTool> get copyWith => _$PenToolCopyWithImpl<PenTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PenToolToJson(this, );
}



@override
String toString() {
  return 'Tool.pen(name: $name, displayIcon: $displayIcon, zoomDependent: $zoomDependent, shapeDetectionTime: $shapeDetectionTime, shapeDetectionEnabled: $shapeDetectionEnabled, property: $property)';
}


}

/// @nodoc
abstract mixin class $PenToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $PenToolCopyWith(PenTool value, $Res Function(PenTool) _then) = _$PenToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, bool zoomDependent, double shapeDetectionTime, bool shapeDetectionEnabled, PenProperty property
});




}
/// @nodoc
class _$PenToolCopyWithImpl<$Res>
    implements $PenToolCopyWith<$Res> {
  _$PenToolCopyWithImpl(this._self, this._then);

  final PenTool _self;
  final $Res Function(PenTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? zoomDependent = null,Object? shapeDetectionTime = null,Object? shapeDetectionEnabled = null,Object? property = freezed,}) {
  return _then(PenTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,zoomDependent: null == zoomDependent ? _self.zoomDependent : zoomDependent // ignore: cast_nullable_to_non_nullable
as bool,shapeDetectionTime: null == shapeDetectionTime ? _self.shapeDetectionTime : shapeDetectionTime // ignore: cast_nullable_to_non_nullable
as double,shapeDetectionEnabled: null == shapeDetectionEnabled ? _self.shapeDetectionEnabled : shapeDetectionEnabled // ignore: cast_nullable_to_non_nullable
as bool,property: freezed == property ? _self.property : property // ignore: cast_nullable_to_non_nullable
as PenProperty,
  ));
}


}

/// @nodoc
@JsonSerializable()

class EraserTool extends Tool {
   EraserTool({this.name = '', this.displayIcon = '', this.strokeWidth = 5, this.eraseElements = false, final  String? $type}): $type = $type ?? 'eraser',super._();
  factory EraserTool.fromJson(Map<String, dynamic> json) => _$EraserToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  double strokeWidth;
@JsonKey() final  bool eraseElements;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EraserToolCopyWith<EraserTool> get copyWith => _$EraserToolCopyWithImpl<EraserTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EraserToolToJson(this, );
}



@override
String toString() {
  return 'Tool.eraser(name: $name, displayIcon: $displayIcon, strokeWidth: $strokeWidth, eraseElements: $eraseElements)';
}


}

/// @nodoc
abstract mixin class $EraserToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $EraserToolCopyWith(EraserTool value, $Res Function(EraserTool) _then) = _$EraserToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, double strokeWidth, bool eraseElements
});




}
/// @nodoc
class _$EraserToolCopyWithImpl<$Res>
    implements $EraserToolCopyWith<$Res> {
  _$EraserToolCopyWithImpl(this._self, this._then);

  final EraserTool _self;
  final $Res Function(EraserTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? strokeWidth = null,Object? eraseElements = null,}) {
  return _then(EraserTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,eraseElements: null == eraseElements ? _self.eraseElements : eraseElements // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PathEraserTool extends Tool {
   PathEraserTool({this.name = '', this.displayIcon = '', this.strokeWidth = 5, this.eraseElements = false, final  String? $type}): $type = $type ?? 'pathEraser',super._();
  factory PathEraserTool.fromJson(Map<String, dynamic> json) => _$PathEraserToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  double strokeWidth;
@JsonKey() final  bool eraseElements;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PathEraserToolCopyWith<PathEraserTool> get copyWith => _$PathEraserToolCopyWithImpl<PathEraserTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PathEraserToolToJson(this, );
}



@override
String toString() {
  return 'Tool.pathEraser(name: $name, displayIcon: $displayIcon, strokeWidth: $strokeWidth, eraseElements: $eraseElements)';
}


}

/// @nodoc
abstract mixin class $PathEraserToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $PathEraserToolCopyWith(PathEraserTool value, $Res Function(PathEraserTool) _then) = _$PathEraserToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, double strokeWidth, bool eraseElements
});




}
/// @nodoc
class _$PathEraserToolCopyWithImpl<$Res>
    implements $PathEraserToolCopyWith<$Res> {
  _$PathEraserToolCopyWithImpl(this._self, this._then);

  final PathEraserTool _self;
  final $Res Function(PathEraserTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? strokeWidth = null,Object? eraseElements = null,}) {
  return _then(PathEraserTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,eraseElements: null == eraseElements ? _self.eraseElements : eraseElements // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class CollectionTool extends Tool {
   CollectionTool({this.name = '', this.displayIcon = '', this.strokeWidth = 5, final  String? $type}): $type = $type ?? 'collection',super._();
  factory CollectionTool.fromJson(Map<String, dynamic> json) => _$CollectionToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  double strokeWidth;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionToolCopyWith<CollectionTool> get copyWith => _$CollectionToolCopyWithImpl<CollectionTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CollectionToolToJson(this, );
}



@override
String toString() {
  return 'Tool.collection(name: $name, displayIcon: $displayIcon, strokeWidth: $strokeWidth)';
}


}

/// @nodoc
abstract mixin class $CollectionToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $CollectionToolCopyWith(CollectionTool value, $Res Function(CollectionTool) _then) = _$CollectionToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, double strokeWidth
});




}
/// @nodoc
class _$CollectionToolCopyWithImpl<$Res>
    implements $CollectionToolCopyWith<$Res> {
  _$CollectionToolCopyWithImpl(this._self, this._then);

  final CollectionTool _self;
  final $Res Function(CollectionTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? strokeWidth = null,}) {
  return _then(CollectionTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AreaTool extends Tool {
   AreaTool({this.name = '', this.displayIcon = '', this.constrainedWidth = 0, this.constrainedHeight = 0, this.constrainedAspectRatio = 0, this.askForName = false, final  String? $type}): $type = $type ?? 'area',super._();
  factory AreaTool.fromJson(Map<String, dynamic> json) => _$AreaToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  double constrainedWidth;
@JsonKey() final  double constrainedHeight;
@JsonKey() final  double constrainedAspectRatio;
@JsonKey() final  bool askForName;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AreaToolCopyWith<AreaTool> get copyWith => _$AreaToolCopyWithImpl<AreaTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AreaToolToJson(this, );
}



@override
String toString() {
  return 'Tool.area(name: $name, displayIcon: $displayIcon, constrainedWidth: $constrainedWidth, constrainedHeight: $constrainedHeight, constrainedAspectRatio: $constrainedAspectRatio, askForName: $askForName)';
}


}

/// @nodoc
abstract mixin class $AreaToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $AreaToolCopyWith(AreaTool value, $Res Function(AreaTool) _then) = _$AreaToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, double constrainedWidth, double constrainedHeight, double constrainedAspectRatio, bool askForName
});




}
/// @nodoc
class _$AreaToolCopyWithImpl<$Res>
    implements $AreaToolCopyWith<$Res> {
  _$AreaToolCopyWithImpl(this._self, this._then);

  final AreaTool _self;
  final $Res Function(AreaTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? constrainedWidth = null,Object? constrainedHeight = null,Object? constrainedAspectRatio = null,Object? askForName = null,}) {
  return _then(AreaTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,constrainedWidth: null == constrainedWidth ? _self.constrainedWidth : constrainedWidth // ignore: cast_nullable_to_non_nullable
as double,constrainedHeight: null == constrainedHeight ? _self.constrainedHeight : constrainedHeight // ignore: cast_nullable_to_non_nullable
as double,constrainedAspectRatio: null == constrainedAspectRatio ? _self.constrainedAspectRatio : constrainedAspectRatio // ignore: cast_nullable_to_non_nullable
as double,askForName: null == askForName ? _self.askForName : askForName // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class LaserTool extends Tool {
   LaserTool({this.name = '', this.displayIcon = '', this.duration = 5, this.hideDuration = 0.5, this.strokeWidth = 5, this.thinning = 0.4, @ColorJsonConverter() this.color = BasicColors.red, this.animation = LaserAnimation.fade, final  String? $type}): $type = $type ?? 'laser',super._();
  factory LaserTool.fromJson(Map<String, dynamic> json) => _$LaserToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  double duration;
@JsonKey() final  double hideDuration;
@JsonKey() final  double strokeWidth;
@JsonKey() final  double thinning;
@JsonKey()@ColorJsonConverter() final  SRGBColor color;
@JsonKey() final  LaserAnimation animation;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LaserToolCopyWith<LaserTool> get copyWith => _$LaserToolCopyWithImpl<LaserTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LaserToolToJson(this, );
}



@override
String toString() {
  return 'Tool.laser(name: $name, displayIcon: $displayIcon, duration: $duration, hideDuration: $hideDuration, strokeWidth: $strokeWidth, thinning: $thinning, color: $color, animation: $animation)';
}


}

/// @nodoc
abstract mixin class $LaserToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $LaserToolCopyWith(LaserTool value, $Res Function(LaserTool) _then) = _$LaserToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, double duration, double hideDuration, double strokeWidth, double thinning,@ColorJsonConverter() SRGBColor color, LaserAnimation animation
});




}
/// @nodoc
class _$LaserToolCopyWithImpl<$Res>
    implements $LaserToolCopyWith<$Res> {
  _$LaserToolCopyWithImpl(this._self, this._then);

  final LaserTool _self;
  final $Res Function(LaserTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? duration = null,Object? hideDuration = null,Object? strokeWidth = null,Object? thinning = null,Object? color = null,Object? animation = null,}) {
  return _then(LaserTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as double,hideDuration: null == hideDuration ? _self.hideDuration : hideDuration // ignore: cast_nullable_to_non_nullable
as double,strokeWidth: null == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double,thinning: null == thinning ? _self.thinning : thinning // ignore: cast_nullable_to_non_nullable
as double,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as SRGBColor,animation: null == animation ? _self.animation : animation // ignore: cast_nullable_to_non_nullable
as LaserAnimation,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ShapeTool extends Tool {
   ShapeTool({this.name = '', this.displayIcon = '', this.zoomDependent = false, this.constrainedWidth = 0, this.constrainedHeight = 0, this.constrainedAspectRatio = 0, this.property = const ShapeProperty(shape: RectangleShape()), this.drawFromCenter = false, final  String? $type}): $type = $type ?? 'shape',super._();
  factory ShapeTool.fromJson(Map<String, dynamic> json) => _$ShapeToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  bool zoomDependent;
@JsonKey() final  double constrainedWidth;
@JsonKey() final  double constrainedHeight;
@JsonKey() final  double constrainedAspectRatio;
@JsonKey() final  ShapeProperty property;
@JsonKey() final  bool drawFromCenter;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShapeToolCopyWith<ShapeTool> get copyWith => _$ShapeToolCopyWithImpl<ShapeTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShapeToolToJson(this, );
}



@override
String toString() {
  return 'Tool.shape(name: $name, displayIcon: $displayIcon, zoomDependent: $zoomDependent, constrainedWidth: $constrainedWidth, constrainedHeight: $constrainedHeight, constrainedAspectRatio: $constrainedAspectRatio, property: $property, drawFromCenter: $drawFromCenter)';
}


}

/// @nodoc
abstract mixin class $ShapeToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $ShapeToolCopyWith(ShapeTool value, $Res Function(ShapeTool) _then) = _$ShapeToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, bool zoomDependent, double constrainedWidth, double constrainedHeight, double constrainedAspectRatio, ShapeProperty property, bool drawFromCenter
});




}
/// @nodoc
class _$ShapeToolCopyWithImpl<$Res>
    implements $ShapeToolCopyWith<$Res> {
  _$ShapeToolCopyWithImpl(this._self, this._then);

  final ShapeTool _self;
  final $Res Function(ShapeTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? zoomDependent = null,Object? constrainedWidth = null,Object? constrainedHeight = null,Object? constrainedAspectRatio = null,Object? property = freezed,Object? drawFromCenter = null,}) {
  return _then(ShapeTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,zoomDependent: null == zoomDependent ? _self.zoomDependent : zoomDependent // ignore: cast_nullable_to_non_nullable
as bool,constrainedWidth: null == constrainedWidth ? _self.constrainedWidth : constrainedWidth // ignore: cast_nullable_to_non_nullable
as double,constrainedHeight: null == constrainedHeight ? _self.constrainedHeight : constrainedHeight // ignore: cast_nullable_to_non_nullable
as double,constrainedAspectRatio: null == constrainedAspectRatio ? _self.constrainedAspectRatio : constrainedAspectRatio // ignore: cast_nullable_to_non_nullable
as double,property: freezed == property ? _self.property : property // ignore: cast_nullable_to_non_nullable
as ShapeProperty,drawFromCenter: null == drawFromCenter ? _self.drawFromCenter : drawFromCenter // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class StampTool extends Tool {
   StampTool({this.name = '', this.displayIcon = '', this.component = const PackAssetLocation(), final  String? $type}): $type = $type ?? 'stamp',super._();
  factory StampTool.fromJson(Map<String, dynamic> json) => _$StampToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  PackAssetLocation component;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StampToolCopyWith<StampTool> get copyWith => _$StampToolCopyWithImpl<StampTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StampToolToJson(this, );
}



@override
String toString() {
  return 'Tool.stamp(name: $name, displayIcon: $displayIcon, component: $component)';
}


}

/// @nodoc
abstract mixin class $StampToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $StampToolCopyWith(StampTool value, $Res Function(StampTool) _then) = _$StampToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, PackAssetLocation component
});


$PackAssetLocationCopyWith<$Res> get component;

}
/// @nodoc
class _$StampToolCopyWithImpl<$Res>
    implements $StampToolCopyWith<$Res> {
  _$StampToolCopyWithImpl(this._self, this._then);

  final StampTool _self;
  final $Res Function(StampTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? component = null,}) {
  return _then(StampTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,component: null == component ? _self.component : component // ignore: cast_nullable_to_non_nullable
as PackAssetLocation,
  ));
}

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PackAssetLocationCopyWith<$Res> get component {
  
  return $PackAssetLocationCopyWith<$Res>(_self.component, (value) {
    return _then(_self.copyWith(component: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class PresentationTool extends Tool {
   PresentationTool({this.name = '', this.displayIcon = '', final  String? $type}): $type = $type ?? 'presentation',super._();
  factory PresentationTool.fromJson(Map<String, dynamic> json) => _$PresentationToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresentationToolCopyWith<PresentationTool> get copyWith => _$PresentationToolCopyWithImpl<PresentationTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PresentationToolToJson(this, );
}



@override
String toString() {
  return 'Tool.presentation(name: $name, displayIcon: $displayIcon)';
}


}

/// @nodoc
abstract mixin class $PresentationToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $PresentationToolCopyWith(PresentationTool value, $Res Function(PresentationTool) _then) = _$PresentationToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon
});




}
/// @nodoc
class _$PresentationToolCopyWithImpl<$Res>
    implements $PresentationToolCopyWith<$Res> {
  _$PresentationToolCopyWithImpl(this._self, this._then);

  final PresentationTool _self;
  final $Res Function(PresentationTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,}) {
  return _then(PresentationTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SpacerTool extends Tool {
   SpacerTool({this.name = '', this.displayIcon = '', this.axis = Axis2D.horizontal, final  String? $type}): $type = $type ?? 'spacer',super._();
  factory SpacerTool.fromJson(Map<String, dynamic> json) => _$SpacerToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  Axis2D axis;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpacerToolCopyWith<SpacerTool> get copyWith => _$SpacerToolCopyWithImpl<SpacerTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpacerToolToJson(this, );
}



@override
String toString() {
  return 'Tool.spacer(name: $name, displayIcon: $displayIcon, axis: $axis)';
}


}

/// @nodoc
abstract mixin class $SpacerToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $SpacerToolCopyWith(SpacerTool value, $Res Function(SpacerTool) _then) = _$SpacerToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, Axis2D axis
});




}
/// @nodoc
class _$SpacerToolCopyWithImpl<$Res>
    implements $SpacerToolCopyWith<$Res> {
  _$SpacerToolCopyWithImpl(this._self, this._then);

  final SpacerTool _self;
  final $Res Function(SpacerTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? axis = null,}) {
  return _then(SpacerTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as Axis2D,
  ));
}


}

/// @nodoc
@JsonSerializable()

class FullScreenTool extends Tool {
   FullScreenTool({this.name = '', this.displayIcon = '', final  String? $type}): $type = $type ?? 'fullSceen',super._();
  factory FullScreenTool.fromJson(Map<String, dynamic> json) => _$FullScreenToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FullScreenToolCopyWith<FullScreenTool> get copyWith => _$FullScreenToolCopyWithImpl<FullScreenTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FullScreenToolToJson(this, );
}



@override
String toString() {
  return 'Tool.fullScreen(name: $name, displayIcon: $displayIcon)';
}


}

/// @nodoc
abstract mixin class $FullScreenToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $FullScreenToolCopyWith(FullScreenTool value, $Res Function(FullScreenTool) _then) = _$FullScreenToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon
});




}
/// @nodoc
class _$FullScreenToolCopyWithImpl<$Res>
    implements $FullScreenToolCopyWith<$Res> {
  _$FullScreenToolCopyWithImpl(this._self, this._then);

  final FullScreenTool _self;
  final $Res Function(FullScreenTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,}) {
  return _then(FullScreenTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AssetTool extends Tool {
   AssetTool({this.name = '', this.displayIcon = '', this.importType = ImportType.document, this.advanced = true, final  String? $type}): $type = $type ?? 'asset',super._();
  factory AssetTool.fromJson(Map<String, dynamic> json) => _$AssetToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  ImportType importType;
@JsonKey() final  bool advanced;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetToolCopyWith<AssetTool> get copyWith => _$AssetToolCopyWithImpl<AssetTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetToolToJson(this, );
}



@override
String toString() {
  return 'Tool.asset(name: $name, displayIcon: $displayIcon, importType: $importType, advanced: $advanced)';
}


}

/// @nodoc
abstract mixin class $AssetToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $AssetToolCopyWith(AssetTool value, $Res Function(AssetTool) _then) = _$AssetToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, ImportType importType, bool advanced
});




}
/// @nodoc
class _$AssetToolCopyWithImpl<$Res>
    implements $AssetToolCopyWith<$Res> {
  _$AssetToolCopyWithImpl(this._self, this._then);

  final AssetTool _self;
  final $Res Function(AssetTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? importType = null,Object? advanced = null,}) {
  return _then(AssetTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,importType: null == importType ? _self.importType : importType // ignore: cast_nullable_to_non_nullable
as ImportType,advanced: null == advanced ? _self.advanced : advanced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ExportTool extends Tool {
   ExportTool({this.name = '', this.displayIcon = '', required this.options, final  String? $type}): $type = $type ?? 'export',super._();
  factory ExportTool.fromJson(Map<String, dynamic> json) => _$ExportToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
 final  ExportOptions options;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExportToolCopyWith<ExportTool> get copyWith => _$ExportToolCopyWithImpl<ExportTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExportToolToJson(this, );
}



@override
String toString() {
  return 'Tool.export(name: $name, displayIcon: $displayIcon, options: $options)';
}


}

/// @nodoc
abstract mixin class $ExportToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $ExportToolCopyWith(ExportTool value, $Res Function(ExportTool) _then) = _$ExportToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, ExportOptions options
});


$ExportOptionsCopyWith<$Res> get options;

}
/// @nodoc
class _$ExportToolCopyWithImpl<$Res>
    implements $ExportToolCopyWith<$Res> {
  _$ExportToolCopyWithImpl(this._self, this._then);

  final ExportTool _self;
  final $Res Function(ExportTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? options = null,}) {
  return _then(ExportTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as ExportOptions,
  ));
}

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExportOptionsCopyWith<$Res> get options {
  
  return $ExportOptionsCopyWith<$Res>(_self.options, (value) {
    return _then(_self.copyWith(options: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class TextureTool extends Tool {
   TextureTool({this.name = '', this.displayIcon = '', this.zoomDependent = false, this.constrainedWidth = 0, this.constrainedHeight = 0, this.constrainedAspectRatio = 0, this.texture = const SurfaceTexture.pattern(), final  String? $type}): $type = $type ?? 'texture',super._();
  factory TextureTool.fromJson(Map<String, dynamic> json) => _$TextureToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  bool zoomDependent;
@JsonKey() final  double constrainedWidth;
@JsonKey() final  double constrainedHeight;
@JsonKey() final  double constrainedAspectRatio;
@JsonKey() final  SurfaceTexture texture;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextureToolCopyWith<TextureTool> get copyWith => _$TextureToolCopyWithImpl<TextureTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TextureToolToJson(this, );
}



@override
String toString() {
  return 'Tool.texture(name: $name, displayIcon: $displayIcon, zoomDependent: $zoomDependent, constrainedWidth: $constrainedWidth, constrainedHeight: $constrainedHeight, constrainedAspectRatio: $constrainedAspectRatio, texture: $texture)';
}


}

/// @nodoc
abstract mixin class $TextureToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $TextureToolCopyWith(TextureTool value, $Res Function(TextureTool) _then) = _$TextureToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, bool zoomDependent, double constrainedWidth, double constrainedHeight, double constrainedAspectRatio, SurfaceTexture texture
});


$SurfaceTextureCopyWith<$Res> get texture;

}
/// @nodoc
class _$TextureToolCopyWithImpl<$Res>
    implements $TextureToolCopyWith<$Res> {
  _$TextureToolCopyWithImpl(this._self, this._then);

  final TextureTool _self;
  final $Res Function(TextureTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? zoomDependent = null,Object? constrainedWidth = null,Object? constrainedHeight = null,Object? constrainedAspectRatio = null,Object? texture = null,}) {
  return _then(TextureTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,zoomDependent: null == zoomDependent ? _self.zoomDependent : zoomDependent // ignore: cast_nullable_to_non_nullable
as bool,constrainedWidth: null == constrainedWidth ? _self.constrainedWidth : constrainedWidth // ignore: cast_nullable_to_non_nullable
as double,constrainedHeight: null == constrainedHeight ? _self.constrainedHeight : constrainedHeight // ignore: cast_nullable_to_non_nullable
as double,constrainedAspectRatio: null == constrainedAspectRatio ? _self.constrainedAspectRatio : constrainedAspectRatio // ignore: cast_nullable_to_non_nullable
as double,texture: null == texture ? _self.texture : texture // ignore: cast_nullable_to_non_nullable
as SurfaceTexture,
  ));
}

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SurfaceTextureCopyWith<$Res> get texture {
  
  return $SurfaceTextureCopyWith<$Res>(_self.texture, (value) {
    return _then(_self.copyWith(texture: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class RulerTool extends Tool {
   RulerTool({this.name = '', this.displayIcon = '', @ColorJsonConverter() this.color, this.size = 100, final  String? $type}): $type = $type ?? 'ruler',super._();
  factory RulerTool.fromJson(Map<String, dynamic> json) => _$RulerToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@ColorJsonConverter() final  SRGBColor? color;
@JsonKey() final  int size;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulerToolCopyWith<RulerTool> get copyWith => _$RulerToolCopyWithImpl<RulerTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RulerToolToJson(this, );
}



@override
String toString() {
  return 'Tool.ruler(name: $name, displayIcon: $displayIcon, color: $color, size: $size)';
}


}

/// @nodoc
abstract mixin class $RulerToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $RulerToolCopyWith(RulerTool value, $Res Function(RulerTool) _then) = _$RulerToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon,@ColorJsonConverter() SRGBColor? color, int size
});




}
/// @nodoc
class _$RulerToolCopyWithImpl<$Res>
    implements $RulerToolCopyWith<$Res> {
  _$RulerToolCopyWithImpl(this._self, this._then);

  final RulerTool _self;
  final $Res Function(RulerTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? color = freezed,Object? size = null,}) {
  return _then(RulerTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as SRGBColor?,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class GridTool extends Tool {
   GridTool({this.name = '', this.displayIcon = '', @ColorJsonConverter() this.color = SRGBColor.black, this.xSize = 20, this.ySize = 20, this.xOffset = 0, this.yOffset = 0, this.positionDependent = false, this.zoomDependent = false, this.stroke = 1, final  String? $type}): $type = $type ?? 'grid',super._();
  factory GridTool.fromJson(Map<String, dynamic> json) => _$GridToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey()@ColorJsonConverter() final  SRGBColor color;
@JsonKey() final  double xSize;
@JsonKey() final  double ySize;
@JsonKey() final  double xOffset;
@JsonKey() final  double yOffset;
@JsonKey() final  bool positionDependent;
@JsonKey() final  bool zoomDependent;
@JsonKey() final  double stroke;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GridToolCopyWith<GridTool> get copyWith => _$GridToolCopyWithImpl<GridTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GridToolToJson(this, );
}



@override
String toString() {
  return 'Tool.grid(name: $name, displayIcon: $displayIcon, color: $color, xSize: $xSize, ySize: $ySize, xOffset: $xOffset, yOffset: $yOffset, positionDependent: $positionDependent, zoomDependent: $zoomDependent, stroke: $stroke)';
}


}

/// @nodoc
abstract mixin class $GridToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $GridToolCopyWith(GridTool value, $Res Function(GridTool) _then) = _$GridToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon,@ColorJsonConverter() SRGBColor color, double xSize, double ySize, double xOffset, double yOffset, bool positionDependent, bool zoomDependent, double stroke
});




}
/// @nodoc
class _$GridToolCopyWithImpl<$Res>
    implements $GridToolCopyWith<$Res> {
  _$GridToolCopyWithImpl(this._self, this._then);

  final GridTool _self;
  final $Res Function(GridTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? color = null,Object? xSize = null,Object? ySize = null,Object? xOffset = null,Object? yOffset = null,Object? positionDependent = null,Object? zoomDependent = null,Object? stroke = null,}) {
  return _then(GridTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as SRGBColor,xSize: null == xSize ? _self.xSize : xSize // ignore: cast_nullable_to_non_nullable
as double,ySize: null == ySize ? _self.ySize : ySize // ignore: cast_nullable_to_non_nullable
as double,xOffset: null == xOffset ? _self.xOffset : xOffset // ignore: cast_nullable_to_non_nullable
as double,yOffset: null == yOffset ? _self.yOffset : yOffset // ignore: cast_nullable_to_non_nullable
as double,positionDependent: null == positionDependent ? _self.positionDependent : positionDependent // ignore: cast_nullable_to_non_nullable
as bool,zoomDependent: null == zoomDependent ? _self.zoomDependent : zoomDependent // ignore: cast_nullable_to_non_nullable
as bool,stroke: null == stroke ? _self.stroke : stroke // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
@JsonSerializable()

class EyeDropperTool extends Tool {
   EyeDropperTool({this.name = '', this.displayIcon = '', final  String? $type}): $type = $type ?? 'eyeDropper',super._();
  factory EyeDropperTool.fromJson(Map<String, dynamic> json) => _$EyeDropperToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EyeDropperToolCopyWith<EyeDropperTool> get copyWith => _$EyeDropperToolCopyWithImpl<EyeDropperTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EyeDropperToolToJson(this, );
}



@override
String toString() {
  return 'Tool.eyeDropper(name: $name, displayIcon: $displayIcon)';
}


}

/// @nodoc
abstract mixin class $EyeDropperToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $EyeDropperToolCopyWith(EyeDropperTool value, $Res Function(EyeDropperTool) _then) = _$EyeDropperToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon
});




}
/// @nodoc
class _$EyeDropperToolCopyWithImpl<$Res>
    implements $EyeDropperToolCopyWith<$Res> {
  _$EyeDropperToolCopyWithImpl(this._self, this._then);

  final EyeDropperTool _self;
  final $Res Function(EyeDropperTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,}) {
  return _then(EyeDropperTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class BarcodeTool extends Tool {
   BarcodeTool({this.name = '', this.displayIcon = '', this.barcodeType = BarcodeType.qrCode, @ColorJsonConverter() this.color = SRGBColor.black, final  String? $type}): $type = $type ?? 'barcode',super._();
  factory BarcodeTool.fromJson(Map<String, dynamic> json) => _$BarcodeToolFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String displayIcon;
@JsonKey() final  BarcodeType barcodeType;
@JsonKey()@ColorJsonConverter() final  SRGBColor color;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarcodeToolCopyWith<BarcodeTool> get copyWith => _$BarcodeToolCopyWithImpl<BarcodeTool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BarcodeToolToJson(this, );
}



@override
String toString() {
  return 'Tool.barcode(name: $name, displayIcon: $displayIcon, barcodeType: $barcodeType, color: $color)';
}


}

/// @nodoc
abstract mixin class $BarcodeToolCopyWith<$Res> implements $ToolCopyWith<$Res> {
  factory $BarcodeToolCopyWith(BarcodeTool value, $Res Function(BarcodeTool) _then) = _$BarcodeToolCopyWithImpl;
@override @useResult
$Res call({
 String name, String displayIcon, BarcodeType barcodeType,@ColorJsonConverter() SRGBColor color
});




}
/// @nodoc
class _$BarcodeToolCopyWithImpl<$Res>
    implements $BarcodeToolCopyWith<$Res> {
  _$BarcodeToolCopyWithImpl(this._self, this._then);

  final BarcodeTool _self;
  final $Res Function(BarcodeTool) _then;

/// Create a copy of Tool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? displayIcon = null,Object? barcodeType = null,Object? color = null,}) {
  return _then(BarcodeTool(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,displayIcon: null == displayIcon ? _self.displayIcon : displayIcon // ignore: cast_nullable_to_non_nullable
as String,barcodeType: null == barcodeType ? _self.barcodeType : barcodeType // ignore: cast_nullable_to_non_nullable
as BarcodeType,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as SRGBColor,
  ));
}


}

// dart format on
