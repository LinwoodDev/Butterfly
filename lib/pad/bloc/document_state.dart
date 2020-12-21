part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object> get props => [];
}

class DocumentLoadInProgress extends DocumentState {}

class DocumentLoadSuccess extends DocumentState {
  final AppDocument document;
  final String currentPadPath;

  PadProjectItem get currentPad =>
      currentPadPath == null ? null : document.folder.getFile(currentPadPath);

  const DocumentLoadSuccess(this.document, {this.currentPadPath});

  @override
  List<Object> get props => [document];
}

class DocumentLoadFailure extends DocumentState {}
