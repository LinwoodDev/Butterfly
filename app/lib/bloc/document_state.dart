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
  final List<String> invisibleLayers;
  final CameraViewport cameraViewport;
  final CurrentIndex currentIndex;
  final SettingsCubit settingsCubit;

  DocumentLoadSuccess(this.document,
      {this.path,
      required this.settingsCubit,
      CameraViewport? cameraViewport,
      this.currentAreaIndex = -1,
      CurrentIndex? currentIndex,
      this.currentLayer = '',
      this.invisibleLayers = const []})
      : currentIndex = currentIndex ?? CurrentIndex(-1, HandHandler()),
        cameraViewport = cameraViewport ??
            CameraViewport.unbaked(
                Renderer.fromInstance(document.background)..setup(document),
                document.content
                    .map((e) => Renderer.fromInstance(e)..setup(document))
                    .toList());

  @override
  List<Object?> get props => [
        currentIndex,
        invisibleLayers,
        cameraViewport,
        document,
        path,
        currentLayer,
        currentAreaIndex
      ];

  List<Renderer<PadElement>> get renderers =>
      List.from(cameraViewport.bakedElements)
        ..addAll(cameraViewport.unbakedElements);

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

  Renderer? getRenderer(PadElement element) =>
      renderers.firstWhereOrNull((renderer) => renderer.element == element);

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
          CameraViewport? cameraViewport}) =>
      DocumentLoadSuccess(document ?? this.document,
          path: removePath ? null : path ?? this.path,
          invisibleLayers: invisibleLayers ?? this.invisibleLayers,
          currentLayer: currentLayer ?? this.currentLayer,
          currentAreaIndex: currentAreaIndex ?? this.currentAreaIndex,
          cameraViewport: cameraViewport ?? this.cameraViewport,
          settingsCubit: settingsCubit,
          currentIndex:
              removeCurrentIndex ? null : currentIndex ?? this.currentIndex);

  bool isLayerVisible(String layer) => !invisibleLayers.contains(layer);

  Future<String> save() {
    if (path == null) {
      return DocumentFileSystem.fromPlatform()
          .importDocument(document)
          .then((value) => value.path)
        ..then(settingsCubit.addRecentHistory);
    }
    return DocumentFileSystem.fromPlatform()
        .updateDocument(path!, document)
        .then((value) => value.path)
      ..then(settingsCubit.addRecentHistory);
  }
}

class DocumentLoadFailure extends DocumentState {}
