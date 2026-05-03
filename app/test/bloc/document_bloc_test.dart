import 'dart:async';
import 'dart:math';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

Future<void> _settleBlocEvents() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

class _VisibleTrackingRenderer extends Renderer<PadElement> {
  int onVisibleCalls = 0;
  int onHiddenCalls = 0;
  CameraTransform? lastVisibleTransform;
  Size? lastVisibleSize;

  _VisibleTrackingRenderer(super.element);

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
      const CameraViewport.unbaked(),
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
      const [],
      null,
      secondPage,
      secondPageName,
    );
  });

  tearDown(() async {
    await bloc.close();
    await currentIndexCubit.close();
    await windowCubit.close();
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

  test('resetInput clears active pointers and buttons', () async {
    currentIndexCubit.addPointer(12);
    currentIndexCubit.setButtons(kPrimaryMouseButton);

    await currentIndexCubit.resetInput(bloc);

    expect(currentIndexCubit.state.pointers, isEmpty);
    expect(currentIndexCubit.state.buttons, isNull);
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
      renderers,
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
      renderers,
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
          shape: RectangleShape(fillColor: SRGBColor(0xFFFF0000)),
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
        renderers,
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
