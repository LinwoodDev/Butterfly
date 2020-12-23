part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object> get props => [];
}

class DocumentLoadInProgress extends DocumentState {}

class DocumentLoadSuccess extends DocumentState {
  final AppDocument document;
  final String currentSelectedPath;

  ProjectItem get currentSelected =>
      currentSelectedPath == null ? null : document.folder.getFile(currentSelectedPath);
  PadProjectItem get currentPad =>
      currentSelected == null || !(currentSelected is PadProjectItem) ? currentSelected : null;

  const DocumentLoadSuccess(this.document, {this.currentSelectedPath});

  @override
  List<Object> get props => [document];
}

class DocumentLoadFailure extends DocumentState {}
