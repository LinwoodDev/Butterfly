import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/files/entity.dart';
import 'package:butterfly/views/files/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/file_system.dart';
import '../../helpers/mocks.dart';

class _TrackingDocumentSystem extends TypedDirectoryFileSystem<NoteFile> {
  int directoryFetches = 0;
  Completer<void>? beforeNextFetch;
  Completer<void>? afterNextSnapshot;

  _TrackingDocumentSystem()
    : super.raw(
        MockFileSystem(),
        onEncode: encodeNoteFile,
        onDecode: decodeNoteFile,
        config: const MockFileSystemConfig(),
      );

  @override
  Stream<FileSystemEntity<NoteFile>?> fetchAsset(
    String path, {
    int listLevel = oneListLevel,
    bool readData = true,
    bool forceRemote = false,
    bool absolute = false,
  }) async* {
    if (normalizePath(path) == normalizePath('/notes')) directoryFetches++;
    final barrier = beforeNextFetch;
    final partial = afterNextSnapshot;
    beforeNextFetch = null;
    afterNextSnapshot = null;
    if (barrier != null) await barrier.future;
    var first = true;
    await for (final asset in super.fetchAsset(
      path,
      listLevel: listLevel,
      readData: readData,
      forceRemote: forceRemote,
      absolute: absolute,
    )) {
      yield asset;
      if (first && partial != null) await partial.future;
      first = false;
    }
  }
}

class _TrackingFileSystem extends MockButterflyFileSystem {
  final documents = _TrackingDocumentSystem();

  @override
  DocumentFileSystem buildDocumentSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) => documents;
}

void main() {
  late _TrackingFileSystem fileSystem;
  late MockSettingsCubit settings;
  late GlobalKey<FilesViewState> viewKey;

  setUpAll(() => registerFallbackValue(AssetLocation.empty));

  setUp(() async {
    fileSystem = _TrackingFileSystem();
    settings = configureFileSystemSettings(fileSystem);
    viewKey = GlobalKey<FilesViewState>();
    FilesViewState.collapseTrees();
    for (final name in ['Alpha', 'Beta']) {
      await createTestNote(fileSystem.documents, '/notes/$name.bfly');
    }
  });

  Future<void> pumpFiles(
    WidgetTester tester, {
    FilesLayout layout = FilesLayout.list,
  }) async {
    when(
      () => settings.state,
    ).thenReturn(ButterflySettings(showThumbnails: false, filesLayout: layout));
    await tester.pumpWidget(
      buildFileSystemTestApp(
        fileSystem: fileSystem,
        child: SingleChildScrollView(
          child: FilesView(key: viewKey, initialPath: '/notes'),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder asset(String path) =>
      find.byKey(ValueKey(AssetLocation(path: '/notes/$path')));

  Finder item(String name) => asset('$name.bfly');

  Finder renameField(String name) =>
      find.descendant(of: item(name), matching: find.byType(TextField));

  String renameText(WidgetTester tester, String name) =>
      tester.widget<TextField>(renameField(name)).controller!.text;

  Future<void> edit(WidgetTester tester, String name, {String? text}) async {
    await startFileRename(tester, item(name));
    if (text != null) await tester.enterText(renameField(name), text);
  }

  Future<void> select(WidgetTester tester, String name) async {
    tester.widget<FileEntityItem>(item(name)).onSelected(true);
    await tester.pumpAndSettle();
  }

  Future<void> save(WidgetTester tester, String name) async {
    await tester.tap(
      find.descendant(of: item(name), matching: find.byTooltip('Save')),
    );
    await tester.pumpAndSettle();
  }

  for (final layout in FilesLayout.values) {
    testWidgets(
      '${layout.name} rename preserves other edits and selection without fetching',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 900));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        await pumpFiles(tester, layout: layout);
        await select(tester, 'Alpha');
        await edit(tester, 'Beta', text: 'Unsubmitted edit');
        final betaState = tester.state(item('Beta'));
        await edit(tester, 'Alpha', text: 'Zeta');
        await save(tester, 'Alpha');

        expect(fileSystem.documents.directoryFetches, 1);
        expect(item('Alpha'), findsNothing);
        expect(item('Zeta'), findsOneWidget);
        expect(tester.widget<FileEntityItem>(item('Zeta')).selected, isTrue);
        expect(tester.state(item('Beta')), same(betaState));
        expect(renameText(tester, 'Beta'), 'Unsubmitted edit');
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(
          await fileSystem.documents.getAsset('/notes/Zeta.bfly'),
          isA<FileSystemFile<NoteFile>>(),
        );

        await edit(tester, 'Zeta', text: 'Gamma');
        await save(tester, 'Zeta');
        expect(fileSystem.documents.directoryFetches, 1);
        expect(await fileSystem.documents.getAsset('/notes/Zeta.bfly'), isNull);
        expect(item('Gamma'), findsOneWidget);
      },
    );
  }

  testWidgets('refresh keeps rows and unfinished edits while fetching', (
    tester,
  ) async {
    await pumpFiles(tester);
    await edit(tester, 'Beta', text: 'Unsubmitted edit');
    final betaState = tester.state(item('Beta'));
    final barrier = Completer<void>();
    fileSystem.documents.beforeNextFetch = barrier;
    viewKey.currentState!.reloadFileSystem();
    await tester.pump();
    await tester.pump();
    expect(fileSystem.documents.directoryFetches, 2);
    expect(item('Alpha'), findsOneWidget);
    expect(tester.state(item('Beta')), same(betaState));
    expect(find.byType(CircularProgressIndicator), findsNothing);
    barrier.complete();
    await tester.pumpAndSettle();
    expect(tester.state(item('Beta')), same(betaState));
    expect(renameText(tester, 'Beta'), 'Unsubmitted edit');
  });

  testWidgets('refresh clears selections for files that no longer exist', (
    tester,
  ) async {
    await pumpFiles(tester);
    await select(tester, 'Alpha');
    await fileSystem.documents.deleteAsset('/notes/Alpha.bfly');
    viewKey.currentState!.reloadFileSystem();
    await tester.pumpAndSettle();
    expect(item('Alpha'), findsNothing);
    expect(tester.widget<FileEntityItem>(item('Beta')).selected, isNull);
    expect(find.byTooltip('Deselect'), findsNothing);
  });

  testWidgets('a pending refresh cannot undo a completed rename', (
    tester,
  ) async {
    await pumpFiles(tester);
    final partial = Completer<void>();
    fileSystem.documents.afterNextSnapshot = partial;
    viewKey.currentState!.reloadFileSystem();
    await tester.pumpAndSettle();
    await edit(tester, 'Alpha', text: 'Zeta');
    await save(tester, 'Alpha');
    partial.complete();
    await tester.pumpAndSettle();
    expect(item('Alpha'), findsNothing);
    expect(item('Zeta'), findsOneWidget);
    expect(item('Beta'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('creating a folder keeps the existing rows without fetching', (
    tester,
  ) async {
    await pumpFiles(tester);
    await edit(tester, 'Beta', text: 'Unsubmitted edit');
    final betaState = tester.state(item('Beta'));
    await tester.tap(find.byTooltip('Create'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('New folder'));
    await tester.pumpAndSettle();
    final dialog = find.byType(NameDialog);
    await tester.enterText(
      find.descendant(of: dialog, matching: find.byType(TextField)),
      'Other',
    );
    await tester.tap(
      find.descendant(of: dialog, matching: find.byType(ElevatedButton)),
    );
    await tester.pumpAndSettle();
    expect(fileSystem.documents.directoryFetches, 1);
    expect(asset('Other'), findsOneWidget);
    expect(tester.state(item('Beta')), same(betaState));
    expect(renameText(tester, 'Beta'), 'Unsubmitted edit');
  });

  testWidgets(
    'navigation clears selection and does not show the old folder while loading',
    (tester) async {
      await createTestNote(fileSystem.documents, '/notes/Other/Child.bfly');
      await pumpFiles(tester);
      await select(tester, 'Alpha');
      final barrier = Completer<void>();
      fileSystem.documents.beforeNextFetch = barrier;
      tester.widget<FileEntityItem>(asset('Other')).onTap();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(item('Alpha'), findsNothing);
      expect(find.byTooltip('Deselect'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      barrier.complete();
      await tester.pumpAndSettle();
      expect(asset('Other/Child.bfly'), findsOneWidget);
    },
  );

  testWidgets(
    'deleting a selected entry keeps other rows and clears selection',
    (tester) async {
      await pumpFiles(tester);
      await select(tester, 'Alpha');
      final betaState = tester.state(item('Beta'));
      await tester.tap(find.byTooltip('Delete').first);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton).last);
      await tester.pumpAndSettle();
      expect(fileSystem.documents.directoryFetches, 1);
      expect(item('Alpha'), findsNothing);
      expect(await fileSystem.documents.getAsset('/notes/Alpha.bfly'), isNull);
      expect(tester.state(item('Beta')), same(betaState));
      expect(tester.widget<FileEntityItem>(item('Beta')).selected, isNull);
      expect(find.byTooltip('Deselect'), findsNothing);
    },
  );

  testWidgets(
    'a rename completing after navigation does not change the new directory',
    (tester) async {
      await createTestNote(fileSystem.documents, '/notes/Other/Child.bfly');
      final renamed = Completer<void>();
      when(
        () => settings.moveAssetReferences(
          any(),
          any(),
          directory: any(named: 'directory'),
        ),
      ).thenAnswer((_) => renamed.future);
      await pumpFiles(tester);
      await edit(tester, 'Alpha', text: 'Zeta');
      await save(tester, 'Alpha');
      tester.widget<FileEntityItem>(asset('Other')).onTap();
      await tester.pumpAndSettle();
      renamed.complete();
      await tester.pumpAndSettle();
      expect(item('Zeta'), findsNothing);
      expect(asset('Other/Child.bfly'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('tree expands folders in place and keeps them after refresh', (
    tester,
  ) async {
    await createTestNote(fileSystem.documents, '/notes/Other/Child.bfly');
    await createTestNote(fileSystem.documents, '/notes/Other/Sub/Deep.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    expect(asset('Other'), findsOneWidget);
    expect(asset('Other/Child.bfly'), findsNothing);

    tester.widget<FileEntityItem>(asset('Other')).onTap();
    await tester.pumpAndSettle();
    expect(item('Alpha'), findsOneWidget);
    expect(asset('Other/Child.bfly'), findsOneWidget);
    expect(asset('Other/Sub/Deep.bfly'), findsNothing);

    await tester.tap(find.byTooltip('Expand'));
    await tester.pumpAndSettle();
    expect(asset('Other/Sub/Deep.bfly'), findsOneWidget);

    viewKey.currentState!.reloadFileSystem();
    await tester.pumpAndSettle();
    expect(asset('Other/Sub/Deep.bfly'), findsOneWidget);
    expect(fileSystem.documents.directoryFetches, 2);

    await tester.tap(find.byTooltip('Collapse').first);
    await tester.pumpAndSettle();
    expect(asset('Other/Child.bfly'), findsNothing);
    expect(asset('Other/Sub/Deep.bfly'), findsNothing);

    tester.widget<FileEntityItem>(asset('Other')).onTap();
    await tester.pumpAndSettle();
    expect(asset('Other/Sub/Deep.bfly'), findsOneWidget);
  });

  testWidgets('tree renames a nested file without fetching', (tester) async {
    await createTestNote(fileSystem.documents, '/notes/Other/Child.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    tester.widget<FileEntityItem>(asset('Other')).onTap();
    await tester.pumpAndSettle();
    final child = asset('Other/Child.bfly');
    await startFileRename(tester, child);
    await tester.enterText(
      find.descendant(of: child, matching: find.byType(TextField)),
      'Renamed',
    );
    await tester.tap(
      find.descendant(of: child, matching: find.byTooltip('Save')),
    );
    await tester.pumpAndSettle();
    expect(asset('Other/Child.bfly'), findsNothing);
    expect(asset('Other/Renamed.bfly'), findsOneWidget);
    expect(fileSystem.documents.directoryFetches, 1);
  });

  testWidgets('tree search keeps the folders of matching files', (
    tester,
  ) async {
    await createTestNote(fileSystem.documents, '/notes/Other/Needle.bfly');
    await createTestNote(fileSystem.documents, '/notes/Empty/Hay.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    tester.widget<FileEntityItem>(asset('Other')).onTap();
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(SearchBar), 'needle');
    await tester.pumpAndSettle();
    expect(asset('Other'), findsOneWidget);
    expect(asset('Other/Needle.bfly'), findsOneWidget);
    expect(asset('Empty'), findsNothing);
    expect(item('Alpha'), findsNothing);
  });

  Future<void> mouseDrag(
    WidgetTester tester,
    Finder from,
    Finder to, {
    Duration hold = Duration.zero,
  }) async {
    final gesture = await tester.startGesture(
      tester.getCenter(from),
      kind: PointerDeviceKind.mouse,
    );
    await gesture.moveBy(const Offset(30, 0));
    await tester.pump();
    await gesture.moveTo(tester.getCenter(to));
    await tester.pump();
    await tester.pump(hold);
    await gesture.up();
    await tester.pumpAndSettle();
  }

  testWidgets('tree moves a note dragged with the mouse into a folder', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await createTestNote(fileSystem.documents, '/notes/Other/Child.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    tester.widget<FileEntityItem>(asset('Other')).onTap();
    await tester.pumpAndSettle();

    await mouseDrag(tester, item('Alpha'), asset('Other'));
    expect(item('Alpha'), findsNothing);
    expect(asset('Other/Alpha.bfly'), findsOneWidget);
    expect(
      await fileSystem.documents.getAsset('/notes/Other/Alpha.bfly'),
      isA<FileSystemFile<NoteFile>>(),
    );

    // Dropping on a note of the top level moves it back there.
    await mouseDrag(tester, asset('Other/Child.bfly'), item('Beta'));
    expect(asset('Other/Child.bfly'), findsNothing);
    expect(item('Child'), findsOneWidget);
    expect(asset('Other/Alpha.bfly'), findsOneWidget);
  });

  testWidgets('tree opens a closed folder while a note is held over it', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await createTestNote(fileSystem.documents, '/notes/Other/Sub/Deep.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    final gesture = await tester.startGesture(
      tester.getCenter(item('Alpha')),
      kind: PointerDeviceKind.mouse,
    );
    await gesture.moveBy(const Offset(30, 0));
    await tester.pump();
    await gesture.moveTo(tester.getCenter(asset('Other')));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(asset('Other/Sub'), findsOneWidget);
    await gesture.moveTo(tester.getCenter(asset('Other/Sub')));
    await tester.pump();
    await gesture.up();
    await tester.pumpAndSettle();
    expect(asset('Other/Sub/Alpha.bfly'), findsNothing);
    expect(
      await fileSystem.documents.getAsset('/notes/Other/Sub/Alpha.bfly'),
      isA<FileSystemFile<NoteFile>>(),
    );
  });

  test('assets cannot move into themselves or where they already are', () {
    expect(canMoveAssetInto('/notes/Other', '/notes/Target'), isTrue);
    expect(canMoveAssetInto('/notes/Other', '/notes/Other'), isFalse);
    expect(canMoveAssetInto('/notes/Other', '/notes/Other/Sub'), isFalse);
    expect(canMoveAssetInto('/notes/Other', '/notes'), isFalse);
    expect(canMoveAssetInto('/notes/Other', 'notes/'), isFalse);
    expect(canMoveAssetInto('/notes/Other', '/notes/Others'), isTrue);
    expect(canMoveAssetInto('/Top.bfly', ''), isFalse);
  });
}
