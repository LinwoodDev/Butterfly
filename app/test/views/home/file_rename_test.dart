import 'package:butterfly/views/files/entity.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/file_system.dart';
import '../../helpers/mocks.dart';

void main() {
  late MockButterflyFileSystem fileSystem;
  late MockSettingsCubit settingsCubit;

  setUpAll(() => registerFallbackValue(AssetLocation.empty));

  setUp(() {
    fileSystem = MockButterflyFileSystem();
    settingsCubit = configureFileSystemSettings(fileSystem);
  });

  Future<void> startRenaming(
    WidgetTester tester,
    FileSystemEntity<NoteFile> entity, {
    bool grid = false,
  }) async {
    await tester.pumpWidget(
      buildFileSystemTestApp(
        fileSystem: fileSystem,
        child: Center(
          child: FileEntityItem(
            entity: entity,
            gridView: grid,
            isMobile: false,
            onTap: () {},
            onReload: () => fail('Renaming must not reload the file view'),
            onChanged: (_) {},
            onSelected: (_) {},
          ),
        ),
      ),
    );
    await startFileRename(tester, find.byType(FileEntityItem));
  }

  String renameText(WidgetTester tester) =>
      tester.widget<TextField>(find.byType(TextField)).controller!.text;

  Future<void> saveRename(
    WidgetTester tester, {
    bool viaKeyboard = false,
  }) async {
    if (viaKeyboard) {
      await tester.testTextInput.receiveAction(TextInputAction.done);
    } else {
      await tester.tap(find.byTooltip('Save'));
    }
    await tester.pumpAndSettle();
  }

  for (final grid in [false, true]) {
    for (final submit in [false, true]) {
      for (final extension in ['bfly', 'tbfly']) {
        for (final name in ['Important note', 'Important note.bfly']) {
          testWidgets(
            '${grid ? 'grid' : 'list'} renames to "$name" via ${submit ? 'Enter' : 'button'} with fixed .$extension',
            (tester) async {
              final system = fileSystem.buildDocumentSystem();
              final entity = await createTestNote(
                system,
                '/notes/original.$extension',
              );
              await startRenaming(tester, entity, grid: grid);
              expect(renameText(tester), 'original');
              await tester.enterText(find.byType(TextField), name);
              await saveRename(tester, viaKeyboard: submit);

              final renamed = await system.getAsset('/notes/$name.$extension');
              expect(renamed, isA<FileSystemFile<NoteFile>>());
              expect(await system.getAsset('/notes/$name'), isNull);
              expect(await system.getAsset(entity.path), isNull);
              verify(
                () => settingsCubit.moveAssetReferences(
                  entity.location,
                  AssetLocation(path: '/notes/$name.$extension'),
                  directory: false,
                ),
              ).called(1);
            },
          );
        }
      }
    }

    testWidgets('${grid ? 'grid' : 'list'} keeps dots in folder names', (
      tester,
    ) async {
      final system = fileSystem.buildDocumentSystem();
      final entity = await system.createDirectory('/notes/folder.bfly');
      await createTestNote(system, '/notes/folder.bfly/Child.bfly');
      await startRenaming(tester, entity, grid: grid);
      expect(renameText(tester), 'folder.bfly');
      await tester.enterText(find.byType(TextField), 'Renamed.folder');
      await saveRename(tester);
      expect(
        await system.getAsset('/notes/Renamed.folder'),
        isA<FileSystemDirectory<NoteFile>>(),
      );
      expect(
        await system.getAsset('/notes/Renamed.folder/Child.bfly'),
        isA<FileSystemFile<NoteFile>>(),
      );
      verify(
        () => settingsCubit.moveAssetReferences(
          entity.location,
          const AssetLocation(path: '/notes/Renamed.folder'),
          directory: true,
        ),
      ).called(1);
    });
  }

  testWidgets('an empty rename keeps a valid text-note extension', (
    tester,
  ) async {
    final system = fileSystem.buildDocumentSystem();
    final entity = await createTestNote(system, '/notes/original.tbfly');
    await startRenaming(tester, entity);
    await tester.enterText(find.byType(TextField), '');
    await saveRename(tester);
    final referencesMoved = verify(
      () => settingsCubit.moveAssetReferences(
        entity.location,
        captureAny(),
        directory: false,
      ),
    );
    final renamed = referencesMoved.captured.single as AssetLocation;
    expect(renamed.fileType, AssetFileType.textNote);
    expect(renamed.fileNameWithoutExtension, isNotEmpty);
  });

  testWidgets('an unchanged name ending in .bfly keeps the complete filename', (
    tester,
  ) async {
    final system = fileSystem.buildDocumentSystem();
    final entity = await createTestNote(system, '/notes/original.bfly.bfly');
    await startRenaming(tester, entity);
    expect(renameText(tester), 'original.bfly');
    await saveRename(tester);
    expect(await system.getAsset(entity.path), isA<FileSystemFile<NoteFile>>());
    expect(await system.getAsset('/notes/original.bfly'), isNull);
    verifyNever(
      () => settingsCubit.moveAssetReferences(
        any(),
        any(),
        directory: any(named: 'directory'),
      ),
    );
  });
}
