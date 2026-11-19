import 'dart:async';

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

class _Context extends Mock implements BuildContext {}

class _PackSystem extends TypedKeyFileSystem<NoteData> {
  _PackSystem()
    : super.raw(
        MockKeyFileSystem(),
        config: const MockFileSystemConfig(),
        onEncode: encodeNoteData,
        onDecode: decodeNoteData,
      );

  int reads = 0;
  Future<NoteData?> Function()? readOverride;

  @override
  Future<NoteData?> getFile(String key) {
    reads++;
    return readOverride?.call() ?? super.getFile(key);
  }
}

class _FileSystem extends ButterflyFileSystem {
  _FileSystem(SettingsCubit settings) : super(_Context(), settings);

  _PackSystem system = _PackSystem();

  @override
  PackFileSystem buildDefaultPackSystem({bool forceRecreate = false}) => system;

  @override
  PackFileSystem buildPackSystem([
    ExternalStorage? storage,
    bool forceRecreate = false,
  ]) => system;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late _FileSystem fileSystem;
  late StreamController<ButterflySettings> settingsChanges;
  late ButterflySettings settings;

  setUp(() {
    settings = const ButterflySettings();
    settingsChanges = StreamController.broadcast(sync: true);
    final cubit = MockSettingsCubit();
    when(() => cubit.state).thenAnswer((_) => settings);
    when(() => cubit.stream).thenAnswer((_) => settingsChanges.stream);
    fileSystem = _FileSystem(cubit);
    addTearDown(fileSystem.dispose);
    addTearDown(settingsChanges.close);
  });

  test(
    'inverted stylus resolves the core path eraser without a user pack',
    () async {
      final tool = await fileSystem.getToolPreset(
        InputMappingDefault.eraserPreset,
      );
      expect(
        tool,
        isA<EraserTool>().having((tool) => tool.mode, 'mode', EraserMode.path),
      );
    },
  );

  test(
    'loads current user presets and handles deleted presets and packs',
    () async {
      final system = fileSystem.buildDefaultPackSystem();
      await system.initialize();
      const location = PackAssetLocation('custom.bfly', 'eraser');
      final pack = NoteData(Archive())
          .setToolPreset('eraser', EraserTool(strokeWidth: 12));
      await system.createFile(location.namespace, pack);
      expect(
        await fileSystem.getToolPreset(location),
        EraserTool(strokeWidth: 12),
      );
      await fileSystem.updatePack(
        location,
        pack.setToolPreset('eraser', EraserTool(strokeWidth: 48)),
      );
      expect(
        await fileSystem.getToolPreset(location),
        EraserTool(strokeWidth: 48),
      );
      await fileSystem.updatePack(location, pack.removeToolPreset('eraser'));
      expect(await fileSystem.getToolPreset(location), isNull);
      await system.deleteFile(location.namespace);
      fileSystem.invalidateToolPresets();
      expect(await fileSystem.getToolPreset(location), isNull);
    },
  );

  test('core preset overrides are respected with inherited defaults', () async {
    final system = fileSystem.buildDefaultPackSystem();
    await system.initialize();
    final location = InputMappingDefault.eraserPreset;
    final tool = EraserTool(mode: EraserMode.path, strokeWidth: 64);
    await system.createFile(
      kCorePackFileName,
      NoteData(Archive()).setToolPreset(location.key, tool),
    );
    expect(await fileSystem.getToolPreset(location), tool);
    await fileSystem.updatePack(location, NoteData(Archive()));
    expect(await fileSystem.getToolPreset(location), isA<EraserTool>());
  });

  test(
    'shares pending loads and returns cached presets synchronously',
    () async {
      const location = PackAssetLocation('custom.bfly', 'eraser');
      final pending = Completer<NoteData?>();
      fileSystem.system.readOverride = () => pending.future;
      final first = fileSystem.getToolPreset(location);
      final second = fileSystem.getToolPreset(location);
      expect(second, same(first));
      final tool = EraserTool(strokeWidth: 32);
      pending.complete(
        NoteData(Archive())
            .setMetadata(
              const FileMetadata(
                type: NoteFileType.pack,
                name: 'Studio erasers',
              ),
            )
            .setToolPreset(location.key, tool),
      );
      expect(await first, tool);
      expect(fileSystem.getToolPreset(location), tool);
      expect(fileSystem.getToolPresetPackName(location), 'Studio erasers');
      expect(fileSystem.system.reads, 1);
    },
  );

  test('caches missing presets until pack changes invalidate them', () async {
    const location = PackAssetLocation('missing.bfly', 'eraser');
    expect(await fileSystem.getToolPreset(location), isNull);
    expect(fileSystem.getToolPreset(location), isNull);
    expect(fileSystem.system.reads, 1);
    final tool = EraserTool(strokeWidth: 24);
    await fileSystem.createPack(
      NoteData(Archive()).setToolPreset(location.key, tool),
      name: location.namespace,
    );
    expect(await fileSystem.getToolPreset(location), tool);
  });

  test('settings changes invalidate preset loads', () async {
    const location = PackAssetLocation('custom.bfly', 'eraser');
    await fileSystem.getToolPreset(location);
    expect(fileSystem.getToolPreset(location), isNull);
    settings = settings.copyWith(
      inputConfiguration: const InputConfiguration(
        invertedPen: InputMapping(1),
      ),
    );
    settingsChanges.add(settings);
    expect(fileSystem.getToolPreset(location), isA<Future<Tool?>>());
    await fileSystem.getToolPreset(location);
    expect(fileSystem.system.reads, 2);
  });

  test('switching pack systems keeps caches separate', () async {
    const location = PackAssetLocation('custom.bfly', 'eraser');
    await fileSystem.getToolPreset(location);
    final next = _PackSystem();
    await next.initialize();
    await next.createFile(
      location.namespace,
      NoteData(Archive()).setToolPreset(location.key, HandTool()),
    );
    fileSystem.system = next;
    expect(await fileSystem.getToolPreset(location), isA<HandTool>());
  });

  test('failed loads can be retried', () async {
    const location = PackAssetLocation('custom.bfly', 'eraser');
    fileSystem.system.readOverride = () =>
        Future.error(StateError('read failed'));
    await expectLater(fileSystem.getToolPreset(location), throwsStateError);
    fileSystem.system.readOverride = null;
    expect(await fileSystem.getToolPreset(location), isNull);
    expect(fileSystem.system.reads, 2);
  });

  test('invalidating a pending load does not cache its stale result', () async {
    const location = PackAssetLocation('custom.bfly', 'eraser');
    final pending = Completer<NoteData?>();
    fileSystem.system.readOverride = () => pending.future;
    final oldLoad = fileSystem.getToolPreset(location);
    // Allow the initial read to start before changing its source.
    await Future<void>.delayed(Duration.zero);
    fileSystem.invalidateToolPresets();
    fileSystem.system.readOverride = null;
    expect(await fileSystem.getToolPreset(location), isNull);
    pending.complete(
      NoteData(Archive()).setToolPreset(location.key, HandTool()),
    );
    expect(await oldLoad, isA<HandTool>());
    expect(fileSystem.getToolPreset(location), isNull);
    expect(fileSystem.system.reads, 2);
  });

  test('built-in presets have descriptive paths', () async {
    final core = await DocumentDefaults.getCorePack();
    final keys = core.getToolPresets().toList();
    expect(
      keys,
      containsAll([
        'pen',
        'eraser-stroke',
        'eraser-path',
        'select-lasso',
        'shape-circle',
      ]),
    );
    expect(keys.where((key) => key.startsWith('core-')), isEmpty);
  });

  test(
    'legacy core overrides load through old and descriptive paths',
    () async {
      final system = fileSystem.system;
      await system.initialize();
      final tool = EraserTool(mode: EraserMode.path, strokeWidth: 64);
      await system.createFile(
        kCorePackFileName,
        NoteData(Archive()).setToolPreset('core-7', tool),
      );
      const oldLocation = PackAssetLocation(kCorePackFileName, 'core-7');
      expect(await fileSystem.getToolPreset(oldLocation), tool);
      expect(fileSystem.getToolPreset(InputMappingDefault.eraserPreset), tool);
      final migrated = DocumentDefaults.migrateCoreToolPresets(
        NoteData(Archive()).setToolPreset('core-7', tool),
      );
      expect(migrated.getToolPresets(), contains('eraser-path'));
      expect(migrated.getToolPresets(), isNot(contains('core-7')));
      expect(migrated.getToolPreset('eraser-path'), tool);
    },
  );
}
