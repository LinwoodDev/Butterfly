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

  const DocumentLoadSuccess(this.document, {this.currentTool = ToolType.view});

  @override
  List<Object?> get props => [document, currentTool];

  DocumentLoadSuccess copyWith({
    AppDocument? document,
    ToolType? currentTool,
  }) {
    return DocumentLoadSuccess(document ?? this.document,
        currentTool: currentTool ?? this.currentTool);
  }
}

class DocumentLoadFailure extends DocumentState {}
