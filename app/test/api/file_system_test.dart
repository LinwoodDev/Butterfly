import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/services/backup.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Context extends Fake implements BuildContext {}

class _ByteDocumentSystem extends DocumentFileSystem {
  _ByteDocumentSystem(MockFileSystem super.storage)
    : super.raw(
        config: storage.config,
        onDecode: decodeNoteFile,
        onEncode: encodeNoteFile,
        onCreate: (file) => NoteFile(Uint8List.fromList([...file.data, 3])),
      );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'local archive saves keep unique names and can overwrite a note',
    () async {
      final temp = await Directory.systemTemp.createTemp('butterfly_save_');
      addTearDown(() => temp.delete(recursive: true));
      SharedPreferences.setMockInitialValues({'document_path': temp.path});
      final settings = SettingsCubit(await SharedPreferences.getInstance());
      addTearDown(settings.close);
      final service = ButterflyFileSystem(_Context(), settings);
      addTearDown(service.dispose);
      final documents = service.buildDocumentSystem();
      final (note, pdf) = DocumentDefaults.createDocument(name: 'Study')
          .importPdf(Uint8List.fromList([1, 2, 3]));

      final first = await documents.createFileStreamWithName(
        note.exportAsStream(),
        name: 'Study',
        suffix: '.bfly',
      );
      final second = await documents.createFileStreamWithName(
        note.exportAsStream(),
        name: 'Study',
        suffix: '.bfly',
      );
      expect(second.path, isNot(first.path));
      final saved = await documents.saveFileStream(
        first.location,
        note.setName('Edited').exportAsStream(),
      );
      final file = await documents.getAsset(saved.path);
      final bytes = (file! as FileSystemFile<NoteFile>).data!.data;
      final restored = NoteData.fromData(bytes);
      expect(restored.name, 'Edited');
      expect(restored.getAsset(pdf), [1, 2, 3]);
      expect(
        (await Directory(
          '${temp.path}/Documents',
        ).list().toList()).whereType<Directory>(),
        isEmpty,
      );
    },
  );

  test(
    'stream saves preserve the byte backend and typed creation hook',
    () async {
      final storage = MockFileSystem();
      final documents = _ByteDocumentSystem(storage);
      final file = await documents.createFileStreamWithName(
        Stream.fromIterable([
          [1],
          [2],
        ]),
        name: 'Study',
        suffix: '.bfly',
      );
      expect((await storage.readAsset(file.path) as RawFileSystemFile).data, [
        1,
        2,
        3,
      ]);

      await documents.saveFileStream(
        file.location,
        Stream.fromIterable([
          [4],
          [5],
        ]),
      );
      expect((await storage.readAsset(file.path) as RawFileSystemFile).data, [
        4,
        5,
      ]);
    },
  );

  test('local backups are written inside the connection folder', () async {
    final temp = await Directory.systemTemp.createTemp('butterfly_backup_');
    addTearDown(() => temp.delete(recursive: true));
    final storage = LocalStorage(paths: {'': '${temp.path}/synced'});
    SharedPreferences.setMockInitialValues({
      'document_path': '${temp.path}/data',
      'connections': [storage.toJson()],
      'backup_remote': storage.identifier,
    });
    final settings = SettingsCubit(await SharedPreferences.getInstance());
    addTearDown(settings.close);
    final service = ButterflyFileSystem(_Context(), settings);
    addTearDown(service.dispose);
    final backupService = BackupService(service);
    addTearDown(backupService.dispose);
    final note = DocumentDefaults.createDocument(name: 'Test').toFile();
    await service.buildDocumentSystem().createFile('Test.bfly', note);

    final fileName = await backupService.backupNow();

    final bytes = await File('${storage.getBasePath()}/Backups/$fileName')
        .readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);
    expect(archive.findFile('Documents/Test.bfly')?.content, note.data);
    expect(settings.state.lastBackup, isNotNull);
  });

  test('empty storage paths disable only their directory types', () async {
    final temp = await Directory.systemTemp.createTemp('butterfly_disabled_');
    addTearDown(() => temp.delete(recursive: true));
    SharedPreferences.setMockInitialValues({});
    final settings = SettingsCubit(await SharedPreferences.getInstance());
    addTearDown(settings.close);
    final service = ButterflyFileSystem(_Context(), settings);
    addTearDown(service.dispose);
    final storage = LocalStorage(
      paths: {
        '': '${temp.path}/storage',
        'documents': '',
        'templates': '',
        'packs': '',
      },
    );
    final documents = service.buildDocumentSystem(storage);
    await documents.initialize(force: true);
    expect(await documents.getAsset('/note.bfly'), isNull);
    await expectLater(
      documents.createFile('/note.bfly', NoteFile(Uint8List(0))),
      throwsStateError,
    );
    await expectLater(documents.createDirectory('/folder'), throwsStateError);
    await expectLater(documents.deleteAsset('/note.bfly'), throwsStateError);
    var listened = false;
    Stream<List<int>> noteStream() async* {
      listened = true;
      yield [1];
    }

    await expectLater(
      documents.createFileStreamWithName(noteStream(), name: 'note'),
      throwsStateError,
    );
    expect(listened, isFalse);
    for (final system in [
      service.buildTemplateSystem(storage),
      service.buildPackSystem(storage),
    ]) {
      await system.initialize(force: true);
      expect(await system.getFiles(), isEmpty);
      await expectLater(
        Future.sync(() => system.updateFile('note', NoteData(Archive()))),
        throwsStateError,
      );
    }
    expect(await Directory(storage.getBasePath()).exists(), isFalse);
    final enabled = storage.copyWith(
      paths: {...storage.paths, 'templates': '.'},
    );
    await service.buildTemplateSystem(enabled).initialize();
    expect(await Directory(storage.getBasePath()).exists(), isTrue);
    expect(
      await Directory('${storage.getBasePath()}/Documents').exists(),
      isFalse,
    );
    expect(await Directory('${storage.getBasePath()}/Packs').exists(), isFalse);
  });
}
