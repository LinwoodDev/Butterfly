import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:rxdart/rxdart.dart';

import '../../butterfly_text.dart';
import '../converter/note.dart';
import 'archive.dart';
import 'meta.dart';
import 'pack.dart';
import 'page.dart';
import 'palette.dart';

class NoteData {
  Archive archive;
  final BehaviorSubject<NoteData> _controller = BehaviorSubject();

  Stream<NoteData> get onChange => _controller.stream;

  NoteData(this.archive) {
    _controller.add(this);
  }

  factory NoteData.fromData(Uint8List data) => NoteData(noteDataMigrator(data));

  NoteFileType? get type => getMetadata()?.type;

  String? get name => getMetadata()?.name;

  set name(String? value) {
    final meta = getMetadata();
    if (meta == null || value == null) return;
    setMetadata(meta.copyWith(name: value));
  }

  Uint8List? getAsset(String path) {
    final file = archive.findFile(path);
    if (file == null) {
      return null;
    }
    return file.content;
  }

  void setAsset(String path, List<int> data) {
    archive.addFile(ArchiveFile.noCompress(path, data.length, data));
    _controller.add(this);
  }

  void removeAsset(String path) {
    final newArchive = Archive();
    for (final file in archive.files) {
      if (file.name != path) {
        newArchive.addFile(ArchiveFile(file.name, file.size, file.content));
      }
    }
    archive = newArchive;
    _controller.add(this);
  }

  String addAsset(String path, List<int> data, String fileExtension,
      [String name = '']) {
    final newPath = '$path/${findUniqueName(path, fileExtension, name)}';
    setAsset(newPath, data);
    return newPath;
  }

  String _getFileName(String name, String fileExtension) =>
      '$name${fileExtension.isNotEmpty ? '.$fileExtension' : ''}';

  String findUniqueName(String path, String fileExtension, [String name = '']) {
    final assets = getAssets(path);
    if (!assets.contains(_getFileName(name, fileExtension)) &&
        name.trim().isNotEmpty) {
      return _getFileName(name, fileExtension);
    }
    var i = 1;
    String getName() => _getFileName('$name ($i)', fileExtension).trim();
    while (assets.contains(getName())) {
      i++;
    }
    return getName();
  }

  List<String> getAssets(String path, [bool removeExtension = false]) {
    return archive.files
        .where((file) => file.name.startsWith(path))
        .map((file) => file.name.substring(path.length))
        .map((name) {
      if (name.startsWith('/')) name = name.substring(1);
      if (!removeExtension) return name;
      final startExtension = name.lastIndexOf('.');
      if (startExtension == -1) return name;
      return name.substring(0, startExtension);
    }).toList();
  }

  Uint8List? getThumbnail() => getAsset(kThumbnailArchiveFile);

  void setThumbnail(Uint8List data) => setAsset(kThumbnailArchiveFile, data);

  FileMetadata? getMetadata() {
    final data = getAsset(kMetaArchiveFile);
    if (data == null) return null;
    final content = utf8.decode(data);
    if (content.isEmpty) return null;
    final json = jsonDecode(content) as Map<String, dynamic>;
    return FileMetadata.fromJson(json);
  }

  void setMetadata(FileMetadata metadata) {
    final content = jsonEncode(metadata.toJson());
    setAsset(kMetaArchiveFile, utf8.encode(content));
  }

  // Document specific

  NoteData createTemplate({
    String? name,
    String? description,
    String? directory,
    Uint8List? thumbnail,
  }) {
    // Copy archive
    final archive = Archive();
    for (final file in this.archive.files) {
      archive.addFile(ArchiveFile(file.name, file.size, file.content));
    }
    final template = NoteData(archive);
    // Change metadata
    final metadata = getMetadata();
    final newMetadata = FileMetadata(
      type: NoteFileType.template,
      name: name ?? metadata?.name ?? '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      description: description ?? metadata?.description ?? '',
      fileVersion: kFileVersion,
      directory: directory ?? metadata?.directory ?? '',
    );
    template.setMetadata(newMetadata);
    if (thumbnail != null) template.setThumbnail(thumbnail);
    return NoteData(archive);
  }

  NoteData? createDocument({String name = '', DateTime? createdAt}) {
    final archive = Archive();
    for (var file in this.archive.files) {
      archive
          .addFile(ArchiveFile.noCompress(file.name, file.size, file.content));
    }
    final document = NoteData(archive);
    final metadata = getMetadata();
    createdAt ??= DateTime.now();
    final newMetadata = FileMetadata(
      type: NoteFileType.document,
      name: name,
      createdAt: createdAt,
      updatedAt: createdAt,
      description: metadata?.description ?? '',
      fileVersion: kFileVersion,
      directory: metadata?.directory ?? '',
    );
    document.setMetadata(newMetadata);
    return document;
  }

  DocumentPage? getPage([String name = 'default']) {
    final data = getAsset('$kPagesArchiveDirectory/$name.json');
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return DocumentPage.fromJson(json);
  }

  void setPage(DocumentPage page, [String name = 'default']) {
    final content = jsonEncode(page.toJson());
    setAsset('$kPagesArchiveDirectory/$name.json', utf8.encode(content));
  }

  List<String> getPages() => getAssets(kPagesArchiveDirectory, true);

  String addImage(Uint8List data, String fileExtension, [String name = '']) =>
      addAsset(kImagesArchiveDirectory, data, fileExtension, name);

  Uint8List? getFont(String fontName) =>
      getAsset('$kFontsArchiveDirectory/$fontName');

  NoteData? getPack(String packName) {
    final data = getAsset('$kPacksArchiveDirectory/$packName.bfly');
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

  void removePack(String name) =>
      removeAsset('$kPacksArchiveDirectory/$name.bfly');

  List<String> getPacks() => getAssets(kPacksArchiveDirectory, true);

  // Pack specific

  List<String> getComponents() => getAssets(kComponentsArchiveDirectory, true);

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

  void removeComponent(String name) =>
      removeAsset('$kComponentsArchiveDirectory/$name.json');

  List<String> getStyles() => getAssets(kStylesArchiveDirectory, true);

  TextStyleSheet? getStyle(String styleName) {
    final data = getAsset('$kStylesArchiveDirectory/$styleName.json');
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return TextStyleSheet.fromJson(json);
  }

  void setStyle(TextStyleSheet style) {
    final content = jsonEncode(style.toJson());
    setAsset(
        '$kStylesArchiveDirectory/${style.name}.json', utf8.encode(content));
  }

  void removeStyle(String name) =>
      removeAsset('$kStylesArchiveDirectory/$name.json');

  List<String> getPalettes() => getAssets(kPalettesArchiveDirectory, true);

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

  void removePalette(String name) =>
      removeAsset('$kPalettesArchiveDirectory/$name.json');

  List<int> save() => ZipEncoder().encode(archive)!;
}
