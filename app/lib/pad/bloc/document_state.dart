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
  final Painter currentPainter;
  final Matrix4? transform;
  final PaintOption editOption;
  final ElementLayer? currentEditLayer;

  const DocumentLoadSuccess(this.document,
      {this.currentTool = ToolType.view,
      this.transform,
      this.currentPainter = const PenPainter(),
      this.currentEditLayer,
      this.editOption = const PaintOption()});

  @override
  List<Object?> get props => [document, currentTool, currentEditLayer, transform, editOption];

  DocumentLoadSuccess copyWith(
      {AppDocument? document,
      ToolType? currentTool,
      Matrix4? transform,
      PaintOption? editOption,
      Painter? currentPainter,
      ElementLayer? currentEditLayer,
      bool removeCurrentEditLayer = false}) {
    return DocumentLoadSuccess(document ?? this.document,
        currentTool: currentTool ?? this.currentTool,
        transform: transform ?? this.transform,
        editOption: editOption ?? this.editOption,
        currentPainter: currentPainter ?? this.currentPainter,
        currentEditLayer:
            removeCurrentEditLayer ? null : (currentEditLayer ?? this.currentEditLayer));
  }
}

class DocumentLoadFailure extends DocumentState {}
