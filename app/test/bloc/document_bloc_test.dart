import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pdfrx/pdfrx.dart';

import '../helpers/mocks.dart';

Future<void> _settleBlocEvents() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

class _VisibleTrackingRenderer extends Renderer<PadElement> {
  int onVisibleCalls = 0;
  int onHiddenCalls = 0;
  int disposeCalls = 0;
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
    CurrentIndexCubit currentIndexCubit,
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
    CurrentIndexCubit currentIndexCubit,
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
  ]) {}

  @override
  void dispose() {
    disposeCalls++;
    super.dispose();
  }
}

class _BlockingReloadCurrentIndexCubit extends CurrentIndexCubit {
  _BlockingReloadCurrentIndexCubit(
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
    CurrentIndexCubit currentIndexCubit,
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
  late CurrentIndexCubit currentIndexCubit;
  late WindowCubit windowCubit;
  late DocumentBloc bloc;

  setUp(() {
    fileSystem = MockButterflyFileSystem();
    settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;

    when(
      () => settingsCubit.state,
    ).thenReturn(const ButterflySettings(autosave: false));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());

    currentIndexCubit = CurrentIndexCubit(
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
      currentIndexCubit,
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
    if (!currentIndexCubit.isClosed) {
      await currentIndexCubit.close();
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
    expect(currentIndexCubit.state.saved, SaveState.saved);

    final location = await currentIndexCubit.save(bloc, force: true);

    expect(location, const AssetLocation(path: 'test-note.bfly'));
    expect(currentIndexCubit.state.saved, SaveState.saved);
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
    currentIndexCubit.changeIndex(0);

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

  test('reset state change waits for reload to finish', () async {
    await bloc.close();
    await currentIndexCubit.close();

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
    final blockingCubit = _BlockingReloadCurrentIndexCubit(
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
    currentIndexCubit = blockingCubit;
    bloc = DocumentBloc(
      fileSystem,
      currentIndexCubit,
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
    await currentIndexCubit.close();

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
    currentIndexCubit = CurrentIndexCubit(
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
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await bloc.load();
    expect(currentIndexCubit.renderers, contains(same(renderer)));

    await currentIndexCubit.close();
    expect(renderer.disposeCalls, 1);
  });

  test('failed visible renderer is retried', () async {
    await bloc.close();
    await currentIndexCubit.close();

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
    currentIndexCubit = CurrentIndexCubit(
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
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await currentIndexCubit.loadElements(bloc.state);
    await currentIndexCubit.loadElements(bloc.state);

    expect(renderer.onVisibleCalls, 2);
  });

  test('pdf renderer catches document load failures', () async {
    await currentIndexCubit.close();

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
    currentIndexCubit = CurrentIndexCubit(
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
      absolute: currentIndexCubit.state.absolute,
    );

    await renderer.onVisible(
      currentIndexCubit,
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
      currentIndexCubit.renderers.map((renderer) => renderer.layer),
      containsAll([layers[1].id, layers[3].id]),
    );
  });

  test('resetInput clears active pointers and buttons', () async {
    currentIndexCubit.addPointer(12);
    currentIndexCubit.setButtons(kPrimaryMouseButton);

    await currentIndexCubit.resetInput(bloc);

    expect(currentIndexCubit.state.pointers, isEmpty);
    expect(currentIndexCubit.state.buttons, isNull);
  });

  test('adding a combined highlight immediately unbakes its group', () async {
    await bloc.close();
    await currentIndexCubit.close();

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
    currentIndexCubit = CurrentIndexCubit(
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
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );
    await currentIndexCubit.bake(
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );
    expect(currentIndexCubit.state.cameraViewport.bakedElements, isNotEmpty);

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

    final viewport = currentIndexCubit.state.cameraViewport;
    expect(viewport.bakedElements, isEmpty);
    expect(
      viewport.unbakedElements.whereType<PenRenderer>().map(
        (renderer) => renderer.element.combineId,
      ),
      everyElement('highlighter'),
    );
    expect(viewport.unbakedElements, hasLength(2));
  });

  test('bake records only elements visible in the current viewport', () async {
    await bloc.close();
    await currentIndexCubit.close();

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
    currentIndexCubit = CurrentIndexCubit(
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
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await currentIndexCubit.bake(
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );

    final viewport = currentIndexCubit.state.cameraViewport;
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

  test('bake refreshes cached viewport when pixel ratio changes', () async {
    await bloc.close();
    await currentIndexCubit.close();

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
    currentIndexCubit = CurrentIndexCubit(
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
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await currentIndexCubit.bake(
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );
    expect(currentIndexCubit.state.cameraViewport.pixelRatio, 1);
    expect(currentIndexCubit.state.cameraViewport.unbakedElements, isEmpty);

    await currentIndexCubit.bake(
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 2,
    );

    expect(currentIndexCubit.state.cameraViewport.pixelRatio, 2);
  });

  test(
    'bake snaps cached viewport to screen pixels at fractional zoom',
    () async {
      await bloc.close();
      await currentIndexCubit.close();
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
      currentIndexCubit = CurrentIndexCubit(
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
        currentIndexCubit,
        windowCubit,
        data,
        const AssetLocation(path: 'test-note.bfly'),
        null,
        page,
        pageName,
      );

      await currentIndexCubit.bake(
        bloc.state as DocumentLoadSuccess,
        viewportSize: const Size(401, 303),
        pixelRatio: 1,
        reset: true,
      );

      final viewport = currentIndexCubit.state.cameraViewport;
      final transform = currentIndexCubit.transformCubit.state;
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

  test('renderImage does not hide already tracked visible renderers', () async {
    await bloc.close();
    await currentIndexCubit.close();

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
    currentIndexCubit = CurrentIndexCubit(
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
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'test-note.bfly'),
      null,
      page,
      pageName,
    );

    await currentIndexCubit.bake(
      bloc.state as DocumentLoadSuccess,
      viewportSize: const Size(100, 100),
      pixelRatio: 1,
      reset: true,
    );
    renderer.onVisibleCalls = 0;
    renderer.onHiddenCalls = 0;
    await currentIndexCubit.renderImage(
      (bloc.state as DocumentLoadSuccess).data,
      page,
      (bloc.state as DocumentLoadSuccess).info,
      const ImageExportOptions(width: 100, height: 100),
      docState: bloc.state as DocumentLoadSuccess,
    );
    await currentIndexCubit.bake(
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
      await currentIndexCubit.close();

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
      currentIndexCubit = CurrentIndexCubit(
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
        currentIndexCubit,
        windowCubit,
        data,
        const AssetLocation(path: 'test-note.bfly'),
        null,
        page,
        pageName,
      );

      final image = await currentIndexCubit.renderImage(
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
}
