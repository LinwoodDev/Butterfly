import 'package:archive/archive.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';

import '../helpers/mocks.dart';

void main() {
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
