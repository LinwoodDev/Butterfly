import 'dart:async';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/tool_defaults.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/mocks.dart';

class _TestButterflyFileSystem extends MockButterflyFileSystem {
  _TestButterflyFileSystem(this._settingsCubit);

  final SettingsCubit _settingsCubit;

  @override
  SettingsCubit get settingsCubit => _settingsCubit;
}

Future<void> _settleBlocEvents() async {
  await Future<void>.delayed(Duration.zero);
  await Future<void>.delayed(Duration.zero);
}

DocumentInfo _realisticZoomBoxInfo() => DocumentInfo(
  tools: [
    PenTool(id: 'pen-tool'),
    ZoomBoxTool(id: 'zoom-box-tool'),
  ],
);

void _expectZoomBoxConfigEquals(
  ZoomBoxOverlayState actual,
  ZoomBoxOverlayState expected,
) {
  expect(actual.boxRect, expected.boxRect);
  expect(actual.zoomFactor, expected.zoomFactor);
  expect(actual.autoAdvancePauseSeconds, expected.autoAdvancePauseSeconds);
  expect(actual.advanceTriggerFraction, expected.advanceTriggerFraction);
}

void _expectZoomBoxReferenceEquals(
  ZoomBoxOverlayState actual,
  ZoomBoxOverlayState expected,
) {
  expect(actual.targetOrigin, expected.targetOrigin);
  expect(actual.targetWidthScale, expected.targetWidthScale);
  expect(actual.targetHeightScale, expected.targetHeightScale);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockButterflyFileSystem fileSystem;
  late SettingsCubit settingsCubit;
  late CurrentIndexCubit currentIndexCubit;
  late WindowCubit windowCubit;
  late DocumentBloc bloc;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    settingsCubit = SettingsCubit(prefs);
    fileSystem = _TestButterflyFileSystem(settingsCubit);

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
    await settingsCubit.close();
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

  test('zoom box preserves current state when toggled off and on', () async {
    var data = NoteData(Archive()).setInfo(_realisticZoomBoxInfo());
    const page = DocumentPage(layers: [DocumentLayer(id: 'layer')]);
    final (pageData, pageName) = data.setPage(page, 'Page 1');
    data = pageData;

    await bloc.close();
    await currentIndexCubit.close();

    currentIndexCubit = CurrentIndexCubit(
      settingsCubit,
      TransformCubit(1),
      const CameraViewport.unbaked(),
    );
    bloc = DocumentBloc(
      fileSystem,
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'zoom-box-test.bfly'),
      const [],
      null,
      page,
      pageName,
    );
    await bloc.load();

    final viewportSize = const Size(1200, 900);
    final transform = currentIndexCubit.state.transformCubit.state;

    final handler =
        await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
    final defaultReference = handler.ensureState(viewportSize, transform);
    handler.moveBox(const Offset(0, -180), viewportSize);
    handler.moveReferenceBy(const Offset(84, 42), viewportSize, transform);
    handler.resizeReferenceBy(const Offset(36, 36), viewportSize, transform);
    handler.setZoomFactor(4.5, viewportSize, transform, persist: false);
    handler.adjustAdvanceTriggerFraction(-0.18, persist: false);
    handler.setAutoAdvancePauseSeconds(0.75, bloc, viewportSize);

    final beforeClose = handler.ensureState(viewportSize, transform);
    currentIndexCubit.disableHandler(bloc, 1);
    await _settleBlocEvents();

    final reopened =
        await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
    final afterReopen = reopened.ensureState(viewportSize, transform);

    _expectZoomBoxConfigEquals(afterReopen, beforeClose);
    _expectZoomBoxReferenceEquals(afterReopen, defaultReference);

    currentIndexCubit.disableHandler(bloc, 1);
    await _settleBlocEvents();

    final reopenedAgain =
        await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
    final afterSecondReopen = reopenedAgain.ensureState(
      viewportSize,
      transform,
    );

    _expectZoomBoxConfigEquals(afterSecondReopen, beforeClose);
    _expectZoomBoxReferenceEquals(afterSecondReopen, defaultReference);
  });

  test(
    'zoom box preserves persisted ui controls after toolbar toggle',
    () async {
      var data = NoteData(Archive()).setInfo(_realisticZoomBoxInfo());
      const page = DocumentPage(layers: [DocumentLayer(id: 'layer')]);
      final (pageData, pageName) = data.setPage(page, 'Page 1');
      data = pageData;

      await bloc.close();
      await currentIndexCubit.close();

      currentIndexCubit = CurrentIndexCubit(
        settingsCubit,
        TransformCubit(1),
        const CameraViewport.unbaked(),
      );
      bloc = DocumentBloc(
        fileSystem,
        currentIndexCubit,
        windowCubit,
        data,
        const AssetLocation(path: 'zoom-box-ui-toggle-test.bfly'),
        const [],
        null,
        page,
        pageName,
      );
      await bloc.load();

      final viewportSize = const Size(1200, 900);
      final transform = currentIndexCubit.state.transformCubit.state;

      final handler =
          await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
      final defaultReference = handler.ensureState(viewportSize, transform);
      handler.moveBox(const Offset(-140, -220), viewportSize);
      handler.moveReferenceBy(const Offset(72, 48), viewportSize, transform);
      handler.resizeReferenceBy(const Offset(28, 28), viewportSize, transform);
      handler.persistLayout(bloc, viewportSize);
      await _settleBlocEvents();

      handler.setZoomFactor(
        4.5,
        viewportSize,
        transform,
        bloc: bloc,
        persist: true,
      );
      await _settleBlocEvents();

      handler.adjustAdvanceTriggerFraction(-0.18, persist: false);
      handler.persistLayout(bloc, viewportSize);
      await _settleBlocEvents();

      handler.setAutoAdvancePauseSeconds(0.75, bloc, viewportSize);
      await _settleBlocEvents();

      final beforeClose = handler.ensureState(viewportSize, transform);
      currentIndexCubit.disableHandler(bloc, 1);
      await _settleBlocEvents();

      final reopened =
          await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
      final afterReopen = reopened.ensureState(viewportSize, transform);

      _expectZoomBoxConfigEquals(afterReopen, beforeClose);
      _expectZoomBoxReferenceEquals(afterReopen, defaultReference);
    },
  );

  test('zoom box persists globally across new notes', () async {
    var data = NoteData(Archive()).setInfo(_realisticZoomBoxInfo());
    const page = DocumentPage(layers: [DocumentLayer(id: 'layer')]);
    final (pageData, pageName) = data.setPage(page, 'Page 1');
    data = pageData;

    await bloc.close();
    await currentIndexCubit.close();

    currentIndexCubit = CurrentIndexCubit(
      settingsCubit,
      TransformCubit(1),
      const CameraViewport.unbaked(),
    );
    bloc = DocumentBloc(
      fileSystem,
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'zoom-box-global-source.bfly'),
      const [],
      null,
      page,
      pageName,
    );
    await bloc.load();

    final viewportSize = const Size(1200, 900);
    final transform = currentIndexCubit.state.transformCubit.state;

    final handler =
        await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
    final defaultReference = handler.ensureState(viewportSize, transform);
    handler.moveBox(const Offset(-120, -210), viewportSize);
    handler.moveReferenceBy(const Offset(64, 52), viewportSize, transform);
    handler.resizeReferenceBy(const Offset(24, 24), viewportSize, transform);
    handler.persistLayout(bloc, viewportSize);
    handler.setZoomFactor(
      4.2,
      viewportSize,
      transform,
      bloc: bloc,
      persist: true,
    );
    handler.adjustAdvanceTriggerFraction(-0.12, persist: false);
    handler.persistLayout(bloc, viewportSize);
    handler.setAutoAdvancePauseSeconds(0.65, bloc, viewportSize);
    final expected = handler.ensureState(viewportSize, transform);
    await _settleBlocEvents();

    await bloc.close();
    await currentIndexCubit.close();

    var freshData = NoteData(Archive()).setInfo(_realisticZoomBoxInfo());
    final (freshPageData, freshPageName) = freshData.setPage(page, 'Page 1');
    freshData = settingsCubit.state.applyGlobalToolDefaultsToDocument(
      freshPageData,
    );

    currentIndexCubit = CurrentIndexCubit(
      settingsCubit,
      TransformCubit(1),
      const CameraViewport.unbaked(),
    );
    bloc = DocumentBloc(
      fileSystem,
      currentIndexCubit,
      windowCubit,
      freshData,
      const AssetLocation(path: 'zoom-box-global-target.bfly'),
      const [],
      null,
      page,
      freshPageName,
    );
    await bloc.load();

    final reopened =
        await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
    final actual = reopened.ensureState(viewportSize, transform);

    _expectZoomBoxConfigEquals(actual, expected);
    _expectZoomBoxReferenceEquals(actual, defaultReference);
  });

  test('zoom box global settings survive settings cubit reload', () async {
    var data = NoteData(Archive()).setInfo(_realisticZoomBoxInfo());
    const page = DocumentPage(layers: [DocumentLayer(id: 'layer')]);
    final (pageData, pageName) = data.setPage(page, 'Page 1');
    data = pageData;

    await bloc.close();
    await currentIndexCubit.close();

    currentIndexCubit = CurrentIndexCubit(
      settingsCubit,
      TransformCubit(1),
      const CameraViewport.unbaked(),
    );
    bloc = DocumentBloc(
      fileSystem,
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'zoom-box-settings-reload.bfly'),
      const [],
      null,
      page,
      pageName,
    );
    await bloc.load();

    final viewportSize = const Size(1200, 900);
    final transform = currentIndexCubit.state.transformCubit.state;
    final handler =
        await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
    handler.ensureState(viewportSize, transform);
    handler.moveBox(const Offset(-100, -170), viewportSize);
    handler.moveReferenceBy(const Offset(50, 40), viewportSize, transform);
    handler.resizeReferenceBy(const Offset(22, 22), viewportSize, transform);
    handler.persistLayout(bloc, viewportSize);
    handler.setZoomFactor(
      4.1,
      viewportSize,
      transform,
      bloc: bloc,
      persist: true,
    );
    handler.adjustAdvanceTriggerFraction(-0.16, persist: false);
    handler.persistLayout(bloc, viewportSize);
    handler.setAutoAdvancePauseSeconds(0.71, bloc, viewportSize);
    await _settleBlocEvents();

    final expected = mergeAutomaticGlobalZoomBoxTool(
      handler.snapshotTool(),
      settingsCubit.state.globalZoomBoxTool,
    );

    await currentIndexCubit.close();
    await settingsCubit.close();

    final reloadedPrefs = await SharedPreferences.getInstance();
    settingsCubit = SettingsCubit(reloadedPrefs);
    fileSystem = _TestButterflyFileSystem(settingsCubit);

    expect(
      sanitizeGlobalZoomBoxTool(
        settingsCubit.state.globalZoomBoxTool!,
      ).toJson(),
      sanitizeGlobalZoomBoxTool(expected).toJson(),
    );
  });

  test('zoom box preserves state across immediate toolbar retoggle', () async {
    var data = NoteData(Archive()).setInfo(_realisticZoomBoxInfo());
    const page = DocumentPage(layers: [DocumentLayer(id: 'layer')]);
    final (pageData, pageName) = data.setPage(page, 'Page 1');
    data = pageData;

    await bloc.close();
    await currentIndexCubit.close();

    currentIndexCubit = CurrentIndexCubit(
      settingsCubit,
      TransformCubit(1),
      const CameraViewport.unbaked(),
    );
    bloc = DocumentBloc(
      fileSystem,
      currentIndexCubit,
      windowCubit,
      data,
      const AssetLocation(path: 'zoom-box-retoggle-test.bfly'),
      const [],
      null,
      page,
      pageName,
    );
    await bloc.load();

    final viewportSize = const Size(1200, 900);
    final transform = currentIndexCubit.state.transformCubit.state;
    final handler =
        await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
    final defaultReference = handler.ensureState(viewportSize, transform);
    handler.moveBox(const Offset(-90, -160), viewportSize);
    handler.moveReferenceBy(const Offset(48, 36), viewportSize, transform);
    handler.resizeReferenceBy(const Offset(18, 18), viewportSize, transform);
    handler.setZoomFactor(
      4.6,
      viewportSize,
      transform,
      bloc: bloc,
      persist: true,
    );
    handler.adjustAdvanceTriggerFraction(-0.14, persist: false);
    handler.persistLayout(bloc, viewportSize);
    handler.setAutoAdvancePauseSeconds(0.58, bloc, viewportSize);

    final expected = handler.ensureState(viewportSize, transform);
    unawaited(currentIndexCubit.toggleHandler(bloc, 1));
    await currentIndexCubit.toggleHandler(bloc, 1);
    final reopened =
        currentIndexCubit.state.toggleableHandlers[1] as ZoomBoxHandler;
    final actual = reopened.ensureState(viewportSize, transform);

    _expectZoomBoxConfigEquals(actual, expected);
    _expectZoomBoxReferenceEquals(actual, defaultReference);
    await _settleBlocEvents();
  });

  test(
    'zoom box keeps hydrated state after rebuild-only restore before dragging',
    () async {
      var data = NoteData(Archive()).setInfo(_realisticZoomBoxInfo());
      const page = DocumentPage(layers: [DocumentLayer(id: 'layer')]);
      final (pageData, pageName) = data.setPage(page, 'Page 1');
      data = pageData;

      await bloc.close();
      await currentIndexCubit.close();

      currentIndexCubit = CurrentIndexCubit(
        settingsCubit,
        TransformCubit(1),
        const CameraViewport.unbaked(),
      );
      bloc = DocumentBloc(
        fileSystem,
        currentIndexCubit,
        windowCubit,
        data,
        const AssetLocation(path: 'zoom-box-rebuild-restore.bfly'),
        const [],
        null,
        page,
        pageName,
      );
      await bloc.load();

      final viewportSize = const Size(1200, 900);
      final transform = currentIndexCubit.state.transformCubit.state;
      final handler =
          await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
      final defaultReference = handler.ensureState(viewportSize, transform);
      handler.moveBox(const Offset(-100, -170), viewportSize);
      handler.moveReferenceBy(const Offset(52, 38), viewportSize, transform);
      handler.setZoomFactor(
        4.4,
        viewportSize,
        transform,
        bloc: bloc,
        persist: true,
      );
      handler.adjustAdvanceTriggerFraction(-0.17, persist: false);
      handler.persistLayout(bloc, viewportSize);
      handler.setAutoAdvancePauseSeconds(0.63, bloc, viewportSize);
      final saved = handler.ensureState(viewportSize, transform);
      currentIndexCubit.disableHandler(bloc, 1);
      await _settleBlocEvents();

      final reopened =
          await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
      reopened.ensureState(viewportSize, transform, notify: false);
      reopened.moveBox(const Offset(0, 18), viewportSize);
      reopened.persistLayout(bloc, viewportSize);
      await _settleBlocEvents();
      currentIndexCubit.disableHandler(bloc, 1);
      await _settleBlocEvents();

      final reopenedAgain =
          await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
      final actual = reopenedAgain.ensureState(viewportSize, transform);

      expect(
        actual.boxRect,
        Rect.fromLTWH(
          saved.boxRect!.left,
          saved.boxRect!.top + 18,
          saved.boxRect!.width,
          saved.boxRect!.height,
        ),
      );
      expect(actual.zoomFactor, saved.zoomFactor);
      expect(actual.autoAdvancePauseSeconds, saved.autoAdvancePauseSeconds);
      expect(actual.advanceTriggerFraction, saved.advanceTriggerFraction);
      _expectZoomBoxReferenceEquals(actual, defaultReference);
    },
  );

  test(
    'zoom box keeps hydrated state after rebuild-only restore before control edits',
    () async {
      var data = NoteData(Archive()).setInfo(_realisticZoomBoxInfo());
      const page = DocumentPage(layers: [DocumentLayer(id: 'layer')]);
      final (pageData, pageName) = data.setPage(page, 'Page 1');
      data = pageData;

      await bloc.close();
      await currentIndexCubit.close();

      currentIndexCubit = CurrentIndexCubit(
        settingsCubit,
        TransformCubit(1),
        const CameraViewport.unbaked(),
      );
      bloc = DocumentBloc(
        fileSystem,
        currentIndexCubit,
        windowCubit,
        data,
        const AssetLocation(path: 'zoom-box-rebuild-controls.bfly'),
        const [],
        null,
        page,
        pageName,
      );
      await bloc.load();

      final viewportSize = const Size(1200, 900);
      final transform = currentIndexCubit.state.transformCubit.state;
      final handler =
          await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
      final defaultReference = handler.ensureState(viewportSize, transform);
      handler.moveBox(const Offset(-110, -180), viewportSize);
      handler.moveReferenceBy(const Offset(44, 32), viewportSize, transform);
      handler.setZoomFactor(
        4.2,
        viewportSize,
        transform,
        bloc: bloc,
        persist: true,
      );
      handler.adjustAdvanceTriggerFraction(-0.11, persist: false);
      handler.persistLayout(bloc, viewportSize);
      handler.setAutoAdvancePauseSeconds(0.57, bloc, viewportSize);
      currentIndexCubit.disableHandler(bloc, 1);
      await _settleBlocEvents();

      final reopened =
          await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
      reopened.ensureState(viewportSize, transform, notify: false);
      reopened.setZoomFactor(
        4.8,
        viewportSize,
        transform,
        bloc: bloc,
        persist: true,
      );
      reopened.adjustAdvanceTriggerFraction(-0.04, persist: false);
      reopened.moveReferenceBy(const Offset(18, 14), viewportSize, transform);
      reopened.persistLayout(bloc, viewportSize);
      reopened.setAutoAdvancePauseSeconds(0.83, bloc, viewportSize);
      final expected = reopened.ensureState(viewportSize, transform);
      currentIndexCubit.disableHandler(bloc, 1);
      await _settleBlocEvents();

      final reopenedAgain =
          await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
      final actual = reopenedAgain.ensureState(viewportSize, transform);

      _expectZoomBoxConfigEquals(actual, expected);
      _expectZoomBoxReferenceEquals(actual, defaultReference);
    },
  );

  test(
    'zoom box reopens at explicitly predetermined reference defaults',
    () async {
      var data = NoteData(Archive()).setInfo(_realisticZoomBoxInfo());
      const page = DocumentPage(layers: [DocumentLayer(id: 'layer')]);
      final (pageData, pageName) = data.setPage(page, 'Page 1');
      data = pageData;

      await bloc.close();
      await currentIndexCubit.close();

      currentIndexCubit = CurrentIndexCubit(
        settingsCubit,
        TransformCubit(1),
        const CameraViewport.unbaked(),
      );
      bloc = DocumentBloc(
        fileSystem,
        currentIndexCubit,
        windowCubit,
        data,
        const AssetLocation(path: 'zoom-box-reference-defaults.bfly'),
        const [],
        null,
        page,
        pageName,
      );
      await bloc.load();

      final viewportSize = const Size(1200, 900);
      final transform = currentIndexCubit.state.transformCubit.state;
      final handler =
          await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
      handler.ensureState(viewportSize, transform);
      handler.moveReferenceBy(const Offset(86, 54), viewportSize, transform);
      handler.resizeReferenceBy(const Offset(30, 30), viewportSize, transform);
      final predetermined = handler.ensureState(viewportSize, transform);
      handler.applyReferenceDefaults(bloc, settingsCubit, viewportSize);
      await _settleBlocEvents();

      handler.moveReferenceBy(const Offset(44, 18), viewportSize, transform);
      handler.resizeReferenceBy(const Offset(12, 12), viewportSize, transform);
      currentIndexCubit.disableHandler(bloc, 1);
      await _settleBlocEvents();

      final reopened =
          await currentIndexCubit.enableHandler(bloc, 1) as ZoomBoxHandler;
      final actual = reopened.ensureState(viewportSize, transform);

      _expectZoomBoxReferenceEquals(actual, predetermined);
    },
  );
}
