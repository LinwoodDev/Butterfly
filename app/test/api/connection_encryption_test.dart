import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';

void main() {
  const password = 'correct horse battery staple';
  const storage = DavRemoteStorage(
    username: 'user',
    url: 'https://example.com/dav',
    extra: {connectionEncryptionEnabledKey: true},
  );

  test('connection note data uses the same native encryption password', () {
    final document = DocumentDefaults.createDocument(name: 'Encrypted')
        .changePassword('source password');

    final encrypted = addConnectionPasswordToNoteData(
      storage,
      document,
      password: password,
    );
    final decoded = decodeConnectionNoteData(
      storage,
      encrypted.exportAsBytes(),
      password: password,
    );

    expect(encrypted.isEncrypted, isTrue);
    expect(encrypted.password, password);
    expect(decoded.isValid, isTrue);
    expect(decoded.password, password);
  });

  test('plaintext connection note data stays unencrypted when decoded', () {
    final document = DocumentDefaults.createDocument(name: 'Plaintext');

    final decoded = decodeConnectionNoteData(
      storage,
      document.exportAsBytes(),
      password: password,
    );

    expect(decoded.isValid, isTrue);
    expect(decoded.isEncrypted, isFalse);
    expect(decoded.password, isNull);
  });

  test(
    'connection password is added only to plaintext files on create',
    () async {
      final fileSystem = MockTypedDirectoryFileSystem<NoteFile>(
        onCreate: (file) =>
            addConnectionPasswordToNoteFile(storage, file, password: password),
        onEncode: encodeNoteFile,
        onDecode: decodeNoteFile,
      );
      final document = DocumentDefaults.createDocument(name: 'Encrypted');

      final created = await fileSystem.createFile(
        'document.bfly',
        document.toFile(),
      );
      expect(created.data?.isEncrypted(), isTrue);

      final decrypted = created.data!
          .load(password: password)!
          .changePassword(null)
          .toFile();
      await fileSystem.updateFile(created.path, decrypted);
      final updated = await fileSystem.getAsset(created.path);

      expect(
        (updated as FileSystemFile<NoteFile>).data?.isEncrypted(),
        isFalse,
      );
      expect(updated.data?.load()?.isValid, isTrue);

      final imported = document.changePassword('document password').toFile();
      final preserved = await fileSystem.createFile('imported.bfly', imported);
      expect(
        preserved.data?.load(password: 'document password')?.isValid,
        isTrue,
      );
    },
  );
}
