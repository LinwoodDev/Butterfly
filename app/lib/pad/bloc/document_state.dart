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
  final ToolType currentTool;
  final ElementLayer? currentLayer;
  final String currentPath;
  final List<String> history;
  final bool gridView;

  const DocumentLoadSuccess(this.document,
      {this.currentSelectedPath = "pads/main",
      this.history = const [""],
      this.gridView = false,
      this.currentTool = ToolType.view,
      this.currentPath = '',
      this.currentLayer});

  @override
  List<Object?> get props => [document, currentSelectedPath, currentTool, currentLayer, gridView];

  DocumentLoadSuccess copyWith(
      {AppDocument? document,
      String? currentSelectedPath,
      ToolType? currentTool,
      ElementLayer? currentLayer,
      String? currentPath,
      bool unselectLayer = false,
      bool? gridView,
      List<String>? history}) {
    return DocumentLoadSuccess(document ?? this.document,
        currentSelectedPath: currentSelectedPath ?? this.currentSelectedPath,
        currentTool: currentTool ?? this.currentTool,
        currentLayer: unselectLayer ? null : currentLayer ?? this.currentLayer,
        currentPath: currentPath ?? this.currentPath,
        history: history ?? this.history,
        gridView: gridView ?? this.gridView);
  }
}

class DocumentLoadFailure extends DocumentState {}
