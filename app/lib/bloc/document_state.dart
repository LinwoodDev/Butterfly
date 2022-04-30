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
  final Embedding? embedding;

  DocumentLoadSuccess(this.document,
      {this.path,
      required this.settingsCubit,
      CameraViewport? cameraViewport,
      this.currentAreaIndex = -1,
      CurrentIndex? currentIndex,
      this.currentLayer = '',
      this.embedding,
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
        currentAreaIndex,
        settingsCubit,
        embedding
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
          embedding: embedding,
          currentIndex:
              removeCurrentIndex ? null : currentIndex ?? this.currentIndex);

  bool isLayerVisible(String layer) => !invisibleLayers.contains(layer);

  Future<String> save() {
    if (embedding != null) return Future.value('');
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

  Future<ByteData?> render(
      {required int width,
      required int height,
      double x = 0,
      double y = 0,
      double scale = 1,
      bool renderBackground = true}) async {
    var recorder = ui.PictureRecorder();
    var canvas = Canvas(recorder);
    var painter = ViewPainter(document,
        renderBackground: renderBackground,
        cameraViewport: cameraViewport.withUnbaked(renderers),
        transform: CameraTransform(-Offset(x.toDouble(), y.toDouble()), scale));
    painter.paint(canvas, Size(width.toDouble(), height.toDouble()));
    var picture = recorder.endRecording();
    var image = await picture.toImage(width, height);
    return await image.toByteData(format: ui.ImageByteFormat.png);
  }

  XmlDocument renderSVG(
      {required int width,
      required int height,
      double x = 0,
      double y = 0,
      bool renderBackground = true}) {
    final document = XmlDocument();
    final svg = document.createElement('svg', attributes: {
      'xmlns': 'http://www.w3.org/2000/svg',
      'xmlns:xlink': 'http://www.w3.org/1999/xlink',
      'version': '1.1',
      'width': '${width}px',
      'height': '${height}px',
      'viewBox': '$x $y $width $height',
    });
    svg
        .createElement('defs')
        .createElement('mask', id: 'eraser-mask')
        .createElement('rect', attributes: {
      'x': '0',
      'y': '0',
      'width': '${width}px',
      'height': '${height}px',
      'fill': 'white',
    });

    final rect = Rect.fromLTWH(x, y, width.toDouble(), height.toDouble());
    if (renderBackground) {
      cameraViewport.background.buildSvg(document, this.document, rect);
    }
    for (var e in renderers) {
      e.buildSvg(document, this.document, rect);
    }
    return document;
  }
}

class DocumentLoadFailure extends DocumentState {}
