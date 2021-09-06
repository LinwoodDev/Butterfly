part of 'document_bloc.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object?> get props => [];
}

class ProjectChanged extends DocumentEvent {
  final String? nextSelected;

  ProjectChanged({this.nextSelected});
  @override
  List<Object?> get props => [nextSelected];
}

class LayerCreated extends DocumentEvent {
  final ElementLayer layer;

  LayerCreated({required this.layer});
  @override
  List<Object?> get props => [layer];
}

class LayerChanged extends DocumentEvent {
  final ElementLayer? layer;

  LayerChanged(this.layer);
  @override
  List<Object?> get props => [layer];
}

class DocumentNameChanged extends DocumentEvent {
  final String name;

  DocumentNameChanged(this.name);
  @override
  List<Object?> get props => [name];
}

class ToggleGridView extends DocumentEvent {
  ToggleGridView();
  @override
  List<Object?> get props => [];
}

class SelectedChanged extends DocumentEvent {
  final String path;

  SelectedChanged(this.path);

  @override
  List<Object?> get props => [path];
}

class ToolChanged extends DocumentEvent {
  final ToolType tool;

  ToolChanged(this.tool);

  @override
  List<Object?> get props => [tool];
}
