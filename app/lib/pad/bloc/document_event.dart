part of 'document_bloc.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object?> get props => [];
}

class LayerCreated extends DocumentEvent {
  final ElementLayer? layer;

  const LayerCreated({this.layer});
  @override
  List<Object?> get props => [layer];
}

class LayersRemoved extends DocumentEvent {
  final List<ElementLayer> layers;

  const LayersRemoved(this.layers);
  @override
  List<Object?> get props => [layers];
}

class DocumentNameChanged extends DocumentEvent {
  final String name;

  const DocumentNameChanged(this.name);
  @override
  List<Object?> get props => [name];
}

class ToolChanged extends DocumentEvent {
  final ToolType tool;

  const ToolChanged(this.tool);

  @override
  List<Object?> get props => [tool];
}

class TransformChanged extends DocumentEvent {
  final Matrix4 transform;

  const TransformChanged(this.transform);

  @override
  List<Object?> get props => [transform];
}

class EditingLayerChanged extends DocumentEvent {
  final ElementLayer? editingLayer;

  const EditingLayerChanged(this.editingLayer);

  @override
  List<Object?> get props => [editingLayer];
}

class PainterChanged extends DocumentEvent {
  final Painter? painter;

  const PainterChanged(this.painter);

  @override
  List<Object?> get props => [painter];
}
