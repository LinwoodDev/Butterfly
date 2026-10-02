import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Context extends Fake implements BuildContext {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
