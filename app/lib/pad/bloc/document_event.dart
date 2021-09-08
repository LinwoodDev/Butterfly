part of 'document_bloc.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object?> get props => [];
}

class LayerCreated extends DocumentEvent {
  final ElementLayer layer;

  LayerCreated({required this.layer});
  @override
  List<Object?> get props => [layer];
}

class DocumentNameChanged extends DocumentEvent {
  final String name;

  DocumentNameChanged(this.name);
  @override
  List<Object?> get props => [name];
}

class ToolChanged extends DocumentEvent {
  final ToolType tool;

  ToolChanged(this.tool);

  @override
  List<Object?> get props => [tool];
}

class TransformChanged extends DocumentEvent {
  final Matrix4 transform;

  TransformChanged(this.transform);

  @override
  List<Object?> get props => [transform];
}
