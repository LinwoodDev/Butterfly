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
  (String?, NoteDisplay)? _display;

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

  NoteDisplay? display({String? password}) {
    if (_display != null && _display?.$1 == password) {
      return _display?.$2;
    }
    if (_data != null && _data?.$1 == password) {
      return _data?.$2;
    }
    try {
      final display = SimpleNoteDisplay.fromData(data, password: password);
      _display = (password, display);
      return display;
    } catch (_) {
      return null;
    }
  }
}

abstract class NoteDisplay<T> extends ArchiveData<T> {
  NoteDisplay(super.archive, {super.state});
  NoteDisplay.build(super.archive, {super.password}) : super.build();

  NoteFileType? get type => getMetadata()?.type;

  String? get name => getMetadata()?.name;

  bool get isValid {
    try {
      return getAsset(kMetaArchiveFile) != null;
    } catch (_) {
      return false;
    }
  }

  Uint8List? _thumbnail;
  bool _thumbnailLoaded = false;

  @useResult
  Uint8List? getThumbnail() {
    if (_thumbnailLoaded) return _thumbnail;
    try {
      _thumbnail = getAsset(kThumbnailArchiveFile);
      _thumbnailLoaded = true;
      return _thumbnail;
    } catch (_) {
      _thumbnailLoaded = true;
      return null;
    }
  }

  FileMetadata? _metadata;
  bool _metadataLoaded = false;

  @useResult
  FileMetadata? getMetadata() {
    if (_metadataLoaded) return _metadata;
    try {
      final data = getAsset(kMetaArchiveFile);
      if (data == null) {
        _metadataLoaded = true;
        return null;
      }
      final content = utf8.decode(data);
      if (content.isEmpty) {
        _metadataLoaded = true;
        return null;
      }
      final json = jsonDecode(content) as Map<String, dynamic>;
      _metadata = FileMetadata.fromJson(json);
      _metadataLoaded = true;
      return _metadata;
    } catch (_) {
      _metadataLoaded = true;
      return null;
    }
  }
}

class SimpleNoteDisplay extends NoteDisplay<SimpleNoteDisplay> {
  SimpleNoteDisplay(super.archive, {super.state});
  SimpleNoteDisplay.build(super.archive, {super.password}) : super.build();

  factory SimpleNoteDisplay.fromData(Uint8List data, {String? password}) {
    final archive = ZipDecoder().decodeBytes(data, password: password);
    return SimpleNoteDisplay.build(archive, password: password);
  }

  @override
  @useResult
  SimpleNoteDisplay updateState(ArchiveState state) =>
      SimpleNoteDisplay(archive, state: state);
}

final class NoteData extends NoteDisplay<NoteData> {
  NoteData(super.archive, {super.state});
  NoteData.build(super.archive, {super.password}) : super.build();

  factory NoteData.fromData(Uint8List data, {String? password}) {
    return noteDataMigrator(data, password: password);
  }

  factory NoteData.fromArchive(Archive archive, {String? password}) {
    return archiveNoteDataMigrator(archive);
  }

  factory NoteData.fromJson(dynamic json, {String? password}) =>
      NoteData.fromData(base64Decode(json as String), password: password);

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
  NoteData setThumbnail(Uint8List data) =>
      setAsset(kThumbnailArchiveFile, data);

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

  static String getPageNameFromRealName(String realName) {
    if (realName.contains('.')) {
      final split = realName.split('.');
      return split.sublist(1).join('.');
    }
    return realName;
  }

  @useResult
  String? _getPageFileName(String name) {
    final pages = getPages(true);
    if (pages.contains(name)) {
      return name;
    }
    for (final page in pages) {
      if (getPageNameFromRealName(page) == name) {
        return page;
      }
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
    final displayName = getPageNameFromRealName(pageName);
    var noteData = removeAsset('$kPagesArchiveDirectory/$pageName.json');
    noteData = noteData._realignPages(newIndex);
    // ignore: unused_result
    (noteData, _) = noteData.setPage(data, displayName, newIndex);
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

  String _findUniquePageName(String name, {String? excludeName}) {
    final existingNames = getPages().where((e) => e != excludeName).toSet();
    if (!existingNames.contains(name)) return name;
    var i = 2;
    var current = '$name $i';
    while (existingNames.contains(current)) {
      i++;
      current = '$name $i';
    }
    return current;
  }

  @useResult
  (NoteData, String) renamePage(String oldName, String newName) {
    final oldPageName = _getPageFileName(oldName);
    if (oldPageName == null) return (this, oldName);
    final page = getPage(oldPageName);
    final index = getPageIndex(oldPageName);
    if (page == null) return (this, oldPageName);
    final oldDisplayName = getPageNameFromRealName(oldPageName);
    final uniqueName = _findUniquePageName(
      newName,
      excludeName: oldDisplayName,
    );
    final noteData = removePage(oldPageName);
    return noteData.setPage(page, uniqueName, index);
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

  Iterable<String> getValidAssets() => validAssetPaths
      .expand((e) => getAssets(e).map((asset) => '$e/$asset'))
      .toList();

  Map<String, Uint8List> getAllAssets() {
    final Map<String, Uint8List> assets = {};
    for (final path in validAssetPaths) {
      for (final assetName in getAssets(path)) {
        final fullPath = '$path/$assetName';
        final data = getAsset(fullPath);
        if (data != null) {
          assets[fullPath] = data;
        }
      }
    }
    return assets;
  }

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
  Iterable<String> getToolbars() =>
      getAssets('$kToolbarsArchiveDirectory/', true);

  @useResult
  Iterable<NamedItem<Toolbar>> getNamedToolbars() => getToolbars().map((e) {
    final toolbar = getToolbar(e);
    if (toolbar == null) return null;
    return NamedItem<Toolbar>(name: e, item: toolbar);
  }).nonNulls;

  @useResult
  Toolbar? getToolbar(String toolbarName) {
    final data = getAsset('$kToolbarsArchiveDirectory/$toolbarName.json');
    if (data == null) {
      return null;
    }
    try {
      final content = utf8.decode(data);
      final json = jsonDecode(content) as Map<String, dynamic>;
      return Toolbar.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @useResult
  NoteData setToolbar(String name, Toolbar toolbar) {
    final content = jsonEncode(toolbar.toJson());
    return setAsset(
      '$kToolbarsArchiveDirectory/$name.json',
      utf8.encode(content),
    );
  }

  @useResult
  NoteData removeToolbar(String name) =>
      removeAsset('$kToolbarsArchiveDirectory/$name.json');

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
    final existingNames = getPages().toSet();
    late String current;

    if (name.isEmpty) {
      var i = 1;
      current = i.toString();
      while (existingNames.contains(current)) {
        i++;
        current = i.toString();
      }
      return setPage(page, current, index);
    }

    if (!existingNames.contains(name)) {
      return setPage(page, name, index);
    }

    var i = addNumber ? 1 : 2;
    current = '$name $i';
    while (existingNames.contains(current)) {
      i++;
      current = '$name $i';
    }

    return setPage(page, current, index);
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
