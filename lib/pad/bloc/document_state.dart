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
  final String currentPath;

  ProjectItem get currentSelected =>
      currentSelectedPath == null ? null : document.getFile(currentSelectedPath);
  PadProjectItem get currentPad =>
      currentSelected == null || !(currentSelected is PadProjectItem) ? null : currentSelected;

  const DocumentLoadSuccess(this.document, {this.currentSelectedPath, this.currentPath = ''});

  @override
  List<Object> get props => [document, currentSelectedPath, currentPath];
}

class DocumentLoadFailure extends DocumentState {}
