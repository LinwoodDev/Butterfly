import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly_api/butterfly_api.dart';

class ArchiveDocumentReader {
  final Archive archive;

  ArchiveDocumentReader(this.archive);

  Uint8List? _getAsset(String path) {
    final file = archive.findFile(path);
    if (file == null) {
      return null;
    }
    return file.content;
  }

  FileMetadata getMetadata() {
    final data = _getAsset(kMetaArchiveFile);
    if (data == null) {
      throw Exception('No metadata file found');
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return FileMetadata.fromJson(json);
  }

  DocumentPage getPage() {
    final data = _getAsset(kPagesArchiveDirectory);
    if (data == null) {
      throw Exception('No page file found');
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return DocumentPage.fromJson(json);
  }

  Uint8List? getThumbnail() => _getAsset(kThumbnailArchiveFile);

  Uint8List? getImage(String imageName) =>
      _getAsset('$kImagesArchiveDirectory/$imageName');

  Uint8List? getFont(String fontName) =>
      _getAsset('$kFontsArchiveDirectory/$fontName');

  ButterflyPack? getPack(String packName) {
    final data = _getAsset('$kPacksArchiveDirectory/$packName');
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return ButterflyPack.fromJson(json);
  }

  List<String> getPacks() {
    final dir = archive.findFile(kPacksArchiveDirectory);
    if (dir == null) {
      throw Exception('No pack file found');
    }
    return archive.files
        .where((file) => file.name.startsWith(kPacksArchiveDirectory))
        .map((file) => file.name.substring(kPacksArchiveDirectory.length))
        .toList();
  }
}
