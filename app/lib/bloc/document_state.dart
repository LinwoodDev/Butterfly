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
  final String currentLayer;
  final List<String> invisibleLayers;
  final BakedViewport? bakedViewport;
  final int? currentPainterIndex;

  const DocumentLoadSuccess(this.document,
      {this.path,
      this.bakedViewport,
      this.currentPainterIndex = 0,
      this.currentLayer = '',
      this.invisibleLayers = const []});

  @override
  List<Object?> get props =>
      [currentPainterIndex, invisibleLayers, bakedViewport];

  List<PadElement> get elements {
    return bakedViewport?.unbakedElements ?? document.content;
  }

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
          String? currentLayer,
          bool removeCurrentPainterIndex = false,
          bool removePath = false,
          List<String>? invisibleLayers,
          BakedViewport? bakedViewport,
          bool removeBakedViewport = false}) =>
      DocumentLoadSuccess(document ?? this.document,
          path: removePath ? null : path ?? this.path,
          invisibleLayers: invisibleLayers ?? this.invisibleLayers,
          currentLayer: currentLayer ?? this.currentLayer,
          bakedViewport:
              removeBakedViewport ? null : bakedViewport ?? this.bakedViewport,
          currentPainterIndex: removeCurrentPainterIndex
              ? null
              : currentPainterIndex ?? this.currentPainterIndex);

  bool isLayerVisible(String layer) => !invisibleLayers.contains(layer);

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
