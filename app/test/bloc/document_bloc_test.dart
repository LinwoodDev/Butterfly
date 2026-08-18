import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/embed/embedding.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly/view_painter.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:xml/xml.dart';

import '../helpers/mocks.dart';

Future<void> _settleBlocEvents() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

Future<Uint8List> _renderViewportPixels(
  DocumentLoadSuccess state,
  EditorController controller,
  Size size,
) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  ViewPainter(
    state.data,
    state.page,
    state.info,
    cameraViewport: controller.rendererCubit.state.cameraViewport,
    transform: controller.transformCubit.state,
  ).paint(canvas, size);
  final picture = recorder.endRecording();
  ui.Image? image;
  try {
    image = await picture.toImage(size.width.toInt(), size.height.toInt());
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    return data!.buffer.asUint8List();
  } finally {
    image?.dispose();
    picture.dispose();
  }
}

class _SolidRectRenderer extends Renderer<ShapeElement> {
  _SolidRectRenderer(super.element, this.color, [super.layer]);

  final Color color;

  @override
  Rect get rect => Rect.fromPoints(
    Offset(element.firstPosition.x, element.firstPosition.y),
    Offset(element.secondPosition.x, element.secondPosition.y),
  );

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    canvas.drawRect(rect, Paint()..color = color);
  }
}

class _VisibleTrackingRenderer extends Renderer<PadElement> {
  int onVisibleCalls = 0;
  int onHiddenCalls = 0;
  int disposeCalls = 0;
  int buildCalls = 0;
  CameraTransform? lastVisibleTransform;
  Size? lastVisibleSize;

  _VisibleTrackingRenderer(super.element, [super.layer]);

  @override
  Rect? get rect {
    final element = this.element;
    if (element is ShapeElement) {
      return Rect.fromPoints(
        Offset(element.firstPosition.x, element.firstPosition.y),
        Offset(element.secondPosition.x, element.secondPosition.y),
      );
    }
    return const Rect.fromLTWH(10, 10, 10, 10);
  }

  @override
  Future<void> onVisible(
    EditorController editorController,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    Size size,
  ) async {
    onVisibleCalls++;
    lastVisibleTransform = renderTransform;
    lastVisibleSize = size;
  }

  @override
  Future<void> onHidden(
    EditorController editorController,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    Size size,
  ) async {
    onHiddenCalls++;
  }

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    buildCalls++;
  }

  @override
  void dispose() {
    disposeCalls++;
    super.dispose();
  }
}

class _BlockingReloadEditorController extends EditorController {
  _BlockingReloadEditorController(
    super.settingsCubit,
    super.transformCubit,
    super.viewport,
  );

  final reloadStarted = Completer<void>();
  final releaseReload = Completer<void>();

  @override
  Future<void> reload(DocumentBloc bloc, [DocumentLoaded? blocState]) async {
    if (!reloadStarted.isCompleted) {
      reloadStarted.complete();
    }
    await releaseReload.future;
  }
}

class _ThrowingVisibleRenderer extends Renderer<PadElement> {
  int onVisibleCalls = 0;

  _ThrowingVisibleRenderer(super.element, [super.layer]);

  @override
  Rect? get rect => const Rect.fromLTWH(10, 10, 10, 10);

  @override
  Future<void> onVisible(
    EditorController editorController,
    DocumentLoaded blocState,
    CameraTransform renderTransform,
    Size size,
  ) async {
    onVisibleCalls++;
    throw StateError('blocked');
  }

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {}
}

class _ThrowingPdfAssetService extends AssetService {
  int pdfLoads = 0;

  @override
  Future<PdfDocument?> getPdfDocument(String source, NoteData document) async {
    pdfLoads++;
    throw StateError('blocked pdf');
  }
}

class _FailingPdfDataAssetService extends AssetService {
  int pdfLoads = 0;

  @override
  Future<Uint8List?> computeDataFromSource(
    String source,
    NoteData document,
  ) async {
    pdfLoads++;
    throw StateError('blocked pdf data');
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockButterflyFileSystem fileSystem;
  late MockSettingsCubit settingsCubit;
  late EditorController editorController;
  late WindowCubit windowCubit;
  late DocumentBloc bloc;

  setUpAll(() {
    registerFallbackValue(const AssetLocation(path: 'fallback.bfly'));
  });

  setUp(() {
    fileSystem = MockButterflyFileSystem();
    settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;

    when(() => settingsCubit.state)
        .thenReturn(const ButterflySettings(autosave: false));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => settingsCubit.addRecentHistory(any())).thenAnswer((_) async {});

    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(),
    );
    windowCubit = WindowCubit(fullScreen: false);

    var data = NoteData(Archive());
    const firstPage = DocumentPage(
      layers: [DocumentLayer(id: 'first-page-layer')],
    );
    const secondPage = DocumentPage(
      layers: [DocumentLayer(id: 'second-page-layer')],
    );

    final (firstData, _) = data.setPage(firstPage, 'Page 1');
    data = firstData;
    final (secondData, secondPageName) = data.setPage(secondPage, 'Page 2');
    data = secondData;

    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      secondPage,
      secondPageName,
    );
  });

  tearDown(() async {
    if (!bloc.isClosed) {
      await bloc.close();
    }
    if (!editorController.isClosed) {
      await editorController.close();
    }
    if (!windowCubit.isClosed) {
      await windowCubit.close();
    }
  });

  test(
    'renaming non-active page keeps active page and preserves page contents',
    () async {
      final initialState = bloc.state as DocumentLoadSuccess;
      final pages = initialState.data.getPages(true);
      final firstPageName = pages.firstWhere(
        (name) => name.endsWith('.Page 1'),
      );
      final secondPageName = pages.firstWhere(
        (name) => name.endsWith('.Page 2'),
      );

      expect(initialState.pageName, secondPageName);
      expect(initialState.page.layers.first.id, 'second-page-layer');

      bloc.add(PageRenamed(firstPageName, 'Renamed Page 1'));
      await _settleBlocEvents();

      final renamedState = bloc.state as DocumentLoadSuccess;
      expect(renamedState.pageName, secondPageName);
      expect(renamedState.page.layers.first.id, 'second-page-layer');

      final renamedPage = renamedState.data.getPage('Renamed Page 1');
      expect(renamedPage, isNotNull);
      expect(renamedPage!.layers.first.id, 'first-page-layer');

      bloc.add(const PageChanged('Renamed Page 1'));
      await _settleBlocEvents();

      final changedState = bloc.state as DocumentLoadSuccess;
      expect(changedState.page.layers.first.id, 'first-page-layer');
      expect(
        changedState.data.getPage('Page 2')?.layers.first.id,
        'second-page-layer',
      );
    },
  );

  test('force saving an already saved document does not write again', () async {
    expect(editorController.saveCubit.state.saved, SaveState.saved);

    final location = await editorController.saveCubit.save(
      bloc,
      editorController.networkingService,
      force: true,
    );

    expect(location, const AssetLocation(path: 'test-note.bfly'));
    expect(editorController.saveCubit.state.saved, SaveState.saved);
  });

  test('duplicating area adds it to selected pages', () async {
    final initialState = bloc.state as DocumentLoadSuccess;
    final pages = initialState.data.getPages(true);
    final firstPageName = pages.firstWhere((name) => name.endsWith('.Page 1'));
    final secondPageName = pages.firstWhere((name) => name.endsWith('.Page 2'));
    const area = Area(
      name: 'Shared area',
      width: 100,
      height: 80,
      position: Point(10, 20),
    );

    bloc.add(AreasDuplicated(area, ['Page 1', secondPageName]));
    await _settleBlocEvents();

    final state = bloc.state as DocumentLoadSuccess;
    expect(state.pageName, secondPageName);
    expect(state.page.areas, [area]);
    expect(state.data.getPage(firstPageName)?.areas, [area]);
    expect(state.data.getPage(secondPageName)?.areas, [area]);
  });

  test('removing areas can target multiple pages', () async {
    final initialState = bloc.state as DocumentLoadSuccess;
    final pages = initialState.data.getPages(true);
    final firstPageName = pages.firstWhere((name) => name.endsWith('.Page 1'));
    final secondPageName = pages.firstWhere((name) => name.endsWith('.Page 2'));
    const area = Area(
      name: 'Shared area',
      width: 100,
      height: 80,
      position: Point(10, 20),
    );

    bloc.add(AreasDuplicated(area, ['Page 1', secondPageName]));
    await _settleBlocEvents();
    bloc.add(
      AreasRemoved([
        AreaPreset(page: firstPageName, name: area.name),
        AreaPreset(page: secondPageName, name: area.name),
      ]),
    );
    await _settleBlocEvents();

    final state = bloc.state as DocumentLoadSuccess;
    expect(state.data.getPage(firstPageName)?.areas, isEmpty);
    expect(state.data.getPage(secondPageName)?.areas, isEmpty);
    expect(state.page.areas, isEmpty);
  });

  test('unmatched single tool change does not overwrite active tool', () async {
    final activeTool = PenTool(id: 'active-tool');
    final otherTool = PenTool(id: 'other-tool');

    bloc.add(ToolsReplaced([activeTool, otherTool]));
    await _settleBlocEvents();
    editorController.toolCubit.setIndex(0);

    bloc.add(
      ToolsChanged([PenTool(property: const PenProperty(strokeWidth: 12))]),
    );
    await _settleBlocEvents();

    final state = bloc.state as DocumentLoadSuccess;
    final active = state.info.tools[0] as PenTool;
    final other = state.info.tools[1] as PenTool;
    expect(active.id, 'active-tool');
    expect(active.property.strokeWidth, 5);
    expect(other.id, 'other-tool');
    expect(other.property.strokeWidth, 5);
  });

  test('ruler runtime survives toggling and property updates', () async {
    final rulerTool = RulerTool(id: 'ruler');
    bloc.add(ToolsReplaced([HandTool(id: 'hand'), rulerTool]));
    await _settleBlocEvents();

    final ruler = await editorController.toolCubit.enableHandler(
      editorController,
      bloc,
      1,
    ) as RulerHandler;
    ruler.setPosition(const Offset(24, 48));
    ruler.setRotation(87);

    await editorController.toolCubit.toggleHandler(editorController, bloc, 1);
    final restored = await editorController.toolCubit.toggleHandler(
      editorController,
      bloc,
      1,
    ) as RulerHandler;
    expect(restored, same(ruler));
    expect(restored.position, const Offset(24, 48));
    expect(restored.rotation, 87);

    const background = SRGBColor(0xFF123456);
    const foreground = SRGBColor(0xFFABCDEF);
    final handlerUpdated = editorController.toolCubit.stream.firstWhere(
      (state) =>
          (state.toggleableHandlers[1]?.data as RulerTool?)?.color ==
          background,
    );
    bloc.add(
      ToolsChanged([
        rulerTool.copyWith(
          color: background,
          foreground: foreground,
          size: 150,
        ),
      ]),
    );
    await handlerUpdated;

    final updated =
        editorController.toolCubit.state.toggleableHandlers[1] as RulerHandler;
    expect(updated, same(ruler));
    expect(updated.position, const Offset(24, 48));
    expect(updated.rotation, 87);
    expect(updated.data.color, background);
    expect(updated.data.foreground, foreground);
    expect(updated.data.size, 150);
    final rendered =
        editorController.toolCubit.state.toggleableForegrounds[1]!.single
            as RulerRenderer;
    expect(rendered.element, same(updated.data));
    expect(rendered.position, const Offset(24, 48));
    expect(rendered.rulerRotation, 87);

    await editorController.toolCubit.toggleHandler(editorController, bloc, 1);
    bloc.add(const ToolsRemoved(['ruler']));
    await _settleBlocEvents();
    bloc.add(ToolCreated(RulerTool(id: 'ruler')));
    await _settleBlocEvents();
    final recreated = await editorController.toolCubit.enableHandler(
      editorController,
      bloc,
      1,
    ) as RulerHandler;
    expect(recreated, isNot(same(ruler)));
    expect(recreated.position, Offset.zero);
    expect(recreated.rotation, 0);
  });

  test('reset state change waits for reload to finish', () async {
    await bloc.close();
    await editorController.close();

    final firstElement = ShapeElement(
      id: 'first-page-element',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(20, 20),
    );
    final secondElement = ShapeElement(
      id: 'second-page-element',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(20, 20),
    );
    final firstPage = DocumentPage(
      layers: [
        DocumentLayer(id: 'first-page-layer', content: [firstElement]),
      ],
    );
    final secondPage = DocumentPage(
      layers: [
        DocumentLayer(id: 'second-page-layer', content: [secondElement]),
      ],
    );

    var data = NoteData(Archive());
    final (firstData, firstPageName) = data.setPage(firstPage, 'Page 1');
    data = firstData;
    final (secondData, secondPageName) = data.setPage(secondPage, 'Page 2');
    data = secondData;
    final secondRenderer = Renderer.fromInstance(secondElement);
    final blockingCubit = _BlockingReloadEditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: [secondRenderer],
        visibleElements: [secondRenderer],
        visibleUnbakedElements: [secondRenderer],
        width: 100,
        height: 100,
      ),
    );
    editorController = blockingCubit;
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      secondPage,
      secondPageName,
    );

    expect(firstPageName, isNot(secondPageName));

    var stateChangedCompleted = false;
    final stateChangedFuture = blockingCubit
        .stateChanged(bloc.state as DocumentLoadSuccess, bloc, reset: true)
        .then((_) {
          stateChangedCompleted = true;
        });
    await blockingCubit.reloadStarted.future;

    await Future<void>.delayed(Duration.zero);

    expect(stateChangedCompleted, isFalse);

    blockingCubit.releaseReload.complete();
    await stateChangedFuture;
    expect(stateChangedCompleted, isTrue);
  });

  test('current index close disposes initially loaded renderers', () async {
    await bloc.close();
    await editorController.close();

    final element = ShapeElement(
      id: 'initial-renderer',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(20, 20),
    );
    final renderer = _VisibleTrackingRenderer(element, 'layer');
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [element]),
      ],
    );
    var data = NoteData(Archive());
    final (newData, pageName) = data.setPage(page, 'Page');
    data = newData;
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: [renderer],
        visibleElements: [renderer],
        visibleUnbakedElements: [renderer],
      ),
    );
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await bloc.load();
    expect(editorController.rendererCubit.renderers, contains(same(renderer)));

    await editorController.close();
    expect(renderer.disposeCalls, 1);
  });

  test('renderer reload reuses identity and restores page order', () async {
    await bloc.close();
    await editorController.close();

    final firstElement = ShapeElement(
      id: 'first-renderer',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(20, 20),
    );
    final secondElement = ShapeElement(
      id: 'second-renderer',
      firstPosition: const Point(30, 30),
      secondPosition: const Point(40, 40),
    );
    final firstRenderer = _VisibleTrackingRenderer(firstElement, 'layer');
    final secondRenderer = _VisibleTrackingRenderer(secondElement, 'layer');
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [firstElement, secondElement]),
      ],
    );
    var data = NoteData(Archive());
    final (newData, pageName) = data.setPage(page, 'Page');
    data = newData;
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: [secondRenderer, firstRenderer],
        visibleElements: [secondRenderer, firstRenderer],
        visibleUnbakedElements: [secondRenderer, firstRenderer],
        width: 100,
        height: 100,
      ),
    );
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await editorController.rendererCubit.loadElements(
      editorController,
      bloc.state,
    );

    expect(editorController.rendererCubit.renderers, [
      same(firstRenderer),
      same(secondRenderer),
    ]);
    expect(firstRenderer.disposeCalls, 0);
    expect(secondRenderer.disposeCalls, 0);
  });

  test('failed visible renderer is retried', () async {
    await bloc.close();
    await editorController.close();

    final element = ShapeElement(
      id: 'failed-visible',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(20, 20),
    );
    final renderer = _ThrowingVisibleRenderer(element, 'layer');
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [element]),
      ],
    );
    var data = NoteData(Archive());
    final (nextData, pageName) = data.setPage(page, 'Page 1');
    data = nextData;
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: [renderer],
        visibleElements: [renderer],
        visibleUnbakedElements: [renderer],
        width: 100,
        height: 100,
      ),
    );
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await editorController.rendererCubit.loadElements(
      editorController,
      bloc.state,
    );
    await editorController.rendererCubit.loadElements(
      editorController,
      bloc.state,
    );

    expect(renderer.onVisibleCalls, 2);
  });

  test('pdf renderer catches document load failures', () async {
    await editorController.close();

    final element = PdfElement(source: 'test.pdf', width: 100, height: 100);
    final renderer = PdfRenderer(element, 'layer');
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [element]),
      ],
    );
    var data = NoteData(Archive());
    final (nextData, pageName) = data.setPage(page, 'Page 1');
    data = nextData;
    final assetService = _ThrowingPdfAssetService();
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: [renderer],
        visibleElements: [renderer],
        visibleUnbakedElements: [renderer],
        width: 100,
        height: 100,
      ),
    );
    final docState = DocumentLoadSuccess(
      data,
      page: page,
      pageName: pageName,
      fileSystem: fileSystem,
      windowCubit: windowCubit,
      assetService: assetService,
      absolute: editorController.saveCubit.state.absolute,
    );

    await renderer.onVisible(
      editorController,
      docState,
      const CameraTransform(),
      const Size(100, 100),
    );

    expect(assetService.pdfLoads, 1);
    expect(renderer.image, isNull);
    expect(renderer.renderedScale, isNull);
  });

  test('failed pdf document future is not cached', () async {
    final assetService = _FailingPdfDataAssetService();
    final data = NoteData(Archive());

    expect(await assetService.getPdfDocument('test.pdf', data), isNull);
    expect(await assetService.getPdfDocument('test.pdf', data), isNull);

    expect(assetService.pdfLoads, 2);
  });

  test('renaming active page updates current page name', () async {
    final initialState = bloc.state as DocumentLoadSuccess;
    final secondPageName = initialState.data
        .getPages(true)
        .firstWhere((name) => name.endsWith('.Page 2'));

    bloc.add(PageRenamed(secondPageName, 'Renamed Active Page'));
    await _settleBlocEvents();

    final renamedState = bloc.state as DocumentLoadSuccess;
    expect(renamedState.pageName, endsWith('.Renamed Active Page'));
    expect(renamedState.page.layers.first.id, 'second-page-layer');
    expect(
      renamedState.data.getPage('Renamed Active Page')?.layers.first.id,
      'second-page-layer',
    );
  });

  test('duplicating layers creates new layers with new element ids', () async {
    final firstElement = ShapeElement(
      id: 'first-element',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(20, 20),
    );
    final secondElement = ShapeElement(
      id: 'second-element',
      firstPosition: const Point(30, 30),
      secondPosition: const Point(40, 40),
    );
    bloc
      ..add(const LayerChanged('second-page-layer', name: 'Original layer'))
      ..add(ElementsCreated([firstElement]))
      ..add(const LayerVisibilityChanged('second-page-layer', false))
      ..add(const LayerCreated(id: 'other-layer', name: 'Other layer'))
      ..add(const CurrentLayerChanged('other-layer'))
      ..add(ElementsCreated([secondElement]));
    await _settleBlocEvents();

    bloc.add(const LayersMerged(['second-page-layer', 'other-layer'], true));
    await _settleBlocEvents();

    final state = bloc.state as DocumentLoadSuccess;
    final layers = state.page.layers;
    expect(layers, hasLength(4));
    expect(layers[0].id, 'second-page-layer');
    expect(layers[1].id, isNot('second-page-layer'));
    expect(layers[1].name, 'Original layer');
    expect(layers[1].content.single.id, isNot(firstElement.id));
    expect(layers[2].id, 'other-layer');
    expect(layers[3].id, isNot('other-layer'));
    expect(layers[3].name, 'Other layer');
    expect(layers[3].content.single.id, isNot(secondElement.id));
    expect(state.currentLayer, layers[3].id);
    expect(state.invisibleLayers, containsAll(['second-page-layer']));
    expect(state.invisibleLayers, contains(layers[1].id));
    expect(state.invisibleLayers, isNot(contains(layers[3].id)));
    expect(
      editorController.rendererCubit.renderers.map(
        (renderer) => renderer.layer,
      ),
      containsAll([layers[1].id, layers[3].id]),
    );
  });

  test('resetInput clears active pointers and buttons', () async {
    editorController.inputCubit.addPointer(12);
    editorController.inputCubit.setButtons(kPrimaryMouseButton);

    await editorController.toolCubit.resetInput(
      bloc,
      editorController.inputCubit,
    );

    expect(editorController.inputCubit.state.pointers, isEmpty);
    expect(editorController.inputCubit.state.buttons, isNull);
  });

  test('adding a combined highlight immediately unbakes its group', () async {
    await bloc.close();
    await editorController.close();

    final existingElement = PenElement(
      id: 'existing',
      combineId: 'highlighter',
      points: const [PathPoint(10, 20), PathPoint(40, 20)],
    );
    final existingRenderer = Renderer<PadElement>.fromInstance(existingElement);
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [existingElement]),
      ],
    );
    var data = NoteData(Archive());
    final (nextData, pageName) = data.setPage(page, 'Page 1');
    data = nextData;
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: [existingRenderer],
        visibleElements: [existingRenderer],
        visibleUnbakedElements: [existingRenderer],
        width: 100,
        height: 100,
      ),
    );
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );
    await editorController.rendererCubit.bake(
      editorController,
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );
    expect(
      editorController.rendererCubit.state.cameraViewport.bakedElements,
      isNotEmpty,
    );

    bloc.add(
      ElementsCreated([
        PenElement(
          id: 'new',
          combineId: 'highlighter',
          points: const [PathPoint(20, 20), PathPoint(50, 20)],
        ),
      ]),
    );
    await _settleBlocEvents();

    final viewport = editorController.rendererCubit.state.cameraViewport;
    expect(viewport.bakedElements, isEmpty);
    expect(
      viewport.unbakedElements.whereType<PenRenderer>().map(
        (renderer) => renderer.element.combineId,
      ),
      everyElement('highlighter'),
    );
    expect(viewport.unbakedElements, hasLength(2));
  });

  test('embedded replacement rebakes the updated element', () async {
    await bloc.close();
    await editorController.close();

    final element = ShapeElement(
      id: 'shape',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(40, 20),
    );
    final renderer = Renderer<PadElement>.fromInstance(element);
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [element]),
      ],
    );
    var data = NoteData(Archive());
    final (nextData, pageName) = data.setPage(page, 'Page 1');
    data = nextData;
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: [renderer],
        visibleElements: [renderer],
        visibleUnbakedElements: [renderer],
        width: 100,
        height: 100,
      ),
      embedding: Embedding(internal: true),
    );
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );
    final state = bloc.state as DocumentLoadSuccess;
    await editorController.rendererCubit.bake(
      editorController,
      state,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );

    final updated = Renderer<PadElement>.fromInstance(
      element.copyWith(rotation: 90),
    );
    await editorController.stateChanged(
      state,
      bloc,
      replacedElements: [updated],
    );

    final viewport = editorController.rendererCubit.state.cameraViewport;
    expect(viewport.bakedElements, hasLength(1));
    expect(viewport.bakedElements.single.rotation, 90);
    expect(viewport.unbakedElements, isEmpty);
  });

  test('partial pen viewport update keeps previews until each renderer is reported', () async {
    final state = bloc.state as DocumentLoadSuccess;
    final handler = PenHandler(PenTool(id: 'pen'));
    final strokePoints = List.generate(
      1000,
      (index) => PathPoint(index / 20, 20),
    );
    final element = PenElement(id: 'stroke', points: strokePoints);
    handler.elements[1] = element;
    final nextElement = PenElement(
      id: 'next-stroke',
      points: const [PathPoint(10, 30), PathPoint(40, 30)],
    );

    await handler.submitElements(bloc, [1]);
    handler.elements[2] = nextElement;
    await handler.submitElements(bloc, [2]);

    final submittedForegrounds = handler.createForegrounds(
      editorController,
      state.data,
      state.page,
      state.info,
    );
    expect(submittedForegrounds, hasLength(2));
    expect(
      (submittedForegrounds.first as PenRenderer).element.points,
      strokePoints,
    );

    final renderer = Renderer<PadElement>.fromInstance(
      element,
      state.currentLayer,
    );
    await renderer.setup(
      editorController.transformCubit,
      state.data,
      state.assetService,
      state.page,
    );
    await handler.onViewportUpdated(
      const CameraViewport.unbaked(),
      CameraViewport.unbaked(
        unbakedElements: [renderer],
        visibleElements: [renderer],
        visibleUnbakedElements: [renderer],
      ),
    );

    expect(
      handler.createForegrounds(
        editorController,
        state.data,
        state.page,
        state.info,
      ),
      hasLength(2),
    );
    expect(handler.onRenderersCreated(state.page, [renderer]), isTrue);
    expect(
      handler.createForegrounds(
        editorController,
        state.data,
        state.page,
        state.info,
      ),
      hasLength(1),
    );
    final nextRenderer = Renderer<PadElement>.fromInstance(nextElement);
    expect(handler.onRenderersCreated(state.page, [nextRenderer]), isTrue);
    expect(
      handler.createForegrounds(
        editorController,
        state.data,
        state.page,
        state.info,
      ),
      isEmpty,
    );

    renderer.dispose();
    nextRenderer.dispose();
  });

  test('bake records only elements visible in the current viewport', () async {
    await bloc.close();
    await editorController.close();

    final visibleElement = ShapeElement(
      id: 'visible',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(20, 20),
    );
    final hiddenElement = ShapeElement(
      id: 'hidden',
      firstPosition: const Point(500, 500),
      secondPosition: const Point(520, 520),
    );
    final renderers = <Renderer<PadElement>>[
      Renderer.fromInstance(visibleElement),
      Renderer.fromInstance(hiddenElement),
    ];
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [visibleElement, hiddenElement]),
      ],
    );
    var data = NoteData(Archive());
    final (nextData, pageName) = data.setPage(page, 'Page 1');
    data = nextData;
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: renderers,
        visibleElements: renderers,
        visibleUnbakedElements: renderers,
        width: 100,
        height: 100,
      ),
    );
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await editorController.rendererCubit.bake(
      editorController,
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );

    final viewport = editorController.rendererCubit.state.cameraViewport;
    expect(viewport.baked, isTrue);
    expect(
      viewport.visibleElements.map((renderer) => renderer.element.id),
      contains('visible'),
    );
    expect(
      viewport.visibleElements.map((renderer) => renderer.element.id),
      isNot(contains('hidden')),
    );
    expect(viewport.visibleUnbakedElements, isEmpty);
  });

  test('changing the current layer rebuilds the layer caches', () async {
    await bloc.close();
    await editorController.close();

    final bottomElement = ShapeElement(
      id: 'bottom',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(90, 90),
    );
    final topElement = ShapeElement(
      id: 'top',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(90, 90),
    );
    final renderers = <Renderer<PadElement>>[
      _SolidRectRenderer(bottomElement, Colors.red, 'bottom-layer'),
      _SolidRectRenderer(topElement, Colors.blue, 'top-layer'),
    ];
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'bottom-layer', content: [bottomElement]),
        DocumentLayer(id: 'top-layer', content: [topElement]),
      ],
    );
    var data = NoteData(Archive());
    final (nextData, pageName) = data.setPage(page, 'Page 1');
    data = nextData;
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: renderers,
        visibleElements: renderers,
        visibleUnbakedElements: renderers,
        width: 100,
        height: 100,
      ),
    );
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await editorController.rendererCubit.bake(
      editorController,
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );
    final oldViewport = editorController.rendererCubit.state.cameraViewport;
    final cacheRebuilt = editorController.rendererCubit.stream.firstWhere(
      (state) =>
          !identical(state.cameraViewport.image, oldViewport.image) &&
          !identical(
            state.cameraViewport.aboveLayerImage,
            oldViewport.aboveLayerImage,
          ),
    );

    bloc.add(const CurrentLayerChanged('bottom-layer'));
    await cacheRebuilt;

    expect((bloc.state as DocumentLoadSuccess).currentLayer, 'bottom-layer');

    final newBottomElement = ShapeElement(
      id: 'new-bottom',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(90, 90),
    );
    final newBottomRenderer = _SolidRectRenderer(
      newBottomElement,
      Colors.green,
      'bottom-layer',
    );
    await editorController.rendererCubit.addUnbaked(
      editorController,
      bloc.state as DocumentLoadSuccess,
      [newBottomRenderer],
    );
    final pixels = await _renderViewportPixels(
      bloc.state as DocumentLoadSuccess,
      editorController,
      const Size(100, 100),
    );
    final centerPixel = (50 * 100 + 50) * 4;
    expect(pixels.sublist(centerPixel, centerPixel + 4), [33, 150, 243, 255]);
  });

  test('deleting an element from another layer rebuilds its cache', () async {
    await bloc.close();
    await editorController.close();

    final bottomElement = ShapeElement(
      id: 'bottom',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(40, 40),
    );
    final topElement = ShapeElement(
      id: 'top',
      firstPosition: const Point(60, 60),
      secondPosition: const Point(90, 90),
    );
    final renderers = <Renderer<PadElement>>[
      _SolidRectRenderer(bottomElement, Colors.red, 'bottom-layer'),
      _SolidRectRenderer(topElement, Colors.blue, 'top-layer'),
    ];
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'bottom-layer', content: [bottomElement]),
        DocumentLayer(id: 'top-layer', content: [topElement]),
      ],
    );
    var data = NoteData(Archive());
    final (nextData, pageName) = data.setPage(page, 'Page 1');
    data = nextData;
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: renderers,
        visibleElements: renderers,
        visibleUnbakedElements: renderers,
        width: 100,
        height: 100,
      ),
    );
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await editorController.rendererCubit.bake(
      editorController,
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );
    final oldBelowLayerImage =
        editorController.rendererCubit.state.cameraViewport.belowLayerImage;
    final cacheRebuilt = editorController.rendererCubit.stream.firstWhere(
      (state) =>
          !identical(
            state.cameraViewport.belowLayerImage,
            oldBelowLayerImage,
          ) &&
          state.cameraViewport.bakedElements.every(
            (renderer) => renderer.element.id != bottomElement.id,
          ),
    );

    bloc.add(const ElementsRemoved(['bottom']));
    await cacheRebuilt;

    expect(
      (bloc.state as DocumentLoadSuccess).page.getLayer('bottom-layer').content,
      isEmpty,
    );
    final pixels = await _renderViewportPixels(
      bloc.state as DocumentLoadSuccess,
      editorController,
      const Size(100, 100),
    );
    final deletedElementPixel = (20 * 100 + 20) * 4;
    expect(pixels.sublist(deletedElementPixel, deletedElementPixel + 4), [
      255,
      255,
      255,
      255,
    ]);
  });

  test('incremental bake does not rebuild already baked renderers', () async {
    await bloc.close();
    await editorController.close();

    final existingElement = ShapeElement(
      id: 'existing',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(20, 20),
    );
    final addedElement = ShapeElement(
      id: 'added',
      firstPosition: const Point(30, 30),
      secondPosition: const Point(40, 40),
    );
    final existingRenderer = _VisibleTrackingRenderer(existingElement, 'layer');
    final addedRenderer = _VisibleTrackingRenderer(addedElement, 'layer');
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [existingElement, addedElement]),
      ],
    );
    var data = NoteData(Archive());
    final (nextData, pageName) = data.setPage(page, 'Page 1');
    data = nextData;
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: [existingRenderer],
        visibleElements: [existingRenderer],
        visibleUnbakedElements: [existingRenderer],
        width: 100,
        height: 100,
      ),
    );
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    final state = bloc.state as DocumentLoadSuccess;
    await editorController.rendererCubit.bake(
      editorController,
      state,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );
    final existingBuildsAfterReset = existingRenderer.buildCalls;

    await addedRenderer.setup(
      editorController.transformCubit,
      state.data,
      state.assetService,
      state.page,
    );
    await editorController.rendererCubit.addUnbaked(editorController, state, [
      addedRenderer,
    ]);
    await editorController.rendererCubit.bake(
      editorController,
      state,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
    );

    expect(existingRenderer.buildCalls, existingBuildsAfterReset);
    expect(addedRenderer.buildCalls, greaterThan(0));
  });

  test(
    'submitting a stroke at fractional zoom keeps existing document pixels',
    () async {
      await bloc.close();
      await editorController.close();

      const viewportSize = Size(1600, 400);
      const pixelRatio = 2.0;
      final leftElement = ShapeElement(
        id: 'left',
        firstPosition: const Point(40, 40),
        secondPosition: const Point(160, 160),
      );
      final rightElement = ShapeElement(
        id: 'right',
        firstPosition: const Point(2500, 40),
        secondPosition: const Point(2800, 160),
      );
      final renderers = <Renderer<PadElement>>[
        _SolidRectRenderer(leftElement, Colors.red, 'layer'),
        _SolidRectRenderer(rightElement, Colors.blue, 'layer'),
      ];
      final page = DocumentPage(
        layers: [
          DocumentLayer(id: 'layer', content: [leftElement, rightElement]),
        ],
      );
      var data = NoteData(Archive());
      final (nextData, pageName) = data.setPage(page, 'Page 1');
      data = nextData;
      final transformCubit = TransformCubit(pixelRatio)
        ..teleport(const Offset(11.3, 17.7), 0.55);
      editorController = EditorController(
        settingsCubit,
        transformCubit,
        CameraViewport.unbaked(
          unbakedElements: renderers,
          visibleElements: renderers,
          visibleUnbakedElements: renderers,
        ),
      );
      bloc = DocumentBloc(
        fileSystem,
        editorController,
        windowCubit,
        data,
        const AssetLocation(path: 'test-note.bfly'),
        null,
        page,
        pageName,
      );
      final penHandler = PenHandler(PenTool(id: 'pen'));
      await editorController.toolCubit.changeTool(
        editorController,
        bloc,
        handler: penHandler,
        allowBake: false,
      );
      await editorController.rendererCubit.bake(
        editorController,
        bloc.state as DocumentLoadSuccess,
        viewportSize: viewportSize,
        pixelRatio: pixelRatio,
        reset: true,
      );
      final before = await _renderViewportPixels(
        bloc.state as DocumentLoadSuccess,
        editorController,
        viewportSize,
      );

      penHandler.elements[1] = PenElement(
        id: 'stroke',
        points: const [PathPoint(1000, 600), PathPoint(1800, 600)],
      );
      await penHandler.submitElements(bloc, [1]);
      await _settleBlocEvents();
      await Future<void>.delayed(const Duration(milliseconds: 150));
      await _settleBlocEvents();
      final bakedViewport = editorController.rendererCubit.state.cameraViewport;
      expect(bakedViewport.unbakedElements, isEmpty);
      expect(
        bakedViewport.bakedElements.map((renderer) => renderer.element.id),
        contains('stroke'),
      );
      final after = await _renderViewportPixels(
        bloc.state as DocumentLoadSuccess,
        editorController,
        viewportSize,
      );

      // The submitted stroke is below this strip, so every compared RGBA byte
      // belongs to pre-existing document content or its white background.
      final unchangedByteCount = viewportSize.width.toInt() * 220 * 4;
      expect(
        after.sublist(0, unchangedByteCount),
        before.sublist(0, unchangedByteCount),
      );
    },
  );

  test('tool refresh without temporary handler does not reset bake', () async {
    await bloc.close();
    await editorController.close();

    final element = ShapeElement(
      id: 'existing',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(20, 20),
    );
    final renderer = _VisibleTrackingRenderer(element, 'layer');
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [element]),
      ],
    );
    var data = NoteData(Archive());
    final (nextData, pageName) = data.setPage(page, 'Page 1');
    data = nextData;
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: [renderer],
        visibleElements: [renderer],
        visibleUnbakedElements: [renderer],
        width: 100,
        height: 100,
      ),
    );
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    final state = bloc.state as DocumentLoadSuccess;
    await editorController.rendererCubit.bake(
      editorController,
      state,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );
    final buildsAfterBake = renderer.buildCalls;

    await editorController.toolCubit.refresh(editorController, state);

    expect(renderer.buildCalls, buildsAfterBake);
  });

  test(
    'creating pen stroke through bloc keeps the next bake incremental',
    () async {
      await bloc.close();
      await editorController.close();

      final existingElement = ShapeElement(
        id: 'existing',
        firstPosition: const Point(10, 10),
        secondPosition: const Point(20, 20),
      );
      final existingRenderer = _VisibleTrackingRenderer(
        existingElement,
        'layer',
      );
      final page = DocumentPage(
        layers: [
          DocumentLayer(id: 'layer', content: [existingElement]),
        ],
      );
      var data = NoteData(Archive());
      final (nextData, pageName) = data.setPage(page, 'Page 1');
      data = nextData;
      editorController = EditorController(
        settingsCubit,
        TransformCubit(1),
        CameraViewport.unbaked(
          unbakedElements: [existingRenderer],
          visibleElements: [existingRenderer],
          visibleUnbakedElements: [existingRenderer],
          width: 100,
          height: 100,
        ),
      );
      bloc = DocumentBloc(
        fileSystem,
        editorController,
        windowCubit,
        data,
        const AssetLocation(path: 'test-note.bfly'),
        null,
        page,
        pageName,
      );
      final state = bloc.state as DocumentLoadSuccess;
      final penHandler = PenHandler(PenTool(id: 'pen'));
      await editorController.toolCubit.changeTool(
        editorController,
        bloc,
        handler: penHandler,
        allowBake: false,
      );
      await editorController.rendererCubit.bake(
        editorController,
        state,
        viewportSize: const Size(100, 100),
        pixelRatio: 1,
        reset: true,
      );
      final buildsAfterInitialBake = existingRenderer.buildCalls;

      penHandler.elements[1] = PenElement(
        id: 'stroke',
        points: const [PathPoint(30, 30), PathPoint(40, 40)],
      );
      await penHandler.submitElements(bloc, [1]);
      await _settleBlocEvents();
      await Future<void>.delayed(const Duration(milliseconds: 150));
      await _settleBlocEvents();

      expect(existingRenderer.buildCalls, buildsAfterInitialBake);
      expect(
        editorController.rendererCubit.renderers.map((e) => e.element.id),
        contains('stroke'),
      );
    },
  );

  test('bake refreshes cached viewport when pixel ratio changes', () async {
    await bloc.close();
    await editorController.close();

    final element = ShapeElement(
      id: 'visible',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(20, 20),
    );
    final renderers = <Renderer<PadElement>>[Renderer.fromInstance(element)];
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [element]),
      ],
    );
    var data = NoteData(Archive());
    final (nextData, pageName) = data.setPage(page, 'pixel-ratio-page');
    data = nextData;
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: renderers,
        visibleElements: renderers,
        visibleUnbakedElements: renderers,
        width: 100,
        height: 100,
      ),
    );
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await editorController.rendererCubit.bake(
      editorController,
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );
    expect(editorController.rendererCubit.state.cameraViewport.pixelRatio, 1);
    expect(
      editorController.rendererCubit.state.cameraViewport.unbakedElements,
      isEmpty,
    );

    await editorController.rendererCubit.bake(
      editorController,
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 2,
    );

    expect(editorController.rendererCubit.state.cameraViewport.pixelRatio, 2);
  });

  test(
    'bake snaps cached viewport to screen pixels at fractional zoom',
    () async {
      await bloc.close();
      await editorController.close();
      when(() => settingsCubit.state).thenReturn(
        const ButterflySettings(
          autosave: false,
          renderResolution: RenderResolution.performance,
        ),
      );

      final element = ShapeElement(
        id: 'visible',
        firstPosition: const Point(10, 10),
        secondPosition: const Point(20, 20),
      );
      final renderers = <Renderer<PadElement>>[Renderer.fromInstance(element)];
      final page = DocumentPage(
        layers: [
          DocumentLayer(id: 'layer', content: [element]),
        ],
      );
      var data = NoteData(Archive());
      final (nextData, pageName) = data.setPage(page, 'Page 1');
      data = nextData;
      final transformCubit = TransformCubit(1);
      transformCubit.teleport(const Offset(12.3, 45.6), 1.37);
      editorController = EditorController(
        settingsCubit,
        transformCubit,
        CameraViewport.unbaked(
          unbakedElements: renderers,
          visibleElements: renderers,
          visibleUnbakedElements: renderers,
          width: 401,
          height: 303,
        ),
      );
      bloc = DocumentBloc(
        fileSystem,
        editorController,
        windowCubit,
        data,
        const AssetLocation(path: 'test-note.bfly'),
        null,
        page,
        pageName,
      );

      await editorController.rendererCubit.bake(
        editorController,
        bloc.state as DocumentLoadSuccess,
        viewportSize: const Size(401, 303),
        pixelRatio: 1,
        reset: true,
      );

      final viewport = editorController.rendererCubit.state.cameraViewport;
      final transform = editorController.transformCubit.state;
      final left = (viewport.x - transform.position.dx) * transform.size;
      final top = (viewport.y - transform.position.dy) * transform.size;
      final right = left + viewport.width!;
      final bottom = top + viewport.height!;

      expect(left, closeTo(left.roundToDouble(), 1e-9));
      expect(top, closeTo(top.roundToDouble(), 1e-9));
      expect(right, closeTo(right.roundToDouble(), 1e-9));
      expect(bottom, closeTo(bottom.roundToDouble(), 1e-9));
      expect(viewport.width, greaterThanOrEqualTo(401));
      expect(viewport.height, greaterThanOrEqualTo(303));
    },
  );

  test('no-argument bake reuses the measured viewport size', () async {
    when(() => settingsCubit.state).thenReturn(
      const ButterflySettings(
        autosave: false,
        renderResolution: RenderResolution.normal,
      ),
    );
    const measuredSize = Size(401.25, 303.75);

    await editorController.rendererCubit.bake(
      editorController,
      bloc.state as DocumentLoadSuccess,
      viewportSize: measuredSize,
      pixelRatio: 1.25,
      reset: true,
    );
    final first = editorController.rendererCubit.state.cameraViewport;

    await editorController.rendererCubit.unbake(
      editorController,
      bloc.state as DocumentLoadSuccess,
    );
    await editorController.rendererCubit.bake(
      editorController,
      bloc.state as DocumentLoadSuccess,
      reset: true,
    );
    final second = editorController.rendererCubit.state.cameraViewport;

    expect(second.width, first.width);
    expect(second.height, first.height);
    expect(second.x, first.x);
    expect(second.y, first.y);
    expect(second.viewportSize, measuredSize);
    expect(second.pixelRatio, 1.25);
  });

  test('renderImage does not hide already tracked visible renderers', () async {
    await bloc.close();
    await editorController.close();

    final element = ShapeElement(
      id: 'visible',
      firstPosition: const Point(10, 10),
      secondPosition: const Point(20, 20),
    );
    final renderer = _VisibleTrackingRenderer(element);
    final renderers = <Renderer<PadElement>>[renderer];
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [element]),
      ],
    );
    var data = NoteData(Archive());
    final (nextData, pageName) = data.setPage(page, 'Page 1');
    data = nextData;
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: renderers,
        visibleElements: renderers,
        visibleUnbakedElements: renderers,
        width: 100,
        height: 100,
      ),
    );
    bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await editorController.rendererCubit.bake(
      editorController,
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );
    renderer.onVisibleCalls = 0;
    renderer.onHiddenCalls = 0;
    await editorController.rendererCubit.renderImage(
      editorController,
      (bloc.state as DocumentLoadSuccess).data,
      page,
      (bloc.state as DocumentLoadSuccess).info,
      const ImageExportOptions(width: 100, height: 100),
      docState: bloc.state as DocumentLoadSuccess,
    );
    await editorController.rendererCubit.bake(
      editorController,
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );

    expect(renderer.onVisibleCalls, 0);
    expect(renderer.onHiddenCalls, 0);
  });

  test(
    'renderImage passes quality as pixel ratio without offsetting scale',
    () async {
      await bloc.close();
      await editorController.close();

      final element = ShapeElement(
        id: 'aligned',
        firstPosition: const Point(10, 20),
        secondPosition: const Point(20, 30),
        property: const ShapeProperty(
          strokeWidth: 0,
          shape: RectangleShape(
            fillPaint: ElementPaint.solid(color: SRGBColor(0xFFFF0000)),
          ),
        ),
      );
      final renderer = _VisibleTrackingRenderer(element);
      final renderers = <Renderer<PadElement>>[renderer];
      final page = DocumentPage(
        layers: [
          DocumentLayer(id: 'layer', content: [element]),
        ],
      );
      var data = NoteData(Archive());
      final (nextData, pageName) = data.setPage(page, 'Page 1');
      data = nextData;
      editorController = EditorController(
        settingsCubit,
        TransformCubit(1),
        CameraViewport.unbaked(
          unbakedElements: renderers,
          visibleElements: renderers,
          visibleUnbakedElements: renderers,
          width: 10,
          height: 10,
        ),
      );
      bloc = DocumentBloc(
        fileSystem,
        editorController,
        windowCubit,
        data,
        const AssetLocation(path: 'test-note.bfly'),
        null,
        page,
        pageName,
      );

      final image = await editorController.rendererCubit.renderImage(
        editorController,
        data,
        page,
        (bloc.state as DocumentLoadSuccess).info,
        const ImageExportOptions(
          width: 10,
          height: 10,
          x: 10,
          y: 20,
          quality: 10,
        ),
        docState: bloc.state as DocumentLoadSuccess,
      );
      addTearDown(() => image?.dispose());

      expect(image, isNotNull);
      expect(image!.width, 100);
      expect(image.height, 100);
      expect(renderer.onVisibleCalls, 1);
      expect(renderer.lastVisibleSize, const Size(10, 10));
      expect(renderer.lastVisibleTransform?.position, const Offset(10, 20));
      expect(renderer.lastVisibleTransform?.size, 1);
      expect(renderer.lastVisibleTransform?.pixelRatio, 10);
    },
  );

  test(
    'renderImage exports the rotated view regardless of viewport state',
    () async {
      await bloc.close();
      await editorController.close();

      final element = ShapeElement(
        id: 'rotated-view',
        firstPosition: const Point(10, -30),
        secondPosition: const Point(20, -20),
      );
      final renderer = _VisibleTrackingRenderer(element);
      final renderers = <Renderer<PadElement>>[renderer];
      final page = DocumentPage(
        layers: [
          DocumentLayer(id: 'layer', content: [element]),
        ],
      );
      var data = NoteData(Archive());
      final (nextData, pageName) = data.setPage(page, 'Page 1');
      data = nextData;
      editorController = EditorController(
        settingsCubit,
        TransformCubit(1),
        CameraViewport.unbaked(
          unbakedElements: renderers,
          visibleElements: renderers,
          visibleUnbakedElements: renderers,
          rendererStates: const {'rotated-view': RendererState.hidden},
        ),
      );
      bloc = DocumentBloc(
        fileSystem,
        editorController,
        windowCubit,
        data,
        const AssetLocation(path: 'test-note.bfly'),
        null,
        page,
        pageName,
      );

      final image = await editorController.rendererCubit.renderImage(
        editorController,
        data,
        page,
        (bloc.state as DocumentLoadSuccess).info,
        const ImageExportOptions(width: 100, height: 100, rotation: pi / 2),
        docState: bloc.state as DocumentLoadSuccess,
      );
      addTearDown(() => image?.dispose());

      expect(image, isNotNull);
      expect(renderer.onVisibleCalls, 1);
      expect(renderer.buildCalls, 1);
      expect(renderer.lastVisibleTransform?.rotation, pi / 2);
    },
  );

  test('renderSVG applies camera rotation and element transforms', () async {
    await editorController.close();

    final element = ShapeElement(
      id: 'svg-transform',
      firstPosition: Point(10, -30),
      secondPosition: Point(20, -20),
      rotation: 45,
      shear: 0.25,
      property: ShapeProperty(
        strokeWidth: 0,
        shape: RectangleShape(
          fillPaint: ElementPaint.solid(color: SRGBColor(0xFFFF0000)),
        ),
      ),
    );
    final renderer = Renderer<PadElement>.fromInstance(element);
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [element]),
      ],
    );
    editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(
        unbakedElements: [renderer],
        visibleElements: [renderer],
        visibleUnbakedElements: [renderer],
      ),
    );

    final xml = editorController.rendererCubit.renderSVG(
      NoteData(Archive()),
      page,
      const SvgExportOptions(
        width: 100,
        height: 100,
        x: 3,
        y: 4,
        scale: 2,
        rotation: pi / 2,
      ),
    );
    final svg = xml.rootElement;
    final groups = svg.findAllElements('g').toList();

    expect(svg.getAttribute('viewBox'), '0 0 100.0 100.0');
    expect(groups, hasLength(2));
    expect(groups.first.getAttribute('transform'), contains('rotate(90.0)'));
    expect(groups.first.getAttribute('transform'), contains('scale(2.0)'));
    expect(groups.last.getAttribute('transform'), contains('rotate(45.0)'));
    expect(
      groups.last.getAttribute('transform'),
      contains('matrix(1 0 0.25 1 0 0)'),
    );
    expect(svg.findAllElements('path'), isNotEmpty);
  });
}
