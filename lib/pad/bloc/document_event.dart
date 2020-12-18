part of 'document_bloc.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();

  @override
  List<Object> get props => [];
}

class LayerAdded extends DocumentEvent {
  final ElementLayer layer;

  LayerAdded(this.layer);
  @override
  List<Object> get props => [layer];
}

class DocumentNameChanged extends DocumentEvent {
  final String name;

  DocumentNameChanged(this.name);
  @override
  List<Object> get props => [name];
}
