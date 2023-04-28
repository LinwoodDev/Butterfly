import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';

import '../../butterfly_text.dart';
import '../converter/note.dart';
import 'archive.dart';
import 'metadata.dart';
import 'pack.dart';
import 'page.dart';
import 'palette.dart';

class NoteData {
  final Archive archive;

  NoteData(this.archive);

  factory NoteData.fromData(Uint8List data) => NoteData(noteDataMigrator(data));

  NoteFileType? get type => getMetadata()?.type;

  Uint8List? getAsset(String path) {
    final file = archive.findFile(path);
    if (file == null) {
      return null;
    }
    return file.content;
  }

  void setAsset(String path, List<int> data) {
    archive.addFile(ArchiveFile(path, data.length, data));
  }

  List<String> getAssets(String path) {
    return archive.files
        .where((file) => file.name.startsWith(kPacksArchiveDirectory))
        .map((file) => file.name.substring(kPacksArchiveDirectory.length))
        .toList();
  }

  Uint8List? getThumbnail() => getAsset(kThumbnailArchiveFile);

  void setThumbnail(Uint8List uint8list) =>
      setAsset(kThumbnailArchiveFile, uint8list);

  FileMetadata? getMetadata() {
    final data = getAsset(kMetaArchiveFile);
    if (data == null) return null;
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return FileMetadata.fromJson(json);
  }

  void setMetadata(FileMetadata metadata) {
    final content = jsonEncode(metadata.toJson());
    setAsset(kMetaArchiveFile, utf8.encode(content));
  }

  // Document specific

  DocumentPage? getPage() {
    final data = getAsset('$kPagesArchiveDirectory/default.json');
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return DocumentPage.fromJson(json);
  }

  void setPage(DocumentPage page) {
    final content = jsonEncode(page.toJson());
    setAsset('$kPagesArchiveDirectory/default.json', utf8.encode(content));
  }

  Uint8List? getImage(String imageName) =>
      getAsset('$kImagesArchiveDirectory/$imageName');

  Uint8List? getFont(String fontName) =>
      getAsset('$kFontsArchiveDirectory/$fontName');

  NoteData? getPack(String packName) {
    final data = getAsset('$kPacksArchiveDirectory/$packName');
    if (data == null) {
      return null;
    }
    return NoteData.fromData(data);
  }

  void setPack(NoteData pack) {
    final data = ZipEncoder().encode(pack.archive);
    if (data != null) {
      setAsset(
          '$kPacksArchiveDirectory/${pack.getMetadata()?.name}.bfly', data);
    }
  }

  List<String> getPacks() => getAssets(kPacksArchiveDirectory);

  // Pack specific

  List<String> getComponents() => getAssets(kComponentsArchiveDirectory);

  ButterflyComponent? getComponent(String componentName) {
    final data = getAsset('$kComponentsArchiveDirectory/$componentName.json');
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return ButterflyComponent.fromJson(json);
  }

  void setComponent(ButterflyComponent component) {
    final content = jsonEncode(component.toJson());
    setAsset('$kComponentsArchiveDirectory/${component.name}.json',
        utf8.encode(content));
  }

  List<String> getStyles() => getAssets(kStylesArchiveDirectory);

  TextStyleSheet? getStyle(String styleName) {
    final data = getAsset('$kStylesArchiveDirectory/$styleName');
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return TextStyleSheet.fromJson(json);
  }

  void setStyle(TextStyleSheet style) {
    final content = jsonEncode(style.toJson());
    setAsset('$kStylesArchiveDirectory/${style.name}', utf8.encode(content));
  }

  List<String> getPalettes() => getAssets(kPalettesArchiveDirectory);

  ColorPalette? getPalette(String paletteName) {
    final data = getAsset('$kPalettesArchiveDirectory/$paletteName.json');
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return ColorPalette.fromJson(json);
  }

  void setPalette(ColorPalette palette) {
    final content = jsonEncode(palette.toJson());
    setAsset('$kPalettesArchiveDirectory/${palette.name}.json',
        utf8.encode(content));
  }
}
