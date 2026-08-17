import 'dart:math';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/views/navigator/layers.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('layer operations stay consistent across UI and document state', (
    tester,
  ) async {
    final fileSystem = MockButterflyFileSystem();
    final settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;
    when(() => settingsCubit.state)
        .thenReturn(const ButterflySettings(autosave: false));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());

    final bottomElement = ShapeElement(
      id: 'bottom-element',
      firstPosition: const Point(0, 0),
      secondPosition: const Point(10, 10),
    );
    final middleElement = ShapeElement(
      id: 'middle-element',
      firstPosition: const Point(0, 0),
      secondPosition: const Point(10, 10),
    );
    final topElement = ShapeElement(
      id: 'top-element',
      firstPosition: const Point(0, 0),
      secondPosition: const Point(10, 10),
    );
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'bottom', name: 'Bottom', content: [bottomElement]),
        DocumentLayer(id: 'middle', name: 'Middle', content: [middleElement]),
        DocumentLayer(id: 'top', name: 'Top', content: [topElement]),
      ],
    );
    final renderers = <Renderer<PadElement>>[
      Renderer.fromInstance(bottomElement, 'bottom'),
      Renderer.fromInstance(middleElement, 'middle'),
      Renderer.fromInstance(topElement, 'top'),
    ];
    final editorController = EditorController(
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
    final windowCubit = WindowCubit(fullScreen: false);
    final (data, pageName) = NoteData(Archive()).setPage(page, 'Page');
    final bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'layers-test.bfly'),
      null,
      page,
      pageName,
    );
    addTearDown(() async {
      await bloc.close();
      await editorController.close();
      await windowCubit.close();
    });

    await tester.pumpWidget(
      BlocProvider.value(
        value: bloc,
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            LeapLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) =>
                  const SizedBox(width: 500, child: LayersView()),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    double verticalPosition(String id) =>
        tester.getTopLeft(find.byKey(ValueKey(id))).dy;

    expect(verticalPosition('top'), lessThan(verticalPosition('middle')));
    expect(verticalPosition('middle'), lessThan(verticalPosition('bottom')));
    final topHandle = find.descendant(
      of: find.byKey(const ValueKey('top')),
      matching: find.byType(ReorderableDragStartListener),
    );
    await tester.timedDrag(
      topHandle,
      const Offset(0, 240),
      const Duration(seconds: 1),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    var state = bloc.state as DocumentLoadSuccess;
    expect(state.page.layers.map((layer) => layer.id), [
      'top',
      'bottom',
      'middle',
    ]);
    expect(
      editorController.rendererCubit.renderers.map(
        (renderer) => renderer.layer,
      ),
      ['top', 'bottom', 'middle'],
    );
    expect(verticalPosition('middle'), lessThan(verticalPosition('bottom')));
    expect(verticalPosition('bottom'), lessThan(verticalPosition('top')));

    bloc
      ..add(const LayerChanged('top', name: 'Renamed'))
      ..add(const LayerVisibilityChanged('bottom', false))
      ..add(const LayerCreated(id: 'new', name: 'New'));
    await tester.pumpAndSettle();

    state = bloc.state as DocumentLoadSuccess;
    expect(state.page.getLayer('top').name, 'Renamed');
    expect(state.isLayerVisible('bottom'), isFalse);
    expect(state.page.layers.map((layer) => layer.id), [
      'top',
      'bottom',
      'middle',
      'new',
    ]);
    expect(verticalPosition('new'), lessThan(verticalPosition('middle')));

    bloc.add(const LayerRemoved('middle'));
    await tester.pumpAndSettle();

    state = bloc.state as DocumentLoadSuccess;
    expect(state.page.layers.map((layer) => layer.id), [
      'top',
      'bottom',
      'new',
    ]);
    expect(find.byKey(const ValueKey('middle')), findsNothing);
  });
}
