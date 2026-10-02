import 'dart:async';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/files/entity.dart';
import 'package:butterfly/views/files/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
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
    for (final name in ['Alpha', 'Beta']) {
      await createTestNote(fileSystem.documents, '/notes/$name.bfly');
    }
  });

  Future<void> pumpFiles(WidgetTester tester, {bool grid = false}) async {
    when(() => settings.state)
        .thenReturn(ButterflySettings(showThumbnails: false, gridView: grid));
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

  for (final grid in [false, true]) {
    testWidgets(
      '${grid ? 'grid' : 'list'} rename preserves other edits and selection without fetching',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(1200, 900));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        await pumpFiles(tester, grid: grid);
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
}
