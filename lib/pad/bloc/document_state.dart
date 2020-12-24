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
  final Tool currentTool;
  final InspectorItem currentInspectorItem;

  ProjectItem get currentSelected =>
      currentSelectedPath == null ? null : document.getFile(currentSelectedPath);
  PadProjectItem get currentPad =>
      currentSelected == null || !(currentSelected is PadProjectItem) ? null : currentSelected;

  const DocumentLoadSuccess(this.document,
      {this.currentSelectedPath, this.currentTool, this.currentInspectorItem});

  @override
  List<Object> get props => [document, currentSelectedPath, currentTool];

  DocumentLoadSuccess copyWith(
      {AppDocument document,
      String currentSelectedPath,
      Tool currentTool,
      InspectorItem currentInspectorItem}) {
    return DocumentLoadSuccess(document ?? this.document,
        currentSelectedPath: currentSelectedPath ?? this.currentSelectedPath,
        currentTool: currentTool ?? this.currentTool,
        currentInspectorItem: currentInspectorItem ?? this.currentInspectorItem);
  }
}

class DocumentLoadFailure extends DocumentState {}
