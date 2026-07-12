import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/editor_session.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/persisted_document_state.dart';
import 'package:butterfly/repositories/document_state.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

class _MockDocumentStateFileSystem extends Mock
    implements DocumentStateFileSystem {}

void main() {
  group('PersistedDocumentState', () {
    test('round trips through typed encoding', () {
      final state = PersistedDocumentState(
        pathKey: 'path/a',
        contentHash: 'hash',
        pageName: 'Page 1',
        camera: const PersistedCameraState(
          positionX: 10,
          positionY: 20,
          zoom: 2,
        ),
        locks: const PersistentLockState(lockZoom: true),
        selectedTool: const PersistedToolSelection(
          toolId: 'tool-a',
          toolIndex: 3,
        ),
        navigator: PersistedNavigatorState(
          enabled: true,
          page: NavigatorPage.layers.name,
        ),
        layers: const PersistedLayerState(
          currentLayer: 'layer-a',
          currentCollection: 'collection-a',
          invisibleLayers: {'hidden-a'},
        ),
        areaNavigator: const PersistedAreaNavigatorState(create: false),
        updatedAt: DateTime.utc(2026),
      );

      final decoded = decodePersistedDocumentState(
        encodePersistedDocumentState(state),
      );

      expect(decoded, state.copyWith(pathKey: null, contentHash: null));
    });

    test('uses schema defaults for sparse json', () {
      final state = PersistedDocumentState.fromJson(const {});

      expect(state.version, kPersistedDocumentStateVersion);
      expect(state.camera.zoom, 1);
      expect(state.locks, const PersistentLockState());
      expect(state.navigator.page, NavigatorPage.waypoints.name);
    });
  });

  group('EditorSessionCubit storage', () {
    late DocumentStateFileSystem fileSystem;

    setUp(() {
      fileSystem = buildMockDocumentStateFileSystem();
    });

    test('path match wins over content hash match', () async {
      const byContent = PersistedDocumentState(pageName: 'Content Page');
      const byPath = PersistedDocumentState(pageName: 'Path Page');
      await fileSystem.initialize();
      await fileSystem.createFile(documentStateContentKey('hash-a'), byContent);
      await fileSystem.createFile('path/a', byPath);

      final loaded = await DocumentStateRepository(
        fileSystem,
      ).load(contentHash: 'hash-a', pathKey: 'path/a');

      expect(loaded?.pageName, 'Path Page');
    });

    test('falls back to path when content hash is missing', () async {
      const byPath = PersistedDocumentState(pageName: 'Path Page');
      await fileSystem.initialize();
      await fileSystem.createFile('path/a', byPath);

      final loaded = await DocumentStateRepository(
        fileSystem,
      ).load(contentHash: 'missing', pathKey: 'path/a');

      expect(loaded?.pageName, 'Path Page');
    });

    test('returns null when no fingerprints match', () async {
      final loaded = await DocumentStateRepository(
        fileSystem,
      ).load(contentHash: 'missing', pathKey: 'path/missing');

      expect(loaded, isNull);
    });

    test('ignores unavailable remote state when opening offline', () async {
      final offlineFileSystem = _MockDocumentStateFileSystem();
      when(() => offlineFileSystem.initialize()).thenAnswer((_) async {});
      when(() => offlineFileSystem.getFile(any())).thenThrow(
        const NetworkException('Offline', type: NetworkErrorType.connection),
      );

      final loaded = await DocumentStateRepository(
        offlineFileSystem,
      ).load(contentHash: 'hash-a', pathKey: 'path/a');

      expect(loaded, isNull);
      verify(() => offlineFileSystem.getFile('path/a')).called(1);
      verifyNever(
        () => offlineFileSystem.getFile(documentStateContentKey('hash-a')),
      );
    });

    test('does not load or save when persistence is disabled', () async {
      const state = PersistedDocumentState(pageName: 'Page 1');
      await fileSystem.initialize();
      await fileSystem.createFile('path/a', state);

      final repository = DocumentStateRepository(
        fileSystem,
        settingsProvider: () =>
            const DocumentStatePersistenceSettings(enabled: false),
      );

      expect(await repository.load(pathKey: 'path/a'), isNull);
      await repository.save(
        const PersistedDocumentState(pageName: 'Changed'),
        pathKey: 'path/b',
        persistentChanged: true,
      );
      expect(await fileSystem.getFile('path/b'), isNull);
    });

    test('filters disabled categories on load', () async {
      final state = PersistedDocumentState(
        pageName: 'Page 1',
        locks: const PersistentLockState(lockZoom: true),
        areaNavigator: const PersistedAreaNavigatorState(create: false),
      );
      await fileSystem.initialize();
      await fileSystem.createFile('path/a', state);

      final loaded = await DocumentStateRepository(
        fileSystem,
        settingsProvider: () =>
            const DocumentStatePersistenceSettings(locks: false, areas: false),
      ).load(pathKey: 'path/a');

      expect(loaded?.pageName, 'Page 1');
      expect(loaded?.locks, const PersistentLockState());
      expect(loaded?.areaNavigator, const PersistedAreaNavigatorState());
    });

    test('preserves disabled categories on save', () async {
      final existing = PersistedDocumentState(
        pageName: 'Page 1',
        locks: const PersistentLockState(lockZoom: true),
      );
      await fileSystem.initialize();
      await fileSystem.createFile('path/a', existing);

      await DocumentStateRepository(
        fileSystem,
        settingsProvider: () =>
            const DocumentStatePersistenceSettings(locks: false),
      ).save(
        const PersistedDocumentState(
          pageName: 'Page 2',
          locks: PersistentLockState(lockLayer: true),
        ),
        pathKey: 'path/a',
        persistentChanged: true,
      );

      final saved = await fileSystem.getFile('path/a');
      expect(saved?.pageName, 'Page 2');
      expect(saved?.locks, existing.locks);
    });

    test('cleanup removes old and overflowing records', () async {
      final repository = DocumentStateRepository(
        fileSystem,
        settingsProvider: () => const DocumentStatePersistenceSettings(
          maxEntries: 2,
          maxAgeDays: 30,
        ),
      );
      await fileSystem.initialize();
      await fileSystem.createFile(
        'path/old',
        PersistedDocumentState(updatedAt: DateTime.utc(2026, 1)),
      );
      await fileSystem.createFile(
        'path/a',
        PersistedDocumentState(updatedAt: DateTime.utc(2026, 5, 1)),
      );
      await fileSystem.createFile(
        'path/b',
        PersistedDocumentState(updatedAt: DateTime.utc(2026, 5, 2)),
      );
      await fileSystem.createFile(
        'path/c',
        PersistedDocumentState(updatedAt: DateTime.utc(2026, 5, 3)),
      );

      await repository.cleanup(now: DateTime.utc(2026, 6, 1));

      expect(await fileSystem.getFile('path/old'), isNull);
      expect(await fileSystem.getFile('path/a'), isNull);
      expect(await fileSystem.getFile('path/b'), isNotNull);
      expect(await fileSystem.getFile('path/c'), isNotNull);
    });

    test('writes session state to content and path keys', () async {
      final transformCubit = TransformCubit(1);
      final cubit = EditorSessionCubit(
        repository: DocumentStateRepository(fileSystem),
        transformCubit: transformCubit,
        initialState: const PersistedDocumentState(pageName: 'Page 1'),
        pathKey: 'path/a',
        contentHash: 'hash-a',
      );

      cubit.updateNavigator(enabled: true, page: NavigatorPage.layers);
      await cubit.saveNow();

      final contentRecord = await fileSystem.getFile(
        documentStateContentKey('hash-a'),
      );
      final pathRecord = await fileSystem.getFile('path/a');
      expect(contentRecord?.pathKey, isNull);
      expect(contentRecord?.contentHash, isNull);
      expect(pathRecord?.pathKey, isNull);
      expect(pathRecord?.contentHash, isNull);
      expect(pathRecord?.navigator.enabled, isTrue);

      await cubit.close();
      await transformCubit.close();
    });

    test('writes session state to updated document identity', () async {
      final transformCubit = TransformCubit(1);
      final cubit = EditorSessionCubit(
        repository: DocumentStateRepository(fileSystem),
        transformCubit: transformCubit,
        initialState: const PersistedDocumentState(pageName: 'Page 1'),
        pathKey: 'path/old',
        contentHash: 'hash-old',
      );

      cubit.updateNavigator(enabled: true);
      await cubit.saveNow();
      await cubit.saveNow(pathKey: 'path/new');

      expect(await fileSystem.getFile('path/old'), isNull);
      final pathRecord = await fileSystem.getFile('path/new');
      final contentRecord = await fileSystem.getFile(
        documentStateContentKey('hash-old'),
      );
      expect(pathRecord?.pathKey, isNull);
      expect(pathRecord?.contentHash, isNull);
      expect(contentRecord?.pathKey, isNull);
      expect(contentRecord?.contentHash, isNull);
      expect(pathRecord?.navigator.enabled, isTrue);

      await cubit.close();
      await transformCubit.close();
    });

    test('rewrites state when document identity and state changed', () async {
      final transformCubit = TransformCubit(1);
      final cubit = EditorSessionCubit(
        repository: DocumentStateRepository(fileSystem),
        transformCubit: transformCubit,
        initialState: const PersistedDocumentState(pageName: 'Page 1'),
        pathKey: 'path/old',
        contentHash: 'hash-old',
      );

      cubit.updateNavigator(enabled: true);
      await cubit.saveNow(pathKey: 'path/new');

      expect(await fileSystem.getFile('path/old'), isNull);
      final pathRecord = await fileSystem.getFile('path/new');
      expect(pathRecord?.pathKey, isNull);
      expect(pathRecord?.navigator.enabled, isTrue);

      await cubit.close();
      await transformCubit.close();
    });

    test('renames content identity without leaving old content key', () async {
      final transformCubit = TransformCubit(1);
      final cubit = EditorSessionCubit(
        repository: DocumentStateRepository(fileSystem),
        transformCubit: transformCubit,
        initialState: const PersistedDocumentState(pageName: 'Page 1'),
        pathKey: 'path/a',
        contentHash: 'hash-old',
      );

      cubit.updateNavigator(enabled: true);
      await cubit.saveNow();
      await cubit.saveNow(contentHash: 'hash-new');

      expect(
        await fileSystem.getFile(documentStateContentKey('hash-old')),
        isNull,
      );
      final contentRecord = await fileSystem.getFile(
        documentStateContentKey('hash-new'),
      );
      final pathRecord = await fileSystem.getFile('path/a');
      expect(contentRecord?.contentHash, isNull);
      expect(pathRecord?.contentHash, isNull);
      expect(contentRecord?.navigator.enabled, isTrue);

      await cubit.close();
      await transformCubit.close();
    });

    test('camera changes stay in memory until session is flushed', () async {
      final transformCubit = TransformCubit(1);
      final cubit = EditorSessionCubit(
        repository: DocumentStateRepository(fileSystem),
        transformCubit: transformCubit,
        initialState: const PersistedDocumentState(pageName: 'Page 1'),
        pathKey: 'path/a',
        contentHash: 'hash-a',
      );

      transformCubit.teleport(const Offset(10, 20), 2);
      await Future<void>.delayed(const Duration(milliseconds: 300));

      expect(await fileSystem.getFile('path/a'), isNull);
      await cubit.saveNow();

      final saved = await fileSystem.getFile('path/a');
      expect(saved?.camera.positionX, 10);
      expect(saved?.camera.positionY, 20);
      expect(saved?.camera.zoom, 2);

      await cubit.close();
      await transformCubit.close();
    });

    test('does not modify document files when session state changes', () async {
      final documentSystem = buildMockDocumentFileSystem();
      final original = NoteFile(Uint8List.fromList([1, 2, 3]));
      await documentSystem.initialize();
      await documentSystem.createFile('/test.bfly', original);

      final transformCubit = TransformCubit(1);
      final cubit = EditorSessionCubit(
        repository: DocumentStateRepository(fileSystem),
        transformCubit: transformCubit,
        initialState: const PersistedDocumentState(pageName: 'Page 1'),
        pathKey: 'path/test',
        contentHash: 'hash-test',
      );

      cubit.updateAreaNavigator(create: false);
      await cubit.saveNow();

      final asset = await documentSystem.getAsset('/test.bfly');
      expect(asset, isA<FileSystemFile<NoteFile>>());
      expect(
        (asset as FileSystemFile<NoteFile>).data?.data,
        orderedEquals(original.data),
      );

      await cubit.close();
      await transformCubit.close();
    });

    test('close flushes unsaved session state', () async {
      final transformCubit = TransformCubit(1);
      final cubit = EditorSessionCubit(
        repository: DocumentStateRepository(fileSystem),
        transformCubit: transformCubit,
        initialState: const PersistedDocumentState(pageName: 'Page 1'),
        pathKey: 'path/a',
        contentHash: 'hash-a',
      );

      cubit.updateNavigator(enabled: true);
      expect(cubit.isDirty, isTrue);

      await cubit.close();

      final saved = await fileSystem.getFile('path/a');
      expect(saved?.navigator.enabled, isTrue);
      expect(saved?.contentHash, isNull);

      await transformCubit.close();
    });
  });
}
