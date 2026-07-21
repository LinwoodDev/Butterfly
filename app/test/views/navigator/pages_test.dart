import 'dart:math';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/pages.dart' as pages_dialog;
import 'package:butterfly/helpers/rect.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/views/navigator/pages.dart';
import 'package:butterfly/widgets/document_page_preview.dart';
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

  group('page navigator path helpers', () {
    test('shows root untitled page', () {
      final pages = [('', '0.')];

      expect(buildPageEntitiesForLocation(pages, ''), [
        (path: '0.', name: '', isFile: true),
      ]);
    });

    test('shows nested page as file inside its folder', () {
      final pages = [('folder/page', '0.folder/page')];

      expect(buildPageEntitiesForLocation(pages, ''), [
        (path: 'folder', name: 'folder', isFile: false),
      ]);
      expect(buildPageEntitiesForLocation(pages, 'folder'), [
        (path: '0.folder/page', name: 'page', isFile: true),
      ]);
    });

    test('shows only the next folder level for deeper pages', () {
      final pages = [
        (
          'section/subsection/chapter/page',
          '0.section/subsection/chapter/page',
        ),
      ];

      expect(buildPageEntitiesForLocation(pages, 'section'), [
        (path: 'section/subsection', name: 'subsection', isFile: false),
      ]);
    });

    test('resolves leaf renames relative to the current folder', () {
      expect(resolvePageRename('', 'folder/page'), 'folder/page');
      expect(resolvePageRename('folder', 'renamed'), 'folder/renamed');
      expect(
        resolvePageRename('folder', 'subfolder/renamed'),
        'folder/subfolder/renamed',
      );
    });

    test('resolves absolute and parent renames out of the current folder', () {
      expect(resolvePageRename('folder/', '/renamed/'), 'renamed');
      expect(resolvePageRename('folder', '../renamed'), 'renamed');
      expect(
        resolvePageRename('section/subsection', '../renamed'),
        'section/renamed',
      );
      expect(
        resolvePageRename('section/subsection', '../../renamed'),
        'renamed',
      );
    });
  });

  group('navigator preview bounds', () {
    test('uses the initial area before the full page content', () {
      const initialArea = Area(
        name: 'Initial',
        width: 200,
        height: 100,
        position: Point(10, 20),
        isInitial: true,
      );
      const page = DocumentPage(areas: [initialArea]);

      expect(
        resolvePagePreviewBounds(page, [
          const Rect.fromLTWH(-500, -500, 1000, 1000),
        ]),
        initialArea.rect,
      );
    });

    test('an explicit area overrides the page initial area', () {
      const initialArea = Area(
        width: 200,
        height: 100,
        position: Point(10, 20),
        isInitial: true,
      );
      const selectedArea = Area(
        width: 80,
        height: 60,
        position: Point(300, 400),
      );
      const page = DocumentPage(areas: [initialArea, selectedArea]);

      expect(
        resolvePagePreviewBounds(page, const [], area: selectedArea),
        selectedArea.rect,
      );
    });

    test('fits all content when no initial area exists', () {
      const content = Rect.fromLTWH(-50, -25, 100, 50);
      final bounds = resolvePagePreviewBounds(const DocumentPage(), const [
        content,
      ]);

      expect(bounds.contains(content.topLeft), isTrue);
      expect(bounds.contains(content.bottomRight), isTrue);
      expect(bounds.width, greaterThan(content.width));
      expect(bounds.height, greaterThan(content.height));
    });
  });

  group('page selection parser', () {
    test('accepts individual pages and ranges', () {
      expect(pages_dialog.parsePageSelection('[2-4, 6]', 8), [1, 2, 3, 5]);
    });

    test('keeps document order and accepts reversed ranges', () {
      expect(pages_dialog.parsePageSelection('5-3, 2', 6), [1, 2, 3, 4]);
    });

    test('formats selected pages as compact ranges', () {
      expect(
        pages_dialog.formatPageSelection([0, 1, 2, 4, 6, 7]),
        '1-3, 5, 7-8',
      );
      expect(pages_dialog.formatPageSelection([3]), '4');
      expect(pages_dialog.formatPageSelection([]), '');
    });

    test('rejects out of bounds and malformed input', () {
      expect(pages_dialog.parsePageSelection('0, 2', 4), isNull);
      expect(pages_dialog.parsePageSelection('2-', 4), isNull);
      expect(pages_dialog.parsePageSelection('5', 4), isNull);
    });
  });

  testWidgets('dragging pages updates document and visible order', (
    tester,
  ) async {
    final fileSystem = MockButterflyFileSystem();
    final settingsCubit = fileSystem.settingsCubit as MockSettingsCubit;
    when(
      () => settingsCubit.state,
    ).thenReturn(const ButterflySettings(autosave: false));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());
    final editorController = EditorController(
      settingsCubit,
      TransformCubit(1),
      CameraViewport.unbaked(),
    );
    final windowCubit = WindowCubit(fullScreen: false);

    var data = NoteData(Archive());
    late String firstPath;
    late String thirdPath;
    (data, firstPath) = data.setPage(
      const DocumentPage(layers: [DocumentLayer(id: 'first-layer')]),
      'First',
    );
    (data, _) = data.setPage(
      const DocumentPage(layers: [DocumentLayer(id: 'second-layer')]),
      'Second',
    );
    (data, _) = data.setPage(
      const DocumentPage(layers: [DocumentLayer(id: 'third-layer')]),
      'Third',
    );
    (data, _) = data.setPage(
      const DocumentPage(layers: [DocumentLayer(id: 'fourth-layer')]),
      'Fourth',
    );
    (data, thirdPath) = data.setPage(
      const DocumentPage(layers: [DocumentLayer(id: 'fifth-layer')]),
      'Fifth',
    );
    final page = data.getPage(thirdPath)!;
    final bloc = DocumentBloc(
      fileSystem,
      editorController,
      windowCubit,
      data,
      const AssetLocation(path: 'pages-test.bfly'),
      null,
      page,
      thirdPath,
    );
    addTearDown(() async {
      await bloc.close();
      await editorController.close();
      await windowCubit.close();
    });

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: bloc),
          BlocProvider<SettingsCubit>.value(value: settingsCubit),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            LeapLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: SizedBox(width: 500, child: PagesView())),
        ),
      ),
    );
    await tester.pumpAndSettle();

    double verticalPosition(String path) =>
        tester.getTopLeft(find.byKey(ValueKey(path)).first).dy;
    final firstHandle = find.descendant(
      of: find.byKey(ValueKey(firstPath)),
      matching: find.byType(ReorderableDragStartListener),
    );
    final gesture = await tester.startGesture(tester.getCenter(firstHandle));
    await gesture.moveTo(
      tester.getRect(find.byKey(ValueKey(thirdPath)).first).bottomCenter -
          const Offset(0, 1),
      timeStamp: const Duration(seconds: 1),
    );
    await gesture.up();
    await tester.pumpAndSettle();

    final state = bloc.state as DocumentLoadSuccess;
    expect(state.data.getPages(), [
      'Second',
      'Third',
      'Fourth',
      'First',
      'Fifth',
    ]);
    final paths = state.data.getPages(true);
    expect(verticalPosition(paths[0]), lessThan(verticalPosition(paths[1])));
    expect(verticalPosition(paths[1]), lessThan(verticalPosition(paths[2])));
    expect(verticalPosition(paths[2]), lessThan(verticalPosition(paths[3])));
  });

  test('page model accepts converted Flutter final indices', () {
    var data = NoteData(Archive());
    late String firstPath;
    (data, firstPath) = data.setPage(const DocumentPage(), 'First');
    (data, _) = data.setPage(const DocumentPage(), 'Second');
    (data, _) = data.setPage(const DocumentPage(), 'Third');
    (data, _) = data.setPage(const DocumentPage(), 'Fourth');
    (data, _) = data.setPage(const DocumentPage(), 'Fifth');

    data = data.reorderPage(firstPath, 3);
    expect(data.getPages(), ['Second', 'Third', 'First', 'Fourth', 'Fifth']);

    final movedFirstPath = data.getPages(true)[2];
    final endIndex =
        data
            .getPages(true)
            .map(data.getPageIndex)
            .nonNulls
            .fold(-1, (maximum, index) => index > maximum ? index : maximum) +
        1;
    data = data.reorderPage(movedFirstPath, endIndex);
    expect(data.getPages(), ['Second', 'Third', 'Fourth', 'Fifth', 'First']);
  });
}
