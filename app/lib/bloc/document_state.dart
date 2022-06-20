part of 'document_bloc.dart';

enum StorageType {
  local,
  cloud,
}

abstract class DocumentState extends Equatable {
  const DocumentState();

  @override
  List<Object?> get props => [];
}

class DocumentLoadInProgress extends DocumentState {}

class DocumentLoadSuccess extends DocumentState {
  final AppDocument document;
  final AssetLocation? location;
  final StorageType storageType;
  final String currentLayer;
  final int currentAreaIndex;
  final List<String> invisibleLayers;
  final CameraViewport cameraViewport;
  final SettingsCubit settingsCubit;
  final CurrentIndexCubit currentIndexCubit;
  final Embedding? embedding;
  final bool saved;

  DocumentLoadSuccess(this.document,
      {this.location,
      this.storageType = StorageType.local,
      this.saved = true,
      required this.settingsCubit,
      required this.currentIndexCubit,
      CameraViewport? cameraViewport,
      this.currentAreaIndex = -1,
      this.currentLayer = '',
      this.embedding,
      this.invisibleLayers = const []})
      : cameraViewport = cameraViewport ??
            CameraViewport.unbaked(
                Renderer.fromInstance(document.background)..setup(document),
                document.content
                    .map((e) => Renderer.fromInstance(e)..setup(document))
                    .toList());

  @override
  List<Object?> get props => [
        invisibleLayers,
        cameraViewport,
        document,
        location,
        currentLayer,
        currentAreaIndex,
        settingsCubit,
        embedding,
        saved
      ];

  List<Renderer<PadElement>> get renderers =>
      List.from(cameraViewport.bakedElements)
        ..addAll(cameraViewport.unbakedElements);

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
          AssetLocation? location,
          String? currentLayer,
          int? currentAreaIndex,
          bool removePath = false,
          bool? saved,
          List<String>? invisibleLayers,
          CameraViewport? cameraViewport}) =>
      DocumentLoadSuccess(
        document ?? this.document,
        location: removePath ? null : location ?? this.location,
        invisibleLayers: invisibleLayers ?? this.invisibleLayers,
        currentLayer: currentLayer ?? this.currentLayer,
        currentAreaIndex: currentAreaIndex ?? this.currentAreaIndex,
        cameraViewport: cameraViewport ?? this.cameraViewport,
        saved: saved ?? this.saved,
        settingsCubit: settingsCubit,
        embedding: embedding,
        currentIndexCubit: currentIndexCubit,
      );

  bool isLayerVisible(String layer) => !invisibleLayers.contains(layer);

  Future<AssetLocation> save() {
    final storage = getRemoteStorage();
    if (embedding != null) return Future.value(AssetLocation.local(''));
    if (location == null || location?.path == '') {
      return DocumentFileSystem.fromPlatform(remote: getRemoteStorage())
          .importDocument(document)
          .then((value) => value.location)
        ..then(settingsCubit.addRecentHistory);
    }
    return DocumentFileSystem.fromPlatform(remote: storage)
        .updateDocument(location!.path, document)
        .then((value) => value.location)
      ..then(settingsCubit.addRecentHistory);
  }

  RemoteStorage? getRemoteStorage() =>
      location == null ? null : settingsCubit.state.getRemote(location!.remote);

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
      'x': '${x}px',
      'y': '${y}px',
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
