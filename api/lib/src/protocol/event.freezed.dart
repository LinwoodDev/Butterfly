// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DocumentEvent _$DocumentEventFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'pageChanged':
      return PageChanged.fromJson(json);
    case 'viewChanged':
      return ViewChanged.fromJson(json);
    case 'utilitiesChanged':
      return UtilitiesChanged.fromJson(json);
    case 'elementsCreated':
      return ElementsCreated.fromJson(json);
    case 'elementsChanged':
      return ElementsChanged.fromJson(json);
    case 'elementsRemoved':
      return ElementsRemoved.fromJson(json);
    case 'elementsArranged':
      return ElementsArranged.fromJson(json);
    case 'documentDescriptionChanged':
      return DocumentDescriptionChanged.fromJson(json);
    case 'documentPathChanged':
      return DocumentPathChanged.fromJson(json);
    case 'documentSaved':
      return DocumentSaved.fromJson(json);
    case 'toolCreated':
      return ToolCreated.fromJson(json);
    case 'toolsChanged':
      return ToolsChanged.fromJson(json);
    case 'toolsRemoved':
      return ToolsRemoved.fromJson(json);
    case 'toolReordered':
      return ToolReordered.fromJson(json);
    case 'documentBackgroundsChanged':
      return DocumentBackgroundsChanged.fromJson(json);
    case 'waypointCreated':
      return WaypointCreated.fromJson(json);
    case 'waypointRenamed':
      return WaypointRenamed.fromJson(json);
    case 'waypointRemoved':
      return WaypointRemoved.fromJson(json);
    case 'layerRenamed':
      return LayerRenamed.fromJson(json);
    case 'layerRemoved':
      return LayerRemoved.fromJson(json);
    case 'layerElementsRemoved':
      return LayerElementsRemoved.fromJson(json);
    case 'layerVisibilityChanged':
      return LayerVisibilityChanged.fromJson(json);
    case 'currentLayerChanged':
      return CurrentLayerChanged.fromJson(json);
    case 'elementsLayerChanged':
      return ElementsLayerChanged.fromJson(json);
    case 'templateCreated':
      return TemplateCreated.fromJson(json);
    case 'areasCreated':
      return AreasCreated.fromJson(json);
    case 'areasRemoved':
      return AreasRemoved.fromJson(json);
    case 'areaChanged':
      return AreaChanged.fromJson(json);
    case 'currentAreaChanged':
      return CurrentAreaChanged.fromJson(json);
    case 'exportPresetCreated':
      return ExportPresetCreated.fromJson(json);
    case 'exportPresetUpdated':
      return ExportPresetUpdated.fromJson(json);
    case 'exportPresetRemoved':
      return ExportPresetRemoved.fromJson(json);
    case 'packAdded':
      return PackAdded.fromJson(json);
    case 'packUpdated':
      return PackUpdated.fromJson(json);
    case 'packRemoved':
      return PackRemoved.fromJson(json);
    case 'animationAdded':
      return AnimationAdded.fromJson(json);
    case 'animationUpdated':
      return AnimationUpdated.fromJson(json);
    case 'animationRemoved':
      return AnimationRemoved.fromJson(json);
    case 'presentationModeEntered':
      return PresentationModeEntered.fromJson(json);
    case 'presentationModeExited':
      return PresentationModeExited.fromJson(json);
    case 'presentationTick':
      return PresentationTick.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'DocumentEvent',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
mixin _$DocumentEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentEventCopyWith<$Res> {
  factory $DocumentEventCopyWith(
          DocumentEvent value, $Res Function(DocumentEvent) then) =
      _$DocumentEventCopyWithImpl<$Res, DocumentEvent>;
}

/// @nodoc
class _$DocumentEventCopyWithImpl<$Res, $Val extends DocumentEvent>
    implements $DocumentEventCopyWith<$Res> {
  _$DocumentEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PageChangedCopyWith<$Res> {
  factory _$$PageChangedCopyWith(
          _$PageChanged value, $Res Function(_$PageChanged) then) =
      __$$PageChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({String pageName});
}

/// @nodoc
class __$$PageChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$PageChanged>
    implements _$$PageChangedCopyWith<$Res> {
  __$$PageChangedCopyWithImpl(
      _$PageChanged _value, $Res Function(_$PageChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pageName = null,
  }) {
    return _then(_$PageChanged(
      null == pageName
          ? _value.pageName
          : pageName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PageChanged extends PageChanged {
  const _$PageChanged(this.pageName, {final String? $type})
      : $type = $type ?? 'pageChanged',
        super._();

  factory _$PageChanged.fromJson(Map<String, dynamic> json) =>
      _$$PageChangedFromJson(json);

  @override
  final String pageName;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.pageChanged(pageName: $pageName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PageChanged &&
            (identical(other.pageName, pageName) ||
                other.pageName == pageName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pageName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PageChangedCopyWith<_$PageChanged> get copyWith =>
      __$$PageChangedCopyWithImpl<_$PageChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return pageChanged(pageName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return pageChanged?.call(pageName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (pageChanged != null) {
      return pageChanged(pageName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return pageChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return pageChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (pageChanged != null) {
      return pageChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PageChangedToJson(
      this,
    );
  }
}

abstract class PageChanged extends DocumentEvent {
  const factory PageChanged(final String pageName) = _$PageChanged;
  const PageChanged._() : super._();

  factory PageChanged.fromJson(Map<String, dynamic> json) =
      _$PageChanged.fromJson;

  String get pageName;
  @JsonKey(ignore: true)
  _$$PageChangedCopyWith<_$PageChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ViewChangedCopyWith<$Res> {
  factory _$$ViewChangedCopyWith(
          _$ViewChanged value, $Res Function(_$ViewChanged) then) =
      __$$ViewChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({ViewOption view});

  $ViewOptionCopyWith<$Res> get view;
}

/// @nodoc
class __$$ViewChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ViewChanged>
    implements _$$ViewChangedCopyWith<$Res> {
  __$$ViewChangedCopyWithImpl(
      _$ViewChanged _value, $Res Function(_$ViewChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? view = null,
  }) {
    return _then(_$ViewChanged(
      null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as ViewOption,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ViewOptionCopyWith<$Res> get view {
    return $ViewOptionCopyWith<$Res>(_value.view, (value) {
      return _then(_value.copyWith(view: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ViewChanged extends ViewChanged {
  const _$ViewChanged(this.view, {final String? $type})
      : $type = $type ?? 'viewChanged',
        super._();

  factory _$ViewChanged.fromJson(Map<String, dynamic> json) =>
      _$$ViewChangedFromJson(json);

  @override
  final ViewOption view;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.viewChanged(view: $view)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ViewChanged &&
            (identical(other.view, view) || other.view == view));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, view);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ViewChangedCopyWith<_$ViewChanged> get copyWith =>
      __$$ViewChangedCopyWithImpl<_$ViewChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return viewChanged(view);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return viewChanged?.call(view);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (viewChanged != null) {
      return viewChanged(view);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return viewChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return viewChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (viewChanged != null) {
      return viewChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ViewChangedToJson(
      this,
    );
  }
}

abstract class ViewChanged extends DocumentEvent {
  const factory ViewChanged(final ViewOption view) = _$ViewChanged;
  const ViewChanged._() : super._();

  factory ViewChanged.fromJson(Map<String, dynamic> json) =
      _$ViewChanged.fromJson;

  ViewOption get view;
  @JsonKey(ignore: true)
  _$$ViewChangedCopyWith<_$ViewChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UtilitiesChangedCopyWith<$Res> {
  factory _$$UtilitiesChangedCopyWith(
          _$UtilitiesChanged value, $Res Function(_$UtilitiesChanged) then) =
      __$$UtilitiesChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({UtilitiesState state});

  $UtilitiesStateCopyWith<$Res> get state;
}

/// @nodoc
class __$$UtilitiesChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$UtilitiesChanged>
    implements _$$UtilitiesChangedCopyWith<$Res> {
  __$$UtilitiesChangedCopyWithImpl(
      _$UtilitiesChanged _value, $Res Function(_$UtilitiesChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_$UtilitiesChanged(
      null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as UtilitiesState,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $UtilitiesStateCopyWith<$Res> get state {
    return $UtilitiesStateCopyWith<$Res>(_value.state, (value) {
      return _then(_value.copyWith(state: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$UtilitiesChanged extends UtilitiesChanged {
  const _$UtilitiesChanged(this.state, {final String? $type})
      : $type = $type ?? 'utilitiesChanged',
        super._();

  factory _$UtilitiesChanged.fromJson(Map<String, dynamic> json) =>
      _$$UtilitiesChangedFromJson(json);

  @override
  final UtilitiesState state;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.utilitiesChanged(state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UtilitiesChanged &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UtilitiesChangedCopyWith<_$UtilitiesChanged> get copyWith =>
      __$$UtilitiesChangedCopyWithImpl<_$UtilitiesChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return utilitiesChanged(state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return utilitiesChanged?.call(state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (utilitiesChanged != null) {
      return utilitiesChanged(state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return utilitiesChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return utilitiesChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (utilitiesChanged != null) {
      return utilitiesChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UtilitiesChangedToJson(
      this,
    );
  }
}

abstract class UtilitiesChanged extends DocumentEvent {
  const factory UtilitiesChanged(final UtilitiesState state) =
      _$UtilitiesChanged;
  const UtilitiesChanged._() : super._();

  factory UtilitiesChanged.fromJson(Map<String, dynamic> json) =
      _$UtilitiesChanged.fromJson;

  UtilitiesState get state;
  @JsonKey(ignore: true)
  _$$UtilitiesChangedCopyWith<_$UtilitiesChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ElementsCreatedCopyWith<$Res> {
  factory _$$ElementsCreatedCopyWith(
          _$ElementsCreated value, $Res Function(_$ElementsCreated) then) =
      __$$ElementsCreatedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PadElement> elements});
}

/// @nodoc
class __$$ElementsCreatedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ElementsCreated>
    implements _$$ElementsCreatedCopyWith<$Res> {
  __$$ElementsCreatedCopyWithImpl(
      _$ElementsCreated _value, $Res Function(_$ElementsCreated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elements = null,
  }) {
    return _then(_$ElementsCreated(
      null == elements
          ? _value._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElementsCreated extends ElementsCreated {
  const _$ElementsCreated(final List<PadElement> elements,
      {final String? $type})
      : _elements = elements,
        $type = $type ?? 'elementsCreated',
        super._();

  factory _$ElementsCreated.fromJson(Map<String, dynamic> json) =>
      _$$ElementsCreatedFromJson(json);

  final List<PadElement> _elements;
  @override
  List<PadElement> get elements {
    if (_elements is EqualUnmodifiableListView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_elements);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.elementsCreated(elements: $elements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElementsCreated &&
            const DeepCollectionEquality().equals(other._elements, _elements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_elements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ElementsCreatedCopyWith<_$ElementsCreated> get copyWith =>
      __$$ElementsCreatedCopyWithImpl<_$ElementsCreated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return elementsCreated(elements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return elementsCreated?.call(elements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsCreated != null) {
      return elementsCreated(elements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return elementsCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return elementsCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsCreated != null) {
      return elementsCreated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ElementsCreatedToJson(
      this,
    );
  }
}

abstract class ElementsCreated extends DocumentEvent {
  const factory ElementsCreated(final List<PadElement> elements) =
      _$ElementsCreated;
  const ElementsCreated._() : super._();

  factory ElementsCreated.fromJson(Map<String, dynamic> json) =
      _$ElementsCreated.fromJson;

  List<PadElement> get elements;
  @JsonKey(ignore: true)
  _$$ElementsCreatedCopyWith<_$ElementsCreated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ElementsChangedCopyWith<$Res> {
  factory _$$ElementsChangedCopyWith(
          _$ElementsChanged value, $Res Function(_$ElementsChanged) then) =
      __$$ElementsChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<int, List<PadElement>> elements});
}

/// @nodoc
class __$$ElementsChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ElementsChanged>
    implements _$$ElementsChangedCopyWith<$Res> {
  __$$ElementsChangedCopyWithImpl(
      _$ElementsChanged _value, $Res Function(_$ElementsChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elements = null,
  }) {
    return _then(_$ElementsChanged(
      null == elements
          ? _value._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as Map<int, List<PadElement>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElementsChanged extends ElementsChanged {
  const _$ElementsChanged(final Map<int, List<PadElement>> elements,
      {final String? $type})
      : _elements = elements,
        $type = $type ?? 'elementsChanged',
        super._();

  factory _$ElementsChanged.fromJson(Map<String, dynamic> json) =>
      _$$ElementsChangedFromJson(json);

  final Map<int, List<PadElement>> _elements;
  @override
  Map<int, List<PadElement>> get elements {
    if (_elements is EqualUnmodifiableMapView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_elements);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.elementsChanged(elements: $elements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElementsChanged &&
            const DeepCollectionEquality().equals(other._elements, _elements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_elements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ElementsChangedCopyWith<_$ElementsChanged> get copyWith =>
      __$$ElementsChangedCopyWithImpl<_$ElementsChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return elementsChanged(elements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return elementsChanged?.call(elements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsChanged != null) {
      return elementsChanged(elements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return elementsChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return elementsChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsChanged != null) {
      return elementsChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ElementsChangedToJson(
      this,
    );
  }
}

abstract class ElementsChanged extends DocumentEvent {
  const factory ElementsChanged(final Map<int, List<PadElement>> elements) =
      _$ElementsChanged;
  const ElementsChanged._() : super._();

  factory ElementsChanged.fromJson(Map<String, dynamic> json) =
      _$ElementsChanged.fromJson;

  Map<int, List<PadElement>> get elements;
  @JsonKey(ignore: true)
  _$$ElementsChangedCopyWith<_$ElementsChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ElementsRemovedCopyWith<$Res> {
  factory _$$ElementsRemovedCopyWith(
          _$ElementsRemoved value, $Res Function(_$ElementsRemoved) then) =
      __$$ElementsRemovedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<int> elements});
}

/// @nodoc
class __$$ElementsRemovedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ElementsRemoved>
    implements _$$ElementsRemovedCopyWith<$Res> {
  __$$ElementsRemovedCopyWithImpl(
      _$ElementsRemoved _value, $Res Function(_$ElementsRemoved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? elements = null,
  }) {
    return _then(_$ElementsRemoved(
      null == elements
          ? _value._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElementsRemoved extends ElementsRemoved {
  const _$ElementsRemoved(final List<int> elements, {final String? $type})
      : _elements = elements,
        $type = $type ?? 'elementsRemoved',
        super._();

  factory _$ElementsRemoved.fromJson(Map<String, dynamic> json) =>
      _$$ElementsRemovedFromJson(json);

  final List<int> _elements;
  @override
  List<int> get elements {
    if (_elements is EqualUnmodifiableListView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_elements);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.elementsRemoved(elements: $elements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElementsRemoved &&
            const DeepCollectionEquality().equals(other._elements, _elements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_elements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ElementsRemovedCopyWith<_$ElementsRemoved> get copyWith =>
      __$$ElementsRemovedCopyWithImpl<_$ElementsRemoved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return elementsRemoved(elements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return elementsRemoved?.call(elements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsRemoved != null) {
      return elementsRemoved(elements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return elementsRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return elementsRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsRemoved != null) {
      return elementsRemoved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ElementsRemovedToJson(
      this,
    );
  }
}

abstract class ElementsRemoved extends DocumentEvent {
  const factory ElementsRemoved(final List<int> elements) = _$ElementsRemoved;
  const ElementsRemoved._() : super._();

  factory ElementsRemoved.fromJson(Map<String, dynamic> json) =
      _$ElementsRemoved.fromJson;

  List<int> get elements;
  @JsonKey(ignore: true)
  _$$ElementsRemovedCopyWith<_$ElementsRemoved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ElementsArrangedCopyWith<$Res> {
  factory _$$ElementsArrangedCopyWith(
          _$ElementsArranged value, $Res Function(_$ElementsArranged) then) =
      __$$ElementsArrangedCopyWithImpl<$Res>;
  @useResult
  $Res call({Arrangement arrangement, List<int> elements});
}

/// @nodoc
class __$$ElementsArrangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ElementsArranged>
    implements _$$ElementsArrangedCopyWith<$Res> {
  __$$ElementsArrangedCopyWithImpl(
      _$ElementsArranged _value, $Res Function(_$ElementsArranged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? arrangement = null,
    Object? elements = null,
  }) {
    return _then(_$ElementsArranged(
      null == arrangement
          ? _value.arrangement
          : arrangement // ignore: cast_nullable_to_non_nullable
              as Arrangement,
      null == elements
          ? _value._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElementsArranged extends ElementsArranged {
  const _$ElementsArranged(this.arrangement, final List<int> elements,
      {final String? $type})
      : _elements = elements,
        $type = $type ?? 'elementsArranged',
        super._();

  factory _$ElementsArranged.fromJson(Map<String, dynamic> json) =>
      _$$ElementsArrangedFromJson(json);

  @override
  final Arrangement arrangement;
  final List<int> _elements;
  @override
  List<int> get elements {
    if (_elements is EqualUnmodifiableListView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_elements);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.elementsArranged(arrangement: $arrangement, elements: $elements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElementsArranged &&
            (identical(other.arrangement, arrangement) ||
                other.arrangement == arrangement) &&
            const DeepCollectionEquality().equals(other._elements, _elements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, arrangement, const DeepCollectionEquality().hash(_elements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ElementsArrangedCopyWith<_$ElementsArranged> get copyWith =>
      __$$ElementsArrangedCopyWithImpl<_$ElementsArranged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return elementsArranged(arrangement, elements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return elementsArranged?.call(arrangement, elements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsArranged != null) {
      return elementsArranged(arrangement, elements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return elementsArranged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return elementsArranged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsArranged != null) {
      return elementsArranged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ElementsArrangedToJson(
      this,
    );
  }
}

abstract class ElementsArranged extends DocumentEvent {
  const factory ElementsArranged(
          final Arrangement arrangement, final List<int> elements) =
      _$ElementsArranged;
  const ElementsArranged._() : super._();

  factory ElementsArranged.fromJson(Map<String, dynamic> json) =
      _$ElementsArranged.fromJson;

  Arrangement get arrangement;
  List<int> get elements;
  @JsonKey(ignore: true)
  _$$ElementsArrangedCopyWith<_$ElementsArranged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DocumentDescriptionChangedCopyWith<$Res> {
  factory _$$DocumentDescriptionChangedCopyWith(
          _$DocumentDescriptionChanged value,
          $Res Function(_$DocumentDescriptionChanged) then) =
      __$$DocumentDescriptionChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({String? name, String? description});
}

/// @nodoc
class __$$DocumentDescriptionChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$DocumentDescriptionChanged>
    implements _$$DocumentDescriptionChangedCopyWith<$Res> {
  __$$DocumentDescriptionChangedCopyWithImpl(
      _$DocumentDescriptionChanged _value,
      $Res Function(_$DocumentDescriptionChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_$DocumentDescriptionChanged(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentDescriptionChanged extends DocumentDescriptionChanged {
  const _$DocumentDescriptionChanged(
      {this.name, this.description, final String? $type})
      : $type = $type ?? 'documentDescriptionChanged',
        super._();

  factory _$DocumentDescriptionChanged.fromJson(Map<String, dynamic> json) =>
      _$$DocumentDescriptionChangedFromJson(json);

  @override
  final String? name;
  @override
  final String? description;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.documentDescriptionChanged(name: $name, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentDescriptionChanged &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentDescriptionChangedCopyWith<_$DocumentDescriptionChanged>
      get copyWith => __$$DocumentDescriptionChangedCopyWithImpl<
          _$DocumentDescriptionChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return documentDescriptionChanged(name, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return documentDescriptionChanged?.call(name, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (documentDescriptionChanged != null) {
      return documentDescriptionChanged(name, description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return documentDescriptionChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return documentDescriptionChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (documentDescriptionChanged != null) {
      return documentDescriptionChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentDescriptionChangedToJson(
      this,
    );
  }
}

abstract class DocumentDescriptionChanged extends DocumentEvent {
  const factory DocumentDescriptionChanged(
      {final String? name,
      final String? description}) = _$DocumentDescriptionChanged;
  const DocumentDescriptionChanged._() : super._();

  factory DocumentDescriptionChanged.fromJson(Map<String, dynamic> json) =
      _$DocumentDescriptionChanged.fromJson;

  String? get name;
  String? get description;
  @JsonKey(ignore: true)
  _$$DocumentDescriptionChangedCopyWith<_$DocumentDescriptionChanged>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DocumentPathChangedCopyWith<$Res> {
  factory _$$DocumentPathChangedCopyWith(_$DocumentPathChanged value,
          $Res Function(_$DocumentPathChanged) then) =
      __$$DocumentPathChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({String path});
}

/// @nodoc
class __$$DocumentPathChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$DocumentPathChanged>
    implements _$$DocumentPathChangedCopyWith<$Res> {
  __$$DocumentPathChangedCopyWithImpl(
      _$DocumentPathChanged _value, $Res Function(_$DocumentPathChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
  }) {
    return _then(_$DocumentPathChanged(
      null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentPathChanged extends DocumentPathChanged {
  const _$DocumentPathChanged(this.path, {final String? $type})
      : $type = $type ?? 'documentPathChanged',
        super._();

  factory _$DocumentPathChanged.fromJson(Map<String, dynamic> json) =>
      _$$DocumentPathChangedFromJson(json);

  @override
  final String path;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.documentPathChanged(path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentPathChanged &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, path);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentPathChangedCopyWith<_$DocumentPathChanged> get copyWith =>
      __$$DocumentPathChangedCopyWithImpl<_$DocumentPathChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return documentPathChanged(path);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return documentPathChanged?.call(path);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (documentPathChanged != null) {
      return documentPathChanged(path);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return documentPathChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return documentPathChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (documentPathChanged != null) {
      return documentPathChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentPathChangedToJson(
      this,
    );
  }
}

abstract class DocumentPathChanged extends DocumentEvent {
  const factory DocumentPathChanged(final String path) = _$DocumentPathChanged;
  const DocumentPathChanged._() : super._();

  factory DocumentPathChanged.fromJson(Map<String, dynamic> json) =
      _$DocumentPathChanged.fromJson;

  String get path;
  @JsonKey(ignore: true)
  _$$DocumentPathChangedCopyWith<_$DocumentPathChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DocumentSavedCopyWith<$Res> {
  factory _$$DocumentSavedCopyWith(
          _$DocumentSaved value, $Res Function(_$DocumentSaved) then) =
      __$$DocumentSavedCopyWithImpl<$Res>;
  @useResult
  $Res call({AssetLocation? location});

  $AssetLocationCopyWith<$Res>? get location;
}

/// @nodoc
class __$$DocumentSavedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$DocumentSaved>
    implements _$$DocumentSavedCopyWith<$Res> {
  __$$DocumentSavedCopyWithImpl(
      _$DocumentSaved _value, $Res Function(_$DocumentSaved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
  }) {
    return _then(_$DocumentSaved(
      freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as AssetLocation?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AssetLocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $AssetLocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentSaved extends DocumentSaved {
  const _$DocumentSaved([this.location, final String? $type])
      : $type = $type ?? 'documentSaved',
        super._();

  factory _$DocumentSaved.fromJson(Map<String, dynamic> json) =>
      _$$DocumentSavedFromJson(json);

  @override
  final AssetLocation? location;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.documentSaved(location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentSaved &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentSavedCopyWith<_$DocumentSaved> get copyWith =>
      __$$DocumentSavedCopyWithImpl<_$DocumentSaved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return documentSaved(location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return documentSaved?.call(location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (documentSaved != null) {
      return documentSaved(location);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return documentSaved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return documentSaved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (documentSaved != null) {
      return documentSaved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentSavedToJson(
      this,
    );
  }
}

abstract class DocumentSaved extends DocumentEvent {
  const factory DocumentSaved([final AssetLocation? location]) =
      _$DocumentSaved;
  const DocumentSaved._() : super._();

  factory DocumentSaved.fromJson(Map<String, dynamic> json) =
      _$DocumentSaved.fromJson;

  AssetLocation? get location;
  @JsonKey(ignore: true)
  _$$DocumentSavedCopyWith<_$DocumentSaved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToolCreatedCopyWith<$Res> {
  factory _$$ToolCreatedCopyWith(
          _$ToolCreated value, $Res Function(_$ToolCreated) then) =
      __$$ToolCreatedCopyWithImpl<$Res>;
  @useResult
  $Res call({Tool tool});

  $ToolCopyWith<$Res> get tool;
}

/// @nodoc
class __$$ToolCreatedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ToolCreated>
    implements _$$ToolCreatedCopyWith<$Res> {
  __$$ToolCreatedCopyWithImpl(
      _$ToolCreated _value, $Res Function(_$ToolCreated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tool = null,
  }) {
    return _then(_$ToolCreated(
      null == tool
          ? _value.tool
          : tool // ignore: cast_nullable_to_non_nullable
              as Tool,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ToolCopyWith<$Res> get tool {
    return $ToolCopyWith<$Res>(_value.tool, (value) {
      return _then(_value.copyWith(tool: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ToolCreated extends ToolCreated {
  const _$ToolCreated(this.tool, {final String? $type})
      : $type = $type ?? 'toolCreated',
        super._();

  factory _$ToolCreated.fromJson(Map<String, dynamic> json) =>
      _$$ToolCreatedFromJson(json);

  @override
  final Tool tool;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.toolCreated(tool: $tool)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToolCreated &&
            (identical(other.tool, tool) || other.tool == tool));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tool);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ToolCreatedCopyWith<_$ToolCreated> get copyWith =>
      __$$ToolCreatedCopyWithImpl<_$ToolCreated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return toolCreated(tool);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return toolCreated?.call(tool);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (toolCreated != null) {
      return toolCreated(tool);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return toolCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return toolCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (toolCreated != null) {
      return toolCreated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ToolCreatedToJson(
      this,
    );
  }
}

abstract class ToolCreated extends DocumentEvent {
  const factory ToolCreated(final Tool tool) = _$ToolCreated;
  const ToolCreated._() : super._();

  factory ToolCreated.fromJson(Map<String, dynamic> json) =
      _$ToolCreated.fromJson;

  Tool get tool;
  @JsonKey(ignore: true)
  _$$ToolCreatedCopyWith<_$ToolCreated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToolsChangedCopyWith<$Res> {
  factory _$$ToolsChangedCopyWith(
          _$ToolsChanged value, $Res Function(_$ToolsChanged) then) =
      __$$ToolsChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<int, Tool> tools});
}

/// @nodoc
class __$$ToolsChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ToolsChanged>
    implements _$$ToolsChangedCopyWith<$Res> {
  __$$ToolsChangedCopyWithImpl(
      _$ToolsChanged _value, $Res Function(_$ToolsChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tools = null,
  }) {
    return _then(_$ToolsChanged(
      null == tools
          ? _value._tools
          : tools // ignore: cast_nullable_to_non_nullable
              as Map<int, Tool>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ToolsChanged extends ToolsChanged {
  const _$ToolsChanged(final Map<int, Tool> tools, {final String? $type})
      : _tools = tools,
        $type = $type ?? 'toolsChanged',
        super._();

  factory _$ToolsChanged.fromJson(Map<String, dynamic> json) =>
      _$$ToolsChangedFromJson(json);

  final Map<int, Tool> _tools;
  @override
  Map<int, Tool> get tools {
    if (_tools is EqualUnmodifiableMapView) return _tools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tools);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.toolsChanged(tools: $tools)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToolsChanged &&
            const DeepCollectionEquality().equals(other._tools, _tools));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tools));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ToolsChangedCopyWith<_$ToolsChanged> get copyWith =>
      __$$ToolsChangedCopyWithImpl<_$ToolsChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return toolsChanged(tools);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return toolsChanged?.call(tools);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (toolsChanged != null) {
      return toolsChanged(tools);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return toolsChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return toolsChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (toolsChanged != null) {
      return toolsChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ToolsChangedToJson(
      this,
    );
  }
}

abstract class ToolsChanged extends DocumentEvent {
  const factory ToolsChanged(final Map<int, Tool> tools) = _$ToolsChanged;
  const ToolsChanged._() : super._();

  factory ToolsChanged.fromJson(Map<String, dynamic> json) =
      _$ToolsChanged.fromJson;

  Map<int, Tool> get tools;
  @JsonKey(ignore: true)
  _$$ToolsChangedCopyWith<_$ToolsChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToolsRemovedCopyWith<$Res> {
  factory _$$ToolsRemovedCopyWith(
          _$ToolsRemoved value, $Res Function(_$ToolsRemoved) then) =
      __$$ToolsRemovedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<int> tools});
}

/// @nodoc
class __$$ToolsRemovedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ToolsRemoved>
    implements _$$ToolsRemovedCopyWith<$Res> {
  __$$ToolsRemovedCopyWithImpl(
      _$ToolsRemoved _value, $Res Function(_$ToolsRemoved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tools = null,
  }) {
    return _then(_$ToolsRemoved(
      null == tools
          ? _value._tools
          : tools // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ToolsRemoved extends ToolsRemoved {
  const _$ToolsRemoved(final List<int> tools, {final String? $type})
      : _tools = tools,
        $type = $type ?? 'toolsRemoved',
        super._();

  factory _$ToolsRemoved.fromJson(Map<String, dynamic> json) =>
      _$$ToolsRemovedFromJson(json);

  final List<int> _tools;
  @override
  List<int> get tools {
    if (_tools is EqualUnmodifiableListView) return _tools;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tools);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.toolsRemoved(tools: $tools)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToolsRemoved &&
            const DeepCollectionEquality().equals(other._tools, _tools));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tools));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ToolsRemovedCopyWith<_$ToolsRemoved> get copyWith =>
      __$$ToolsRemovedCopyWithImpl<_$ToolsRemoved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return toolsRemoved(tools);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return toolsRemoved?.call(tools);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (toolsRemoved != null) {
      return toolsRemoved(tools);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return toolsRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return toolsRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (toolsRemoved != null) {
      return toolsRemoved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ToolsRemovedToJson(
      this,
    );
  }
}

abstract class ToolsRemoved extends DocumentEvent {
  const factory ToolsRemoved(final List<int> tools) = _$ToolsRemoved;
  const ToolsRemoved._() : super._();

  factory ToolsRemoved.fromJson(Map<String, dynamic> json) =
      _$ToolsRemoved.fromJson;

  List<int> get tools;
  @JsonKey(ignore: true)
  _$$ToolsRemovedCopyWith<_$ToolsRemoved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToolReorderedCopyWith<$Res> {
  factory _$$ToolReorderedCopyWith(
          _$ToolReordered value, $Res Function(_$ToolReordered) then) =
      __$$ToolReorderedCopyWithImpl<$Res>;
  @useResult
  $Res call({int oldIndex, int newIndex});
}

/// @nodoc
class __$$ToolReorderedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ToolReordered>
    implements _$$ToolReorderedCopyWith<$Res> {
  __$$ToolReorderedCopyWithImpl(
      _$ToolReordered _value, $Res Function(_$ToolReordered) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldIndex = null,
    Object? newIndex = null,
  }) {
    return _then(_$ToolReordered(
      null == oldIndex
          ? _value.oldIndex
          : oldIndex // ignore: cast_nullable_to_non_nullable
              as int,
      null == newIndex
          ? _value.newIndex
          : newIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ToolReordered extends ToolReordered {
  const _$ToolReordered(this.oldIndex, this.newIndex, {final String? $type})
      : $type = $type ?? 'toolReordered',
        super._();

  factory _$ToolReordered.fromJson(Map<String, dynamic> json) =>
      _$$ToolReorderedFromJson(json);

  @override
  final int oldIndex;
  @override
  final int newIndex;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.toolReordered(oldIndex: $oldIndex, newIndex: $newIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToolReordered &&
            (identical(other.oldIndex, oldIndex) ||
                other.oldIndex == oldIndex) &&
            (identical(other.newIndex, newIndex) ||
                other.newIndex == newIndex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, oldIndex, newIndex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ToolReorderedCopyWith<_$ToolReordered> get copyWith =>
      __$$ToolReorderedCopyWithImpl<_$ToolReordered>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return toolReordered(oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return toolReordered?.call(oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (toolReordered != null) {
      return toolReordered(oldIndex, newIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return toolReordered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return toolReordered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (toolReordered != null) {
      return toolReordered(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ToolReorderedToJson(
      this,
    );
  }
}

abstract class ToolReordered extends DocumentEvent {
  const factory ToolReordered(final int oldIndex, final int newIndex) =
      _$ToolReordered;
  const ToolReordered._() : super._();

  factory ToolReordered.fromJson(Map<String, dynamic> json) =
      _$ToolReordered.fromJson;

  int get oldIndex;
  int get newIndex;
  @JsonKey(ignore: true)
  _$$ToolReorderedCopyWith<_$ToolReordered> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DocumentBackgroundsChangedCopyWith<$Res> {
  factory _$$DocumentBackgroundsChangedCopyWith(
          _$DocumentBackgroundsChanged value,
          $Res Function(_$DocumentBackgroundsChanged) then) =
      __$$DocumentBackgroundsChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Background> backgrounds});
}

/// @nodoc
class __$$DocumentBackgroundsChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$DocumentBackgroundsChanged>
    implements _$$DocumentBackgroundsChangedCopyWith<$Res> {
  __$$DocumentBackgroundsChangedCopyWithImpl(
      _$DocumentBackgroundsChanged _value,
      $Res Function(_$DocumentBackgroundsChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? backgrounds = null,
  }) {
    return _then(_$DocumentBackgroundsChanged(
      null == backgrounds
          ? _value._backgrounds
          : backgrounds // ignore: cast_nullable_to_non_nullable
              as List<Background>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentBackgroundsChanged extends DocumentBackgroundsChanged {
  const _$DocumentBackgroundsChanged(final List<Background> backgrounds,
      {final String? $type})
      : _backgrounds = backgrounds,
        $type = $type ?? 'documentBackgroundsChanged',
        super._();

  factory _$DocumentBackgroundsChanged.fromJson(Map<String, dynamic> json) =>
      _$$DocumentBackgroundsChangedFromJson(json);

  final List<Background> _backgrounds;
  @override
  List<Background> get backgrounds {
    if (_backgrounds is EqualUnmodifiableListView) return _backgrounds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_backgrounds);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.documentBackgroundsChanged(backgrounds: $backgrounds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentBackgroundsChanged &&
            const DeepCollectionEquality()
                .equals(other._backgrounds, _backgrounds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_backgrounds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentBackgroundsChangedCopyWith<_$DocumentBackgroundsChanged>
      get copyWith => __$$DocumentBackgroundsChangedCopyWithImpl<
          _$DocumentBackgroundsChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return documentBackgroundsChanged(backgrounds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return documentBackgroundsChanged?.call(backgrounds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (documentBackgroundsChanged != null) {
      return documentBackgroundsChanged(backgrounds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return documentBackgroundsChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return documentBackgroundsChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (documentBackgroundsChanged != null) {
      return documentBackgroundsChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentBackgroundsChangedToJson(
      this,
    );
  }
}

abstract class DocumentBackgroundsChanged extends DocumentEvent {
  const factory DocumentBackgroundsChanged(final List<Background> backgrounds) =
      _$DocumentBackgroundsChanged;
  const DocumentBackgroundsChanged._() : super._();

  factory DocumentBackgroundsChanged.fromJson(Map<String, dynamic> json) =
      _$DocumentBackgroundsChanged.fromJson;

  List<Background> get backgrounds;
  @JsonKey(ignore: true)
  _$$DocumentBackgroundsChangedCopyWith<_$DocumentBackgroundsChanged>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WaypointCreatedCopyWith<$Res> {
  factory _$$WaypointCreatedCopyWith(
          _$WaypointCreated value, $Res Function(_$WaypointCreated) then) =
      __$$WaypointCreatedCopyWithImpl<$Res>;
  @useResult
  $Res call({Waypoint waypoint});

  $WaypointCopyWith<$Res> get waypoint;
}

/// @nodoc
class __$$WaypointCreatedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$WaypointCreated>
    implements _$$WaypointCreatedCopyWith<$Res> {
  __$$WaypointCreatedCopyWithImpl(
      _$WaypointCreated _value, $Res Function(_$WaypointCreated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? waypoint = null,
  }) {
    return _then(_$WaypointCreated(
      null == waypoint
          ? _value.waypoint
          : waypoint // ignore: cast_nullable_to_non_nullable
              as Waypoint,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $WaypointCopyWith<$Res> get waypoint {
    return $WaypointCopyWith<$Res>(_value.waypoint, (value) {
      return _then(_value.copyWith(waypoint: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$WaypointCreated extends WaypointCreated {
  const _$WaypointCreated(this.waypoint, {final String? $type})
      : $type = $type ?? 'waypointCreated',
        super._();

  factory _$WaypointCreated.fromJson(Map<String, dynamic> json) =>
      _$$WaypointCreatedFromJson(json);

  @override
  final Waypoint waypoint;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.waypointCreated(waypoint: $waypoint)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaypointCreated &&
            (identical(other.waypoint, waypoint) ||
                other.waypoint == waypoint));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, waypoint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaypointCreatedCopyWith<_$WaypointCreated> get copyWith =>
      __$$WaypointCreatedCopyWithImpl<_$WaypointCreated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return waypointCreated(waypoint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return waypointCreated?.call(waypoint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (waypointCreated != null) {
      return waypointCreated(waypoint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return waypointCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return waypointCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (waypointCreated != null) {
      return waypointCreated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WaypointCreatedToJson(
      this,
    );
  }
}

abstract class WaypointCreated extends DocumentEvent {
  const factory WaypointCreated(final Waypoint waypoint) = _$WaypointCreated;
  const WaypointCreated._() : super._();

  factory WaypointCreated.fromJson(Map<String, dynamic> json) =
      _$WaypointCreated.fromJson;

  Waypoint get waypoint;
  @JsonKey(ignore: true)
  _$$WaypointCreatedCopyWith<_$WaypointCreated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WaypointRenamedCopyWith<$Res> {
  factory _$$WaypointRenamedCopyWith(
          _$WaypointRenamed value, $Res Function(_$WaypointRenamed) then) =
      __$$WaypointRenamedCopyWithImpl<$Res>;
  @useResult
  $Res call({int index, String name});
}

/// @nodoc
class __$$WaypointRenamedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$WaypointRenamed>
    implements _$$WaypointRenamedCopyWith<$Res> {
  __$$WaypointRenamedCopyWithImpl(
      _$WaypointRenamed _value, $Res Function(_$WaypointRenamed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? name = null,
  }) {
    return _then(_$WaypointRenamed(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WaypointRenamed extends WaypointRenamed {
  const _$WaypointRenamed(this.index, this.name, {final String? $type})
      : $type = $type ?? 'waypointRenamed',
        super._();

  factory _$WaypointRenamed.fromJson(Map<String, dynamic> json) =>
      _$$WaypointRenamedFromJson(json);

  @override
  final int index;
  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.waypointRenamed(index: $index, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaypointRenamed &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, index, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaypointRenamedCopyWith<_$WaypointRenamed> get copyWith =>
      __$$WaypointRenamedCopyWithImpl<_$WaypointRenamed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return waypointRenamed(index, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return waypointRenamed?.call(index, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (waypointRenamed != null) {
      return waypointRenamed(index, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return waypointRenamed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return waypointRenamed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (waypointRenamed != null) {
      return waypointRenamed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WaypointRenamedToJson(
      this,
    );
  }
}

abstract class WaypointRenamed extends DocumentEvent {
  const factory WaypointRenamed(final int index, final String name) =
      _$WaypointRenamed;
  const WaypointRenamed._() : super._();

  factory WaypointRenamed.fromJson(Map<String, dynamic> json) =
      _$WaypointRenamed.fromJson;

  int get index;
  String get name;
  @JsonKey(ignore: true)
  _$$WaypointRenamedCopyWith<_$WaypointRenamed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WaypointRemovedCopyWith<$Res> {
  factory _$$WaypointRemovedCopyWith(
          _$WaypointRemoved value, $Res Function(_$WaypointRemoved) then) =
      __$$WaypointRemovedCopyWithImpl<$Res>;
  @useResult
  $Res call({int index});
}

/// @nodoc
class __$$WaypointRemovedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$WaypointRemoved>
    implements _$$WaypointRemovedCopyWith<$Res> {
  __$$WaypointRemovedCopyWithImpl(
      _$WaypointRemoved _value, $Res Function(_$WaypointRemoved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
  }) {
    return _then(_$WaypointRemoved(
      null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WaypointRemoved extends WaypointRemoved {
  const _$WaypointRemoved(this.index, {final String? $type})
      : $type = $type ?? 'waypointRemoved',
        super._();

  factory _$WaypointRemoved.fromJson(Map<String, dynamic> json) =>
      _$$WaypointRemovedFromJson(json);

  @override
  final int index;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.waypointRemoved(index: $index)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaypointRemoved &&
            (identical(other.index, index) || other.index == index));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaypointRemovedCopyWith<_$WaypointRemoved> get copyWith =>
      __$$WaypointRemovedCopyWithImpl<_$WaypointRemoved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return waypointRemoved(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return waypointRemoved?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (waypointRemoved != null) {
      return waypointRemoved(index);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return waypointRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return waypointRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (waypointRemoved != null) {
      return waypointRemoved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WaypointRemovedToJson(
      this,
    );
  }
}

abstract class WaypointRemoved extends DocumentEvent {
  const factory WaypointRemoved(final int index) = _$WaypointRemoved;
  const WaypointRemoved._() : super._();

  factory WaypointRemoved.fromJson(Map<String, dynamic> json) =
      _$WaypointRemoved.fromJson;

  int get index;
  @JsonKey(ignore: true)
  _$$WaypointRemovedCopyWith<_$WaypointRemoved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LayerRenamedCopyWith<$Res> {
  factory _$$LayerRenamedCopyWith(
          _$LayerRenamed value, $Res Function(_$LayerRenamed) then) =
      __$$LayerRenamedCopyWithImpl<$Res>;
  @useResult
  $Res call({String oldName, String newName});
}

/// @nodoc
class __$$LayerRenamedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$LayerRenamed>
    implements _$$LayerRenamedCopyWith<$Res> {
  __$$LayerRenamedCopyWithImpl(
      _$LayerRenamed _value, $Res Function(_$LayerRenamed) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldName = null,
    Object? newName = null,
  }) {
    return _then(_$LayerRenamed(
      null == oldName
          ? _value.oldName
          : oldName // ignore: cast_nullable_to_non_nullable
              as String,
      null == newName
          ? _value.newName
          : newName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LayerRenamed extends LayerRenamed {
  const _$LayerRenamed(this.oldName, this.newName, {final String? $type})
      : $type = $type ?? 'layerRenamed',
        super._();

  factory _$LayerRenamed.fromJson(Map<String, dynamic> json) =>
      _$$LayerRenamedFromJson(json);

  @override
  final String oldName;
  @override
  final String newName;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.layerRenamed(oldName: $oldName, newName: $newName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LayerRenamed &&
            (identical(other.oldName, oldName) || other.oldName == oldName) &&
            (identical(other.newName, newName) || other.newName == newName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, oldName, newName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LayerRenamedCopyWith<_$LayerRenamed> get copyWith =>
      __$$LayerRenamedCopyWithImpl<_$LayerRenamed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return layerRenamed(oldName, newName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return layerRenamed?.call(oldName, newName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (layerRenamed != null) {
      return layerRenamed(oldName, newName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return layerRenamed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return layerRenamed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (layerRenamed != null) {
      return layerRenamed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LayerRenamedToJson(
      this,
    );
  }
}

abstract class LayerRenamed extends DocumentEvent {
  const factory LayerRenamed(final String oldName, final String newName) =
      _$LayerRenamed;
  const LayerRenamed._() : super._();

  factory LayerRenamed.fromJson(Map<String, dynamic> json) =
      _$LayerRenamed.fromJson;

  String get oldName;
  String get newName;
  @JsonKey(ignore: true)
  _$$LayerRenamedCopyWith<_$LayerRenamed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LayerRemovedCopyWith<$Res> {
  factory _$$LayerRemovedCopyWith(
          _$LayerRemoved value, $Res Function(_$LayerRemoved) then) =
      __$$LayerRemovedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$LayerRemovedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$LayerRemoved>
    implements _$$LayerRemovedCopyWith<$Res> {
  __$$LayerRemovedCopyWithImpl(
      _$LayerRemoved _value, $Res Function(_$LayerRemoved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$LayerRemoved(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LayerRemoved extends LayerRemoved {
  const _$LayerRemoved(this.name, {final String? $type})
      : $type = $type ?? 'layerRemoved',
        super._();

  factory _$LayerRemoved.fromJson(Map<String, dynamic> json) =>
      _$$LayerRemovedFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.layerRemoved(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LayerRemoved &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LayerRemovedCopyWith<_$LayerRemoved> get copyWith =>
      __$$LayerRemovedCopyWithImpl<_$LayerRemoved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return layerRemoved(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return layerRemoved?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (layerRemoved != null) {
      return layerRemoved(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return layerRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return layerRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (layerRemoved != null) {
      return layerRemoved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LayerRemovedToJson(
      this,
    );
  }
}

abstract class LayerRemoved extends DocumentEvent {
  const factory LayerRemoved(final String name) = _$LayerRemoved;
  const LayerRemoved._() : super._();

  factory LayerRemoved.fromJson(Map<String, dynamic> json) =
      _$LayerRemoved.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$LayerRemovedCopyWith<_$LayerRemoved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LayerElementsRemovedCopyWith<$Res> {
  factory _$$LayerElementsRemovedCopyWith(_$LayerElementsRemoved value,
          $Res Function(_$LayerElementsRemoved) then) =
      __$$LayerElementsRemovedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$LayerElementsRemovedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$LayerElementsRemoved>
    implements _$$LayerElementsRemovedCopyWith<$Res> {
  __$$LayerElementsRemovedCopyWithImpl(_$LayerElementsRemoved _value,
      $Res Function(_$LayerElementsRemoved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$LayerElementsRemoved(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LayerElementsRemoved extends LayerElementsRemoved {
  const _$LayerElementsRemoved(this.name, {final String? $type})
      : $type = $type ?? 'layerElementsRemoved',
        super._();

  factory _$LayerElementsRemoved.fromJson(Map<String, dynamic> json) =>
      _$$LayerElementsRemovedFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.layerElementsRemoved(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LayerElementsRemoved &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LayerElementsRemovedCopyWith<_$LayerElementsRemoved> get copyWith =>
      __$$LayerElementsRemovedCopyWithImpl<_$LayerElementsRemoved>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return layerElementsRemoved(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return layerElementsRemoved?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (layerElementsRemoved != null) {
      return layerElementsRemoved(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return layerElementsRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return layerElementsRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (layerElementsRemoved != null) {
      return layerElementsRemoved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LayerElementsRemovedToJson(
      this,
    );
  }
}

abstract class LayerElementsRemoved extends DocumentEvent {
  const factory LayerElementsRemoved(final String name) =
      _$LayerElementsRemoved;
  const LayerElementsRemoved._() : super._();

  factory LayerElementsRemoved.fromJson(Map<String, dynamic> json) =
      _$LayerElementsRemoved.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$LayerElementsRemovedCopyWith<_$LayerElementsRemoved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LayerVisibilityChangedCopyWith<$Res> {
  factory _$$LayerVisibilityChangedCopyWith(_$LayerVisibilityChanged value,
          $Res Function(_$LayerVisibilityChanged) then) =
      __$$LayerVisibilityChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$LayerVisibilityChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$LayerVisibilityChanged>
    implements _$$LayerVisibilityChangedCopyWith<$Res> {
  __$$LayerVisibilityChangedCopyWithImpl(_$LayerVisibilityChanged _value,
      $Res Function(_$LayerVisibilityChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$LayerVisibilityChanged(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LayerVisibilityChanged extends LayerVisibilityChanged {
  const _$LayerVisibilityChanged(this.name, {final String? $type})
      : $type = $type ?? 'layerVisibilityChanged',
        super._();

  factory _$LayerVisibilityChanged.fromJson(Map<String, dynamic> json) =>
      _$$LayerVisibilityChangedFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.layerVisibilityChanged(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LayerVisibilityChanged &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LayerVisibilityChangedCopyWith<_$LayerVisibilityChanged> get copyWith =>
      __$$LayerVisibilityChangedCopyWithImpl<_$LayerVisibilityChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return layerVisibilityChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return layerVisibilityChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (layerVisibilityChanged != null) {
      return layerVisibilityChanged(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return layerVisibilityChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return layerVisibilityChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (layerVisibilityChanged != null) {
      return layerVisibilityChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LayerVisibilityChangedToJson(
      this,
    );
  }
}

abstract class LayerVisibilityChanged extends DocumentEvent {
  const factory LayerVisibilityChanged(final String name) =
      _$LayerVisibilityChanged;
  const LayerVisibilityChanged._() : super._();

  factory LayerVisibilityChanged.fromJson(Map<String, dynamic> json) =
      _$LayerVisibilityChanged.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$LayerVisibilityChangedCopyWith<_$LayerVisibilityChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CurrentLayerChangedCopyWith<$Res> {
  factory _$$CurrentLayerChangedCopyWith(_$CurrentLayerChanged value,
          $Res Function(_$CurrentLayerChanged) then) =
      __$$CurrentLayerChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$CurrentLayerChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$CurrentLayerChanged>
    implements _$$CurrentLayerChangedCopyWith<$Res> {
  __$$CurrentLayerChangedCopyWithImpl(
      _$CurrentLayerChanged _value, $Res Function(_$CurrentLayerChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$CurrentLayerChanged(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentLayerChanged extends CurrentLayerChanged {
  const _$CurrentLayerChanged(this.name, {final String? $type})
      : $type = $type ?? 'currentLayerChanged',
        super._();

  factory _$CurrentLayerChanged.fromJson(Map<String, dynamic> json) =>
      _$$CurrentLayerChangedFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.currentLayerChanged(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentLayerChanged &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentLayerChangedCopyWith<_$CurrentLayerChanged> get copyWith =>
      __$$CurrentLayerChangedCopyWithImpl<_$CurrentLayerChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return currentLayerChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return currentLayerChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (currentLayerChanged != null) {
      return currentLayerChanged(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return currentLayerChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return currentLayerChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (currentLayerChanged != null) {
      return currentLayerChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentLayerChangedToJson(
      this,
    );
  }
}

abstract class CurrentLayerChanged extends DocumentEvent {
  const factory CurrentLayerChanged(final String name) = _$CurrentLayerChanged;
  const CurrentLayerChanged._() : super._();

  factory CurrentLayerChanged.fromJson(Map<String, dynamic> json) =
      _$CurrentLayerChanged.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$CurrentLayerChangedCopyWith<_$CurrentLayerChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ElementsLayerChangedCopyWith<$Res> {
  factory _$$ElementsLayerChangedCopyWith(_$ElementsLayerChanged value,
          $Res Function(_$ElementsLayerChanged) then) =
      __$$ElementsLayerChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({String layer, List<int> elements});
}

/// @nodoc
class __$$ElementsLayerChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ElementsLayerChanged>
    implements _$$ElementsLayerChangedCopyWith<$Res> {
  __$$ElementsLayerChangedCopyWithImpl(_$ElementsLayerChanged _value,
      $Res Function(_$ElementsLayerChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? layer = null,
    Object? elements = null,
  }) {
    return _then(_$ElementsLayerChanged(
      null == layer
          ? _value.layer
          : layer // ignore: cast_nullable_to_non_nullable
              as String,
      null == elements
          ? _value._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElementsLayerChanged extends ElementsLayerChanged {
  const _$ElementsLayerChanged(this.layer, final List<int> elements,
      {final String? $type})
      : _elements = elements,
        $type = $type ?? 'elementsLayerChanged',
        super._();

  factory _$ElementsLayerChanged.fromJson(Map<String, dynamic> json) =>
      _$$ElementsLayerChangedFromJson(json);

  @override
  final String layer;
  final List<int> _elements;
  @override
  List<int> get elements {
    if (_elements is EqualUnmodifiableListView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_elements);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.elementsLayerChanged(layer: $layer, elements: $elements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElementsLayerChanged &&
            (identical(other.layer, layer) || other.layer == layer) &&
            const DeepCollectionEquality().equals(other._elements, _elements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, layer, const DeepCollectionEquality().hash(_elements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ElementsLayerChangedCopyWith<_$ElementsLayerChanged> get copyWith =>
      __$$ElementsLayerChangedCopyWithImpl<_$ElementsLayerChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return elementsLayerChanged(layer, elements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return elementsLayerChanged?.call(layer, elements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsLayerChanged != null) {
      return elementsLayerChanged(layer, elements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return elementsLayerChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return elementsLayerChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsLayerChanged != null) {
      return elementsLayerChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ElementsLayerChangedToJson(
      this,
    );
  }
}

abstract class ElementsLayerChanged extends DocumentEvent {
  const factory ElementsLayerChanged(
      final String layer, final List<int> elements) = _$ElementsLayerChanged;
  const ElementsLayerChanged._() : super._();

  factory ElementsLayerChanged.fromJson(Map<String, dynamic> json) =
      _$ElementsLayerChanged.fromJson;

  String get layer;
  List<int> get elements;
  @JsonKey(ignore: true)
  _$$ElementsLayerChangedCopyWith<_$ElementsLayerChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TemplateCreatedCopyWith<$Res> {
  factory _$$TemplateCreatedCopyWith(
          _$TemplateCreated value, $Res Function(_$TemplateCreated) then) =
      __$$TemplateCreatedCopyWithImpl<$Res>;
  @useResult
  $Res call({String directory, String? remote, bool deleteDocument});
}

/// @nodoc
class __$$TemplateCreatedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$TemplateCreated>
    implements _$$TemplateCreatedCopyWith<$Res> {
  __$$TemplateCreatedCopyWithImpl(
      _$TemplateCreated _value, $Res Function(_$TemplateCreated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? directory = null,
    Object? remote = freezed,
    Object? deleteDocument = null,
  }) {
    return _then(_$TemplateCreated(
      null == directory
          ? _value.directory
          : directory // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == remote
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as String?,
      null == deleteDocument
          ? _value.deleteDocument
          : deleteDocument // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TemplateCreated extends TemplateCreated {
  const _$TemplateCreated(this.directory,
      [this.remote, this.deleteDocument = true, final String? $type])
      : $type = $type ?? 'templateCreated',
        super._();

  factory _$TemplateCreated.fromJson(Map<String, dynamic> json) =>
      _$$TemplateCreatedFromJson(json);

  @override
  final String directory;
  @override
  final String? remote;
  @override
  @JsonKey()
  final bool deleteDocument;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.templateCreated(directory: $directory, remote: $remote, deleteDocument: $deleteDocument)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemplateCreated &&
            (identical(other.directory, directory) ||
                other.directory == directory) &&
            (identical(other.remote, remote) || other.remote == remote) &&
            (identical(other.deleteDocument, deleteDocument) ||
                other.deleteDocument == deleteDocument));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, directory, remote, deleteDocument);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TemplateCreatedCopyWith<_$TemplateCreated> get copyWith =>
      __$$TemplateCreatedCopyWithImpl<_$TemplateCreated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return templateCreated(directory, remote, deleteDocument);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return templateCreated?.call(directory, remote, deleteDocument);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (templateCreated != null) {
      return templateCreated(directory, remote, deleteDocument);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return templateCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return templateCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (templateCreated != null) {
      return templateCreated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TemplateCreatedToJson(
      this,
    );
  }
}

abstract class TemplateCreated extends DocumentEvent {
  const factory TemplateCreated(final String directory,
      [final String? remote, final bool deleteDocument]) = _$TemplateCreated;
  const TemplateCreated._() : super._();

  factory TemplateCreated.fromJson(Map<String, dynamic> json) =
      _$TemplateCreated.fromJson;

  String get directory;
  String? get remote;
  bool get deleteDocument;
  @JsonKey(ignore: true)
  _$$TemplateCreatedCopyWith<_$TemplateCreated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AreasCreatedCopyWith<$Res> {
  factory _$$AreasCreatedCopyWith(
          _$AreasCreated value, $Res Function(_$AreasCreated) then) =
      __$$AreasCreatedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Area> areas});
}

/// @nodoc
class __$$AreasCreatedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$AreasCreated>
    implements _$$AreasCreatedCopyWith<$Res> {
  __$$AreasCreatedCopyWithImpl(
      _$AreasCreated _value, $Res Function(_$AreasCreated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areas = null,
  }) {
    return _then(_$AreasCreated(
      null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<Area>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreasCreated extends AreasCreated {
  const _$AreasCreated(final List<Area> areas, {final String? $type})
      : _areas = areas,
        $type = $type ?? 'areasCreated',
        super._();

  factory _$AreasCreated.fromJson(Map<String, dynamic> json) =>
      _$$AreasCreatedFromJson(json);

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
    return 'DocumentEvent.areasCreated(areas: $areas)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreasCreated &&
            const DeepCollectionEquality().equals(other._areas, _areas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_areas));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreasCreatedCopyWith<_$AreasCreated> get copyWith =>
      __$$AreasCreatedCopyWithImpl<_$AreasCreated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return areasCreated(areas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return areasCreated?.call(areas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (areasCreated != null) {
      return areasCreated(areas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return areasCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return areasCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (areasCreated != null) {
      return areasCreated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AreasCreatedToJson(
      this,
    );
  }
}

abstract class AreasCreated extends DocumentEvent {
  const factory AreasCreated(final List<Area> areas) = _$AreasCreated;
  const AreasCreated._() : super._();

  factory AreasCreated.fromJson(Map<String, dynamic> json) =
      _$AreasCreated.fromJson;

  List<Area> get areas;
  @JsonKey(ignore: true)
  _$$AreasCreatedCopyWith<_$AreasCreated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AreasRemovedCopyWith<$Res> {
  factory _$$AreasRemovedCopyWith(
          _$AreasRemoved value, $Res Function(_$AreasRemoved) then) =
      __$$AreasRemovedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<String> areas});
}

/// @nodoc
class __$$AreasRemovedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$AreasRemoved>
    implements _$$AreasRemovedCopyWith<$Res> {
  __$$AreasRemovedCopyWithImpl(
      _$AreasRemoved _value, $Res Function(_$AreasRemoved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? areas = null,
  }) {
    return _then(_$AreasRemoved(
      null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AreasRemoved extends AreasRemoved {
  const _$AreasRemoved(final List<String> areas, {final String? $type})
      : _areas = areas,
        $type = $type ?? 'areasRemoved',
        super._();

  factory _$AreasRemoved.fromJson(Map<String, dynamic> json) =>
      _$$AreasRemovedFromJson(json);

  final List<String> _areas;
  @override
  List<String> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.areasRemoved(areas: $areas)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreasRemoved &&
            const DeepCollectionEquality().equals(other._areas, _areas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_areas));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreasRemovedCopyWith<_$AreasRemoved> get copyWith =>
      __$$AreasRemovedCopyWithImpl<_$AreasRemoved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return areasRemoved(areas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return areasRemoved?.call(areas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (areasRemoved != null) {
      return areasRemoved(areas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return areasRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return areasRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (areasRemoved != null) {
      return areasRemoved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AreasRemovedToJson(
      this,
    );
  }
}

abstract class AreasRemoved extends DocumentEvent {
  const factory AreasRemoved(final List<String> areas) = _$AreasRemoved;
  const AreasRemoved._() : super._();

  factory AreasRemoved.fromJson(Map<String, dynamic> json) =
      _$AreasRemoved.fromJson;

  List<String> get areas;
  @JsonKey(ignore: true)
  _$$AreasRemovedCopyWith<_$AreasRemoved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AreaChangedCopyWith<$Res> {
  factory _$$AreaChangedCopyWith(
          _$AreaChanged value, $Res Function(_$AreaChanged) then) =
      __$$AreaChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, Area area});

  $AreaCopyWith<$Res> get area;
}

/// @nodoc
class __$$AreaChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$AreaChanged>
    implements _$$AreaChangedCopyWith<$Res> {
  __$$AreaChangedCopyWithImpl(
      _$AreaChanged _value, $Res Function(_$AreaChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? area = null,
  }) {
    return _then(_$AreaChanged(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == area
          ? _value.area
          : area // ignore: cast_nullable_to_non_nullable
              as Area,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AreaCopyWith<$Res> get area {
    return $AreaCopyWith<$Res>(_value.area, (value) {
      return _then(_value.copyWith(area: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$AreaChanged extends AreaChanged {
  const _$AreaChanged(this.name, this.area, {final String? $type})
      : $type = $type ?? 'areaChanged',
        super._();

  factory _$AreaChanged.fromJson(Map<String, dynamic> json) =>
      _$$AreaChangedFromJson(json);

  @override
  final String name;
  @override
  final Area area;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.areaChanged(name: $name, area: $area)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AreaChanged &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.area, area) || other.area == area));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, area);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AreaChangedCopyWith<_$AreaChanged> get copyWith =>
      __$$AreaChangedCopyWithImpl<_$AreaChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return areaChanged(name, area);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return areaChanged?.call(name, area);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (areaChanged != null) {
      return areaChanged(name, area);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return areaChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return areaChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (areaChanged != null) {
      return areaChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AreaChangedToJson(
      this,
    );
  }
}

abstract class AreaChanged extends DocumentEvent {
  const factory AreaChanged(final String name, final Area area) = _$AreaChanged;
  const AreaChanged._() : super._();

  factory AreaChanged.fromJson(Map<String, dynamic> json) =
      _$AreaChanged.fromJson;

  String get name;
  Area get area;
  @JsonKey(ignore: true)
  _$$AreaChangedCopyWith<_$AreaChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CurrentAreaChangedCopyWith<$Res> {
  factory _$$CurrentAreaChangedCopyWith(_$CurrentAreaChanged value,
          $Res Function(_$CurrentAreaChanged) then) =
      __$$CurrentAreaChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$CurrentAreaChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$CurrentAreaChanged>
    implements _$$CurrentAreaChangedCopyWith<$Res> {
  __$$CurrentAreaChangedCopyWithImpl(
      _$CurrentAreaChanged _value, $Res Function(_$CurrentAreaChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$CurrentAreaChanged(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrentAreaChanged extends CurrentAreaChanged {
  const _$CurrentAreaChanged(this.name, {final String? $type})
      : $type = $type ?? 'currentAreaChanged',
        super._();

  factory _$CurrentAreaChanged.fromJson(Map<String, dynamic> json) =>
      _$$CurrentAreaChangedFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.currentAreaChanged(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrentAreaChanged &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrentAreaChangedCopyWith<_$CurrentAreaChanged> get copyWith =>
      __$$CurrentAreaChangedCopyWithImpl<_$CurrentAreaChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return currentAreaChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return currentAreaChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (currentAreaChanged != null) {
      return currentAreaChanged(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return currentAreaChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return currentAreaChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (currentAreaChanged != null) {
      return currentAreaChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentAreaChangedToJson(
      this,
    );
  }
}

abstract class CurrentAreaChanged extends DocumentEvent {
  const factory CurrentAreaChanged(final String name) = _$CurrentAreaChanged;
  const CurrentAreaChanged._() : super._();

  factory CurrentAreaChanged.fromJson(Map<String, dynamic> json) =
      _$CurrentAreaChanged.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$CurrentAreaChangedCopyWith<_$CurrentAreaChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExportPresetCreatedCopyWith<$Res> {
  factory _$$ExportPresetCreatedCopyWith(_$ExportPresetCreated value,
          $Res Function(_$ExportPresetCreated) then) =
      __$$ExportPresetCreatedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, List<AreaPreset> areas});
}

/// @nodoc
class __$$ExportPresetCreatedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ExportPresetCreated>
    implements _$$ExportPresetCreatedCopyWith<$Res> {
  __$$ExportPresetCreatedCopyWithImpl(
      _$ExportPresetCreated _value, $Res Function(_$ExportPresetCreated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? areas = null,
  }) {
    return _then(_$ExportPresetCreated(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<AreaPreset>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExportPresetCreated extends ExportPresetCreated {
  const _$ExportPresetCreated(this.name,
      [final List<AreaPreset> areas = const [], final String? $type])
      : _areas = areas,
        $type = $type ?? 'exportPresetCreated',
        super._();

  factory _$ExportPresetCreated.fromJson(Map<String, dynamic> json) =>
      _$$ExportPresetCreatedFromJson(json);

  @override
  final String name;
  final List<AreaPreset> _areas;
  @override
  @JsonKey()
  List<AreaPreset> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.exportPresetCreated(name: $name, areas: $areas)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportPresetCreated &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._areas, _areas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_areas));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportPresetCreatedCopyWith<_$ExportPresetCreated> get copyWith =>
      __$$ExportPresetCreatedCopyWithImpl<_$ExportPresetCreated>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return exportPresetCreated(name, areas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return exportPresetCreated?.call(name, areas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (exportPresetCreated != null) {
      return exportPresetCreated(name, areas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return exportPresetCreated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return exportPresetCreated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (exportPresetCreated != null) {
      return exportPresetCreated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ExportPresetCreatedToJson(
      this,
    );
  }
}

abstract class ExportPresetCreated extends DocumentEvent {
  const factory ExportPresetCreated(final String name,
      [final List<AreaPreset> areas]) = _$ExportPresetCreated;
  const ExportPresetCreated._() : super._();

  factory ExportPresetCreated.fromJson(Map<String, dynamic> json) =
      _$ExportPresetCreated.fromJson;

  String get name;
  List<AreaPreset> get areas;
  @JsonKey(ignore: true)
  _$$ExportPresetCreatedCopyWith<_$ExportPresetCreated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExportPresetUpdatedCopyWith<$Res> {
  factory _$$ExportPresetUpdatedCopyWith(_$ExportPresetUpdated value,
          $Res Function(_$ExportPresetUpdated) then) =
      __$$ExportPresetUpdatedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, List<AreaPreset> areas});
}

/// @nodoc
class __$$ExportPresetUpdatedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ExportPresetUpdated>
    implements _$$ExportPresetUpdatedCopyWith<$Res> {
  __$$ExportPresetUpdatedCopyWithImpl(
      _$ExportPresetUpdated _value, $Res Function(_$ExportPresetUpdated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? areas = null,
  }) {
    return _then(_$ExportPresetUpdated(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == areas
          ? _value._areas
          : areas // ignore: cast_nullable_to_non_nullable
              as List<AreaPreset>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExportPresetUpdated extends ExportPresetUpdated {
  const _$ExportPresetUpdated(this.name, final List<AreaPreset> areas,
      {final String? $type})
      : _areas = areas,
        $type = $type ?? 'exportPresetUpdated',
        super._();

  factory _$ExportPresetUpdated.fromJson(Map<String, dynamic> json) =>
      _$$ExportPresetUpdatedFromJson(json);

  @override
  final String name;
  final List<AreaPreset> _areas;
  @override
  List<AreaPreset> get areas {
    if (_areas is EqualUnmodifiableListView) return _areas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_areas);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.exportPresetUpdated(name: $name, areas: $areas)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportPresetUpdated &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._areas, _areas));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_areas));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportPresetUpdatedCopyWith<_$ExportPresetUpdated> get copyWith =>
      __$$ExportPresetUpdatedCopyWithImpl<_$ExportPresetUpdated>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return exportPresetUpdated(name, areas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return exportPresetUpdated?.call(name, areas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (exportPresetUpdated != null) {
      return exportPresetUpdated(name, areas);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return exportPresetUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return exportPresetUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (exportPresetUpdated != null) {
      return exportPresetUpdated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ExportPresetUpdatedToJson(
      this,
    );
  }
}

abstract class ExportPresetUpdated extends DocumentEvent {
  const factory ExportPresetUpdated(
      final String name, final List<AreaPreset> areas) = _$ExportPresetUpdated;
  const ExportPresetUpdated._() : super._();

  factory ExportPresetUpdated.fromJson(Map<String, dynamic> json) =
      _$ExportPresetUpdated.fromJson;

  String get name;
  List<AreaPreset> get areas;
  @JsonKey(ignore: true)
  _$$ExportPresetUpdatedCopyWith<_$ExportPresetUpdated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExportPresetRemovedCopyWith<$Res> {
  factory _$$ExportPresetRemovedCopyWith(_$ExportPresetRemoved value,
          $Res Function(_$ExportPresetRemoved) then) =
      __$$ExportPresetRemovedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$ExportPresetRemovedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ExportPresetRemoved>
    implements _$$ExportPresetRemovedCopyWith<$Res> {
  __$$ExportPresetRemovedCopyWithImpl(
      _$ExportPresetRemoved _value, $Res Function(_$ExportPresetRemoved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$ExportPresetRemoved(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExportPresetRemoved extends ExportPresetRemoved {
  const _$ExportPresetRemoved(this.name, {final String? $type})
      : $type = $type ?? 'exportPresetRemoved',
        super._();

  factory _$ExportPresetRemoved.fromJson(Map<String, dynamic> json) =>
      _$$ExportPresetRemovedFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.exportPresetRemoved(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportPresetRemoved &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExportPresetRemovedCopyWith<_$ExportPresetRemoved> get copyWith =>
      __$$ExportPresetRemovedCopyWithImpl<_$ExportPresetRemoved>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return exportPresetRemoved(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return exportPresetRemoved?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (exportPresetRemoved != null) {
      return exportPresetRemoved(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return exportPresetRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return exportPresetRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (exportPresetRemoved != null) {
      return exportPresetRemoved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ExportPresetRemovedToJson(
      this,
    );
  }
}

abstract class ExportPresetRemoved extends DocumentEvent {
  const factory ExportPresetRemoved(final String name) = _$ExportPresetRemoved;
  const ExportPresetRemoved._() : super._();

  factory ExportPresetRemoved.fromJson(Map<String, dynamic> json) =
      _$ExportPresetRemoved.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$ExportPresetRemovedCopyWith<_$ExportPresetRemoved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PackAddedCopyWith<$Res> {
  factory _$$PackAddedCopyWith(
          _$PackAdded value, $Res Function(_$PackAdded) then) =
      __$$PackAddedCopyWithImpl<$Res>;
  @useResult
  $Res call({NoteData pack});
}

/// @nodoc
class __$$PackAddedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$PackAdded>
    implements _$$PackAddedCopyWith<$Res> {
  __$$PackAddedCopyWithImpl(
      _$PackAdded _value, $Res Function(_$PackAdded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pack = null,
  }) {
    return _then(_$PackAdded(
      null == pack
          ? _value.pack
          : pack // ignore: cast_nullable_to_non_nullable
              as NoteData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PackAdded extends PackAdded {
  const _$PackAdded(this.pack, {final String? $type})
      : $type = $type ?? 'packAdded',
        super._();

  factory _$PackAdded.fromJson(Map<String, dynamic> json) =>
      _$$PackAddedFromJson(json);

  @override
  final NoteData pack;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.packAdded(pack: $pack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackAdded &&
            (identical(other.pack, pack) || other.pack == pack));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pack);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PackAddedCopyWith<_$PackAdded> get copyWith =>
      __$$PackAddedCopyWithImpl<_$PackAdded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return packAdded(pack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return packAdded?.call(pack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (packAdded != null) {
      return packAdded(pack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return packAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return packAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (packAdded != null) {
      return packAdded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PackAddedToJson(
      this,
    );
  }
}

abstract class PackAdded extends DocumentEvent {
  const factory PackAdded(final NoteData pack) = _$PackAdded;
  const PackAdded._() : super._();

  factory PackAdded.fromJson(Map<String, dynamic> json) = _$PackAdded.fromJson;

  NoteData get pack;
  @JsonKey(ignore: true)
  _$$PackAddedCopyWith<_$PackAdded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PackUpdatedCopyWith<$Res> {
  factory _$$PackUpdatedCopyWith(
          _$PackUpdated value, $Res Function(_$PackUpdated) then) =
      __$$PackUpdatedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, NoteData pack});
}

/// @nodoc
class __$$PackUpdatedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$PackUpdated>
    implements _$$PackUpdatedCopyWith<$Res> {
  __$$PackUpdatedCopyWithImpl(
      _$PackUpdated _value, $Res Function(_$PackUpdated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? pack = null,
  }) {
    return _then(_$PackUpdated(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == pack
          ? _value.pack
          : pack // ignore: cast_nullable_to_non_nullable
              as NoteData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PackUpdated extends PackUpdated {
  const _$PackUpdated(this.name, this.pack, {final String? $type})
      : $type = $type ?? 'packUpdated',
        super._();

  factory _$PackUpdated.fromJson(Map<String, dynamic> json) =>
      _$$PackUpdatedFromJson(json);

  @override
  final String name;
  @override
  final NoteData pack;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.packUpdated(name: $name, pack: $pack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackUpdated &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pack, pack) || other.pack == pack));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, pack);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PackUpdatedCopyWith<_$PackUpdated> get copyWith =>
      __$$PackUpdatedCopyWithImpl<_$PackUpdated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return packUpdated(name, pack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return packUpdated?.call(name, pack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (packUpdated != null) {
      return packUpdated(name, pack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return packUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return packUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (packUpdated != null) {
      return packUpdated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PackUpdatedToJson(
      this,
    );
  }
}

abstract class PackUpdated extends DocumentEvent {
  const factory PackUpdated(final String name, final NoteData pack) =
      _$PackUpdated;
  const PackUpdated._() : super._();

  factory PackUpdated.fromJson(Map<String, dynamic> json) =
      _$PackUpdated.fromJson;

  String get name;
  NoteData get pack;
  @JsonKey(ignore: true)
  _$$PackUpdatedCopyWith<_$PackUpdated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PackRemovedCopyWith<$Res> {
  factory _$$PackRemovedCopyWith(
          _$PackRemoved value, $Res Function(_$PackRemoved) then) =
      __$$PackRemovedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$PackRemovedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$PackRemoved>
    implements _$$PackRemovedCopyWith<$Res> {
  __$$PackRemovedCopyWithImpl(
      _$PackRemoved _value, $Res Function(_$PackRemoved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$PackRemoved(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PackRemoved extends PackRemoved {
  const _$PackRemoved(this.name, {final String? $type})
      : $type = $type ?? 'packRemoved',
        super._();

  factory _$PackRemoved.fromJson(Map<String, dynamic> json) =>
      _$$PackRemovedFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.packRemoved(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackRemoved &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PackRemovedCopyWith<_$PackRemoved> get copyWith =>
      __$$PackRemovedCopyWithImpl<_$PackRemoved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return packRemoved(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return packRemoved?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (packRemoved != null) {
      return packRemoved(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return packRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return packRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (packRemoved != null) {
      return packRemoved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PackRemovedToJson(
      this,
    );
  }
}

abstract class PackRemoved extends DocumentEvent {
  const factory PackRemoved(final String name) = _$PackRemoved;
  const PackRemoved._() : super._();

  factory PackRemoved.fromJson(Map<String, dynamic> json) =
      _$PackRemoved.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$PackRemovedCopyWith<_$PackRemoved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnimationAddedCopyWith<$Res> {
  factory _$$AnimationAddedCopyWith(
          _$AnimationAdded value, $Res Function(_$AnimationAdded) then) =
      __$$AnimationAddedCopyWithImpl<$Res>;
  @useResult
  $Res call({AnimationTrack animation});

  $AnimationTrackCopyWith<$Res> get animation;
}

/// @nodoc
class __$$AnimationAddedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$AnimationAdded>
    implements _$$AnimationAddedCopyWith<$Res> {
  __$$AnimationAddedCopyWithImpl(
      _$AnimationAdded _value, $Res Function(_$AnimationAdded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? animation = null,
  }) {
    return _then(_$AnimationAdded(
      null == animation
          ? _value.animation
          : animation // ignore: cast_nullable_to_non_nullable
              as AnimationTrack,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AnimationTrackCopyWith<$Res> get animation {
    return $AnimationTrackCopyWith<$Res>(_value.animation, (value) {
      return _then(_value.copyWith(animation: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$AnimationAdded extends AnimationAdded {
  const _$AnimationAdded(this.animation, {final String? $type})
      : $type = $type ?? 'animationAdded',
        super._();

  factory _$AnimationAdded.fromJson(Map<String, dynamic> json) =>
      _$$AnimationAddedFromJson(json);

  @override
  final AnimationTrack animation;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.animationAdded(animation: $animation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnimationAdded &&
            (identical(other.animation, animation) ||
                other.animation == animation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, animation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnimationAddedCopyWith<_$AnimationAdded> get copyWith =>
      __$$AnimationAddedCopyWithImpl<_$AnimationAdded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return animationAdded(animation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return animationAdded?.call(animation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (animationAdded != null) {
      return animationAdded(animation);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return animationAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return animationAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (animationAdded != null) {
      return animationAdded(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AnimationAddedToJson(
      this,
    );
  }
}

abstract class AnimationAdded extends DocumentEvent {
  const factory AnimationAdded(final AnimationTrack animation) =
      _$AnimationAdded;
  const AnimationAdded._() : super._();

  factory AnimationAdded.fromJson(Map<String, dynamic> json) =
      _$AnimationAdded.fromJson;

  AnimationTrack get animation;
  @JsonKey(ignore: true)
  _$$AnimationAddedCopyWith<_$AnimationAdded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnimationUpdatedCopyWith<$Res> {
  factory _$$AnimationUpdatedCopyWith(
          _$AnimationUpdated value, $Res Function(_$AnimationUpdated) then) =
      __$$AnimationUpdatedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, AnimationTrack animation});

  $AnimationTrackCopyWith<$Res> get animation;
}

/// @nodoc
class __$$AnimationUpdatedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$AnimationUpdated>
    implements _$$AnimationUpdatedCopyWith<$Res> {
  __$$AnimationUpdatedCopyWithImpl(
      _$AnimationUpdated _value, $Res Function(_$AnimationUpdated) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? animation = null,
  }) {
    return _then(_$AnimationUpdated(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == animation
          ? _value.animation
          : animation // ignore: cast_nullable_to_non_nullable
              as AnimationTrack,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AnimationTrackCopyWith<$Res> get animation {
    return $AnimationTrackCopyWith<$Res>(_value.animation, (value) {
      return _then(_value.copyWith(animation: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$AnimationUpdated extends AnimationUpdated {
  const _$AnimationUpdated(this.name, this.animation, {final String? $type})
      : $type = $type ?? 'animationUpdated',
        super._();

  factory _$AnimationUpdated.fromJson(Map<String, dynamic> json) =>
      _$$AnimationUpdatedFromJson(json);

  @override
  final String name;
  @override
  final AnimationTrack animation;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.animationUpdated(name: $name, animation: $animation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnimationUpdated &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.animation, animation) ||
                other.animation == animation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, animation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnimationUpdatedCopyWith<_$AnimationUpdated> get copyWith =>
      __$$AnimationUpdatedCopyWithImpl<_$AnimationUpdated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return animationUpdated(name, animation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return animationUpdated?.call(name, animation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (animationUpdated != null) {
      return animationUpdated(name, animation);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return animationUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return animationUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (animationUpdated != null) {
      return animationUpdated(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AnimationUpdatedToJson(
      this,
    );
  }
}

abstract class AnimationUpdated extends DocumentEvent {
  const factory AnimationUpdated(
      final String name, final AnimationTrack animation) = _$AnimationUpdated;
  const AnimationUpdated._() : super._();

  factory AnimationUpdated.fromJson(Map<String, dynamic> json) =
      _$AnimationUpdated.fromJson;

  String get name;
  AnimationTrack get animation;
  @JsonKey(ignore: true)
  _$$AnimationUpdatedCopyWith<_$AnimationUpdated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnimationRemovedCopyWith<$Res> {
  factory _$$AnimationRemovedCopyWith(
          _$AnimationRemoved value, $Res Function(_$AnimationRemoved) then) =
      __$$AnimationRemovedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$AnimationRemovedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$AnimationRemoved>
    implements _$$AnimationRemovedCopyWith<$Res> {
  __$$AnimationRemovedCopyWithImpl(
      _$AnimationRemoved _value, $Res Function(_$AnimationRemoved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$AnimationRemoved(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnimationRemoved extends AnimationRemoved {
  const _$AnimationRemoved(this.name, {final String? $type})
      : $type = $type ?? 'animationRemoved',
        super._();

  factory _$AnimationRemoved.fromJson(Map<String, dynamic> json) =>
      _$$AnimationRemovedFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.animationRemoved(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnimationRemoved &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnimationRemovedCopyWith<_$AnimationRemoved> get copyWith =>
      __$$AnimationRemovedCopyWithImpl<_$AnimationRemoved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return animationRemoved(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return animationRemoved?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (animationRemoved != null) {
      return animationRemoved(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return animationRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return animationRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (animationRemoved != null) {
      return animationRemoved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AnimationRemovedToJson(
      this,
    );
  }
}

abstract class AnimationRemoved extends DocumentEvent {
  const factory AnimationRemoved(final String name) = _$AnimationRemoved;
  const AnimationRemoved._() : super._();

  factory AnimationRemoved.fromJson(Map<String, dynamic> json) =
      _$AnimationRemoved.fromJson;

  String get name;
  @JsonKey(ignore: true)
  _$$AnimationRemovedCopyWith<_$AnimationRemoved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PresentationModeEnteredCopyWith<$Res> {
  factory _$$PresentationModeEnteredCopyWith(_$PresentationModeEntered value,
          $Res Function(_$PresentationModeEntered) then) =
      __$$PresentationModeEnteredCopyWithImpl<$Res>;
  @useResult
  $Res call({AnimationTrack track, bool fullScreen});

  $AnimationTrackCopyWith<$Res> get track;
}

/// @nodoc
class __$$PresentationModeEnteredCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$PresentationModeEntered>
    implements _$$PresentationModeEnteredCopyWith<$Res> {
  __$$PresentationModeEnteredCopyWithImpl(_$PresentationModeEntered _value,
      $Res Function(_$PresentationModeEntered) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? track = null,
    Object? fullScreen = null,
  }) {
    return _then(_$PresentationModeEntered(
      null == track
          ? _value.track
          : track // ignore: cast_nullable_to_non_nullable
              as AnimationTrack,
      null == fullScreen
          ? _value.fullScreen
          : fullScreen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AnimationTrackCopyWith<$Res> get track {
    return $AnimationTrackCopyWith<$Res>(_value.track, (value) {
      return _then(_value.copyWith(track: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$PresentationModeEntered extends PresentationModeEntered {
  const _$PresentationModeEntered(this.track, this.fullScreen,
      {final String? $type})
      : $type = $type ?? 'presentationModeEntered',
        super._();

  factory _$PresentationModeEntered.fromJson(Map<String, dynamic> json) =>
      _$$PresentationModeEnteredFromJson(json);

  @override
  final AnimationTrack track;
  @override
  final bool fullScreen;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.presentationModeEntered(track: $track, fullScreen: $fullScreen)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresentationModeEntered &&
            (identical(other.track, track) || other.track == track) &&
            (identical(other.fullScreen, fullScreen) ||
                other.fullScreen == fullScreen));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, track, fullScreen);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentationModeEnteredCopyWith<_$PresentationModeEntered> get copyWith =>
      __$$PresentationModeEnteredCopyWithImpl<_$PresentationModeEntered>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return presentationModeEntered(track, fullScreen);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return presentationModeEntered?.call(track, fullScreen);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (presentationModeEntered != null) {
      return presentationModeEntered(track, fullScreen);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return presentationModeEntered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return presentationModeEntered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (presentationModeEntered != null) {
      return presentationModeEntered(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PresentationModeEnteredToJson(
      this,
    );
  }
}

abstract class PresentationModeEntered extends DocumentEvent {
  const factory PresentationModeEntered(
          final AnimationTrack track, final bool fullScreen) =
      _$PresentationModeEntered;
  const PresentationModeEntered._() : super._();

  factory PresentationModeEntered.fromJson(Map<String, dynamic> json) =
      _$PresentationModeEntered.fromJson;

  AnimationTrack get track;
  bool get fullScreen;
  @JsonKey(ignore: true)
  _$$PresentationModeEnteredCopyWith<_$PresentationModeEntered> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PresentationModeExitedCopyWith<$Res> {
  factory _$$PresentationModeExitedCopyWith(_$PresentationModeExited value,
          $Res Function(_$PresentationModeExited) then) =
      __$$PresentationModeExitedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PresentationModeExitedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$PresentationModeExited>
    implements _$$PresentationModeExitedCopyWith<$Res> {
  __$$PresentationModeExitedCopyWithImpl(_$PresentationModeExited _value,
      $Res Function(_$PresentationModeExited) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$PresentationModeExited extends PresentationModeExited {
  const _$PresentationModeExited({final String? $type})
      : $type = $type ?? 'presentationModeExited',
        super._();

  factory _$PresentationModeExited.fromJson(Map<String, dynamic> json) =>
      _$$PresentationModeExitedFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.presentationModeExited()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PresentationModeExited);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return presentationModeExited();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return presentationModeExited?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (presentationModeExited != null) {
      return presentationModeExited();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return presentationModeExited(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return presentationModeExited?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (presentationModeExited != null) {
      return presentationModeExited(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PresentationModeExitedToJson(
      this,
    );
  }
}

abstract class PresentationModeExited extends DocumentEvent {
  const factory PresentationModeExited() = _$PresentationModeExited;
  const PresentationModeExited._() : super._();

  factory PresentationModeExited.fromJson(Map<String, dynamic> json) =
      _$PresentationModeExited.fromJson;
}

/// @nodoc
abstract class _$$PresentationTickCopyWith<$Res> {
  factory _$$PresentationTickCopyWith(
          _$PresentationTick value, $Res Function(_$PresentationTick) then) =
      __$$PresentationTickCopyWithImpl<$Res>;
  @useResult
  $Res call({int tick});
}

/// @nodoc
class __$$PresentationTickCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$PresentationTick>
    implements _$$PresentationTickCopyWith<$Res> {
  __$$PresentationTickCopyWithImpl(
      _$PresentationTick _value, $Res Function(_$PresentationTick) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tick = null,
  }) {
    return _then(_$PresentationTick(
      null == tick
          ? _value.tick
          : tick // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresentationTick extends PresentationTick {
  const _$PresentationTick(this.tick, {final String? $type})
      : $type = $type ?? 'presentationTick',
        super._();

  factory _$PresentationTick.fromJson(Map<String, dynamic> json) =>
      _$$PresentationTickFromJson(json);

  @override
  final int tick;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.presentationTick(tick: $tick)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresentationTick &&
            (identical(other.tick, tick) || other.tick == tick));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tick);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PresentationTickCopyWith<_$PresentationTick> get copyWith =>
      __$$PresentationTickCopyWithImpl<_$PresentationTick>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ViewOption view) viewChanged,
    required TResult Function(UtilitiesState state) utilitiesChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> elements)
        elementsChanged,
    required TResult Function(List<int> elements) elementsRemoved,
    required TResult Function(Arrangement arrangement, List<int> elements)
        elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(Tool tool) toolCreated,
    required TResult Function(Map<int, Tool> tools) toolsChanged,
    required TResult Function(List<int> tools) toolsRemoved,
    required TResult Function(int oldIndex, int newIndex) toolReordered,
    required TResult Function(List<Background> backgrounds)
        documentBackgroundsChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index, String name) waypointRenamed,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String layer, List<int> elements)
        elementsLayerChanged,
    required TResult Function(
            String directory, String? remote, bool deleteDocument)
        templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetCreated,
    required TResult Function(String name, List<AreaPreset> areas)
        exportPresetUpdated,
    required TResult Function(String name) exportPresetRemoved,
    required TResult Function(NoteData pack) packAdded,
    required TResult Function(String name, NoteData pack) packUpdated,
    required TResult Function(String name) packRemoved,
    required TResult Function(AnimationTrack animation) animationAdded,
    required TResult Function(String name, AnimationTrack animation)
        animationUpdated,
    required TResult Function(String name) animationRemoved,
    required TResult Function(AnimationTrack track, bool fullScreen)
        presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return presentationTick(tick);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ViewOption view)? viewChanged,
    TResult? Function(UtilitiesState state)? utilitiesChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult? Function(List<int> elements)? elementsRemoved,
    TResult? Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(Tool tool)? toolCreated,
    TResult? Function(Map<int, Tool> tools)? toolsChanged,
    TResult? Function(List<int> tools)? toolsRemoved,
    TResult? Function(int oldIndex, int newIndex)? toolReordered,
    TResult? Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index, String name)? waypointRenamed,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult? Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return presentationTick?.call(tick);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ViewOption view)? viewChanged,
    TResult Function(UtilitiesState state)? utilitiesChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> elements)? elementsChanged,
    TResult Function(List<int> elements)? elementsRemoved,
    TResult Function(Arrangement arrangement, List<int> elements)?
        elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(Tool tool)? toolCreated,
    TResult Function(Map<int, Tool> tools)? toolsChanged,
    TResult Function(List<int> tools)? toolsRemoved,
    TResult Function(int oldIndex, int newIndex)? toolReordered,
    TResult Function(List<Background> backgrounds)? documentBackgroundsChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index, String name)? waypointRenamed,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String layer, List<int> elements)? elementsLayerChanged,
    TResult Function(String directory, String? remote, bool deleteDocument)?
        templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function(AnimationTrack track, bool fullScreen)?
        presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (presentationTick != null) {
      return presentationTick(tick);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ViewChanged value) viewChanged,
    required TResult Function(UtilitiesChanged value) utilitiesChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(ToolCreated value) toolCreated,
    required TResult Function(ToolsChanged value) toolsChanged,
    required TResult Function(ToolsRemoved value) toolsRemoved,
    required TResult Function(ToolReordered value) toolReordered,
    required TResult Function(DocumentBackgroundsChanged value)
        documentBackgroundsChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRenamed value) waypointRenamed,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
    required TResult Function(ElementsLayerChanged value) elementsLayerChanged,
    required TResult Function(TemplateCreated value) templateCreated,
    required TResult Function(AreasCreated value) areasCreated,
    required TResult Function(AreasRemoved value) areasRemoved,
    required TResult Function(AreaChanged value) areaChanged,
    required TResult Function(CurrentAreaChanged value) currentAreaChanged,
    required TResult Function(ExportPresetCreated value) exportPresetCreated,
    required TResult Function(ExportPresetUpdated value) exportPresetUpdated,
    required TResult Function(ExportPresetRemoved value) exportPresetRemoved,
    required TResult Function(PackAdded value) packAdded,
    required TResult Function(PackUpdated value) packUpdated,
    required TResult Function(PackRemoved value) packRemoved,
    required TResult Function(AnimationAdded value) animationAdded,
    required TResult Function(AnimationUpdated value) animationUpdated,
    required TResult Function(AnimationRemoved value) animationRemoved,
    required TResult Function(PresentationModeEntered value)
        presentationModeEntered,
    required TResult Function(PresentationModeExited value)
        presentationModeExited,
    required TResult Function(PresentationTick value) presentationTick,
  }) {
    return presentationTick(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ViewChanged value)? viewChanged,
    TResult? Function(UtilitiesChanged value)? utilitiesChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(ToolCreated value)? toolCreated,
    TResult? Function(ToolsChanged value)? toolsChanged,
    TResult? Function(ToolsRemoved value)? toolsRemoved,
    TResult? Function(ToolReordered value)? toolReordered,
    TResult? Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRenamed value)? waypointRenamed,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult? Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult? Function(TemplateCreated value)? templateCreated,
    TResult? Function(AreasCreated value)? areasCreated,
    TResult? Function(AreasRemoved value)? areasRemoved,
    TResult? Function(AreaChanged value)? areaChanged,
    TResult? Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult? Function(ExportPresetCreated value)? exportPresetCreated,
    TResult? Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult? Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult? Function(PackAdded value)? packAdded,
    TResult? Function(PackUpdated value)? packUpdated,
    TResult? Function(PackRemoved value)? packRemoved,
    TResult? Function(AnimationAdded value)? animationAdded,
    TResult? Function(AnimationUpdated value)? animationUpdated,
    TResult? Function(AnimationRemoved value)? animationRemoved,
    TResult? Function(PresentationModeEntered value)? presentationModeEntered,
    TResult? Function(PresentationModeExited value)? presentationModeExited,
    TResult? Function(PresentationTick value)? presentationTick,
  }) {
    return presentationTick?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ViewChanged value)? viewChanged,
    TResult Function(UtilitiesChanged value)? utilitiesChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(ToolCreated value)? toolCreated,
    TResult Function(ToolsChanged value)? toolsChanged,
    TResult Function(ToolsRemoved value)? toolsRemoved,
    TResult Function(ToolReordered value)? toolReordered,
    TResult Function(DocumentBackgroundsChanged value)?
        documentBackgroundsChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRenamed value)? waypointRenamed,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
    TResult Function(ElementsLayerChanged value)? elementsLayerChanged,
    TResult Function(TemplateCreated value)? templateCreated,
    TResult Function(AreasCreated value)? areasCreated,
    TResult Function(AreasRemoved value)? areasRemoved,
    TResult Function(AreaChanged value)? areaChanged,
    TResult Function(CurrentAreaChanged value)? currentAreaChanged,
    TResult Function(ExportPresetCreated value)? exportPresetCreated,
    TResult Function(ExportPresetUpdated value)? exportPresetUpdated,
    TResult Function(ExportPresetRemoved value)? exportPresetRemoved,
    TResult Function(PackAdded value)? packAdded,
    TResult Function(PackUpdated value)? packUpdated,
    TResult Function(PackRemoved value)? packRemoved,
    TResult Function(AnimationAdded value)? animationAdded,
    TResult Function(AnimationUpdated value)? animationUpdated,
    TResult Function(AnimationRemoved value)? animationRemoved,
    TResult Function(PresentationModeEntered value)? presentationModeEntered,
    TResult Function(PresentationModeExited value)? presentationModeExited,
    TResult Function(PresentationTick value)? presentationTick,
    required TResult orElse(),
  }) {
    if (presentationTick != null) {
      return presentationTick(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PresentationTickToJson(
      this,
    );
  }
}

abstract class PresentationTick extends DocumentEvent {
  const factory PresentationTick(final int tick) = _$PresentationTick;
  const PresentationTick._() : super._();

  factory PresentationTick.fromJson(Map<String, dynamic> json) =
      _$PresentationTick.fromJson;

  int get tick;
  @JsonKey(ignore: true)
  _$$PresentationTickCopyWith<_$PresentationTick> get copyWith =>
      throw _privateConstructorUsedError;
}
