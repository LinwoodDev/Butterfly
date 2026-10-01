import 'dart:async';
import 'dart:io';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/editor_session.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

class _DiskButterflyFileSystem extends MockButterflyFileSystem {
  final DocumentFileSystem documentSystem;

  _DiskButterflyFileSystem(this.documentSystem, SettingsCubit settingsCubit)
    : super(settingsCubit: settingsCubit);

  @override
  DocumentFileSystem buildDocumentSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) => documentSystem;
}

class _MockEditorSessionCubit extends Mock implements EditorSessionCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory directory;
  late DocumentFileSystem documentSystem;
  late MockSettingsCubit settingsCubit;
  late _DiskButterflyFileSystem fileSystem;
  late EditorController controller;
  late WindowCubit windowCubit;
  DocumentBloc? bloc;

  EditorController createController({String? initialDirectory}) =>
      EditorController(
        settingsCubit,
        TransformCubit(1),
        CameraViewport.unbaked(),
        initialDirectory: initialDirectory,
      );

  setUpAll(() {
    registerFallbackValue(AssetLocation.empty);
  });

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('butterfly_save_');
    documentSystem = TypedDirectoryFileSystem<NoteFile>.build(
      FileSystemConfig(
        storeName: 'documents',
        database: 'save_test',
        databaseVersion: 1,
        getDirectory: (_) async => directory.path,
      ),
      onEncode: encodeNoteFile,
      onDecode: decodeNoteFile,
    );
    settingsCubit = MockSettingsCubit();
    when(() => settingsCubit.state)
        .thenReturn(const ButterflySettings(autosave: false));
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => settingsCubit.getRemote(any())).thenReturn(null);
    when(() => settingsCubit.addRecentHistory(any())).thenAnswer((_) async {});
    fileSystem = _DiskButterflyFileSystem(documentSystem, settingsCubit);
    controller = createController();
    windowCubit = WindowCubit(fullScreen: false);
  });

  tearDown(() async {
    await bloc?.close();
    bloc = null;
    await controller.close();
    await windowCubit.close();
    await documentSystem.release();
    await directory.delete(recursive: true);
  });

  Future<void> openAndEdit(String path) async {
    final data = NoteData.fromData(
      await File('${directory.path}$path').readAsBytes(),
    );
    bloc = DocumentBloc(
      fileSystem,
      controller,
      windowCubit,
      data,
      AssetLocation(path: path),
    );
    bloc!.add(DocumentDescriptionChanged(name: 'Edited important note'));
    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);
    controller.saveCubit.setSaveState(saved: SaveState.unsaved);
  }

  for (final extension in ['', '.bfly', '.tbfly']) {
    test(
      'saves and reopens an existing note with extension "$extension"',
      () async {
        final original = await documentSystem.createFile(
          '/Important note.bfly',
          DocumentDefaults.createDocument(name: 'Important note')
              .toFile(isTextBased: extension == '.tbfly'),
        );
        final path = '/Important note$extension';
        if (path != original.path) {
          await documentSystem.renameAsset(
            original.path,
            'Important note$extension',
          );
        }
        await openAndEdit(path);

        final saved = await controller.saveCubit.save(
          bloc!,
          controller.networkingService,
          force: true,
        );

        expect(
          saved.path,
          extension.isEmpty ? '/Edited important note.bfly' : path,
        );
        expect(controller.saveCubit.state.saved, SaveState.saved);
        final bytes = await File('${directory.path}${saved.path}')
            .readAsBytes();
        expect(NoteData.fromData(bytes).name, 'Edited important note');
        expect(await directory.list().length, extension.isEmpty ? 2 : 1);
      },
    );
  }

  test('autosave is unavailable for an extensionless source', () {
    when(() => settingsCubit.state).thenReturn(const ButterflySettings());
    controller.saveCubit.setSaveState(
      location: const AssetLocation(path: '/Important note'),
      saved: SaveState.unsaved,
    );

    expect(
      controller.saveCubit.hasAutosave(controller.networkingService),
      isFalse,
    );
  });

  test('creates a new note inside an extensionless directory', () async {
    await documentSystem.createDirectory('/notebook');
    await controller.close();
    controller = createController(initialDirectory: '/notebook');
    bloc = DocumentBloc(
      fileSystem,
      controller,
      windowCubit,
      DocumentDefaults.createDocument(name: 'New note').setMetadata(
        DocumentDefaults.createMetadata().copyWith(
          name: 'New note',
          directory: '/template-only',
        ),
      ),
      AssetLocation.empty,
    );
    controller.saveCubit.setSaveState(saved: SaveState.unsaved);

    final saved = await controller.saveCubit.save(
      bloc!,
      controller.networkingService,
      force: true,
    );

    expect(saved.path, '/notebook/New note.bfly');
    final bytes = await File('${directory.path}${saved.path}').readAsBytes();
    expect(NoteData.fromData(bytes).name, 'New note');
    expect(NoteData.fromData(bytes).getMetadata()?.directory, '/template-only');
  });

  test('saving a note does not use its template directory metadata', () async {
    final data = DocumentDefaults.createDocument(name: 'New note');
    bloc = DocumentBloc(
      fileSystem,
      controller,
      windowCubit,
      data.setMetadata(
        data.getMetadata()!.copyWith(directory: '/template-only'),
      ),
      AssetLocation.empty,
    );
    final saved = await controller.saveCubit.save(
      bloc!,
      controller.networkingService,
      force: true,
    );
    expect(saved.pathWithoutLeadingSlash, 'New note.bfly');
  });

  test(
    'retrying a session-state failure keeps the written note location',
    () async {
      bloc = DocumentBloc(
        fileSystem,
        controller,
        windowCubit,
        DocumentDefaults.createDocument(name: 'Important note'),
        AssetLocation.empty,
      );
      controller.saveCubit.setSaveState(saved: SaveState.unsaved);
      final session = _MockEditorSessionCubit();
      var calls = 0;
      when(
        () => session.saveNow(
          pathKey: any(named: 'pathKey'),
          contentHash: any(named: 'contentHash'),
        ),
      ).thenAnswer((_) async {
        if (calls++ == 0) {
          throw const FileSystemException('Session-state write failed');
        }
      });
      await expectLater(
        controller.saveCubit.save(
          bloc!,
          controller.networkingService,
          force: true,
          editorSessionCubit: session,
        ),
        throwsA(isA<FileSystemException>()),
      );
      await controller.saveCubit.save(
        bloc!,
        controller.networkingService,
        force: true,
        editorSessionCubit: session,
      );
      expect(
        await directory.list().length,
        1,
        reason:
            'The note file was already written before session-state failure',
      );
    },
  );

  test('renaming a note preserves an existing destination', () async {
    final settings = MockSettingsCubit();
    when(
      () => settings.moveAssetReferences(
        any(),
        any(),
        directory: any(named: 'directory'),
      ),
    ).thenAnswer((_) async {});
    final source = await documentSystem.createFile(
      '/A.bfly',
      DocumentDefaults.createDocument(name: 'Note A').toFile(),
    );
    await documentSystem.createFile(
      '/B.bfly',
      DocumentDefaults.createDocument(name: 'Important note B').toFile(),
    );
    await renameDocumentAsset(documentSystem, settings, source, 'B');
    final target =
        await documentSystem.getAsset('/B.bfly') as FileSystemFile<NoteFile>;
    expect(target.data!.load()!.name, 'Important note B');
  });

  for (final extension in ['bfly', 'tbfly']) {
    test(
      'saving to a conflicting .$extension destination chooses a unique file',
      () async {
        final original = DocumentDefaults.createDocument(
          name: 'Important note',
        );
        await documentSystem.createFile(
          '/Important note.$extension',
          original.toFile(isTextBased: extension == 'tbfly'),
        );
        final target = await documentSystem.createFile(
          '/Other.$extension',
          DocumentDefaults.createDocument(name: 'Keep this note')
              .toFile(isTextBased: extension == 'tbfly'),
        );
        await openAndEdit('/Important note.$extension');
        final saved = await controller.saveCubit.save(
          bloc!,
          controller.networkingService,
          location: target.location,
          name: 'Renamed note',
          force: true,
        );
        expect(saved.path, '/Other (1).$extension');
        final kept = await documentSystem.getAsset(
          target.path,
        ) as FileSystemFile<NoteFile>;
        expect(kept.data!.load()!.name, 'Keep this note');
        final renamed = await documentSystem.getAsset(
          saved.path,
        ) as FileSystemFile<NoteFile>;
        expect(renamed.data!.load()!.name, 'Renamed note');
        expect(renamed.data!.data.first, extension == 'tbfly' ? 123 : 80);
        final again = await controller.saveCubit.save(
          bloc!,
          controller.networkingService,
          force: true,
        );
        expect(again, saved);
        expect(await directory.list().length, 3);
      },
    );
  }

  test('a failed write remains unsaved and can be retried', () async {
    await documentSystem.createDirectory('/blocked.bfly');
    bloc = DocumentBloc(
      fileSystem,
      controller,
      windowCubit,
      DocumentDefaults.createDocument(name: 'Important note'),
      const AssetLocation(path: '/blocked.bfly'),
    );
    controller.saveCubit.setSaveState(saved: SaveState.unsaved);

    await expectLater(
      controller.saveCubit.save(
        bloc!,
        controller.networkingService,
        force: true,
      ),
      throwsA(isA<FileSystemException>()),
    );
    expect(controller.saveCubit.state.saved, SaveState.unsaved);
    expect(controller.saveCubit.state.location.path, '/blocked.bfly');

    await Directory('${directory.path}/blocked.bfly').delete();
    final saved = await controller.saveCubit.save(
      bloc!,
      controller.networkingService,
      force: true,
    );
    expect(controller.saveCubit.state.saved, SaveState.saved);
    final bytes = await File('${directory.path}${saved.path}').readAsBytes();
    expect(NoteData.fromData(bytes).name, 'Important note');
  });
}
