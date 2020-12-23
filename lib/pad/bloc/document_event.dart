part of 'document_bloc.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object> get props => [];
}

class LayerCreated extends DocumentEvent {
  final ElementLayer layer;
  final ElementLayer parent;

  LayerCreated({@required this.layer, this.parent});
  @override
  List<Object> get props => [layer];
}

class DocumentNameChanged extends DocumentEvent {
  final String name;

  DocumentNameChanged(this.name);
  @override
  List<Object> get props => [name];
}

class PathChanged extends DocumentEvent {
  final String path;

  PathChanged(this.path);

  @override
  List<Object> get props => [path];
}

class SelectedChanged extends DocumentEvent {
  final String path;

  SelectedChanged(this.path);

  @override
  List<Object> get props => [path];
}
