part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object?> get props => [];
}

class DocumentLoadInProgress extends DocumentState {}

class DocumentLoadSuccess extends DocumentState {
  final AppDocument document;
  final ToolType currentTool;
  final int currentPainterIndex;
  final Matrix4? transform;
  final ElementLayer? currentEditLayer;

  const DocumentLoadSuccess(this.document,
      {this.currentTool = ToolType.view,
      this.transform,
      this.currentPainterIndex = 0,
      this.currentEditLayer});

  @override
  List<Object?> get props =>
      [document, currentTool, currentEditLayer, transform, currentPainterIndex];

  Painter? get currentPainter {
    if (document.painters.isEmpty) {
      return null;
    }
    return document.painters[currentPainterIndex.clamp(0, document.painters.length - 1)];
  }

  DocumentLoadSuccess copyWith(
      {AppDocument? document,
      ToolType? currentTool,
      Matrix4? transform,
      int? currentPainterIndex,
      ElementLayer? currentEditLayer,
      bool removeCurrentEditLayer = false}) {
    return DocumentLoadSuccess(document ?? this.document,
        currentTool: currentTool ?? this.currentTool,
        transform: transform ?? this.transform,
        currentPainterIndex: currentPainterIndex ?? this.currentPainterIndex,
        currentEditLayer:
            removeCurrentEditLayer ? null : (currentEditLayer ?? this.currentEditLayer));
  }
}

class DocumentLoadFailure extends DocumentState {}
