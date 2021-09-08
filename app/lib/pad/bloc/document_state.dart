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

  const DocumentLoadSuccess(this.document, {this.currentTool = ToolType.view, this.transform});

  @override
  List<Object?> get props => [document, currentTool];

  DocumentLoadSuccess copyWith({
    AppDocument? document,
    ToolType? currentTool,
    Matrix4? transform,
  }) {
    return DocumentLoadSuccess(document ?? this.document,
        currentTool: currentTool ?? this.currentTool, transform: transform ?? this.transform);
  }
}

class DocumentLoadFailure extends DocumentState {}
