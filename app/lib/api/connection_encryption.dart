import 'package:archive/archive.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lw_file_system/lw_file_system.dart';

const connectionEncryptionEnabledKey = 'butterfly:encryptionEnabled';
const _legacyEncryptionSignature = <int>[
  0x42,
  0x46,
  0x4c,
  0x59,
  0x45,
  0x31,
]; // BFLYE1
const _legacyEncryptionFileName = 'data';

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

String? _readNoteFilePassword(ExternalStorage? storage, NoteFile file) =>
    file.isEncrypted() ? readConnectionEncryptionPassword(storage) : null;

NoteData? loadConnectionNoteFile(ExternalStorage? storage, NoteFile file) =>
    file.load(password: _readNoteFilePassword(storage, file));

NoteDisplay? displayConnectionNoteFile(
  ExternalStorage? storage,
  NoteFile file,
) => file.display(password: _readNoteFilePassword(storage, file));

String _requireConnectionEncryptionPassword(RemoteStorage storage) {
  final password = connectionEncryptionPasswordStorage.read(storage);
  if (password == null) {
    throw const FormatException('Missing connection encryption password');
  }
  return password;
}

Uint8List encodeConnectionData(
  ExternalStorage? storage,
  Uint8List data, {
  String? password,
}) {
  if (storage is! RemoteStorage || !storage.isConnectionEncryptionEnabled) {
    return data;
  }
  password ??= _requireConnectionEncryptionPassword(storage);
  final archive = Archive()
    ..addFile(ArchiveFile.bytes(_legacyEncryptionFileName, data));
  final encrypted = ZipEncoder(
    password: password,
  ).encodeBytes(archive, autoClose: true);
  return Uint8List.fromList([..._legacyEncryptionSignature, ...encrypted]);
}

Uint8List decodeConnectionData(
  ExternalStorage? storage,
  Uint8List data, {
  String? password,
}) {
  if (data.length < _legacyEncryptionSignature.length ||
      !listEquals(
        data.sublist(0, _legacyEncryptionSignature.length),
        _legacyEncryptionSignature,
      )) {
    return data;
  }
  if (storage is! RemoteStorage || !storage.isConnectionEncryptionEnabled) {
    throw const FormatException('Missing connection encryption password');
  }
  password ??= _requireConnectionEncryptionPassword(storage);
  final archive = ZipDecoder().decodeBytes(
    data.sublist(_legacyEncryptionSignature.length),
    password: password,
  );
  final file = archive.findFile(_legacyEncryptionFileName);
  if (file == null || !file.isFile) {
    throw const FormatException('Invalid encrypted connection data');
  }
  return Uint8List.fromList(file.content as List<int>);
}

NoteFile addConnectionPasswordToNoteFile(
  ExternalStorage? storage,
  NoteFile file, {
  String? password,
}) {
  if (storage is! RemoteStorage || !storage.isConnectionEncryptionEnabled) {
    return file;
  }
  password ??= _requireConnectionEncryptionPassword(storage);
  var document = file.load(password: password);
  if (!(document?.isValid ?? false)) document = file.load();
  if (!(document?.isValid ?? false)) {
    throw const FormatException('Invalid document encryption password');
  }
  return document!.changePassword(password).toFile();
}

NoteFile decodeConnectionNoteFile(
  ExternalStorage? storage,
  Uint8List data, {
  String? password,
}) => NoteFile(decodeConnectionData(storage, data, password: password));

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
  password ??= readConnectionEncryptionPassword(storage);
  final decoded = decodeConnectionData(storage, data, password: password);
  final file = NoteFile(decoded);
  final note = NoteData.fromData(
    decoded,
    password: file.isEncrypted() ? password : null,
  );
  if (!note.isValid) {
    throw const FormatException('Invalid document encryption password');
  }
  return note;
}
