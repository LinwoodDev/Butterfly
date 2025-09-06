import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lw_file_system_api/lw_file_system_api.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../../butterfly_models.dart';

part 'event.freezed.dart';
part 'event.g.dart';

enum Arrangement { forward, backward, front, back }

enum DocumentPermission { read, write, admin }

Map<String, dynamic> _assetLocationToJson(AssetLocation? location) =>
    location?.toMap() ?? {};

@freezed
sealed class PageAddedDetails with _$PageAddedDetails {
  const factory PageAddedDetails({
    int? index,
    DocumentPage? page,
    @Default(true) bool addNumber,
    @Default('') String name,
  }) = _PageAddedDetails;

  factory PageAddedDetails.fromJson(Map<String, dynamic> json) =>
      _$PageAddedDetailsFromJson(json);
}

@freezed
sealed class DocumentEvent extends ReplayEvent with _$DocumentEvent {
  const DocumentEvent._();

  const factory DocumentEvent.pagesAdded(List<PageAddedDetails> pages) =
      PagesAdded;

  const factory DocumentEvent.pageChanged(String pageName) = PageChanged;

  const factory DocumentEvent.pageReordered(String page, [int? newIndex]) =
      PageReordered;

  const factory DocumentEvent.pageRenamed(String oldName, String newName) =
      PageRenamed;

  const factory DocumentEvent.pageRemoved(String page) = PageRemoved;

  const factory DocumentEvent.thumbnailCaptured(
    @Uint8ListJsonConverter() Uint8List data,
  ) = ThumbnailCaptured;

  const factory DocumentEvent.viewChanged(ViewOption view) = ViewChanged;

  const factory DocumentEvent.utilitiesChanged(UtilitiesState state) =
      UtilitiesChanged;

  const factory DocumentEvent.elementsCreated(List<PadElement> elements) =
      ElementsCreated;

  const factory DocumentEvent.elementsChanged(
    Map<String, List<PadElement>> elements,
  ) = ElementsChanged;

  const factory DocumentEvent.elementsRemoved(List<String> elements) =
      ElementsRemoved;

  const factory DocumentEvent.elementsArranged(
    Arrangement arrangement,
    List<String> elements,
  ) = ElementsArranged;

  const factory DocumentEvent.documentDescriptionChanged({
    String? name,
    String? description,
  }) = DocumentDescriptionChanged;

  const factory DocumentEvent.documentSaved([
    @JsonKey(
      fromJson: AssetLocationMapper.fromMap,
      toJson: _assetLocationToJson,
    )
    AssetLocation? location,
  ]) = DocumentSaved;

  const factory DocumentEvent.toolCreated(Tool tool) = ToolCreated;

  const factory DocumentEvent.toolsChanged(Map<int, Tool> tools) = ToolsChanged;

  const factory DocumentEvent.toolsRemoved(List<int> tools) = ToolsRemoved;

  const factory DocumentEvent.toolReordered(int oldIndex, int newIndex) =
      ToolReordered;

  const factory DocumentEvent.documentBackgroundsChanged(
    List<Background> backgrounds,
  ) = DocumentBackgroundsChanged;

  const factory DocumentEvent.waypointCreated(Waypoint waypoint) =
      WaypointCreated;

  const factory DocumentEvent.waypointChanged(String? name, Waypoint waypoint) =
      WaypointChanged;

  const factory DocumentEvent.waypointRemoved(String? name) = WaypointRemoved;

  const factory DocumentEvent.waypointReordered(String? name, int newIndex) =
      WaypointReordered;

  const factory DocumentEvent.collectionRenamed(
    String oldName,
    String newName,
  ) = CollectionRenamed;

  const factory DocumentEvent.collectionElementsRemoved(String name) =
      CollectionElementsRemoved;

  const factory DocumentEvent.currentCollectionChanged(String name) =
      CurrentCollectionChanged;

  const factory DocumentEvent.currentLayerChanged(String name) =
      CurrentLayerChanged;

  const factory DocumentEvent.layerCreated({
    @Default('') String name,
    String? id,
  }) = LayerCreated;

  const factory DocumentEvent.layerChanged(String id, {String? name}) =
      LayerChanged;

  const factory DocumentEvent.layerRemoved(String id) = LayerRemoved;

  const factory DocumentEvent.layersMerged(
    List<String> layers, [
    @Default(false) bool duplicate,
  ]) = LayersMerged;

  const factory DocumentEvent.layerOrderChanged(String id, int index) =
      LayerOrderChanged;

  const factory DocumentEvent.layerVisibilityChanged(String id, bool visible) =
      LayerVisibilityChanged;

  const factory DocumentEvent.elementsCollectionChanged(
    List<String> elements,
    String collection,
  ) = ElementsCollectionChanged;

  const factory DocumentEvent.areasCreated(List<Area> areas) = AreasCreated;

  const factory DocumentEvent.areasRemoved(List<String> areas) = AreasRemoved;

  const factory DocumentEvent.areaChanged(String name, Area area) = AreaChanged;

  const factory DocumentEvent.areaReordered(String name, int newIndex) =
      AreaReordered;

  const factory DocumentEvent.currentAreaChanged(String name) =
      CurrentAreaChanged;

  const factory DocumentEvent.exportPresetCreated(
    String name, [
    @Default([]) List<AreaPreset> areas,
  ]) = ExportPresetCreated;

  const factory DocumentEvent.exportPresetUpdated(
    String name,
    List<AreaPreset> areas,
  ) = ExportPresetUpdated;

  const factory DocumentEvent.exportPresetRemoved(String name) =
      ExportPresetRemoved;

  const factory DocumentEvent.packAdded(NoteData pack) = PackAdded;

  const factory DocumentEvent.packUpdated(String name, NoteData pack) =
      PackUpdated;

  const factory DocumentEvent.packRemoved(String name) = PackRemoved;

  const factory DocumentEvent.animationAdded(AnimationTrack animation) =
      AnimationAdded;

  const factory DocumentEvent.animationUpdated(
    String name,
    AnimationTrack animation,
  ) = AnimationUpdated;

  const factory DocumentEvent.animationRemoved(String name) = AnimationRemoved;

  const factory DocumentEvent.presentationModeEntered(
    AnimationTrack track,
    bool fullScreen,
  ) = PresentationModeEntered;

  const factory DocumentEvent.presentationModeExited() = PresentationModeExited;

  const factory DocumentEvent.presentationTick(int tick) = PresentationTick;

  const factory DocumentEvent.assetUpdated(String path, List<int> data) =
      AssetUpdated;

  const factory DocumentEvent.elementsLayerConverted(
    List<String> elements, [
    @Default('') String name,
  ]) = ElementsLayerConverted;

  const factory DocumentEvent.encryptionChanged(String? password) =
      EncryptionChanged;

  const factory DocumentEvent.documentRebuilt(
    @Uint8ListJsonConverter() Uint8List data,
  ) = DocumentRebuilt;

  factory DocumentEvent.fromJson(Map<String, dynamic> json) =>
      _$DocumentEventFromJson(json);

  bool shouldSync() => switch (this) {
    CurrentCollectionChanged _ => false,
    DocumentSaved _ => false,
    CurrentAreaChanged _ => false,
    LayerVisibilityChanged _ => false,
    UtilitiesChanged _ => false,
    PresentationModeEntered _ => false,
    PresentationModeExited _ => false,
    PresentationTick _ => false,
    DocumentRebuilt _ => false,
    _ => true,
  };

  bool isAllowed(DocumentPermission permission) {
    if (permission == DocumentPermission.read) return false;
    if (!shouldSync()) return false;
    return switch (this) {
      _ => true,
    };
  }
}
