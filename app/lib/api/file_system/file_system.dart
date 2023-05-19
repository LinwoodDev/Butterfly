import 'dart:async';
import 'package:archive/archive.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'file_system_dav.dart';
import 'file_system_io.dart';
import 'file_system_html_stub.dart'
    if (dart.library.js) 'file_system_html.dart';

abstract class GeneralFileSystem {
  static String? dataPath;

  RemoteStorage? get remote => null;

  String convertNameToFile(String name) {
    return '${name.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.bfly';
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

  FutureOr<String> getDirectory() {
    return '/';
  }
}

abstract class DocumentFileSystem extends GeneralFileSystem {
  Future<AppDocumentDirectory> getRootDirectory() {
    return getAsset('').then((value) => value as AppDocumentDirectory);
  }

  @override
  FutureOr<String> getDirectory();

  Future<AppDocumentEntity?> getAsset(String path);

  Future<AppDocumentDirectory> createDirectory(String path);

  Future<AppDocumentFile> updateFile(String path, List<int> data);

  Future<String> findAvailableName(String path) =>
      _findAvailableName(path, hasAsset);

  Future<AppDocumentFile> createFile(String path, List<int> data) async =>
      updateFile(await findAvailableName(path), data);

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

  static DocumentFileSystem fromPlatform({final RemoteStorage? remote}) {
    if (kIsWeb) {
      return WebDocumentFileSystem();
    } else {
      return remote?.map(dav: (e) => DavRemoteDocumentFileSystem(e)) ??
          IODocumentFileSystem();
    }
  }

  Future<bool> moveAbsolute(String oldPath, String newPath) =>
      Future.value(false);

  Future<Uint8List?> loadAbsolute(String path) => Future.value(null);

  Future<void> saveAbsolute(String path, Uint8List bytes) => Future.value();

  Future<AppDocumentFile> updateDocument(String path, NoteData document) =>
      updateFile(path, document.save());

  Future<AppDocumentFile> importDocument(NoteData document,
      {String path = '/'}) {
    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    return createFile('$path/${document.name}.bfly', document.save());
  }
}

abstract class TemplateFileSystem extends GeneralFileSystem {
  Future<bool> createDefault(BuildContext context, {bool force = false});

  Future<NoteData?> getTemplate(String name);

  Future<String> findAvailableName(String path) =>
      _findAvailableName(path, hasTemplate);

  Future<NoteData> createTemplate(NoteData template) async {
    final metadata = template.getMetadata();
    if (metadata == null) return template;
    final name = await findAvailableName(metadata.name);
    template.setMetadata(metadata.copyWith(name: name));
    updateTemplate(template);
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
    final template = await getTemplate(path);
    if (template == null) return null;
    final metadata = template.getMetadata()?.copyWith(name: newName);
    if (metadata == null) return null;
    template.setMetadata(metadata);
    final newTemplate = await createTemplate(template);
    await deleteTemplate(path);
    return newTemplate;
  }

  static TemplateFileSystem fromPlatform({RemoteStorage? remote}) {
    if (kIsWeb) {
      return WebTemplateFileSystem();
    } else {
      return remote?.map(dav: (e) => DavRemoteTemplateFileSystem(e)) ??
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
    pack.setMetadata(metadata.copyWith(name: newName));
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
    final pack = await getPack(path);
    final metadata = pack?.getMetadata();
    if (pack == null || metadata == null) return null;
    await deletePack(path);
    pack.setMetadata(metadata.copyWith(name: newName));
    await updatePack(pack);
    return pack;
  }

  static PackFileSystem fromPlatform({RemoteStorage? remote}) {
    if (kIsWeb) {
      return WebPackFileSystem();
    } else {
      return remote?.map(dav: (e) => DavRemotePackFileSystem(e)) ??
          IOPackFileSystem();
    }
  }
}
