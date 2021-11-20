part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object?> get props => [];
}

class DocumentLoadInProgress extends DocumentState {}

class DocumentLoadSuccess extends DocumentState {
  final AppDocument document;
  final String? path;
  final bool editMode;
  final int currentPainterIndex;

  const DocumentLoadSuccess(this.document,
      {this.editMode = true, this.path, this.currentPainterIndex = 0});

  @override
  List<Object?> get props => [document, editMode, currentPainterIndex, path];

  Painter? get currentPainter {
    if (document.painters.isEmpty) {
      return null;
    }
    return document
        .painters[currentPainterIndex.clamp(0, document.painters.length - 1)];
  }

  DocumentLoadSuccess copyWith(
      {AppDocument? document,
      bool? editMode,
      int? currentPainterIndex,
      String? path}) {
    return DocumentLoadSuccess(document ?? this.document,
        editMode: editMode ?? this.editMode,
        path: path ?? this.path,
        currentPainterIndex: currentPainterIndex ?? this.currentPainterIndex);
  }

  Future<String> save() {
    if (path == null) {
      return DocumentFileSystem.fromPlatform()
          .importDocument(document)
          .then((value) => value.path);
    }
    return DocumentFileSystem.fromPlatform()
        .updateDocument(path!, document)
        .then((value) => value.path);
  }
}

class DocumentLoadFailure extends DocumentState {}
