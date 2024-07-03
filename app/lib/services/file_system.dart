import 'dart:typed_data';

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:lw_file_system/lw_file_system.dart';

NoteData _decode(Uint8List data) => NoteData.fromData(data);
Uint8List _encode(NoteData data) => Uint8List.fromList(data.save());

class FileSystemService {
  final SettingsCubit settingsCubit;
  final Map<String, TypedDirectoryFileSystem<NoteData>> document;
  final Map<String, TypedKeyFileSystem<NoteData>> template, pack;

  FileSystemService._({
    required this.settingsCubit,
    required TypedDirectoryFileSystem<NoteData> document,
    required TypedKeyFileSystem<NoteData> template,
    required TypedKeyFileSystem<NoteData> pack,
  })  : document = {'': document},
        template = {'': template},
        pack = {'': pack};

  static Future<FileSystemService> load() async {
    return FileSystemService._(
      document: TypedDirectoryFileSystem.build(
        config,
        onEncode: _encode,
        onDecode: _decode,
      ),
      template: TypedKeyFileSystem.build(
        config,
        onEncode: _encode,
        onDecode: _decode,
      ),
      pack: TypedKeyFileSystem.build(
        config,
        onEncode: _encode,
        onDecode: _decode,
      ),
    );
  }

  TypedDirectoryFileSystem<NoteData> getDocument([String identifier = '']) {
    final fileSystem = document[identifier];
    if (fileSystem != null) return fileSystem;
    final storage = settingsCubit.state.getRemote(identifier);
    return document[identifier] = TypedDirectoryFileSystem.build(
      config,
      storage: storage,
      onEncode: _encode,
      onDecode: _decode,
    );
  }
}
