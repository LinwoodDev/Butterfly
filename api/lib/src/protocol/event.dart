import 'dart:math';
import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../../butterfly_models.dart';

part 'event.freezed.dart';
part 'event.g.dart';

enum Arrangement { forward, backward, front, back }

enum DocumentPermission { read, write, admin }

@freezed
@JsonSerializable()
class const InitialAreaDetails({
  required final double width,
  required final double height,
  required final String name,
}) with _$InitialAreaDetails {
  static InitialAreaDetails fromJson(Map json) =>
      _$InitialAreaDetailsFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$InitialAreaDetailsToJson(this);
}

@freezed
@JsonSerializable()
class const PageAddedDetails({
  final int? index,
  final DocumentPage? page,
  final bool addNumber = true,
  final String name = '',
  final InitialAreaDetails? initialArea,
}) with _$PageAddedDetails {
  static PageAddedDetails fromJson(Map json) =>
      _$PageAddedDetailsFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$PageAddedDetailsToJson(this);

  DocumentPage resolvePage(List<Background> backgrounds) {
    final initialArea = this.initialArea;
    return page ??
        DocumentPage(
          backgrounds: backgrounds,
          areas: [
            if (initialArea != null)
              Area(
                name: initialArea.name,
                width: initialArea.width,
                height: initialArea.height,
                position: const Point(0, 0),
                isInitial: true,
              ),
          ],
        );
  }
}

@freezed
sealed class DocumentEvent extends ReplayEvent with _$DocumentEvent {
  const DocumentEvent._();

  const factory DocumentEvent.pagesAdded(List<PageAddedDetails> pages) =
      PagesAdded;

  const factory DocumentEvent.pageChanged(
    String pageName, {
    // Camera destinations are local; collaboration only synchronizes the page.
    @JsonKey(includeFromJson: false, includeToJson: false)
    Point<double>? position,
    @JsonKey(includeFromJson: false, includeToJson: false) double? zoom,
  }) = PageChanged;

  const factory DocumentEvent.pageReordered(String page, [int? newIndex]) =
      PageReordered;

  const factory DocumentEvent.pageRenamed(String oldName, String newName) =
      PageRenamed;

  const factory DocumentEvent.pageRemoved(String page) = PageRemoved;

  const factory DocumentEvent.thumbnailCaptured(
    @Uint8ListJsonConverter() Uint8List data,
  ) = ThumbnailCaptured;

  const factory DocumentEvent.elementsCreated(
    List<PadElement> elements, {
    @Uint8ListJsonConverter() @Default({}) Map<String, Uint8List> assets,
    String? pageName,
    String? layer,
  }) = ElementsCreated;

  const factory DocumentEvent.elementsChanged(
    Map<String, List<PadElement>> elements, {
    String? pageName,
  }) = ElementsChanged;

  const factory DocumentEvent.elementsRemoved(
    List<String> elements, {
    String? pageName,
  }) = ElementsRemoved;

  const factory DocumentEvent.elementsArranged(
    Arrangement arrangement,
    List<String> elements, {
    String? pageName,
  }) = ElementsArranged;

  const factory DocumentEvent.documentDescriptionChanged({
    String? name,
    String? description,
  }) = DocumentDescriptionChanged;

  const factory DocumentEvent.toolCreated(Tool tool) = ToolCreated;

  const factory DocumentEvent.toolsChanged(List<Tool> tools) = ToolsChanged;

  const factory DocumentEvent.toolsRemoved(List<String> tools) = ToolsRemoved;

  const factory DocumentEvent.toolsReplaced(List<Tool> tools) = ToolsReplaced;

  const factory DocumentEvent.toolReordered(String id, int newIndex) =
      ToolReordered;

  const factory DocumentEvent.documentBackgroundsChanged(
    List<Background> backgrounds, {
    String? pageName,
  }) = DocumentBackgroundsChanged;

  const factory DocumentEvent.waypointCreated(
    Waypoint waypoint, {
    String? pageName,
  }) = WaypointCreated;

  const factory DocumentEvent.waypointChanged(
    String? name,
    Waypoint waypoint, {
    String? pageName,
  }) = WaypointChanged;

  const factory DocumentEvent.waypointRemoved(
    String? name, {
    String? pageName,
  }) = WaypointRemoved;

  const factory DocumentEvent.waypointReordered(
    String? name,
    int newIndex, {
    String? pageName,
  }) = WaypointReordered;

  const factory DocumentEvent.collectionRenamed(
    String oldName,
    String newName, {
    String? pageName,
  }) = CollectionRenamed;

  const factory DocumentEvent.collectionElementsRemoved(
    String name, {
    String? pageName,
  }) = CollectionElementsRemoved;

  const factory DocumentEvent.currentCollectionChanged(String name) =
      CurrentCollectionChanged;

  const factory DocumentEvent.currentLayerChanged(String name) =
      CurrentLayerChanged;

  const factory DocumentEvent.layerCreated({
    @Default('') String name,
    String? id,
    String? pageName,
  }) = LayerCreated;

  const factory DocumentEvent.layerChanged(
    String id, {
    String? name,
    String? pageName,
  }) = LayerChanged;

  const factory DocumentEvent.layerRemoved(String id, {String? pageName}) =
      LayerRemoved;

  const factory DocumentEvent.layersMerged(
    List<String> layers, [
    @Default(false) bool duplicate,
    String? pageName,
  ]) = LayersMerged;

  const factory DocumentEvent.layerOrderChanged(
    String id,
    int index, {
    String? pageName,
  }) = LayerOrderChanged;

  const factory DocumentEvent.layerVisibilityChanged(String id, bool visible) =
      LayerVisibilityChanged;

  const factory DocumentEvent.elementsCollectionChanged(
    List<String> elements,
    String collection, {
    String? pageName,
  }) = ElementsCollectionChanged;

  const factory DocumentEvent.areasCreated(List<AreaPreset> areas) =
      AreasCreated;

  const factory DocumentEvent.areasDuplicated(Area area, List<String> pages) =
      AreasDuplicated;

  const factory DocumentEvent.areasRemoved(List<AreaPreset> areas) =
      AreasRemoved;

  const factory DocumentEvent.areaChanged(
    String name,
    Area area, [
    @Default(false) bool moveContents,
    String? pageName,
  ]) = AreaChanged;

  const factory DocumentEvent.areaReordered(
    String name,
    int newIndex, {
    String? pageName,
  }) = AreaReordered;

  const factory DocumentEvent.currentAreaChanged(
    String name, {
    String? pageName,
  }) = CurrentAreaChanged;

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

  const factory DocumentEvent.animationAdded(
    AnimationTrack animation, {
    String? pageName,
  }) = AnimationAdded;

  const factory DocumentEvent.animationUpdated(
    String name,
    AnimationTrack animation, {
    String? pageName,
  }) = AnimationUpdated;

  const factory DocumentEvent.animationRemoved(
    String name, {
    String? pageName,
  }) = AnimationRemoved;

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
    String? pageName,
  ]) = ElementsLayerConverted;

  const factory DocumentEvent.elementsLayerMoved(
    List<String> elements,
    String layerId, {
    String? pageName,
  }) = ElementsLayerMoved;

  const factory DocumentEvent.encryptionChanged(String? password) =
      EncryptionChanged;

  const factory DocumentEvent.documentRebuilt(
    @Uint8ListJsonConverter() Uint8List data,
  ) = DocumentRebuilt;

  factory DocumentEvent.fromJson(Map<String, dynamic> json) =>
      _$DocumentEventFromJson(json);

  bool isAllowed(DocumentPermission permission) {
    if (permission == .read) return false;
    return switch (this) {
      CurrentCollectionChanged() ||
      LayerVisibilityChanged() ||
      PresentationModeEntered() ||
      PresentationModeExited() ||
      PresentationTick() ||
      DocumentRebuilt() => false,
      _ => true,
    };
  }
}
