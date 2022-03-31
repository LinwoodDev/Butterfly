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
  final int currentAreaIndex;
  final List<Renderer> renderers;
  final List<String> invisibleLayers;
  final BakedViewport? bakedViewport;
  final CurrentIndex currentIndex;

  DocumentLoadSuccess(this.document,
      {this.path,
      this.bakedViewport,
      this.renderers = const [],
      this.currentAreaIndex = -1,
      CurrentIndex? currentIndex,
      this.currentLayer = '',
      this.invisibleLayers = const []})
      : currentIndex = currentIndex ?? CurrentIndex(-1, HandHandler());

  @override
  List<Object?> get props => [
        currentIndex,
        invisibleLayers,
        bakedViewport,
        document,
        path,
        currentLayer,
        currentAreaIndex
      ];

  List<PadElement> get elements {
    return bakedViewport?.unbakedElements ?? document.content;
  }

  HandHandler? fetchHand() {
    final handler = currentIndex.handler;
    if (handler is! HandHandler) return null;
    return handler;
  }

  Painter? get currentPainter {
    var index = currentIndex.index;
    if (document.painters.isEmpty ||
        index < 0 ||
        index >= document.painters.length) {
      return null;
    }
    return document.painters[index];
  }

  Area? get currentArea {
    if (currentAreaIndex < 0 || currentAreaIndex >= document.areas.length) {
      return null;
    }
    return document.areas[currentAreaIndex];
  }

  DocumentLoadSuccess copyWith(
          {AppDocument? document,
          bool? editMode,
          CurrentIndex? currentIndex,
          String? path,
          String? currentLayer,
          int? currentAreaIndex,
          bool removeCurrentIndex = false,
          bool removePath = false,
          List<String>? invisibleLayers,
          BakedViewport? bakedViewport,
          bool removeBakedViewport = false}) =>
      DocumentLoadSuccess(document ?? this.document,
          path: removePath ? null : path ?? this.path,
          invisibleLayers: invisibleLayers ?? this.invisibleLayers,
          currentLayer: currentLayer ?? this.currentLayer,
          currentAreaIndex: currentAreaIndex ?? this.currentAreaIndex,
          bakedViewport:
              removeBakedViewport ? null : bakedViewport ?? this.bakedViewport,
          currentIndex:
              removeCurrentIndex ? null : currentIndex ?? this.currentIndex);

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
