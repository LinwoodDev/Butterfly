import 'package:archive/archive.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

import '../helpers/mocks.dart';

void main() {
  testWidgets(
    'imported document titles cannot choose the destination directory',
    (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            LeapLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (value) {
              context = value;
              return const SizedBox();
            },
          ),
        ),
      );
      final source = DocumentDefaults.createDocument(name: '../outside');
      final fileSystem = buildMockDocumentFileSystem();
      final service = ImportService(
        context,
        path: 'imported',
        useDefaultStorage: false,
      );
      final importing = service.importArchive(
        source.exportAsBytes(),
        fileSystem: fileSystem,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ElevatedButton, 'OK'));
      await tester.pumpAndSettle();
      expect(await importing, isTrue);
      expect(await fileSystem.getAsset('outside'), isNull);
      expect(await fileSystem.getAsset('imported/.._outside'), isNotNull);
    },
  );

  for (final entry in [
    '../outside.bfly',
    'folder/../../outside.bfly',
    '/outside.bfly',
    r'..\outside.bfly',
    r'C:\outside.bfly',
    'C:outside.bfly',
    r'\\server\share\outside.bfly',
    'safe.bfly:outside.bfly',
  ]) {
    testWidgets('archive rejects unsafe entry $entry before writing files', (
      tester,
    ) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (value) {
              context = value;
              return const SizedBox();
            },
          ),
        ),
      );
      final source = DocumentDefaults.createDocument(name: 'Test').toFile();
      final archive = Archive()
        ..addFile(ArchiveFile.bytes('safe.bfly', source.data))
        ..addFile(ArchiveFile.bytes(entry, source.data));
      final fileSystem = buildMockDocumentFileSystem();
      final service = ImportService(
        context,
        path: 'imported',
        useDefaultStorage: false,
      );
      expect(
        await service.importArchive(
          ZipEncoder().encodeBytes(archive),
          fileSystem: fileSystem,
        ),
        isFalse,
      );
      expect(await fileSystem.getAsset('imported/safe.bfly'), isNull);
      expect(await fileSystem.getAsset('outside.bfly'), isNull);
      await tester.pumpAndSettle();
      expect(find.byType(Dialog), findsOneWidget);
    });
  }

  testWidgets(
    'archive import preserves encrypted documents without a password',
    (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (value) {
              context = value;
              return const SizedBox();
            },
          ),
        ),
      );

      final source = DocumentDefaults.createDocument(name: 'Encrypted')
          .changePassword('secret')
          .toFile();
      final archive = Archive()
        ..addFile(ArchiveFile.bytes('folder/encrypted.bfly', source.data));
      final bytes = ZipEncoder().encodeBytes(archive);
      final fileSystem = buildMockDocumentFileSystem();
      final service = ImportService(
        context,
        path: 'imported',
        useDefaultStorage: false,
      );

      expect(
        await service.importArchive(bytes, fileSystem: fileSystem),
        isTrue,
      );

      final imported = await fileSystem.getAsset(
        'imported/folder/encrypted.bfly',
      );
      expect(imported, isA<FileSystemFile<NoteFile>>());
      expect(
        (imported as FileSystemFile<NoteFile>).data?.data,
        orderedEquals(source.data),
      );
      expect(imported.data?.load(password: 'secret')?.isValid, isTrue);
      expect(find.byType(Dialog), findsNothing);
    },
  );
}
