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
  final ElementLayer currentLayer;
  final InspectorItem currentInspectorItem;

  ProjectItem get currentSelected =>
      (currentSelectedPath == null ? null : document.getFile(currentSelectedPath)) ?? document;
  PadProjectItem get currentPad =>
      currentSelected == null || !(currentSelected is PadProjectItem) ? null : currentSelected;

  const DocumentLoadSuccess(this.document,
      {this.currentSelectedPath,
      this.currentTool = const ViewTool(),
      this.currentInspectorItem,
      this.currentLayer});

  @override
  List<Object> get props =>
      [document, currentSelectedPath, currentTool, currentInspectorItem, currentLayer];

  DocumentLoadSuccess copyWith(
      {AppDocument document,
      String currentSelectedPath,
      Tool currentTool,
      ElementLayer currentLayer,
      InspectorItem currentInspectorItem,
      bool unselectLayer = false}) {
    return DocumentLoadSuccess(document ?? this.document,
        currentSelectedPath: currentSelectedPath ?? this.currentSelectedPath,
        currentTool: currentTool ?? this.currentTool,
        currentLayer: unselectLayer ? null : currentLayer ?? this.currentLayer,
        currentInspectorItem: currentInspectorItem ?? this.currentInspectorItem);
  }
}

class DocumentLoadFailure extends DocumentState {}
