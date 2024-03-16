import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly_api/src/converter/core.dart';
import 'package:butterfly_api/src/models/info.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../butterfly_text.dart';
import '../converter/note.dart';
import 'archive.dart';
import 'meta.dart';
import 'pack.dart';
import 'page.dart';
import 'palette.dart';

part 'data.g.dart';
part 'data.freezed.dart';

@freezed
class NoteDataState with _$NoteDataState {
  const factory NoteDataState([
    @Uint8ListJsonConverter()
    @Default(<String, Uint8List>{})
    Map<String, Uint8List> added,
    @Default(<String>[]) List<String> removed,
  ]) = _NoteDataState;

  factory NoteDataState.fromJson(dynamic json) => _$NoteDataStateFromJson(json);
}

final Set<String> validAssetPaths = {kImagesArchiveDirectory};

@immutable
class NoteData {
  final Archive archive;
  final NoteDataState state;

  NoteData(this.archive, [this.state = const NoteDataState()]);

  factory NoteData.fromData(Uint8List data, {bool disableMigrations = false}) {
    if (disableMigrations) {
      final archive = ZipDecoder().decodeBytes(data);
      return NoteData(archive);
    }
    return noteDataMigrator(data);
  }

  factory NoteData.fromJson(dynamic json) => NoteData.fromData(
        base64Decode(json as String),
      );

  Archive export() {
    final archive = Archive();
    for (final file in this.archive.files) {
      if (state.removed.contains(file.name) ||
          state.added.containsKey(file.name)) {
        continue;
      }
      archive.addFile(ArchiveFile(file.name, file.size, file.content));
    }
    for (final entry in state.added.entries) {
      archive.addFile(ArchiveFile(entry.key, entry.value.length, entry.value));
    }
    return archive;
  }

  NoteFileType? get type => getMetadata()?.type;

  String? get name => getMetadata()?.name;

  NoteData setName(String? value) {
    final meta = getMetadata();
    if (meta == null || value == null) return this;
    return setMetadata(meta.copyWith(name: value));
  }

  Uint8List? getAsset(String path) {
    if (state.removed.contains(path)) {
      return null;
    }
    if (state.added.containsKey(path)) {
      return state.added[path];
    }
    final file = archive.findFile(path);
    if (file == null) {
      return null;
    }
    return file.content;
  }

  @useResult
  NoteData _updateState(NoteDataState state) => NoteData(archive, state);

  @useResult
  NoteData setAsset(String path, List<int> data) => _updateState(
        state.copyWith(
          added: {
            ...state.added,
            path: Uint8List.fromList(data),
          },
          removed: state.removed.where((element) => element != path).toList(),
        ),
      );

  @useResult
  NoteData removeAsset(String path) => removeAssets([path]);

  @useResult
  NoteData removeAssets(List<String> path) => _updateState(
        state.copyWith(
          removed: [
            ...state.removed,
            ...path,
          ],
          added: Map.of(state.added)
            ..removeWhere((key, value) => path.contains(key)),
        ),
      );

  @useResult
  (NoteData, String) addAsset(String path, List<int> data, String fileExtension,
      [String name = '']) {
    final newPath = '$path/${findUniqueName(path, fileExtension, name)}';
    return (setAsset(newPath, data), newPath);
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

  @useResult
  Iterable<String> getAssets(String path, [bool removeExtension = false]) => {
        ...archive.files.map((e) => e.name),
        ...state.added.keys,
      }
          .where((e) => e.startsWith(path) && !state.removed.contains(e))
          .map((e) => e.substring(path.length))
          .map((e) {
        if (e.startsWith('/')) e = e.substring(1);
        if (!removeExtension) return e;
        final startExtension = e.lastIndexOf('.');
        if (startExtension == -1) return e;
        return e.substring(0, startExtension);
      });

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
  NoteData createDocument({String name = '', DateTime? createdAt}) {
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

  @useResult
  NoteData setPage(DocumentPage page, [String name = 'default', int? index]) {
    final pages = getPages();
    final newIndex = index ?? pages.length;
    final content = jsonEncode(page.toJson());
    var noteData = this;
    if (index != null) {
      noteData = _realignPages(index);
    }
    return noteData.setAsset(
        '$kPagesArchiveDirectory/${_getPageFileName(name) ?? '$newIndex.$name'}.json',
        utf8.encode(content));
  }

  @useResult
  NoteData _realignPages(int index) {
    final pagesOrder = _getPagesOrder();
    final nextPages =
        pagesOrder.where((element) => element.$1 >= index).toList();
    if (nextPages.isEmpty) return this;
    final nextPagesData = nextPages.map((e) => (e, getPage(e.$3))).toList();
    var noteData = this;
    noteData = noteData.removeAssets(
        nextPages.map((e) => '$kPagesArchiveDirectory/${e.$3}.json').toList());
    var nextIndex = index + 1;
    for (final ((_, lastName, _), data) in nextPagesData) {
      noteData = noteData.setAsset(
          '$kPagesArchiveDirectory/$nextIndex.$lastName.json',
          utf8.encode(jsonEncode(data?.toJson())));
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
    noteData = noteData.setPage(data, page, newIndex);
    return noteData;
  }

  @useResult
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

  @useResult
  List<String> getPages([bool realName = false]) =>
      _getPagesOrder().map((e) => realName ? e.$3 : e.$2).toList();

  @useResult
  int? getPageIndex(String page) =>
      _getPagesOrder().firstWhereOrNull((element) => element.$2 == page)?.$1;

  @useResult
  NoteData removePage(String page) => removeAssets(_getPagesOrder()
      .where((e) => e.$2 == page)
      .map((e) => '$kPagesArchiveDirectory/${e.$3}.json')
      .toList());

  @useResult
  NoteData renamePage(String oldName, String newName) {
    final page = getPage(oldName);
    final index = getPageIndex(oldName);
    if (page == null) return this;
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
    final json = jsonDecode(content) as Map<String, dynamic>;
    return DocumentInfo.fromJson(json);
  }

  @useResult
  NoteData setInfo(DocumentInfo info) {
    final content = jsonEncode(info.toJson());
    return setAsset(kInfoArchiveFile, utf8.encode(content));
  }

  (NoteData, String) addImage(Uint8List data, String fileExtension,
          [String name = '']) =>
      addAsset(kImagesArchiveDirectory, data, fileExtension, name);

  @useResult
  Uint8List? getFont(String fontName) =>
      getAsset('$kFontsArchiveDirectory/$fontName');

  @useResult
  NoteData? getPack(String packName) {
    final data = getAsset('$kPacksArchiveDirectory/$packName.bfly');
    if (data == null) {
      return null;
    }
    return NoteData.fromData(data);
  }

  @useResult
  NoteData setPack(NoteData pack, [String? name]) {
    final data = pack.save();
    return setAsset(
        '$kPacksArchiveDirectory/${name ?? pack.getMetadata()?.name}.bfly',
        data);
  }

  @useResult
  NoteData removePack(String name) =>
      removeAsset('$kPacksArchiveDirectory/$name.bfly');

  @useResult
  Iterable<String> getPacks() => getAssets(kPacksArchiveDirectory, true);

  // Pack specific

  @useResult
  Iterable<String> getComponents() =>
      getAssets(kComponentsArchiveDirectory, true);

  @useResult
  ButterflyComponent? getComponent(String componentName) {
    final data = getAsset('$kComponentsArchiveDirectory/$componentName.json');
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return ButterflyComponent.fromJson(json);
  }

  @useResult
  NoteData setComponent(ButterflyComponent component) => setAsset(
      '$kComponentsArchiveDirectory/${component.name}.json',
      utf8.encode(jsonEncode(component.toJson())));

  @useResult
  NoteData removeComponent(String name) =>
      removeAsset('$kComponentsArchiveDirectory/$name.json');

  @useResult
  Iterable<String> getStyles() => getAssets(kStylesArchiveDirectory, true);

  @useResult
  TextStyleSheet? getStyle(String styleName) {
    final data = getAsset('$kStylesArchiveDirectory/$styleName.json');
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return TextStyleSheet.fromJson(json);
  }

  @useResult
  NoteData setStyle(TextStyleSheet style) {
    final content = jsonEncode(style.toJson());
    return setAsset(
        '$kStylesArchiveDirectory/${style.name}.json', utf8.encode(content));
  }

  @useResult
  NoteData removeStyle(String name) =>
      removeAsset('$kStylesArchiveDirectory/$name.json');

  @useResult
  PackAssetLocation findStyle() {
    for (final pack in getPacks()) {
      final styles = getPack(pack)?.getStyles();
      if (styles?.isEmpty ?? true) continue;
      return PackAssetLocation(pack, styles!.first);
    }
    return PackAssetLocation.empty;
  }

  @useResult
  Iterable<String> getPalettes() => getAssets(kPalettesArchiveDirectory, true);

  @useResult
  ColorPalette? getPalette(String paletteName) {
    final data = getAsset('$kPalettesArchiveDirectory/$paletteName.json');
    if (data == null) {
      return null;
    }
    final content = utf8.decode(data);
    final json = jsonDecode(content) as Map<String, dynamic>;
    return ColorPalette.fromJson(json);
  }

  @useResult
  NoteData setPalette(ColorPalette palette) {
    final content = jsonEncode(palette.toJson());
    return setAsset('$kPalettesArchiveDirectory/${palette.name}.json',
        utf8.encode(content));
  }

  @useResult
  NoteData removePalette(String name) =>
      removeAsset('$kPalettesArchiveDirectory/$name.json');

  @useResult
  List<int> save() => ZipEncoder().encode(export())!;

  @useResult
  String toJson() {
    return base64Encode(save());
  }

  (NoteData, String) addPage(DocumentPage page, [int? index]) {
    var name = 'Page ${getPages().length + 1}';
    var i = 1;
    while (getPages().contains(name)) {
      name = 'Page ${i++}';
    }
    return (setPage(page, name, index), name);
  }

  NoteData undoDelete(String path) {
    final removed = state.removed.where((element) => element != path).toList();
    return _updateState(state.copyWith(removed: removed));
  }
}
