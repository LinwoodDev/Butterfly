part of 'document_bloc.dart';

abstract class DocumentEvent extends ReplayEvent with EquatableMixin {
  const DocumentEvent();

  @override
  List<Object?> get props => [];
}

class DocumentUpdated extends DocumentEvent {
  final AppDocument document;

  DocumentUpdated(this.document);
}

class ElementsCreated extends DocumentEvent {
  final List<PadElement> elements;

  const ElementsCreated(this.elements);

  @override
  List<Object?> get props => [elements];
}

class ElementsReplaced extends DocumentEvent {
  final Map<int?, List<PadElement>> replacedElements;

  const ElementsReplaced(this.replacedElements);

  @override
  List<Object?> get props => [replacedElements];
}

class ElementChanged extends DocumentEvent {
  final PadElement old;
  final PadElement updated;
  const ElementChanged(this.old, this.updated);

  @override
  List<Object?> get props => [old, updated];
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
  final String? path;

  const DocumentPathChanged(this.path);
  @override
  List<Object?> get props => [path];
}

class DocumentPaletteChanged extends DocumentEvent {
  final List<ColorPalette> palette;

  const DocumentPaletteChanged(this.palette);
  @override
  List<Object?> get props => [palette];
}

class DocumentSaved extends DocumentEvent {
  const DocumentSaved();
}

class PainterCreated extends DocumentEvent {
  final Painter painter;

  const PainterCreated(this.painter);

  @override
  List<Object?> get props => [painter];
}

class PainterChanged extends DocumentEvent {
  final Painter painter;
  final int index;

  const PainterChanged(this.painter, this.index);

  @override
  List<Object?> get props => [painter, index];
}

class PainterRemoved extends DocumentEvent {
  final int index;

  const PainterRemoved(this.index);

  @override
  List<Object?> get props => [index];
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

class HandPropertyChanged extends DocumentEvent {
  final HandProperty property;

  const HandPropertyChanged(this.property);

  @override
  List<Object?> get props => [property];
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

class ImageUnbaked extends DocumentEvent {
  const ImageUnbaked();

  @override
  List<Object?> get props => [];
}

class ImageBaked extends DocumentEvent {
  final ui.Size viewportSize;
  final CameraTransform cameraTransform;
  final bool undoLast;

  const ImageBaked(this.viewportSize, this.cameraTransform,
      [this.undoLast = true]);

  @override
  List<Object?> get props => [viewportSize];
}

class TemplateCreated extends DocumentEvent {
  final bool deleteDocument;

  const TemplateCreated({this.deleteDocument = true});

  @override
  List<Object?> get props => [deleteDocument];
}

class AreaCreated extends DocumentEvent {
  final Area area;

  const AreaCreated(this.area);

  @override
  List<Object?> get props => [area];
}

class AreaRemoved extends DocumentEvent {
  final int index;

  const AreaRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class AreaChanged extends DocumentEvent {
  final Area area;
  final int index;
  const AreaChanged(this.index, this.area);

  @override
  List<Object?> get props => [area, index];
}

class CurrentAreaChanged extends DocumentEvent {
  final int area;

  const CurrentAreaChanged(this.area);
  const CurrentAreaChanged.exit() : area = -1;

  @override
  List<Object?> get props => [area];
}
