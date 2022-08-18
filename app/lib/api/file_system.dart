import 'dart:async';
import 'dart:typed_data';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/palette.dart';
import 'package:butterfly/models/template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

import 'file_system_io.dart';
import 'file_system_html.dart';
import 'file_system_remote.dart';

abstract class GeneralFileSystem {
  RemoteStorage? get remote => null;

  String convertNameToFile(String name) {
    return '${name.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}.bfly';
  }

  FutureOr<String> getAbsolutePath(String relativePath) async {
    // Convert \ to /
    relativePath = relativePath.replaceAll('\\', '/');
    // Remove leading slash
    if (relativePath.startsWith('/')) {
      relativePath = relativePath.substring(1);
    }
    final root = await getDirectory();
    var absolutePath = path.join(root, relativePath);
    if (!absolutePath.startsWith(root)) {
      throw Exception('Path is not in root directory');
    }
    return absolutePath;
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
  FutureOr<String> getDirectory() async {
    var prefs = await SharedPreferences.getInstance();
    String? path;
    if (prefs.containsKey('document_path')) {
      path = prefs.getString('document_path');
    }
    if (path == '') {
      path = null;
    }
    path ??= await getButterflyDirectory();
    // Convert \ to /
    path = path.replaceAll('\\', '/');
    path += '/Templates';
    return path;
  }

  Future<AppDocumentAsset?> getAsset(String path);

  Future<AppDocumentDirectory> createDirectory(String name);

  Future<AppDocumentFile> createDocument(String name,
          {String path = '/', List<ColorPalette> palettes = const []}) =>
      importDocument(
          AppDocument(
              name: name, palettes: palettes, createdAt: DateTime.now()),
          path: path);

  Future<bool> hasAsset(String path);

  Future<AppDocumentFile> updateDocument(String path, AppDocument document);

  Future<void> deleteAsset(String path);

  Future<AppDocumentFile> importDocument(AppDocument document,
      {String path = '/'});

  Future<AppDocumentAsset?> renameAsset(String path, String newName) async {
    // Remove leading slash
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    final asset = await getAsset(path);
    if (asset == null) return null;
    AppDocumentAsset? newAsset;
    if (asset is AppDocumentFile) {
      newAsset = await updateDocument(newName, asset.load());
    } else {
      newAsset = await createDirectory(newName);
      var assets = (asset as AppDocumentDirectory).assets;
      for (var current in assets) {
        var currentPath = current.pathWithoutLeadingSlash;
        final newPath = newName + currentPath.substring(path.length);
        await renameAsset(currentPath, newPath);
      }
    }
    await deleteAsset(path);
    return newAsset;
  }

  static DocumentFileSystem fromPlatform({final RemoteStorage? remote}) {
    if (kIsWeb) {
      return WebDocumentFileSystem();
    } else {
      if (remote is DavRemoteStorage) {
        return DavRemoteDocumentFileSystem(remote);
      }
      return IODocumentFileSystem();
    }
  }

  Future<AppDocumentAsset?> duplicateAsset(String path, String newPath) async {
    var asset = await getAsset(path);
    if (asset == null) return null;
    if (asset is AppDocumentFile) {
      return updateDocument(newPath, asset.load());
    } else {
      var newDirectory = await createDirectory(newPath);
      var assets = (asset as AppDocumentDirectory).assets;
      for (var current in assets) {
        var currentPath = current.pathWithoutLeadingSlash;
        final currentNewPath = newPath + currentPath.substring(path.length);
        await duplicateAsset(currentPath, currentNewPath);
      }
      return newDirectory;
    }
  }

  Future<AppDocumentAsset?> moveAsset(String path, String newPath) async {
    var asset = await duplicateAsset(path, newPath);
    if (asset == null) return null;
    if (path != newPath) await deleteAsset(path);
    return asset;
  }

  Future<bool> moveAbsolute(String oldPath, String newPath) =>
      Future.value(false);

  Future<Uint8List?> loadAbsolute(String path) => Future.value(null);

  Future<void> saveAbsolute(String path, Uint8List bytes) => Future.value();
}

abstract class TemplateFileSystem extends GeneralFileSystem {
  Future<bool> createDefault(BuildContext context, {bool force = false});

  Future<DocumentTemplate?> getTemplate(String name);
  Future<DocumentTemplate> createTemplate(AppDocument document) async {
    var template = DocumentTemplate(document: document);
    var name = document.name;
    var attemps = 1;
    while (await hasTemplate(name)) {
      name = '${document.name} ($attemps)';
      attemps++;
    }
    template =
        template.copyWith(document: template.document.copyWith(name: name));
    updateTemplate(template);
    return template;
  }

  Future<bool> hasTemplate(String name);
  Future<void> updateTemplate(DocumentTemplate template);
  Future<void> deleteTemplate(String name);
  Future<List<DocumentTemplate>> getTemplates();

  Future<DocumentTemplate?> renameTemplate(String path, String newName) async {
    // Remove leading slash
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    final template = await getTemplate(path);
    if (template == null) return null;
    DocumentTemplate? newTemplate =
        await createTemplate(template.document.copyWith(name: newName));
    await deleteTemplate(path);
    return newTemplate;
  }

  static TemplateFileSystem fromPlatform({RemoteStorage? remote}) {
    if (kIsWeb) {
      return WebTemplateFileSystem();
    } else {
      if (remote is DavRemoteStorage) {
        return DavRemoteTemplateFileSystem(remote);
      }
      return IOTemplateFileSystem();
    }
  }
}
