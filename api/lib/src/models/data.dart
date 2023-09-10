import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly_api/src/models/info.dart';
import 'package:collection/collection.dart';
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

  factory NoteData.fromData(Uint8List data, {bool disableMigrations = false}) {
    if (disableMigrations) {
      final archive = ZipDecoder().decodeBytes(data);
      return NoteData(archive);
    }
    return noteDataMigrator(data);
  }

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

  void removeAsset(String path) => removeAssets([path]);

  void removeAssets(List<String> path) {
    final newArchive = Archive();
    for (final file in archive.files) {
      if (!path.contains(file.name)) {
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

  Iterable<String> getAssets(String path, [bool removeExtension = false]) =>
      archive.files
          .where((file) => file.name.startsWith(path))
          .map((file) => file.name.substring(path.length))
          .map((name) {
        if (name.startsWith('/')) name = name.substring(1);
        if (!removeExtension) return name;
        final startExtension = name.lastIndexOf('.');
        if (startExtension == -1) return name;
        return name.substring(0, startExtension);
      });

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

  NoteData createDocument({String name = '', DateTime? createdAt}) {
    final archive = Archive();
    for (var file in this.archive.files) {
      archive
          .addFile(ArchiveFile.noCompress(file.name, file.size, file.content));
    }
    final document = NoteData(archive);
    final metadata = getMetadata();
    createdAt ??= DateTime.now().toUtc();
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

  String? _getPageFileName(String name) {
    final pages = getPages(true);
    if (pages.contains(name)) {
      return name;
    }
    final fileName = pages
        .where((element) => element.split('.').sublist(1).join('.') == name)
        .firstOrNull;
    if (fileName != null) {
      return fileName;
    }
    return null;
  }

  DocumentPage? getPage([String name = 'default']) {
    final data = getAsset(
        '$kPagesArchiveDirectory/${_getPageFileName(name) ?? name}.json');
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return DocumentPage.fromJson(json);
  }

  void setPage(DocumentPage page, [String name = 'default', int? index]) {
    final pages = getPages();
    final newIndex = index ?? pages.length;
    final content = jsonEncode(page.toJson());
    if (index != null) {
      _realignPages(index);
    }
    setAsset(
        '$kPagesArchiveDirectory/${_getPageFileName(name) ?? '$newIndex.$name'}.json',
        utf8.encode(content));
  }

  void _realignPages(int index) {
    final pagesOrder = _getPagesOrder();
    final nextPages =
        pagesOrder.where((element) => element.$1 >= index).toList();
    if (nextPages.isEmpty) return;
    final nextPagesData = nextPages.map((e) => (e, getPage(e.$3))).toList();
    removeAssets(
        nextPages.map((e) => '$kPagesArchiveDirectory/${e.$3}.json').toList());
    var nextIndex = index + 1;
    for (final ((_, lastName, _), data) in nextPagesData) {
      setAsset('$kPagesArchiveDirectory/$nextIndex.$lastName.json',
          utf8.encode(jsonEncode(data?.toJson())));
      nextIndex++;
    }
  }

  void reoderPage(String page, [int? newIndex]) {
    newIndex ??= getPages().length;
    final pageName = _getPageFileName(page);
    final index = getPageIndex(page);
    final data = getPage(page);
    if (pageName == null ||
        index == null ||
        data == null ||
        index == newIndex) {
      return;
    }
    removeAsset('$kPagesArchiveDirectory/$pageName.json');
    _realignPages(newIndex);
    setPage(data, page, newIndex);
  }

  List<(int, String, String)> _getPagesOrder() =>
      getAssets(kPagesArchiveDirectory, true).map((e) {
        if (e.contains('.')) {
          final split = e.split('.');
          return (
            int.tryParse(split.first) ?? -1,
            split.sublist(1).join('.'),
            e
          );
        }
        return (-1, e, e);
      }).sorted((a, b) => a.$1.compareTo(b.$1));

  List<String> getPages([bool realName = false]) =>
      _getPagesOrder().map((e) => realName ? e.$3 : e.$2).toList();

  int? getPageIndex(String page) =>
      _getPagesOrder().firstWhereOrNull((element) => element.$2 == page)?.$1;

  void removePage(String page) => removeAssets(_getPagesOrder()
      .where((e) => e.$2 == page)
      .map((e) => '$kPagesArchiveDirectory/${e.$3}.json')
      .toList());

  void renamePage(String oldName, String newName) {
    final page = getPage(oldName);
    if (page == null) return;
    removePage(oldName);
    setPage(page, newName);
  }

  DocumentInfo? getInfo() {
    final data = getAsset(kInfoArchiveFile);
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return DocumentInfo.fromJson(json);
  }

  void setInfo(DocumentInfo info) {
    final content = jsonEncode(info.toJson());
    setAsset(kInfoArchiveFile, utf8.encode(content));
  }

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

  void setPack(NoteData pack, [String? name]) {
    final data = ZipEncoder().encode(pack.archive);
    if (data != null) {
      setAsset(
          '$kPacksArchiveDirectory/${name ?? pack.getMetadata()?.name}.bfly',
          data);
    }
  }

  void removePack(String name) =>
      removeAsset('$kPacksArchiveDirectory/$name.bfly');

  Iterable<String> getPacks() => getAssets(kPacksArchiveDirectory, true);

  // Pack specific

  Iterable<String> getComponents() =>
      getAssets(kComponentsArchiveDirectory, true);

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

  Iterable<String> getStyles() => getAssets(kStylesArchiveDirectory, true);

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

  Iterable<String> getPalettes() => getAssets(kPalettesArchiveDirectory, true);

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

  String addPage([DocumentPage? page, int? index]) {
    var name = 'Page ${getPages().length + 1}';
    var i = 1;
    while (getPages().contains(name)) {
      name = 'Page ${i++}';
    }
    setPage(
        page == null
            ? DocumentPage()
            : DocumentPage(backgrounds: page.backgrounds),
        name,
        index);
    return name;
  }
}
