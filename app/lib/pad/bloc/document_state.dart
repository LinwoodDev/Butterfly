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
  final Matrix4? transform;
  final ElementLayer? currentEditLayer;

  const DocumentLoadSuccess(this.document,
      {this.currentTool = ToolType.view, this.transform, this.currentEditLayer});

  @override
  List<Object?> get props => [document, currentTool, currentEditLayer, transform];

  DocumentLoadSuccess copyWith(
      {AppDocument? document,
      ToolType? currentTool,
      Matrix4? transform,
      ElementLayer? currentEditLayer,
      bool removeCurrentEditLayer = false}) {
    return DocumentLoadSuccess(document ?? this.document,
        currentTool: currentTool ?? this.currentTool,
        transform: transform ?? this.transform,
        currentEditLayer:
            removeCurrentEditLayer ? null : (currentEditLayer ?? this.currentEditLayer));
  }
}

class DocumentLoadFailure extends DocumentState {}
