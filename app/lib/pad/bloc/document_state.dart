part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object?> get props => [];
}

class DocumentLoadInProgress extends DocumentState {}

class DocumentLoadSuccess extends DocumentState {
  final AppDocument document;
  final String? currentSelectedPath;
  final Tool currentTool;
  final ElementLayer? currentLayer;
  final String currentPath;
  final List<String> history;
  final InspectorItem? currentInspectorItem;
  final bool gridView;

  ProjectItem? get currentSelected =>
      (currentSelectedPath == null ? null : document.getFile(currentSelectedPath!)) ?? document;
  PadProjectItem? get currentPad => currentSelected == null || !(currentSelected is PadProjectItem)
      ? null
      : currentSelected as PadProjectItem?;

  const DocumentLoadSuccess(this.document,
      {this.currentSelectedPath = "pads/main",
      this.history = const [""],
      this.gridView = false,
      this.currentTool = const ViewTool(),
      this.currentInspectorItem,
      this.currentPath = '',
      this.currentLayer});

  @override
  List<Object?> get props =>
      [document, currentSelectedPath, currentTool, currentInspectorItem, currentLayer, gridView];

  DocumentLoadSuccess copyWith(
      {AppDocument? document,
      String? currentSelectedPath,
      Tool? currentTool,
      ElementLayer? currentLayer,
      String? currentPath,
      InspectorItem? currentInspectorItem,
      bool unselectLayer = false,
      bool? gridView,
      List<String>? history}) {
    return DocumentLoadSuccess(document ?? this.document,
        currentSelectedPath: currentSelectedPath ?? this.currentSelectedPath,
        currentTool: currentTool ?? this.currentTool,
        currentLayer: unselectLayer ? null : currentLayer ?? this.currentLayer,
        currentPath: currentPath ?? this.currentPath,
        history: history ?? this.history,
        gridView: gridView ?? this.gridView,
        currentInspectorItem: currentInspectorItem ?? this.currentInspectorItem);
  }
}

class DocumentLoadFailure extends DocumentState {}
