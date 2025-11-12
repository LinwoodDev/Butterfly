import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lw_file_system_api/archive.dart';

import '../../butterfly_text.dart';
import '../converter/note.dart';
import '../converter/text.dart';
import 'archive.dart';
import 'info.dart';
import 'meta.dart';
import 'pack.dart';
import 'page.dart';

final Set<String> validAssetPaths = {
  kImagesArchiveDirectory,
  kPdfArchiveDirectory,
};

String getAssetFileName(String fileExtension, Uint8List data) {
  final hash = sha512256.convert(data);
  final name = hash.toString();
  return '$name.$fileExtension';
}

final class NoteFile {
  final Uint8List data;

  NoteFile(this.data);

  bool isEncrypted() => isZipEncrypted(data);

  (String?, NoteData)? _data;

  NoteData? load({String? password}) {
    if (_data != null && _data?.$1 == password) {
      return _data?.$2;
    }
    try {
      final data = NoteData.fromData(this.data, password: password);
      _data = (password, data);
      return data;
    } catch (_) {
      return null;
    }
  }
}

final class NoteData extends ArchiveData<NoteData> {
  NoteData(super.archive, {super.state});
  NoteData.build(super.archive, {super.password}) : super.build();

  factory NoteData.fromData(
    Uint8List data, {
    bool disableMigrations = false,
    String? password,
  }) {
    if (disableMigrations) {
      final archive = ZipDecoder().decodeBytes(data, password: password);
      return NoteData.build(archive, password: password);
    }
    return noteDataMigrator(data, password: password);
  }

  factory NoteData.fromArchive(
    Archive archive, {
    bool disableMigrations = false,
    String? password,
  }) {
    if (disableMigrations) {
      return NoteData.build(archive, password: password);
    }
    return archiveNoteDataMigrator(archive);
  }

  factory NoteData.fromJson(
    dynamic json, {
    bool disableMigrations = false,
    String? password,
  }) => NoteData.fromData(
    base64Decode(json as String),
    disableMigrations: disableMigrations,
    password: password,
  );

  NoteFileType? get type => getMetadata()?.type;

  String? get name => getMetadata()?.name;

  bool get isValid => getAsset(kMetaArchiveFile) != null;

  NoteData setName(String? value) {
    final meta = getMetadata();
    if (meta == null || value == null) return this;
    return setMetadata(meta.copyWith(name: value));
  }

  @override
  @useResult
  NoteData updateState(ArchiveState state) => NoteData(archive, state: state);

  @useResult
  (NoteData, String) importAsset(
    String path,
    Uint8List data,
    String fileExtension,
  ) {
    final newPath = '$path/${getAssetFileName(fileExtension, data)}';
    if (getAsset(newPath) != null) {
      return (this, newPath);
    }
    return (setAsset(newPath, data), newPath);
  }

  bool containsAsset(String path, Uint8List data, String fileExtension) {
    final assetPath = getAssetFileName(fileExtension, data);
    return getAssets(path).contains(assetPath);
  }

  String _getFileName(String name, String fileExtension) =>
      '$name${fileExtension.isNotEmpty ? '.$fileExtension' : ''}';

  String findUniqueName(String path, String fileExtension, [String name = '']) {
    final assets = getAssets('$path/');
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

  @useResult
  Uint8List? getThumbnail() => getAsset(kThumbnailArchiveFile);

  @useResult
  NoteData setThumbnail(Uint8List data) =>
      setAsset(kThumbnailArchiveFile, data);

  @useResult
  FileMetadata? getMetadata() {
    final data = getAsset(kMetaArchiveFile);
    if (data == null) return null;
    final content = utf8.decode(data);
    if (content.isEmpty) return null;
    final json = jsonDecode(content) as Map<String, dynamic>;
    return FileMetadata.fromJson(json);
  }

  @useResult
  NoteData setMetadata(FileMetadata metadata) =>
      setAsset(kMetaArchiveFile, utf8.encode(jsonEncode(metadata.toJson())));

  // Document specific

  @useResult
  NoteData createTemplate({
    String? name,
    String? description,
    String? directory,
    Uint8List? thumbnail,
  }) {
    // Copy archive
    final archive = export();
    var template = NoteData(archive);
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
    template = template.setMetadata(newMetadata);
    if (thumbnail != null) template = template.setThumbnail(thumbnail);
    return NoteData(template.export());
  }

  @useResult
  NoteData createDocument({
    String name = '',
    DateTime? createdAt,
    bool disablePages = false,
  }) {
    final archive = export();
    var document = NoteData(archive);
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
    document = document.setMetadata(newMetadata);
    if (disablePages) {
      for (final page in document.getPages(true)) {
        document = document.removePage(page);
      }
    }
    return document;
  }

  @useResult
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

  @useResult
  DocumentPage? getPage([String name = '']) {
    final data = getAsset(
      '$kPagesArchiveDirectory/${_getPageFileName(name) ?? name}.json',
    );
    if (data == null) {
      return null;
    }
    try {
      final content = utf8.decode(data);
      final json = jsonDecode(content) as Map<String, dynamic>;
      return DocumentPage.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @useResult
  (NoteData, String) setPage(
    DocumentPage page, [
    String name = '',
    int? index,
  ]) {
    return setRawPage(utf8.encode(jsonEncode(page.toJson())), name, index);
  }

  @useResult
  (NoteData, String) setRawPage(
    Uint8List content, [
    String name = '',
    int? index,
  ]) {
    final pages = getPages();
    final newIndex = index ?? pages.length;
    var noteData = this;
    if (index != null) {
      noteData = _realignPages(index);
    }
    final pageName = _getPageFileName(name) ?? '$newIndex.$name';
    return (
      noteData.setAsset('$kPagesArchiveDirectory/$pageName.json', content),
      pageName,
    );
  }

  @useResult
  NoteData _realignPages(int index) {
    final pagesOrder = _getPagesOrder();
    final nextPages = pagesOrder
        .where((element) => element.$1 >= index)
        .toList();
    if (nextPages.isEmpty) return this;
    final nextPagesData = nextPages.map((e) => (e, getPage(e.$3))).toList();
    var noteData = this;
    noteData = noteData.removeAssets(
      nextPages.map((e) => '$kPagesArchiveDirectory/${e.$3}.json').toList(),
    );
    var nextIndex = index + 1;
    for (final ((_, lastName, _), data) in nextPagesData) {
      noteData = noteData.setAsset(
        '$kPagesArchiveDirectory/$nextIndex.$lastName.json',
        utf8.encode(jsonEncode(data?.toJson())),
      );
      nextIndex++;
    }
    return noteData;
  }

  @useResult
  NoteData reorderPage(String page, [int? newIndex]) {
    newIndex ??= getPages().length;
    final pageName = _getPageFileName(page);
    final index = getPageIndex(page);
    final data = getPage(page);
    if (pageName == null ||
        index == null ||
        data == null ||
        index == newIndex) {
      return this;
    }
    var noteData = removeAsset('$kPagesArchiveDirectory/$pageName.json');
    noteData = noteData._realignPages(newIndex);
    // ignore: unused_result
    (noteData, _) = noteData.setPage(data, page, newIndex);
    return noteData;
  }

  @useResult
  List<(int, String, String)> _getPagesOrder() =>
      getAssets('$kPagesArchiveDirectory/', true)
          .map((e) {
            if (e.contains('.')) {
              final split = e.split('.');
              return (
                int.tryParse(split.first) ?? -1,
                split.sublist(1).join('.'),
                e,
              );
            }
            return (-1, e, e);
          })
          .sorted((a, b) => a.$1.compareTo(b.$1));

  @useResult
  List<String> getPages([bool realName = false]) =>
      _getPagesOrder().map((e) => realName ? e.$3 : e.$2).toList();

  @useResult
  List<(String, String)> getPagesWithNames() =>
      _getPagesOrder().map((e) => (e.$2, e.$3)).toList();

  @useResult
  int? getPageIndex(String page) =>
      _getPagesOrder().firstWhereOrNull((element) => element.$3 == page)?.$1;

  @useResult
  NoteData removePage(String page) => removeAssets(
    _getPagesOrder()
        .where((e) => e.$3 == page)
        .map((e) => '$kPagesArchiveDirectory/${e.$3}.json')
        .toList(),
  );

  @useResult
  (NoteData, String) renamePage(String oldName, String newName) {
    final page = getPage(oldName);
    final index = getPageIndex(oldName);
    if (page == null) return (this, oldName);
    final noteData = removePage(oldName);
    return noteData.setPage(page, newName, index);
  }

  @useResult
  DocumentInfo? getInfo() {
    final data = getAsset(kInfoArchiveFile);
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    try {
      final json = jsonDecode(content) as Map<String, dynamic>;
      return DocumentInfo.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @useResult
  NoteData setInfo(DocumentInfo info) {
    final content = jsonEncode(info.toJson());
    return setAsset(kInfoArchiveFile, utf8.encode(content));
  }

  Iterable<String> getValidAssets() =>
      validAssetPaths.expand((e) => getAssets(e)).toList();

  (NoteData, String) importImage(Uint8List data, String fileExtension) =>
      importAsset(kImagesArchiveDirectory, data, fileExtension);

  bool containsImage(Uint8List data, String fileExtension) =>
      containsAsset(kImagesArchiveDirectory, data, fileExtension);

  (NoteData, String) importPdf(Uint8List data) =>
      importAsset(kPdfArchiveDirectory, data, 'pdf');

  @useResult
  Uint8List? getFont(String fontName) =>
      getAsset('$kFontsArchiveDirectory/$fontName');

  @useResult
  Uint8List? getBundledPackData(String packName) =>
      getAsset('$kPacksArchiveDirectory/$packName.bfly');

  @useResult
  NoteData? getBundledPack(String packName) {
    final data = getBundledPackData(packName);
    if (data == null) {
      return null;
    }
    try {
      return NoteData.fromData(data);
    } catch (e) {
      return null;
    }
  }

  @useResult
  NoteData setBundledPack(NoteData pack, [String? name]) {
    final data = pack.exportAsBytes();
    return setAsset(
      '$kPacksArchiveDirectory/${name ?? pack.getMetadata()?.name}.bfly',
      data,
    );
  }

  @useResult
  NoteData removeBundledPack(String name) =>
      removeAsset('$kPacksArchiveDirectory/$name.bfly');

  @useResult
  Iterable<String> getBundledPacks() =>
      getAssets('$kPacksArchiveDirectory/', true);

  // Pack specific

  @useResult
  Iterable<String> getComponents() =>
      getAssets('$kComponentsArchiveDirectory/', true);

  @useResult
  Iterable<NamedItem<ButterflyComponent>> getNamedComponents() =>
      getComponents().map((e) {
        final component = getComponent(e);
        if (component == null) return null;
        return NamedItem<ButterflyComponent>(name: e, item: component);
      }).nonNulls;

  @useResult
  ButterflyComponent? getComponent(String componentName) {
    final data = getAsset('$kComponentsArchiveDirectory/$componentName.json');
    if (data == null) {
      return null;
    }
    try {
      final content = utf8.decode(data);
      final json = jsonDecode(content) as Map<String, dynamic>;
      return ButterflyComponent.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @useResult
  NoteData setComponent(String name, ButterflyComponent component) => setAsset(
    '$kComponentsArchiveDirectory/$name.json',
    utf8.encode(jsonEncode(component.toJson())),
  );

  @useResult
  NoteData removeComponent(String name) =>
      removeAsset('$kComponentsArchiveDirectory/$name.json');

  @useResult
  Iterable<String> getStyles() => getAssets('$kStylesArchiveDirectory/', true);

  @useResult
  Iterable<NamedItem<TextStyleSheet>> getNamedStyles() => getStyles().map((e) {
    final style = getStyle(e);
    if (style == null) return null;
    return NamedItem<TextStyleSheet>(name: e, item: style);
  }).nonNulls;

  @useResult
  TextStyleSheet? getStyle(String styleName) {
    final data = getAsset('$kStylesArchiveDirectory/$styleName.json');
    if (data == null) {
      return null;
    }
    try {
      final content = utf8.decode(data);
      final json = jsonDecode(content) as Map<String, dynamic>;
      return TextStyleSheet.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @useResult
  NoteData setStyle(String name, TextStyleSheet style) {
    final content = jsonEncode(style.toJson());
    return setAsset(
      '$kStylesArchiveDirectory/$name.json',
      utf8.encode(content),
    );
  }

  @useResult
  NoteData removeStyle(String name) =>
      removeAsset('$kStylesArchiveDirectory/$name.json');

  @useResult
  Iterable<String> getPalettes() =>
      getAssets('$kPalettesArchiveDirectory/', true);

  @useResult
  Iterable<NamedItem<ColorPalette>> getNamedPalettes() =>
      getPalettes().map((e) {
        final palette = getPalette(e);
        if (palette == null) return null;
        return NamedItem<ColorPalette>(name: e, item: palette);
      }).nonNulls;

  @useResult
  ColorPalette? getPalette(String paletteName) {
    final data = getAsset('$kPalettesArchiveDirectory/$paletteName.json');
    if (data == null) {
      return null;
    }
    try {
      final content = utf8.decode(data);
      final json = jsonDecode(content) as Map<String, dynamic>;
      return ColorPalette.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @useResult
  NoteData setPalette(String name, ColorPalette palette) {
    final content = jsonEncode(palette.toJson());
    return setAsset(
      '$kPalettesArchiveDirectory/$name.json',
      utf8.encode(content),
    );
  }

  @useResult
  NoteData removePalette(String name) =>
      removeAsset('$kPalettesArchiveDirectory/$name.json');

  @useResult
  String toJson() {
    return base64Encode(exportAsBytes());
  }

  (NoteData, String) addPage(
    DocumentPage page,
    String name, {
    int? index,
    bool addNumber = true,
  }) {
    var i = 1;
    String getName(int i) {
      if (i == 1 && !addNumber) {
        return name;
      }
      if (name.isEmpty) return i.toString();
      return '$name $i';
    }

    var current = getName(i);

    while (getPages().contains(current)) {
      current = 'Page ${i++}';
    }
    return setPage(page, name, index);
  }

  NoteData undoDelete(String path) {
    final removed = Set<String>.from(state.removed)..remove(path);
    return updateState(state.copyWith(removed: removed));
  }

  NoteFile toFile({bool isTextBased = false}) =>
      NoteFile(isTextBased ? exportAsTextBytes() : exportAsBytes());

  Map<String, dynamic> exportAsText() => convertDocumentToText(this);
  Uint8List exportAsTextBytes() =>
      utf8.encode(JsonEncoder.withIndent('\t').convert(exportAsText()));
}
