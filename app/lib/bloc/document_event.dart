part of 'document_bloc.dart';

abstract class DocumentEvent extends ReplayEvent with EquatableMixin {
  const DocumentEvent();

  @override
  List<Object?> get props => [];
}

class FileMetaUpdated extends DocumentEvent {
  final FileMetadata metadata;

  FileMetaUpdated(this.metadata);
}

class ToolChanged extends DocumentEvent {
  final ToolOption? option;
  final ToolState? state;

  ToolChanged({this.option, this.state});
  ToolChanged.option(this.option) : state = null;
  ToolChanged.state(this.state) : option = null;
}

class ElementsCreated extends DocumentEvent {
  final List<PadElement>? elements;
  final List<Renderer<PadElement>>? renderers;

  const ElementsCreated(this.elements) : renderers = null;
  const ElementsCreated.renderers(this.renderers) : elements = null;

  @override
  List<Object?> get props => [elements, renderers];
}

class ElementsReplaced extends DocumentEvent {
  final Map<int?, List<PadElement>> replacedElements;

  const ElementsReplaced(this.replacedElements);

  @override
  List<Object?> get props => [replacedElements];
}

class ElementsChanged extends DocumentEvent {
  final Map<PadElement, List<PadElement>> changedElements;
  const ElementsChanged(this.changedElements);

  @override
  List<Object?> get props => [changedElements];
}

class ElementsRemoved extends DocumentEvent {
  final List<PadElement> elements;

  const ElementsRemoved(this.elements);
  @override
  List<Object?> get props => [elements];
}

class DocumentDescriptorChanged extends DocumentEvent {
  final String? name, description;

  const DocumentDescriptorChanged({this.name, this.description});
  @override
  List<Object?> get props => [name, description];
}

class DocumentPathChanged extends DocumentEvent {
  final String location;

  const DocumentPathChanged(this.location);
  @override
  List<Object?> get props => [location];
}

class DocumentSaved extends DocumentEvent {
  final AssetLocation? location;

  const DocumentSaved([this.location]);
  @override
  List<Object?> get props => [location];
}

class PainterCreated extends DocumentEvent {
  final Painter painter;

  const PainterCreated(this.painter);

  @override
  List<Object?> get props => [painter];
}

class PaintersChanged extends DocumentEvent {
  final Map<Painter, Painter> updatedPainters;

  const PaintersChanged(this.updatedPainters);

  @override
  List<Object?> get props => [updatedPainters];
}

class PaintersRemoved extends DocumentEvent {
  final List<Painter> painters;

  const PaintersRemoved(this.painters);

  @override
  List<Object?> get props => [painters];
}

class PainterReordered extends DocumentEvent {
  final int oldIndex, newIndex;

  const PainterReordered(this.oldIndex, this.newIndex);

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class DocumentBackgroundChanged extends DocumentEvent {
  final dynamic background;

  const DocumentBackgroundChanged(this.background);

  @override
  List<Object?> get props => [background];
}

class WaypointCreated extends DocumentEvent {
  final Waypoint waypoint;

  const WaypointCreated(this.waypoint);

  @override
  List<Object?> get props => [waypoint];
}

class WaypointRemoved extends DocumentEvent {
  final int index;

  const WaypointRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class LayerRenamed extends DocumentEvent {
  final String oldName, newName;

  const LayerRenamed(this.oldName, this.newName);

  @override
  List<Object?> get props => [oldName, newName];
}

class LayerRemoved extends DocumentEvent {
  final String name;

  const LayerRemoved(this.name);

  @override
  List<Object?> get props => [name];
}

class LayerElementsDeleted extends DocumentEvent {
  final String name;

  const LayerElementsDeleted(this.name);

  @override
  List<Object?> get props => [name];
}

class LayerVisibilityChanged extends DocumentEvent {
  final String name;

  const LayerVisibilityChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class CurrentLayerChanged extends DocumentEvent {
  final String? name;

  const CurrentLayerChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class ElementsLayerChanged extends DocumentEvent {
  final String layer;
  final List<PadElement> elements;

  const ElementsLayerChanged(this.layer, this.elements);

  @override
  List<Object?> get props => [layer, elements];
}

class TemplateCreated extends DocumentEvent {
  final String directory;
  final String? remote;
  final bool deleteDocument;

  const TemplateCreated(
      {this.deleteDocument = true, this.directory = '', this.remote});

  @override
  List<Object?> get props => [deleteDocument];
}

class AreasCreated extends DocumentEvent {
  final List<Area> areas;

  const AreasCreated(this.areas);

  @override
  List<Object?> get props => [areas];
}

class AreasRemoved extends DocumentEvent {
  final List<String> areas;

  const AreasRemoved(this.areas);

  @override
  List<Object?> get props => [areas];
}

class AreaChanged extends DocumentEvent {
  final Area area;
  final String name;
  const AreaChanged(this.name, this.area);

  @override
  List<Object?> get props => [area, name];
}

class CurrentAreaChanged extends DocumentEvent {
  final String area;

  const CurrentAreaChanged(this.area);
  const CurrentAreaChanged.exit() : area = '';

  @override
  List<Object?> get props => [area];
}

class ExportPresetCreated extends DocumentEvent {
  final String name;
  final List<AreaPreset> areas;

  ExportPresetCreated(this.name, this.areas);

  @override
  List<Object?> get props => [name, areas];
}

class ExportPresetUpdated extends DocumentEvent {
  final String name;
  final List<AreaPreset> areas;

  ExportPresetUpdated(this.name, this.areas);

  @override
  List<Object?> get props => [name, areas];
}

class ExportPresetRemoved extends DocumentEvent {
  final String name;

  ExportPresetRemoved(this.name);

  @override
  List<Object?> get props => [name];
}

class DocumentPackAdded extends DocumentEvent {
  final NoteData pack;

  const DocumentPackAdded(this.pack);

  @override
  List<Object?> get props => [pack];
}

class DocumentPackUpdated extends DocumentEvent {
  final String name;
  final NoteData pack;

  const DocumentPackUpdated(this.name, this.pack);

  @override
  List<Object?> get props => [name, pack];
}

class DocumentPackRemoved extends DocumentEvent {
  final String pack;

  const DocumentPackRemoved(this.pack);

  @override
  List<Object?> get props => [pack];
}

class DocumentAnimationAdded extends DocumentEvent {
  final AnimationTrack animation;

  const DocumentAnimationAdded(this.animation);

  @override
  List<Object?> get props => [animation];
}

class DocumentAnimationUpdated extends DocumentEvent {
  final String name;
  final AnimationTrack animation;

  const DocumentAnimationUpdated(this.name, this.animation);

  @override
  List<Object?> get props => [name, animation];
}

class DocumentAnimationRemoved extends DocumentEvent {
  final String animation;

  const DocumentAnimationRemoved(this.animation);

  @override
  List<Object?> get props => [animation];
}

class PresentationModeEntered extends DocumentEvent {
  final AnimationTrack track;
  final bool fullScreen;

  const PresentationModeEntered(this.track, this.fullScreen);

  @override
  List<Object?> get props => [track, fullScreen];
}

class PresentationModeExited extends DocumentEvent {
  const PresentationModeExited();

  @override
  List<Object?> get props => [];
}

class PresentationTick extends DocumentEvent {
  final int tick;

  const PresentationTick(this.tick);

  @override
  List<Object?> get props => [tick];
}
