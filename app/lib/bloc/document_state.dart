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
  final List<String> invisbleLayers;
  final int? currentPainterIndex;

  const DocumentLoadSuccess(this.document,
      {this.path, this.currentPainterIndex, this.invisbleLayers = const []});

  @override
  List<Object?> get props =>
      [document, currentPainterIndex, path, invisbleLayers];

  Painter? get currentPainter {
    if (document.painters.isEmpty || currentPainterIndex == null) {
      return null;
    }
    return document
        .painters[currentPainterIndex!.clamp(0, document.painters.length - 1)];
  }

  DocumentLoadSuccess copyWith(
      {AppDocument? document,
      bool? editMode,
      int? currentPainterIndex,
      String? path,
      bool removeCurrentPainterIndex = false,
      List<String>? invisbleLayers}) {
    return DocumentLoadSuccess(document ?? this.document,
        path: path ?? this.path,
        invisbleLayers: invisbleLayers ?? this.invisbleLayers,
        currentPainterIndex: removeCurrentPainterIndex
            ? null
            : currentPainterIndex ?? this.currentPainterIndex);
  }

  bool isLayerVisible(String layer) => !invisbleLayers.contains(layer);

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
