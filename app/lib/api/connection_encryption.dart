import 'dart:typed_data';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lw_file_system/lw_file_system.dart';

const connectionEncryptionEnabledKey = 'butterfly:encryptionEnabled';

extension ConnectionEncryptionStorageExtension on ExternalStorage {
  bool get isConnectionEncryptionEnabled =>
      extra[connectionEncryptionEnabledKey] == true;
}

class ConnectionEncryptionPasswordStorage {
  final FlutterSecureStorage secureStorage;
  final Map<String, String> _passwords = {};

  ConnectionEncryptionPasswordStorage({
    this.secureStorage = const FlutterSecureStorage(),
  });

  String _key(RemoteStorage storage) =>
      'connection-encryption ${storage.encodeIdentifier()}';

  String? read(RemoteStorage storage) => _passwords[storage.identifier];

  Future<void> preload(Iterable<ExternalStorage> storages) async {
    final encryptedStorages = storages.whereType<RemoteStorage>().where(
      (storage) => storage.isConnectionEncryptionEnabled,
    );
    await Future.wait(
      encryptedStorages.map((storage) async {
        final password = await secureStorage.read(key: _key(storage));
        if (password != null) _passwords[storage.identifier] = password;
      }),
    );
  }

  Future<void> write(RemoteStorage storage, String password) async {
    if (password.isEmpty) return delete(storage);
    _passwords[storage.identifier] = password;
    await secureStorage.write(key: _key(storage), value: password);
  }

  Future<void> delete(RemoteStorage storage) async {
    _passwords.remove(storage.identifier);
    await secureStorage.delete(key: _key(storage));
  }
}

final connectionEncryptionPasswordStorage =
    ConnectionEncryptionPasswordStorage();

String? readConnectionEncryptionPassword(ExternalStorage? storage) {
  if (storage is! RemoteStorage || !storage.isConnectionEncryptionEnabled) {
    return null;
  }
  return connectionEncryptionPasswordStorage.read(storage);
}

String? _noteFilePassword(
  ExternalStorage? storage,
  NoteFile file, {
  String? password,
}) {
  if (!file.isEncrypted()) return null;
  return password ?? readConnectionEncryptionPassword(storage);
}

NoteData? loadConnectionNoteFile(
  ExternalStorage? storage,
  NoteFile file, {
  String? password,
}) => file.load(password: _noteFilePassword(storage, file, password: password));

NoteDisplay? displayConnectionNoteFile(
  ExternalStorage? storage,
  NoteFile file,
) => file.display(password: _noteFilePassword(storage, file));

String _requireConnectionEncryptionPassword(RemoteStorage storage) {
  final password = connectionEncryptionPasswordStorage.read(storage);
  if (password == null) {
    throw const FormatException('Missing connection encryption password');
  }
  return password;
}

NoteFile addConnectionPasswordToNoteFile(
  ExternalStorage? storage,
  NoteFile file, {
  String? password,
}) {
  if (file.isEncrypted()) return file;
  if (storage is! RemoteStorage || !storage.isConnectionEncryptionEnabled) {
    return file;
  }
  password ??= _requireConnectionEncryptionPassword(storage);
  final document = loadConnectionNoteFile(storage, file, password: password);
  if (!(document?.isValid ?? false)) {
    throw const FormatException('Invalid document encryption password');
  }
  return document!.changePassword(password).toFile();
}

NoteData addConnectionPasswordToNoteData(
  ExternalStorage? storage,
  NoteData data, {
  String? password,
}) {
  if (storage is! RemoteStorage || !storage.isConnectionEncryptionEnabled) {
    return data;
  }
  password ??= _requireConnectionEncryptionPassword(storage);
  return data.changePassword(password);
}

NoteData decodeConnectionNoteData(
  ExternalStorage? storage,
  Uint8List data, {
  String? password,
}) {
  final note = loadConnectionNoteFile(
    storage,
    NoteFile(data),
    password: password,
  );
  if (!(note?.isValid ?? false)) {
    throw const FormatException('Invalid document encryption password');
  }
  return note!;
}
