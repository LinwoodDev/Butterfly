import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:replay_bloc/replay_bloc.dart';

import '../../butterfly_models.dart';

part 'event.freezed.dart';
part 'event.g.dart';

enum Arrangement { forward, backward, front, back }

enum DocumentPermission { read, write, admin }

@freezed
class DocumentEvent extends ReplayEvent with _$DocumentEvent {
  const DocumentEvent._();

  const factory DocumentEvent.pageChanged(
    String pageName,
  ) = PageChanged;

  const factory DocumentEvent.toolOptionChanged([ToolOption? option]) =
      ToolOptionChanged;

  const factory DocumentEvent.toolStateChanged([ToolState? state]) =
      ToolStateChanged;

  const factory DocumentEvent.elementsCreated(
    List<PadElement> elements,
  ) = ElementsCreated;

  const factory DocumentEvent.elementsChanged(
    Map<int, List<PadElement>> elements,
  ) = ElementsChanged;

  const factory DocumentEvent.elementsRemoved(
    List<int> elements,
  ) = ElementsRemoved;

  const factory DocumentEvent.elementsArranged(
    Arrangement arrangement,
    List<int> elements,
  ) = ElementsArranged;

  const factory DocumentEvent.documentDescriptionChanged({
    String? name,
    String? description,
  }) = DocumentDescriptionChanged;

  const factory DocumentEvent.documentPathChanged(String path) =
      DocumentPathChanged;

  const factory DocumentEvent.documentSaved([AssetLocation? location]) =
      DocumentSaved;

  const factory DocumentEvent.painterCreated(
    Painter painter,
  ) = PainterCreated;

  const factory DocumentEvent.paintersChanged(
    Map<int, Painter> painters,
  ) = PaintersChanged;

  const factory DocumentEvent.paintersRemoved(
    List<int> painters,
  ) = PaintersRemoved;

  const factory DocumentEvent.painterReordered(
    int oldIndex,
    int newIndex,
  ) = PainterReordered;

  const factory DocumentEvent.documentBackgroundChanged(
    Background background,
  ) = DocumentBackgroundChanged;

  const factory DocumentEvent.waypointCreated(
    Waypoint waypoint,
  ) = WaypointCreated;

  const factory DocumentEvent.waypointRemoved(
    int index,
  ) = WaypointRemoved;

  const factory DocumentEvent.layerRenamed(
    String oldName,
    String newName,
  ) = LayerRenamed;

  const factory DocumentEvent.layerRemoved(
    String name,
  ) = LayerRemoved;

  const factory DocumentEvent.layerElementsRemoved(
    String name,
  ) = LayerElementsRemoved;

  const factory DocumentEvent.layerVisibilityChanged(
    String name,
  ) = LayerVisibilityChanged;

  const factory DocumentEvent.currentLayerChanged(
    String name,
  ) = CurrentLayerChanged;

  const factory DocumentEvent.elementsLayerChanged(
    String layer,
    List<int> elements,
  ) = ElementsLayerChanged;

  const factory DocumentEvent.templateCreated(String directory,
      [String? remote, @Default(true) bool deleteDocument]) = TemplateCreated;

  const factory DocumentEvent.areasCreated(
    List<Area> areas,
  ) = AreasCreated;

  const factory DocumentEvent.areasRemoved(
    List<String> areas,
  ) = AreasRemoved;

  const factory DocumentEvent.areaChanged(
    String name,
    Area area,
  ) = AreaChanged;

  const factory DocumentEvent.currentAreaChanged(
    String name,
  ) = CurrentAreaChanged;

  const factory DocumentEvent.exportPresetCreated(String name,
      [@Default([]) List<AreaPreset> areas]) = ExportPresetCreated;

  const factory DocumentEvent.exportPresetUpdated(
    String name,
    List<AreaPreset> areas,
  ) = ExportPresetUpdated;

  const factory DocumentEvent.exportPresetRemoved(
    String name,
  ) = ExportPresetRemoved;

  const factory DocumentEvent.packAdded(
    NoteData pack,
  ) = PackAdded;

  const factory DocumentEvent.packUpdated(
    String name,
    NoteData pack,
  ) = PackUpdated;

  const factory DocumentEvent.packRemoved(
    String name,
  ) = PackRemoved;

  const factory DocumentEvent.animationAdded(
    AnimationTrack animation,
  ) = AnimationAdded;

  const factory DocumentEvent.animationUpdated(
    String name,
    AnimationTrack animation,
  ) = AnimationUpdated;

  const factory DocumentEvent.animationRemoved(
    String name,
  ) = AnimationRemoved;

  const factory DocumentEvent.presentationModeEntered(
    AnimationTrack track,
    bool fullScreen,
  ) = PresentationModeEntered;

  const factory DocumentEvent.presentationModeExited() = PresentationModeExited;

  const factory DocumentEvent.presentationTick(int tick) = PresentationTick;

  factory DocumentEvent.fromJson(Map<String, dynamic> json) =>
      _$DocumentEventFromJson(json);

  bool shouldSync() => maybeMap(
        currentLayerChanged: (_) => false,
        templateCreated: (_) => false,
        documentSaved: (_) => false,
        documentPathChanged: (_) => false,
        currentAreaChanged: (_) => false,
        layerVisibilityChanged: (_) => false,
        toolStateChanged: (_) => false,
        presentationModeEntered: (_) => false,
        presentationModeExited: (_) => false,
        presentationTick: (_) => false,
        orElse: () => true,
      );
}
