import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/editor_session.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/persisted_document_state.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';

import '../helpers/mocks.dart';

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
        utilities: const UtilitiesState(lockZoom: true),
        selectedTool: const PersistedToolSelection(
          toolId: 'tool-a',
          toolIndex: 3,
        ),
        navigatorEnabled: true,
        navigatorPage: NavigatorPage.layers.name,
        currentLayer: 'layer-a',
        currentCollection: 'collection-a',
        invisibleLayers: {'hidden-a'},
        areaNavigatorCreate: false,
        updatedAt: DateTime.utc(2026),
      );

      final decoded = decodePersistedDocumentState(
        encodePersistedDocumentState(state),
      );

      expect(decoded, state);
    });

    test('uses schema defaults for sparse json', () {
      final state = PersistedDocumentState.fromJson(const {});

      expect(state.version, kPersistedDocumentStateVersion);
      expect(state.camera.zoom, 1);
      expect(state.utilities, const UtilitiesState());
      expect(state.navigatorPage, NavigatorPage.waypoints.name);
    });
  });

  group('EditorSessionCubit storage', () {
    late DocumentStateFileSystem fileSystem;

    setUp(() {
      fileSystem = buildMockDocumentStateFileSystem();
    });

    test('content hash match wins over path match', () async {
      const byContent = PersistedDocumentState(pageName: 'Content Page');
      const byPath = PersistedDocumentState(pageName: 'Path Page');
      await fileSystem.initialize();
      await fileSystem.createFile(documentStateContentKey('hash-a'), byContent);
      await fileSystem.createFile('path/a', byPath);

      final loaded = await EditorSessionCubit.load(
        fileSystem: fileSystem,
        contentHash: 'hash-a',
        pathKey: 'path/a',
      );

      expect(loaded?.pageName, 'Content Page');
    });

    test('falls back to path when content hash is missing', () async {
      const byPath = PersistedDocumentState(pageName: 'Path Page');
      await fileSystem.initialize();
      await fileSystem.createFile('path/a', byPath);

      final loaded = await EditorSessionCubit.load(
        fileSystem: fileSystem,
        contentHash: 'missing',
        pathKey: 'path/a',
      );

      expect(loaded?.pageName, 'Path Page');
    });

    test('returns null when no fingerprints match', () async {
      final loaded = await EditorSessionCubit.load(
        fileSystem: fileSystem,
        contentHash: 'missing',
        pathKey: 'path/missing',
      );

      expect(loaded, isNull);
    });

    test('writes session state to content and path keys', () async {
      final transformCubit = TransformCubit(1);
      final cubit = EditorSessionCubit(
        fileSystem: fileSystem,
        transformCubit: transformCubit,
        initialState: const PersistedDocumentState(pageName: 'Page 1'),
        pathKey: 'path/a',
        contentHash: 'hash-a',
      );

      cubit.updateNavigator(enabled: true, page: NavigatorPage.layers);
      await cubit.saveNow();

      expect(
        (await fileSystem.getFile(
          documentStateContentKey('hash-a'),
        ))?.navigatorPage,
        NavigatorPage.layers.name,
      );
      final contentRecord = await fileSystem.getFile(
        documentStateContentKey('hash-a'),
      );
      final pathRecord = await fileSystem.getFile('path/a');
      expect(contentRecord?.pathKey, 'path/a');
      expect(contentRecord?.contentHash, 'hash-a');
      expect(pathRecord?.pathKey, 'path/a');
      expect(pathRecord?.contentHash, 'hash-a');
      expect(pathRecord?.navigatorEnabled, isTrue);

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
        fileSystem: fileSystem,
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
  });
}
