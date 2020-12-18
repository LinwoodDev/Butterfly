part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object> get props => [];
}

class DocumentLoadInProgress extends DocumentState {}

class DocumentLoadSuccess extends DocumentState {
  final AppDocument document;

  const DocumentLoadSuccess(this.document);

  @override
  List<Object> get props => [document];
}

class TodosLoadFailure extends DocumentState {}
