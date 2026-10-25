import 'dart:async';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/file_system/move.dart';
import 'package:butterfly/views/files/entity.dart';
import 'package:butterfly/views/files/tree.dart';
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
  // Holds the result of the next read of a folder until the completer ends.
  final Map<String, Completer<void>> holdNextResult = {};
  // Reading these folders fails, as on a storage that cannot be reached.
  final Set<String> failingReads = {};

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
    final hold = holdNextResult.remove(normalizePath(path));
    beforeNextFetch = null;
    afterNextSnapshot = null;
    if (barrier != null) await barrier.future;
    if (failingReads.contains(normalizePath(path))) {
      throw StateError('$path cannot be reached');
    }
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
    if (hold != null) await hold.future;
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
    FileTreeController.collapseAll();
    for (final name in ['Alpha', 'Beta']) {
      await createTestNote(fileSystem.documents, '/notes/$name.bfly');
    }
  });

  Future<void> pumpFiles(
    WidgetTester tester, {
    FilesLayout layout = FilesLayout.list,
    SortOrder sortOrder = SortOrder.ascending,
    bool collapsed = false,
  }) async {
    when(() => settings.state).thenReturn(
      ButterflySettings(
        showThumbnails: false,
        filesLayout: layout,
        sortOrder: sortOrder,
      ),
    );
    await tester.pumpWidget(
      buildFileSystemTestApp(
        fileSystem: fileSystem,
        child: SingleChildScrollView(
          child: FilesView(
            key: viewKey,
            initialPath: '/notes',
            collapsed: collapsed,
          ),
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

  Future<void> renameAsset(
    WidgetTester tester,
    Finder entry,
    String name,
  ) async {
    await startFileRename(tester, entry);
    await tester.enterText(
      find.descendant(of: entry, matching: find.byType(TextField)),
      name,
    );
    await tester.tap(
      find.descendant(of: entry, matching: find.byTooltip('Save')),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('a pending folder read cannot undo a nested rename', (
    tester,
  ) async {
    await createTestNote(fileSystem.documents, '/notes/Other/Child.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    tester.widget<FileEntityItem>(asset('Other')).onTap();
    await tester.pumpAndSettle();
    // The listing of the current folder would read the folder too.
    final barrier = Completer<void>();
    final hold = Completer<void>();
    fileSystem.documents.beforeNextFetch = barrier;
    fileSystem.documents.holdNextResult['/notes/Other'] = hold;
    viewKey.currentState!.reloadFileSystem();
    await tester.pumpAndSettle();
    expect(fileSystem.documents.holdNextResult, isEmpty);
    await renameAsset(tester, asset('Other/Child.bfly'), 'Renamed');
    hold.complete();
    await tester.pumpAndSettle();
    barrier.complete();
    await tester.pumpAndSettle();
    expect(asset('Other/Child.bfly'), findsNothing);
    expect(asset('Other/Renamed.bfly'), findsOneWidget);
  });

  testWidgets('tree selection follows renamed and deleted nested entries', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await createTestNote(fileSystem.documents, '/notes/Other/Child.bfly');
    await createTestNote(fileSystem.documents, '/notes/Other/Second.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    tester.widget<FileEntityItem>(asset('Other')).onTap();
    await tester.pumpAndSettle();
    tester.widget<FileEntityItem>(asset('Other/Child.bfly')).onSelected(true);
    await tester.pumpAndSettle();

    await renameAsset(tester, asset('Other/Child.bfly'), 'Renamed');
    expect(
      tester.widget<FileEntityItem>(asset('Other/Renamed.bfly')).selected,
      isTrue,
    );
    expect(
      tester.widget<FileEntityItem>(asset('Other/Second.bfly')).selected,
      isFalse,
    );

    await renameAsset(tester, asset('Other'), 'Moved');
    expect(
      tester.widget<FileEntityItem>(asset('Moved/Renamed.bfly')).selected,
      isTrue,
    );

    await tester.tap(find.byTooltip('Delete').first);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton).last);
    await tester.pumpAndSettle();
    expect(asset('Moved/Renamed.bfly'), findsNothing);
    expect(asset('Moved/Second.bfly'), findsOneWidget);
    expect(find.byTooltip('Deselect'), findsNothing);
  });

  testWidgets('tree selections of files moved elsewhere are cleared', (
    tester,
  ) async {
    await createTestNote(fileSystem.documents, '/notes/Other/Child.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    tester.widget<FileEntityItem>(asset('Other')).onTap();
    await tester.pumpAndSettle();
    tester.widget<FileEntityItem>(asset('Other/Child.bfly')).onSelected(true);
    await tester.pumpAndSettle();
    await fileSystem.documents.moveAsset(
      '/notes/Other/Child.bfly',
      '/notes/Child.bfly',
    );
    viewKey.currentState!.reloadFileSystem();
    await tester.pumpAndSettle();
    expect(item('Child'), findsOneWidget);
    expect(tester.widget<FileEntityItem>(item('Child')).selected, isNull);
    expect(find.byTooltip('Deselect'), findsNothing);
  });

  testWidgets('export keeps the folders of nested files', (tester) async {
    await createTestNote(fileSystem.documents, '/notes/Other/Alpha.bfly');
    await createTestNote(fileSystem.documents, '/notes/Sub/Deep/Alpha.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    for (final folder in ['Other', 'Sub', 'Sub/Deep']) {
      tester.widget<FileEntityItem>(asset(folder)).onTap();
      await tester.pumpAndSettle();
    }
    for (final path in [
      'Alpha.bfly',
      'Other/Alpha.bfly',
      'Sub/Deep/Alpha.bfly',
    ]) {
      tester.widget<FileEntityItem>(asset(path)).onSelected(true);
    }
    await tester.pumpAndSettle();
    final bytes = await viewKey.currentState!.createSelectionArchive();
    final archive = ZipDecoder().decodeBytes(bytes!);
    expect(archive.files.map((file) => file.name), [
      'Alpha.bfly',
      'Other/Alpha.bfly',
      'Sub/Deep/Alpha.bfly',
    ]);
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

  Future<void> createNote(String path, int byte) => fileSystem.documents
      .createFile(path, NoteFile(Uint8List.fromList([byte])));

  Future<List<int>?> bytesOf(String path) async {
    final file = await fileSystem.documents.getAsset(path);
    return file is FileSystemFile<NoteFile> ? file.data?.data : null;
  }

  testWidgets('dropping onto a folder with the same name inside keeps both', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await createNote('/notes/Other/Alpha.bfly', 7);
    await pumpFiles(tester, layout: FilesLayout.tree);
    await mouseDrag(tester, item('Alpha'), asset('Other'));
    expect(await bytesOf('/notes/Other/Alpha.bfly'), [7]);
    expect(await bytesOf('/notes/Other/Alpha (1).bfly'), [1, 2, 3]);
    expect(await bytesOf('/notes/Alpha.bfly'), isNull);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dropping onto Go up with the same name above keeps both', (
    tester,
  ) async {
    await createNote('/Alpha.bfly', 7);
    await pumpFiles(tester);
    await mouseDrag(tester, item('Alpha'), find.byTooltip('Go up'));
    expect(await bytesOf('/Alpha.bfly'), [7]);
    expect(await bytesOf('/Alpha (1).bfly'), [1, 2, 3]);
    expect(await bytesOf('/notes/Alpha.bfly'), isNull);
  });

  testWidgets('dropping onto the location moves a note to the top level', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await createTestNote(fileSystem.documents, '/notes/Other/Sub/Deep.bfly');
    await createTestNote(fileSystem.documents, '/notes/Other/Sub/Keep.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    for (final folder in ['Other', 'Other/Sub']) {
      tester.widget<FileEntityItem>(asset(folder)).onTap();
      await tester.pumpAndSettle();
    }
    final location = find.byType(TextFormField);
    await mouseDrag(tester, asset('Other/Sub/Deep.bfly'), location);
    expect(asset('Other/Sub/Deep.bfly'), findsNothing);
    expect(item('Deep'), findsOneWidget);

    // A folder moves too; a note already on the top level stays.
    await mouseDrag(tester, asset('Other/Sub'), location);
    expect(asset('Other/Sub'), findsNothing);
    expect(asset('Sub/Keep.bfly'), findsOneWidget);
    await mouseDrag(tester, item('Alpha'), location);
    expect(await bytesOf('/notes/Alpha.bfly'), [1, 2, 3]);
    expect(await bytesOf('/notes/Alpha (1).bfly'), isNull);
  });

  testWidgets('moving notes with the same name from two folders keeps both', (
    tester,
  ) async {
    await createNote('/notes/A/Note.bfly', 1);
    await createNote('/notes/B/Note.bfly', 2);
    await pumpFiles(tester);
    showDialog<void>(
      context: tester.element(find.byType(FilesView)),
      builder: (_) => FileSystemAssetMoveDialog(
        moveMode: MoveMode.move,
        assets: [
          AssetLocation(path: '/notes/A/Note.bfly'),
          AssetLocation(path: '/notes/B/Note.bfly'),
        ],
        fileSystem: fileSystem.documents,
      ),
    );
    await tester.pumpAndSettle();
    // The destination is the folder of the first note.
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(await bytesOf('/notes/A/Note.bfly'), [1]);
    expect(await bytesOf('/notes/A/Note (1).bfly'), [2]);
    expect(await bytesOf('/notes/B/Note.bfly'), isNull);
  });

  testWidgets('dropping a note onto its own folder leaves it there', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await createTestNote(fileSystem.documents, '/notes/Other/Child.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    tester.widget<FileEntityItem>(asset('Other')).onTap();
    await tester.pumpAndSettle();
    await mouseDrag(tester, asset('Other/Child.bfly'), asset('Other'));
    expect(await bytesOf('/notes/Other/Child.bfly'), [1, 2, 3]);
    expect(await bytesOf('/notes/Child.bfly'), isNull);
    expect(asset('Other/Child.bfly'), findsOneWidget);
  });

  testWidgets('a mouse click that moves a few pixels still opens a folder', (
    tester,
  ) async {
    await createTestNote(fileSystem.documents, '/notes/Other/Child.bfly');
    await pumpFiles(tester);
    final gesture = await tester.startGesture(
      tester.getCenter(asset('Other')),
      kind: PointerDeviceKind.mouse,
    );
    await gesture.moveBy(const Offset(3, 0));
    await tester.pump();
    await gesture.up();
    await tester.pumpAndSettle();
    expect(asset('Other/Child.bfly'), findsOneWidget);
  });

  testWidgets('tree entries that are hidden are deselected', (tester) async {
    final states = StreamController<ButterflySettings>.broadcast();
    addTearDown(states.close);
    when(() => settings.stream).thenAnswer((_) => states.stream);
    Future<void> switchLayout(FilesLayout layout) async {
      final state = ButterflySettings(
        showThumbnails: false,
        filesLayout: layout,
      );
      when(() => settings.state).thenReturn(state);
      states.add(state);
      await tester.pumpAndSettle();
    }

    await createTestNote(fileSystem.documents, '/notes/Other/Child.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    tester.widget<FileEntityItem>(asset('Other')).onTap();
    await tester.pumpAndSettle();
    tester.widget<FileEntityItem>(asset('Other/Child.bfly')).onSelected(true);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Collapse'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Deselect'), findsNothing);

    // The list keeps only the selected entries of the current folder.
    tester.widget<FileEntityItem>(asset('Other')).onTap();
    await tester.pumpAndSettle();
    tester.widget<FileEntityItem>(asset('Other/Child.bfly')).onSelected(true);
    tester.widget<FileEntityItem>(item('Alpha')).onSelected(true);
    await tester.pumpAndSettle();
    await switchLayout(FilesLayout.list);
    expect(tester.widget<FileEntityItem>(item('Alpha')).selected, isTrue);
    await switchLayout(FilesLayout.tree);
    expect(
      tester.widget<FileEntityItem>(asset('Other/Child.bfly')).selected,
      isFalse,
    );
  });

  testWidgets('the tree opens a folder from its menu', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await createTestNote(fileSystem.documents, '/notes/Other/Child.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    await tester.tap(
      asset('Other'),
      buttons: kSecondaryMouseButton,
      kind: PointerDeviceKind.mouse,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(asset('Other'), findsNothing);
    expect(asset('Other/Child.bfly'), findsOneWidget);
  });

  testWidgets('a folder that cannot be read stays open and shows why', (
    tester,
  ) async {
    await createTestNote(fileSystem.documents, '/notes/Other/Sub/Deep.bfly');
    await pumpFiles(tester, layout: FilesLayout.tree);
    tester.widget<FileEntityItem>(asset('Other')).onTap();
    await tester.pumpAndSettle();
    fileSystem.documents.failingReads.add('/notes/Other/Sub');
    tester.widget<FileEntityItem>(asset('Other/Sub')).onTap();
    await tester.pumpAndSettle();
    expect(find.textContaining('Error'), findsOneWidget);
    expect(find.byTooltip('Collapse'), findsNWidgets(2));

    // A refresh reads it again.
    fileSystem.documents.failingReads.clear();
    viewKey.currentState!.reloadFileSystem();
    await tester.pumpAndSettle();
    expect(find.textContaining('Error'), findsNothing);
    expect(asset('Other/Sub/Deep.bfly'), findsOneWidget);
  });

  testWidgets('deeply nested folders fit in the side panel', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final folders = List.generate(14, (i) => 'D$i');
    await createTestNote(
      fileSystem.documents,
      '/notes/${folders.join('/')}/Leaf.bfly',
    );
    await pumpFiles(tester, layout: FilesLayout.tree, collapsed: true);
    for (var i = 1; i <= folders.length; i++) {
      tester.widget<FileEntityItem>(asset(folders.take(i).join('/'))).onTap();
      await tester.pumpAndSettle();
    }
    expect(asset('${folders.join('/')}/Leaf.bfly'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('folders follow the sort order', (tester) async {
    for (final name in ['Apple', 'Banana']) {
      await createTestNote(fileSystem.documents, '/notes/$name/Note.bfly');
    }
    await pumpFiles(tester, sortOrder: SortOrder.descending);
    expect(
      tester.getTopLeft(asset('Banana')).dy,
      lessThan(tester.getTopLeft(asset('Apple')).dy),
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
