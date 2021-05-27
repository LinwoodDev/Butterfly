part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object> get props => [];
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

  ProjectItem? get currentSelected =>
      (currentSelectedPath == null ? null : document.getFile(currentSelectedPath!)) ?? document;
  PadProjectItem? get currentPad => currentSelected == null || !(currentSelected is PadProjectItem)
      ? null
      : currentSelected as PadProjectItem?;

  const DocumentLoadSuccess(this.document,
      {this.currentSelectedPath,
      this.history = const [""],
      this.currentTool = const ViewTool(),
      this.currentInspectorItem,
      this.currentPath = '',
      this.currentLayer});

  @override
  List<Object> get props => [
        document,
        if (currentSelectedPath != null) currentSelectedPath!,
        currentTool,
        if (currentInspectorItem != null) currentInspectorItem!,
        if (currentLayer != null) currentLayer!
      ];

  DocumentLoadSuccess copyWith(
      {AppDocument? document,
      String? currentSelectedPath,
      Tool? currentTool,
      ElementLayer? currentLayer,
      String? currentPath,
      InspectorItem? currentInspectorItem,
      bool unselectLayer = false,
      List<String>? history}) {
    return DocumentLoadSuccess(document ?? this.document,
        currentSelectedPath: currentSelectedPath ?? this.currentSelectedPath,
        currentTool: currentTool ?? this.currentTool,
        currentLayer: unselectLayer ? null : currentLayer ?? this.currentLayer,
        currentPath: currentPath ?? this.currentPath,
        history: history ?? this.history,
        currentInspectorItem: currentInspectorItem ?? this.currentInspectorItem);
  }
}

class DocumentLoadFailure extends DocumentState {}
