part of 'document_bloc.dart';

abstract class DocumentEvent extends ReplayEvent with EquatableMixin {
  const DocumentEvent();

  @override
  List<Object?> get props => [];
}

class ElementCreated extends DocumentEvent {
  final PadElement element;

  const ElementCreated(this.element);

  @override
  List<Object?> get props => [element];
}

class ElementChanged extends DocumentEvent {
  final PadElement element;
  final int index;
  const ElementChanged(this.index, this.element);

  @override
  List<Object?> get props => [element, index];
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

class DocumentPaletteChanged extends DocumentEvent {
  final List<ColorPalette> palette;

  const DocumentPaletteChanged(this.palette);
  @override
  List<Object?> get props => [palette];
}

class CurrentPainterChanged extends DocumentEvent {
  final int? painter;

  const CurrentPainterChanged(this.painter);

  @override
  List<Object?> get props => [painter];
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
