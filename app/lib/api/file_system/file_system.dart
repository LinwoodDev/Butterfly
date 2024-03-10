import 'dart:async';
import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'file_system_dav.dart';
import 'file_system_io.dart';
import 'file_system_html_stub.dart'
    if (dart.library.js) 'file_system_html.dart';

const butterflySubDirectory = '/Linwood/Butterfly';

abstract class GeneralFileSystem {
  static String? dataPath;

  RemoteStorage? get remote => null;

  String convertNameToFile(String name) {
    return name.replaceAll(RegExp(r'[\\/:\*\?"<>\|\n\0-\x1F\x7F-\xFF]'), '_');
  }

  Future<String> _findAvailableName(
      String path, Future<bool> Function(String) hasAsset) async {
    final slashIndex = path.lastIndexOf('/');
    var dir = slashIndex < 0 ? '' : path.substring(0, slashIndex);
    if (dir.isNotEmpty) dir = '$dir/';
    final dotIndex = path.lastIndexOf('.');
    var ext = dotIndex < 0 ? '' : path.substring(dotIndex + 1);
    if (ext.isNotEmpty) ext = '.$ext';
    var name = dotIndex < 0
        ? path.substring(dir.length)
        : path.substring(slashIndex + 1, dotIndex);
    var newName = name;
    var i = 1;
    while (await hasAsset('$dir$newName$ext')) {
      newName = '$name ($i)';
      i++;
    }
    return '$dir$newName$ext';
  }

  FutureOr<String> getAbsolutePath(String relativePath) async {
    // Convert \ to /
    relativePath = relativePath.replaceAll('\\', '/');
    // Remove leading slash
    if (relativePath.startsWith('/')) {
      relativePath = relativePath.substring(1);
    }
    final root = await getDirectory();
    return '$root/$relativePath';
  }

  FutureOr<String> getDirectory() => '/';
}

(FileMetadata?, Uint8List?) _getFileDisplay(List<int> data) {
  FileMetadata? metadata;
  Uint8List? thumbnail;
  try {
    final archive = ZipDecoder().decodeBytes(data);

    try {
      final file = archive.findFile(kMetaArchiveFile);
      if (file != null) {
        final content = utf8.decode(file.content);
        metadata = FileMetadata.fromJson(jsonDecode(content));
      }
    } catch (_) {}

    try {
      final file = archive.findFile(kThumbnailArchiveFile);
      thumbnail = file?.content;
    } catch (_) {}
  } catch (_) {}

  return (metadata, thumbnail);
}

Future<AppDocumentFile> getAppDocumentFile(
    AssetLocation location, List<int> data,
    {bool cached = false, bool readMetadata = true}) async {
  final (metadata, thumbnail) =
      readMetadata ? await compute(_getFileDisplay, data) : (null, null);
  return AppDocumentFile(
    location,
    data: data,
    metadata: metadata,
    thumbnail: thumbnail,
    cached: cached,
  );
}

abstract class DocumentFileSystem extends GeneralFileSystem {
  Future<AppDocumentDirectory> getRootDirectory([bool recursive = false]) {
    return getAsset('', recursive ? null : true)
        .then((value) => value as AppDocumentDirectory);
  }

  @override
  FutureOr<String> getDirectory();

  /// If listFiles is null, it will fetch recursively
  Stream<AppDocumentEntity?> fetchAsset(String path, [bool? listFiles = true]);

  Stream<List<AppDocumentEntity>> fetchAssets(Stream<String> paths,
      [bool? listFiles = true]) {
    final files = <AppDocumentEntity>[];
    final streams = paths.asyncExpand((e) async* {
      int? index;
      await for (final file in fetchAsset(e, listFiles).whereNotNull()) {
        if (index == null) {
          index = files.length;
          files.add(file);
        } else {
          files[index] = file;
        }
        yield null;
      }
    });
    return streams.map((event) => files);
  }

  Stream<List<AppDocumentEntity>> fetchAssetsSync(Iterable<String> paths,
          [bool? listFiles = true]) =>
      fetchAssets(Stream.fromIterable(paths), listFiles);

  static Stream<List<AppDocumentEntity>> fetchAssetsGlobal(
      Stream<AssetLocation> locations, ButterflySettings settings,
      [bool? listFiles = true]) {
    final files = <AppDocumentEntity>[];
    final streams = locations.asyncExpand((e) async* {
      final fileSystem =
          DocumentFileSystem.fromPlatform(remote: settings.getRemote(e.remote));
      int? index;
      await for (final file
          in fileSystem.fetchAsset(e.path, listFiles).whereNotNull()) {
        if (index == null) {
          index = files.length;
          files.add(file);
        } else {
          files[index] = file;
        }
        yield null;
      }
    });
    return streams.map((event) => files);
  }

  static Stream<List<AppDocumentEntity>> fetchAssetsGlobalSync(
          Iterable<AssetLocation> locations, ButterflySettings settings,
          [bool? listFiles = true]) =>
      fetchAssetsGlobal(Stream.fromIterable(locations), settings, listFiles);

  Future<AppDocumentEntity?> getAsset(String path, [bool? listFiles = true]) =>
      fetchAsset(path, listFiles).last;

  Future<AppDocumentDirectory> createDirectory(String path);

  Future<void> updateFile(String path, List<int> data);

  Future<String> findAvailableName(String path) =>
      _findAvailableName(path, hasAsset);

  Future<AppDocumentFile?> createFile(String path, List<int> data) async {
    final uniquePath = await findAvailableName(path);
    return updateFile(uniquePath, data)
        .then((_) => getAppDocumentFile(AssetLocation.local(uniquePath), data));
  }

  Future<bool> hasAsset(String path);

  Future<void> deleteAsset(String path);

  Future<AppDocumentEntity?> renameAsset(String path, String newName) async {
    // Remove leading slash
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    if (newName.startsWith('/')) {
      newName = newName.substring(1);
    }
    final asset = await getAsset(path);
    if (asset == null) return null;
    final newPath = '${path.substring(0, path.lastIndexOf('/') + 1)}$newName';
    return moveAsset(path, newPath);
  }

  Future<AppDocumentEntity?> duplicateAsset(String path, String newPath) async {
    var asset = await getAsset(path);
    if (asset == null) return null;
    if (asset is AppDocumentFile) {
      return createFile(newPath, asset.data);
    } else if (asset is AppDocumentDirectory) {
      var newDir = await createDirectory(newPath);
      for (var child in asset.assets) {
        await duplicateAsset(
            '$path/${child.fileName}', '$newPath/${child.fileName}');
      }
      return newDir;
    }
    return null;
  }

  Future<AppDocumentEntity?> moveAsset(String path, String newPath) async {
    var asset = await duplicateAsset(path, newPath);
    if (asset == null) return null;
    if (path != newPath) await deleteAsset(path);
    return asset;
  }

  static DocumentFileSystem fromPlatform({final ExternalStorage? remote}) {
    if (kIsWeb) {
      return WebDocumentFileSystem();
    } else {
      return remote?.map(
            dav: (e) => DavRemoteDocumentFileSystem(e),
            local: (e) =>
                IODocumentFileSystem(e.fullDocumentsPath, remote.identifier),
          ) ??
          IODocumentFileSystem();
    }
  }

  Future<bool> moveAbsolute(String oldPath, String newPath) =>
      Future.value(false);

  Future<Uint8List?> loadAbsolute(String path) => Future.value(null);

  Future<void> saveAbsolute(String path, Uint8List bytes) => Future.value();

  Future<void> updateDocument(String path, NoteData document) async =>
      updateFile(path, await _exportDocument(document));

  Future<AppDocumentFile?> importDocument(NoteData document,
      {String path = '/'}) async {
    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    return createFile('$path/${convertNameToFile(document.name ?? '')}.bfly',
        await _exportDocument(document));
  }

  Future<List<int>> _exportDocument(NoteData document) =>
      compute((_) => document.save(), null);
}

abstract class TemplateFileSystem extends GeneralFileSystem {
  Future<bool> createDefault(BuildContext context, {bool force = false});

  Future<NoteData?> getTemplate(String name);
  Future<NoteData?> getDefaultTemplate(String name) async =>
      await getTemplate(name) ??
      await getTemplates().then((value) => value.firstOrNull);

  Future<String> findAvailableName(String path) =>
      _findAvailableName(path, hasTemplate);

  Future<NoteData> createTemplate(NoteData template) async {
    final metadata = template.getMetadata();
    if (metadata == null) return template;
    final name = await findAvailableName(metadata.name);
    template = template.setMetadata(metadata.copyWith(name: name));
    await updateTemplate(template);
    return template;
  }

  Future<bool> hasTemplate(String name);
  Future<void> updateTemplate(NoteData template);
  Future<void> deleteTemplate(String name);
  Future<List<NoteData>> getTemplates();

  Future<NoteData?> renameTemplate(String path, String newName) async {
    // Remove leading slash
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    var template = await getTemplate(path);
    if (template == null) return null;
    final metadata = template.getMetadata()?.copyWith(name: newName);
    if (metadata == null) return null;
    template = template.setMetadata(metadata);
    final newTemplate = await createTemplate(template);
    await deleteTemplate(path);
    return newTemplate;
  }

  static TemplateFileSystem fromPlatform({ExternalStorage? remote}) {
    if (kIsWeb) {
      return WebTemplateFileSystem();
    } else {
      return remote?.map(
            dav: (e) => DavRemoteTemplateFileSystem(e),
            local: (e) => IOTemplateFileSystem(e.fullTemplatesPath),
          ) ??
          IOTemplateFileSystem();
    }
  }
}

Archive exportDirectory(AppDocumentDirectory directory) {
  final archive = Archive();
  void addToArchive(AppDocumentEntity asset) {
    if (asset is AppDocumentFile) {
      final data = asset.data;
      final size = data.length;
      final file = ArchiveFile(asset.pathWithoutLeadingSlash, size, data);
      archive.addFile(file);
    } else if (asset is AppDocumentDirectory) {
      var assets = asset.assets;
      for (var current in assets) {
        addToArchive(current);
      }
    }
  }

  addToArchive(directory);
  return archive;
}

abstract class PackFileSystem extends GeneralFileSystem {
  Future<bool> createDefault(BuildContext context, {bool force = false});

  Future<String> findAvailableName(String path) =>
      _findAvailableName(path, hasPack);

  Future<NoteData?> getPack(String name);

  Future<NoteData> createPack(NoteData pack) async {
    final metadata = pack.getMetadata();
    if (metadata == null) return pack;
    final newName = await findAvailableName(metadata.name);
    pack = pack.setMetadata(metadata.copyWith(name: newName));
    updatePack(pack);
    return pack;
  }

  Future<bool> hasPack(String name);
  Future<void> updatePack(NoteData pack);
  Future<void> deletePack(String name);
  Future<List<NoteData>> getPacks();

  Future<NoteData?> renamePack(String path, String newName) async {
    // Remove leading slash
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    var pack = await getPack(path);
    final metadata = pack?.getMetadata();
    if (pack == null || metadata == null) return null;
    await deletePack(path);
    pack = pack.setMetadata(metadata.copyWith(name: newName));
    await updatePack(pack);
    return pack;
  }

  static PackFileSystem fromPlatform({ExternalStorage? remote}) {
    if (kIsWeb) {
      return WebPackFileSystem();
    } else {
      return remote?.map(
            dav: (e) => DavRemotePackFileSystem(e),
            local: (e) => IOPackFileSystem(e.fullPacksPath),
          ) ??
          IOPackFileSystem();
    }
  }
}
