import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import '../converter/note.dart';
import '../models/archive.dart';
import '../models/metadata.dart';
import '../models/pack.dart';
import '../models/page.dart';

class ArchiveReader {
  final Archive archive;

  ArchiveReader(this.archive);

  factory ArchiveReader.fromData(Uint8List data) =>
      ArchiveReader(noteDataMigrator(data));

  NoteFileType? get type => getMetadata()?.type;

  Uint8List? getAsset(String path) => _getAsset(archive, path);

  static Uint8List? _getAsset(Archive archive, String path) {
    final file = archive.findFile(path);
    if (file == null) {
      return null;
    }
    return file.content;
  }

  void setAsset(String path, Uint8List data) => _setAsset(archive, path, data);

  static void _setAsset(Archive archive, String path, Uint8List data) {
    archive.addFile(ArchiveFile(path, data.length, data));
  }

  List<String> getAssets(String path) => _getAssets(archive, path);

  static List<String> _getAssets(Archive archive, String path) {
    return archive.files
        .where((file) => file.name.startsWith(kPacksArchiveDirectory))
        .map((file) => file.name.substring(kPacksArchiveDirectory.length))
        .toList();
  }

  Uint8List? getThumbnail() => getAsset(kThumbnailArchiveFile);

  FileMetadata? getMetadata() => _getMetadata(archive);

  static FileMetadata? _getMetadata(Archive archive) {
    final data = _getAsset(archive, kMetaArchiveFile);
    if (data == null) return null;
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return FileMetadata.fromJson(json);
  }

  // Document specific

  DocumentPage getPage() {
    final data = getAsset(kPagesArchiveDirectory);
    if (data == null) {
      throw Exception('No page file found');
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return DocumentPage.fromJson(json);
  }

  Uint8List? getImage(String imageName) =>
      getAsset('$kImagesArchiveDirectory/$imageName');

  Uint8List? getFont(String fontName) =>
      getAsset('$kFontsArchiveDirectory/$fontName');

  ArchiveReader? getPack(String packName) {
    final data = getAsset('$kPacksArchiveDirectory/$packName');
    if (data == null) {
      return null;
    }
    return ArchiveReader.fromData(data);
  }

  List<String> getPacks() => getAssets(kPacksArchiveDirectory);

  // Pack specific

  List<String> getComponents() => getAssets(kComponentsArchiveDirectory);
}
