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
    case 'toolOptionChanged':
      return ToolOptionChanged.fromJson(json);
    case 'toolStateChanged':
      return ToolStateChanged.fromJson(json);
    case 'elementsCreated':
      return ElementsCreated.fromJson(json);
    case 'elementsReplaced':
      return ElementsReplaced.fromJson(json);
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
    case 'paintersChanged':
      return PaintersChanged.fromJson(json);
    case 'paintersRemoved':
      return PaintersRemoved.fromJson(json);
    case 'painterReordered':
      return PainterReordered.fromJson(json);
    case 'documentBackgroundChanged':
      return DocumentBackgroundChanged.fromJson(json);
    case 'waypointCreated':
      return WaypointCreated.fromJson(json);
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return pageChanged(pageName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return pageChanged?.call(pageName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
abstract class _$$ToolOptionChangedCopyWith<$Res> {
  factory _$$ToolOptionChangedCopyWith(
          _$ToolOptionChanged value, $Res Function(_$ToolOptionChanged) then) =
      __$$ToolOptionChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({ToolOption? option});

  $ToolOptionCopyWith<$Res>? get option;
}

/// @nodoc
class __$$ToolOptionChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ToolOptionChanged>
    implements _$$ToolOptionChangedCopyWith<$Res> {
  __$$ToolOptionChangedCopyWithImpl(
      _$ToolOptionChanged _value, $Res Function(_$ToolOptionChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? option = freezed,
  }) {
    return _then(_$ToolOptionChanged(
      freezed == option
          ? _value.option
          : option // ignore: cast_nullable_to_non_nullable
              as ToolOption?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ToolOptionCopyWith<$Res>? get option {
    if (_value.option == null) {
      return null;
    }

    return $ToolOptionCopyWith<$Res>(_value.option!, (value) {
      return _then(_value.copyWith(option: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ToolOptionChanged extends ToolOptionChanged {
  const _$ToolOptionChanged([this.option, final String? $type])
      : $type = $type ?? 'toolOptionChanged',
        super._();

  factory _$ToolOptionChanged.fromJson(Map<String, dynamic> json) =>
      _$$ToolOptionChangedFromJson(json);

  @override
  final ToolOption? option;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.toolOptionChanged(option: $option)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToolOptionChanged &&
            (identical(other.option, option) || other.option == option));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, option);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ToolOptionChangedCopyWith<_$ToolOptionChanged> get copyWith =>
      __$$ToolOptionChangedCopyWithImpl<_$ToolOptionChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return toolOptionChanged(option);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return toolOptionChanged?.call(option);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (toolOptionChanged != null) {
      return toolOptionChanged(option);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    return toolOptionChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    return toolOptionChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    if (toolOptionChanged != null) {
      return toolOptionChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ToolOptionChangedToJson(
      this,
    );
  }
}

abstract class ToolOptionChanged extends DocumentEvent {
  const factory ToolOptionChanged([final ToolOption? option]) =
      _$ToolOptionChanged;
  const ToolOptionChanged._() : super._();

  factory ToolOptionChanged.fromJson(Map<String, dynamic> json) =
      _$ToolOptionChanged.fromJson;

  ToolOption? get option;
  @JsonKey(ignore: true)
  _$$ToolOptionChangedCopyWith<_$ToolOptionChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToolStateChangedCopyWith<$Res> {
  factory _$$ToolStateChangedCopyWith(
          _$ToolStateChanged value, $Res Function(_$ToolStateChanged) then) =
      __$$ToolStateChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({ToolState? state});

  $ToolStateCopyWith<$Res>? get state;
}

/// @nodoc
class __$$ToolStateChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ToolStateChanged>
    implements _$$ToolStateChangedCopyWith<$Res> {
  __$$ToolStateChangedCopyWithImpl(
      _$ToolStateChanged _value, $Res Function(_$ToolStateChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = freezed,
  }) {
    return _then(_$ToolStateChanged(
      freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ToolState?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ToolStateCopyWith<$Res>? get state {
    if (_value.state == null) {
      return null;
    }

    return $ToolStateCopyWith<$Res>(_value.state!, (value) {
      return _then(_value.copyWith(state: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ToolStateChanged extends ToolStateChanged {
  const _$ToolStateChanged([this.state, final String? $type])
      : $type = $type ?? 'toolStateChanged',
        super._();

  factory _$ToolStateChanged.fromJson(Map<String, dynamic> json) =>
      _$$ToolStateChangedFromJson(json);

  @override
  final ToolState? state;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.toolStateChanged(state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToolStateChanged &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ToolStateChangedCopyWith<_$ToolStateChanged> get copyWith =>
      __$$ToolStateChangedCopyWithImpl<_$ToolStateChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return toolStateChanged(state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return toolStateChanged?.call(state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (toolStateChanged != null) {
      return toolStateChanged(state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    return toolStateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    return toolStateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    if (toolStateChanged != null) {
      return toolStateChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ToolStateChangedToJson(
      this,
    );
  }
}

abstract class ToolStateChanged extends DocumentEvent {
  const factory ToolStateChanged([final ToolState? state]) = _$ToolStateChanged;
  const ToolStateChanged._() : super._();

  factory ToolStateChanged.fromJson(Map<String, dynamic> json) =
      _$ToolStateChanged.fromJson;

  ToolState? get state;
  @JsonKey(ignore: true)
  _$$ToolStateChangedCopyWith<_$ToolStateChanged> get copyWith =>
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return elementsCreated(elements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return elementsCreated?.call(elements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
abstract class _$$ElementsReplacedCopyWith<$Res> {
  factory _$$ElementsReplacedCopyWith(
          _$ElementsReplaced value, $Res Function(_$ElementsReplaced) then) =
      __$$ElementsReplacedCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<int, List<PadElement>> replacedElements});
}

/// @nodoc
class __$$ElementsReplacedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$ElementsReplaced>
    implements _$$ElementsReplacedCopyWith<$Res> {
  __$$ElementsReplacedCopyWithImpl(
      _$ElementsReplaced _value, $Res Function(_$ElementsReplaced) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replacedElements = null,
  }) {
    return _then(_$ElementsReplaced(
      null == replacedElements
          ? _value._replacedElements
          : replacedElements // ignore: cast_nullable_to_non_nullable
              as Map<int, List<PadElement>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElementsReplaced extends ElementsReplaced {
  const _$ElementsReplaced(final Map<int, List<PadElement>> replacedElements,
      {final String? $type})
      : _replacedElements = replacedElements,
        $type = $type ?? 'elementsReplaced',
        super._();

  factory _$ElementsReplaced.fromJson(Map<String, dynamic> json) =>
      _$$ElementsReplacedFromJson(json);

  final Map<int, List<PadElement>> _replacedElements;
  @override
  Map<int, List<PadElement>> get replacedElements {
    if (_replacedElements is EqualUnmodifiableMapView) return _replacedElements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_replacedElements);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.elementsReplaced(replacedElements: $replacedElements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElementsReplaced &&
            const DeepCollectionEquality()
                .equals(other._replacedElements, _replacedElements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_replacedElements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ElementsReplacedCopyWith<_$ElementsReplaced> get copyWith =>
      __$$ElementsReplacedCopyWithImpl<_$ElementsReplaced>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return elementsReplaced(replacedElements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return elementsReplaced?.call(replacedElements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsReplaced != null) {
      return elementsReplaced(replacedElements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    return elementsReplaced(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    return elementsReplaced?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    if (elementsReplaced != null) {
      return elementsReplaced(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ElementsReplacedToJson(
      this,
    );
  }
}

abstract class ElementsReplaced extends DocumentEvent {
  const factory ElementsReplaced(
      final Map<int, List<PadElement>> replacedElements) = _$ElementsReplaced;
  const ElementsReplaced._() : super._();

  factory ElementsReplaced.fromJson(Map<String, dynamic> json) =
      _$ElementsReplaced.fromJson;

  Map<int, List<PadElement>> get replacedElements;
  @JsonKey(ignore: true)
  _$$ElementsReplacedCopyWith<_$ElementsReplaced> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ElementsChangedCopyWith<$Res> {
  factory _$$ElementsChangedCopyWith(
          _$ElementsChanged value, $Res Function(_$ElementsChanged) then) =
      __$$ElementsChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<(PadElement, List<PadElement>)> changedElements});
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
    Object? changedElements = null,
  }) {
    return _then(_$ElementsChanged(
      null == changedElements
          ? _value._changedElements
          : changedElements // ignore: cast_nullable_to_non_nullable
              as List<(PadElement, List<PadElement>)>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElementsChanged extends ElementsChanged {
  const _$ElementsChanged(
      final List<(PadElement, List<PadElement>)> changedElements,
      {final String? $type})
      : _changedElements = changedElements,
        $type = $type ?? 'elementsChanged',
        super._();

  factory _$ElementsChanged.fromJson(Map<String, dynamic> json) =>
      _$$ElementsChangedFromJson(json);

  final List<(PadElement, List<PadElement>)> _changedElements;
  @override
  List<(PadElement, List<PadElement>)> get changedElements {
    if (_changedElements is EqualUnmodifiableListView) return _changedElements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_changedElements);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.elementsChanged(changedElements: $changedElements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElementsChanged &&
            const DeepCollectionEquality()
                .equals(other._changedElements, _changedElements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_changedElements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ElementsChangedCopyWith<_$ElementsChanged> get copyWith =>
      __$$ElementsChangedCopyWithImpl<_$ElementsChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return elementsChanged(changedElements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return elementsChanged?.call(changedElements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsChanged != null) {
      return elementsChanged(changedElements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
  const factory ElementsChanged(
          final List<(PadElement, List<PadElement>)> changedElements) =
      _$ElementsChanged;
  const ElementsChanged._() : super._();

  factory ElementsChanged.fromJson(Map<String, dynamic> json) =
      _$ElementsChanged.fromJson;

  List<(PadElement, List<PadElement>)> get changedElements;
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
  $Res call({List<PadElement> elements});
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
              as List<PadElement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElementsRemoved extends ElementsRemoved {
  const _$ElementsRemoved(final List<PadElement> elements,
      {final String? $type})
      : _elements = elements,
        $type = $type ?? 'elementsRemoved',
        super._();

  factory _$ElementsRemoved.fromJson(Map<String, dynamic> json) =>
      _$$ElementsRemovedFromJson(json);

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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return elementsRemoved(elements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return elementsRemoved?.call(elements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
  const factory ElementsRemoved(final List<PadElement> elements) =
      _$ElementsRemoved;
  const ElementsRemoved._() : super._();

  factory ElementsRemoved.fromJson(Map<String, dynamic> json) =
      _$ElementsRemoved.fromJson;

  List<PadElement> get elements;
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
  $Res call({List<PadElement> elements});
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
    Object? elements = null,
  }) {
    return _then(_$ElementsArranged(
      null == elements
          ? _value._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<PadElement>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElementsArranged extends ElementsArranged {
  const _$ElementsArranged(final List<PadElement> elements,
      {final String? $type})
      : _elements = elements,
        $type = $type ?? 'elementsArranged',
        super._();

  factory _$ElementsArranged.fromJson(Map<String, dynamic> json) =>
      _$$ElementsArrangedFromJson(json);

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
    return 'DocumentEvent.elementsArranged(elements: $elements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElementsArranged &&
            const DeepCollectionEquality().equals(other._elements, _elements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_elements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ElementsArrangedCopyWith<_$ElementsArranged> get copyWith =>
      __$$ElementsArrangedCopyWithImpl<_$ElementsArranged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return elementsArranged(elements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return elementsArranged?.call(elements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (elementsArranged != null) {
      return elementsArranged(elements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
  const factory ElementsArranged(final List<PadElement> elements) =
      _$ElementsArranged;
  const ElementsArranged._() : super._();

  factory ElementsArranged.fromJson(Map<String, dynamic> json) =
      _$ElementsArranged.fromJson;

  List<PadElement> get elements;
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return documentDescriptionChanged(name, description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return documentDescriptionChanged?.call(name, description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return documentPathChanged(path);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return documentPathChanged?.call(path);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return documentSaved(location);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return documentSaved?.call(location);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
abstract class _$$PaintersChangedCopyWith<$Res> {
  factory _$$PaintersChangedCopyWith(
          _$PaintersChanged value, $Res Function(_$PaintersChanged) then) =
      __$$PaintersChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<(Painter, Painter)> painters});
}

/// @nodoc
class __$$PaintersChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$PaintersChanged>
    implements _$$PaintersChangedCopyWith<$Res> {
  __$$PaintersChangedCopyWithImpl(
      _$PaintersChanged _value, $Res Function(_$PaintersChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? painters = null,
  }) {
    return _then(_$PaintersChanged(
      null == painters
          ? _value._painters
          : painters // ignore: cast_nullable_to_non_nullable
              as List<(Painter, Painter)>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaintersChanged extends PaintersChanged {
  const _$PaintersChanged(final List<(Painter, Painter)> painters,
      {final String? $type})
      : _painters = painters,
        $type = $type ?? 'paintersChanged',
        super._();

  factory _$PaintersChanged.fromJson(Map<String, dynamic> json) =>
      _$$PaintersChangedFromJson(json);

  final List<(Painter, Painter)> _painters;
  @override
  List<(Painter, Painter)> get painters {
    if (_painters is EqualUnmodifiableListView) return _painters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_painters);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.paintersChanged(painters: $painters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaintersChanged &&
            const DeepCollectionEquality().equals(other._painters, _painters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_painters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaintersChangedCopyWith<_$PaintersChanged> get copyWith =>
      __$$PaintersChangedCopyWithImpl<_$PaintersChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return paintersChanged(painters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return paintersChanged?.call(painters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (paintersChanged != null) {
      return paintersChanged(painters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    return paintersChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    return paintersChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    if (paintersChanged != null) {
      return paintersChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PaintersChangedToJson(
      this,
    );
  }
}

abstract class PaintersChanged extends DocumentEvent {
  const factory PaintersChanged(final List<(Painter, Painter)> painters) =
      _$PaintersChanged;
  const PaintersChanged._() : super._();

  factory PaintersChanged.fromJson(Map<String, dynamic> json) =
      _$PaintersChanged.fromJson;

  List<(Painter, Painter)> get painters;
  @JsonKey(ignore: true)
  _$$PaintersChangedCopyWith<_$PaintersChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PaintersRemovedCopyWith<$Res> {
  factory _$$PaintersRemovedCopyWith(
          _$PaintersRemoved value, $Res Function(_$PaintersRemoved) then) =
      __$$PaintersRemovedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Painter> painters});
}

/// @nodoc
class __$$PaintersRemovedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$PaintersRemoved>
    implements _$$PaintersRemovedCopyWith<$Res> {
  __$$PaintersRemovedCopyWithImpl(
      _$PaintersRemoved _value, $Res Function(_$PaintersRemoved) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? painters = null,
  }) {
    return _then(_$PaintersRemoved(
      null == painters
          ? _value._painters
          : painters // ignore: cast_nullable_to_non_nullable
              as List<Painter>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaintersRemoved extends PaintersRemoved {
  const _$PaintersRemoved(final List<Painter> painters, {final String? $type})
      : _painters = painters,
        $type = $type ?? 'paintersRemoved',
        super._();

  factory _$PaintersRemoved.fromJson(Map<String, dynamic> json) =>
      _$$PaintersRemovedFromJson(json);

  final List<Painter> _painters;
  @override
  List<Painter> get painters {
    if (_painters is EqualUnmodifiableListView) return _painters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_painters);
  }

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.paintersRemoved(painters: $painters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaintersRemoved &&
            const DeepCollectionEquality().equals(other._painters, _painters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_painters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaintersRemovedCopyWith<_$PaintersRemoved> get copyWith =>
      __$$PaintersRemovedCopyWithImpl<_$PaintersRemoved>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return paintersRemoved(painters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return paintersRemoved?.call(painters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (paintersRemoved != null) {
      return paintersRemoved(painters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    return paintersRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    return paintersRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    if (paintersRemoved != null) {
      return paintersRemoved(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PaintersRemovedToJson(
      this,
    );
  }
}

abstract class PaintersRemoved extends DocumentEvent {
  const factory PaintersRemoved(final List<Painter> painters) =
      _$PaintersRemoved;
  const PaintersRemoved._() : super._();

  factory PaintersRemoved.fromJson(Map<String, dynamic> json) =
      _$PaintersRemoved.fromJson;

  List<Painter> get painters;
  @JsonKey(ignore: true)
  _$$PaintersRemovedCopyWith<_$PaintersRemoved> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PainterReorderedCopyWith<$Res> {
  factory _$$PainterReorderedCopyWith(
          _$PainterReordered value, $Res Function(_$PainterReordered) then) =
      __$$PainterReorderedCopyWithImpl<$Res>;
  @useResult
  $Res call({int oldIndex, int newIndex});
}

/// @nodoc
class __$$PainterReorderedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$PainterReordered>
    implements _$$PainterReorderedCopyWith<$Res> {
  __$$PainterReorderedCopyWithImpl(
      _$PainterReordered _value, $Res Function(_$PainterReordered) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldIndex = null,
    Object? newIndex = null,
  }) {
    return _then(_$PainterReordered(
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
class _$PainterReordered extends PainterReordered {
  const _$PainterReordered(this.oldIndex, this.newIndex, {final String? $type})
      : $type = $type ?? 'painterReordered',
        super._();

  factory _$PainterReordered.fromJson(Map<String, dynamic> json) =>
      _$$PainterReorderedFromJson(json);

  @override
  final int oldIndex;
  @override
  final int newIndex;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.painterReordered(oldIndex: $oldIndex, newIndex: $newIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PainterReordered &&
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
  _$$PainterReorderedCopyWith<_$PainterReordered> get copyWith =>
      __$$PainterReorderedCopyWithImpl<_$PainterReordered>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return painterReordered(oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return painterReordered?.call(oldIndex, newIndex);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (painterReordered != null) {
      return painterReordered(oldIndex, newIndex);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    return painterReordered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    return painterReordered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    if (painterReordered != null) {
      return painterReordered(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PainterReorderedToJson(
      this,
    );
  }
}

abstract class PainterReordered extends DocumentEvent {
  const factory PainterReordered(final int oldIndex, final int newIndex) =
      _$PainterReordered;
  const PainterReordered._() : super._();

  factory PainterReordered.fromJson(Map<String, dynamic> json) =
      _$PainterReordered.fromJson;

  int get oldIndex;
  int get newIndex;
  @JsonKey(ignore: true)
  _$$PainterReorderedCopyWith<_$PainterReordered> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DocumentBackgroundChangedCopyWith<$Res> {
  factory _$$DocumentBackgroundChangedCopyWith(
          _$DocumentBackgroundChanged value,
          $Res Function(_$DocumentBackgroundChanged) then) =
      __$$DocumentBackgroundChangedCopyWithImpl<$Res>;
  @useResult
  $Res call({Background background});

  $BackgroundCopyWith<$Res> get background;
}

/// @nodoc
class __$$DocumentBackgroundChangedCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$DocumentBackgroundChanged>
    implements _$$DocumentBackgroundChangedCopyWith<$Res> {
  __$$DocumentBackgroundChangedCopyWithImpl(_$DocumentBackgroundChanged _value,
      $Res Function(_$DocumentBackgroundChanged) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? background = null,
  }) {
    return _then(_$DocumentBackgroundChanged(
      null == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as Background,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $BackgroundCopyWith<$Res> get background {
    return $BackgroundCopyWith<$Res>(_value.background, (value) {
      return _then(_value.copyWith(background: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$DocumentBackgroundChanged extends DocumentBackgroundChanged {
  const _$DocumentBackgroundChanged(this.background, {final String? $type})
      : $type = $type ?? 'documentBackgroundChanged',
        super._();

  factory _$DocumentBackgroundChanged.fromJson(Map<String, dynamic> json) =>
      _$$DocumentBackgroundChangedFromJson(json);

  @override
  final Background background;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.documentBackgroundChanged(background: $background)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentBackgroundChanged &&
            (identical(other.background, background) ||
                other.background == background));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, background);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentBackgroundChangedCopyWith<_$DocumentBackgroundChanged>
      get copyWith => __$$DocumentBackgroundChangedCopyWithImpl<
          _$DocumentBackgroundChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return documentBackgroundChanged(background);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return documentBackgroundChanged?.call(background);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (documentBackgroundChanged != null) {
      return documentBackgroundChanged(background);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    return documentBackgroundChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PageChanged value)? pageChanged,
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    return documentBackgroundChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PageChanged value)? pageChanged,
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    if (documentBackgroundChanged != null) {
      return documentBackgroundChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DocumentBackgroundChangedToJson(
      this,
    );
  }
}

abstract class DocumentBackgroundChanged extends DocumentEvent {
  const factory DocumentBackgroundChanged(final Background background) =
      _$DocumentBackgroundChanged;
  const DocumentBackgroundChanged._() : super._();

  factory DocumentBackgroundChanged.fromJson(Map<String, dynamic> json) =
      _$DocumentBackgroundChanged.fromJson;

  Background get background;
  @JsonKey(ignore: true)
  _$$DocumentBackgroundChangedCopyWith<_$DocumentBackgroundChanged>
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return waypointCreated(waypoint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return waypointCreated?.call(waypoint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return waypointRemoved(index);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return waypointRemoved?.call(index);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return layerRenamed(oldName, newName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return layerRenamed?.call(oldName, newName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return layerRemoved(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return layerRemoved?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return layerElementsRemoved(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return layerElementsRemoved?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
  $Res call({String name, bool visible});
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
    Object? visible = null,
  }) {
    return _then(_$LayerVisibilityChanged(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == visible
          ? _value.visible
          : visible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LayerVisibilityChanged extends LayerVisibilityChanged {
  const _$LayerVisibilityChanged(this.name, this.visible, {final String? $type})
      : $type = $type ?? 'layerVisibilityChanged',
        super._();

  factory _$LayerVisibilityChanged.fromJson(Map<String, dynamic> json) =>
      _$$LayerVisibilityChangedFromJson(json);

  @override
  final String name;
  @override
  final bool visible;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.layerVisibilityChanged(name: $name, visible: $visible)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LayerVisibilityChanged &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.visible, visible) || other.visible == visible));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, visible);

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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return layerVisibilityChanged(name, visible);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return layerVisibilityChanged?.call(name, visible);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (layerVisibilityChanged != null) {
      return layerVisibilityChanged(name, visible);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
  const factory LayerVisibilityChanged(final String name, final bool visible) =
      _$LayerVisibilityChanged;
  const LayerVisibilityChanged._() : super._();

  factory LayerVisibilityChanged.fromJson(Map<String, dynamic> json) =
      _$LayerVisibilityChanged.fromJson;

  String get name;
  bool get visible;
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return currentLayerChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return currentLayerChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
abstract class _$$TemplateCreatedCopyWith<$Res> {
  factory _$$TemplateCreatedCopyWith(
          _$TemplateCreated value, $Res Function(_$TemplateCreated) then) =
      __$$TemplateCreatedCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
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
    Object? name = null,
  }) {
    return _then(_$TemplateCreated(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TemplateCreated extends TemplateCreated {
  const _$TemplateCreated(this.name, {final String? $type})
      : $type = $type ?? 'templateCreated',
        super._();

  factory _$TemplateCreated.fromJson(Map<String, dynamic> json) =>
      _$$TemplateCreatedFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.templateCreated(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TemplateCreated &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TemplateCreatedCopyWith<_$TemplateCreated> get copyWith =>
      __$$TemplateCreatedCopyWithImpl<_$TemplateCreated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return templateCreated(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return templateCreated?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (templateCreated != null) {
      return templateCreated(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
  const factory TemplateCreated(final String name) = _$TemplateCreated;
  const TemplateCreated._() : super._();

  factory TemplateCreated.fromJson(Map<String, dynamic> json) =
      _$TemplateCreated.fromJson;

  String get name;
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return areasCreated(areas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return areasCreated?.call(areas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return areasRemoved(areas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return areasRemoved?.call(areas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return areaChanged(name, area);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return areaChanged?.call(name, area);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return currentAreaChanged(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return currentAreaChanged?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
  $Res call({String name});
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
  }) {
    return _then(_$ExportPresetCreated(
      null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExportPresetCreated extends ExportPresetCreated {
  const _$ExportPresetCreated(this.name, {final String? $type})
      : $type = $type ?? 'exportPresetCreated',
        super._();

  factory _$ExportPresetCreated.fromJson(Map<String, dynamic> json) =>
      _$$ExportPresetCreatedFromJson(json);

  @override
  final String name;

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.exportPresetCreated(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExportPresetCreated &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return exportPresetCreated(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return exportPresetCreated?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (exportPresetCreated != null) {
      return exportPresetCreated(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
  const factory ExportPresetCreated(final String name) = _$ExportPresetCreated;
  const ExportPresetCreated._() : super._();

  factory ExportPresetCreated.fromJson(Map<String, dynamic> json) =
      _$ExportPresetCreated.fromJson;

  String get name;
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return exportPresetUpdated(name, areas);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return exportPresetUpdated?.call(name, areas);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return exportPresetRemoved(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return exportPresetRemoved?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return packAdded(pack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return packAdded?.call(pack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return packUpdated(name, pack);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return packUpdated?.call(name, pack);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return packRemoved(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return packRemoved?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return animationAdded(animation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return animationAdded?.call(animation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return animationUpdated(name, animation);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return animationUpdated?.call(name, animation);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return animationRemoved(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return animationRemoved?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
}

/// @nodoc
class __$$PresentationModeEnteredCopyWithImpl<$Res>
    extends _$DocumentEventCopyWithImpl<$Res, _$PresentationModeEntered>
    implements _$$PresentationModeEnteredCopyWith<$Res> {
  __$$PresentationModeEnteredCopyWithImpl(_$PresentationModeEntered _value,
      $Res Function(_$PresentationModeEntered) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$PresentationModeEntered extends PresentationModeEntered {
  const _$PresentationModeEntered({final String? $type})
      : $type = $type ?? 'presentationModeEntered',
        super._();

  factory _$PresentationModeEntered.fromJson(Map<String, dynamic> json) =>
      _$$PresentationModeEnteredFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DocumentEvent.presentationModeEntered()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresentationModeEntered);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String pageName) pageChanged,
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return presentationModeEntered();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return presentationModeEntered?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
    TResult Function()? presentationModeExited,
    TResult Function(int tick)? presentationTick,
    required TResult orElse(),
  }) {
    if (presentationModeEntered != null) {
      return presentationModeEntered();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PageChanged value) pageChanged,
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
  const factory PresentationModeEntered() = _$PresentationModeEntered;
  const PresentationModeEntered._() : super._();

  factory PresentationModeEntered.fromJson(Map<String, dynamic> json) =
      _$PresentationModeEntered.fromJson;
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return presentationModeExited();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return presentationModeExited?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
    required TResult Function(ToolOption? option) toolOptionChanged,
    required TResult Function(ToolState? state) toolStateChanged,
    required TResult Function(List<PadElement> elements) elementsCreated,
    required TResult Function(Map<int, List<PadElement>> replacedElements)
        elementsReplaced,
    required TResult Function(
            List<(PadElement, List<PadElement>)> changedElements)
        elementsChanged,
    required TResult Function(List<PadElement> elements) elementsRemoved,
    required TResult Function(List<PadElement> elements) elementsArranged,
    required TResult Function(String? name, String? description)
        documentDescriptionChanged,
    required TResult Function(String path) documentPathChanged,
    required TResult Function(AssetLocation? location) documentSaved,
    required TResult Function(List<(Painter, Painter)> painters)
        paintersChanged,
    required TResult Function(List<Painter> painters) paintersRemoved,
    required TResult Function(int oldIndex, int newIndex) painterReordered,
    required TResult Function(Background background) documentBackgroundChanged,
    required TResult Function(Waypoint waypoint) waypointCreated,
    required TResult Function(int index) waypointRemoved,
    required TResult Function(String oldName, String newName) layerRenamed,
    required TResult Function(String name) layerRemoved,
    required TResult Function(String name) layerElementsRemoved,
    required TResult Function(String name, bool visible) layerVisibilityChanged,
    required TResult Function(String name) currentLayerChanged,
    required TResult Function(String name) templateCreated,
    required TResult Function(List<Area> areas) areasCreated,
    required TResult Function(List<String> areas) areasRemoved,
    required TResult Function(String name, Area area) areaChanged,
    required TResult Function(String name) currentAreaChanged,
    required TResult Function(String name) exportPresetCreated,
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
    required TResult Function() presentationModeEntered,
    required TResult Function() presentationModeExited,
    required TResult Function(int tick) presentationTick,
  }) {
    return presentationTick(tick);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String pageName)? pageChanged,
    TResult? Function(ToolOption? option)? toolOptionChanged,
    TResult? Function(ToolState? state)? toolStateChanged,
    TResult? Function(List<PadElement> elements)? elementsCreated,
    TResult? Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult? Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult? Function(List<PadElement> elements)? elementsRemoved,
    TResult? Function(List<PadElement> elements)? elementsArranged,
    TResult? Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult? Function(String path)? documentPathChanged,
    TResult? Function(AssetLocation? location)? documentSaved,
    TResult? Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult? Function(List<Painter> painters)? paintersRemoved,
    TResult? Function(int oldIndex, int newIndex)? painterReordered,
    TResult? Function(Background background)? documentBackgroundChanged,
    TResult? Function(Waypoint waypoint)? waypointCreated,
    TResult? Function(int index)? waypointRemoved,
    TResult? Function(String oldName, String newName)? layerRenamed,
    TResult? Function(String name)? layerRemoved,
    TResult? Function(String name)? layerElementsRemoved,
    TResult? Function(String name, bool visible)? layerVisibilityChanged,
    TResult? Function(String name)? currentLayerChanged,
    TResult? Function(String name)? templateCreated,
    TResult? Function(List<Area> areas)? areasCreated,
    TResult? Function(List<String> areas)? areasRemoved,
    TResult? Function(String name, Area area)? areaChanged,
    TResult? Function(String name)? currentAreaChanged,
    TResult? Function(String name)? exportPresetCreated,
    TResult? Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult? Function(String name)? exportPresetRemoved,
    TResult? Function(NoteData pack)? packAdded,
    TResult? Function(String name, NoteData pack)? packUpdated,
    TResult? Function(String name)? packRemoved,
    TResult? Function(AnimationTrack animation)? animationAdded,
    TResult? Function(String name, AnimationTrack animation)? animationUpdated,
    TResult? Function(String name)? animationRemoved,
    TResult? Function()? presentationModeEntered,
    TResult? Function()? presentationModeExited,
    TResult? Function(int tick)? presentationTick,
  }) {
    return presentationTick?.call(tick);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String pageName)? pageChanged,
    TResult Function(ToolOption? option)? toolOptionChanged,
    TResult Function(ToolState? state)? toolStateChanged,
    TResult Function(List<PadElement> elements)? elementsCreated,
    TResult Function(Map<int, List<PadElement>> replacedElements)?
        elementsReplaced,
    TResult Function(List<(PadElement, List<PadElement>)> changedElements)?
        elementsChanged,
    TResult Function(List<PadElement> elements)? elementsRemoved,
    TResult Function(List<PadElement> elements)? elementsArranged,
    TResult Function(String? name, String? description)?
        documentDescriptionChanged,
    TResult Function(String path)? documentPathChanged,
    TResult Function(AssetLocation? location)? documentSaved,
    TResult Function(List<(Painter, Painter)> painters)? paintersChanged,
    TResult Function(List<Painter> painters)? paintersRemoved,
    TResult Function(int oldIndex, int newIndex)? painterReordered,
    TResult Function(Background background)? documentBackgroundChanged,
    TResult Function(Waypoint waypoint)? waypointCreated,
    TResult Function(int index)? waypointRemoved,
    TResult Function(String oldName, String newName)? layerRenamed,
    TResult Function(String name)? layerRemoved,
    TResult Function(String name)? layerElementsRemoved,
    TResult Function(String name, bool visible)? layerVisibilityChanged,
    TResult Function(String name)? currentLayerChanged,
    TResult Function(String name)? templateCreated,
    TResult Function(List<Area> areas)? areasCreated,
    TResult Function(List<String> areas)? areasRemoved,
    TResult Function(String name, Area area)? areaChanged,
    TResult Function(String name)? currentAreaChanged,
    TResult Function(String name)? exportPresetCreated,
    TResult Function(String name, List<AreaPreset> areas)? exportPresetUpdated,
    TResult Function(String name)? exportPresetRemoved,
    TResult Function(NoteData pack)? packAdded,
    TResult Function(String name, NoteData pack)? packUpdated,
    TResult Function(String name)? packRemoved,
    TResult Function(AnimationTrack animation)? animationAdded,
    TResult Function(String name, AnimationTrack animation)? animationUpdated,
    TResult Function(String name)? animationRemoved,
    TResult Function()? presentationModeEntered,
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
    required TResult Function(ToolOptionChanged value) toolOptionChanged,
    required TResult Function(ToolStateChanged value) toolStateChanged,
    required TResult Function(ElementsCreated value) elementsCreated,
    required TResult Function(ElementsReplaced value) elementsReplaced,
    required TResult Function(ElementsChanged value) elementsChanged,
    required TResult Function(ElementsRemoved value) elementsRemoved,
    required TResult Function(ElementsArranged value) elementsArranged,
    required TResult Function(DocumentDescriptionChanged value)
        documentDescriptionChanged,
    required TResult Function(DocumentPathChanged value) documentPathChanged,
    required TResult Function(DocumentSaved value) documentSaved,
    required TResult Function(PaintersChanged value) paintersChanged,
    required TResult Function(PaintersRemoved value) paintersRemoved,
    required TResult Function(PainterReordered value) painterReordered,
    required TResult Function(DocumentBackgroundChanged value)
        documentBackgroundChanged,
    required TResult Function(WaypointCreated value) waypointCreated,
    required TResult Function(WaypointRemoved value) waypointRemoved,
    required TResult Function(LayerRenamed value) layerRenamed,
    required TResult Function(LayerRemoved value) layerRemoved,
    required TResult Function(LayerElementsRemoved value) layerElementsRemoved,
    required TResult Function(LayerVisibilityChanged value)
        layerVisibilityChanged,
    required TResult Function(CurrentLayerChanged value) currentLayerChanged,
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
    TResult? Function(ToolOptionChanged value)? toolOptionChanged,
    TResult? Function(ToolStateChanged value)? toolStateChanged,
    TResult? Function(ElementsCreated value)? elementsCreated,
    TResult? Function(ElementsReplaced value)? elementsReplaced,
    TResult? Function(ElementsChanged value)? elementsChanged,
    TResult? Function(ElementsRemoved value)? elementsRemoved,
    TResult? Function(ElementsArranged value)? elementsArranged,
    TResult? Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult? Function(DocumentPathChanged value)? documentPathChanged,
    TResult? Function(DocumentSaved value)? documentSaved,
    TResult? Function(PaintersChanged value)? paintersChanged,
    TResult? Function(PaintersRemoved value)? paintersRemoved,
    TResult? Function(PainterReordered value)? painterReordered,
    TResult? Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult? Function(WaypointCreated value)? waypointCreated,
    TResult? Function(WaypointRemoved value)? waypointRemoved,
    TResult? Function(LayerRenamed value)? layerRenamed,
    TResult? Function(LayerRemoved value)? layerRemoved,
    TResult? Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult? Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult? Function(CurrentLayerChanged value)? currentLayerChanged,
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
    TResult Function(ToolOptionChanged value)? toolOptionChanged,
    TResult Function(ToolStateChanged value)? toolStateChanged,
    TResult Function(ElementsCreated value)? elementsCreated,
    TResult Function(ElementsReplaced value)? elementsReplaced,
    TResult Function(ElementsChanged value)? elementsChanged,
    TResult Function(ElementsRemoved value)? elementsRemoved,
    TResult Function(ElementsArranged value)? elementsArranged,
    TResult Function(DocumentDescriptionChanged value)?
        documentDescriptionChanged,
    TResult Function(DocumentPathChanged value)? documentPathChanged,
    TResult Function(DocumentSaved value)? documentSaved,
    TResult Function(PaintersChanged value)? paintersChanged,
    TResult Function(PaintersRemoved value)? paintersRemoved,
    TResult Function(PainterReordered value)? painterReordered,
    TResult Function(DocumentBackgroundChanged value)?
        documentBackgroundChanged,
    TResult Function(WaypointCreated value)? waypointCreated,
    TResult Function(WaypointRemoved value)? waypointRemoved,
    TResult Function(LayerRenamed value)? layerRenamed,
    TResult Function(LayerRemoved value)? layerRemoved,
    TResult Function(LayerElementsRemoved value)? layerElementsRemoved,
    TResult Function(LayerVisibilityChanged value)? layerVisibilityChanged,
    TResult Function(CurrentLayerChanged value)? currentLayerChanged,
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
