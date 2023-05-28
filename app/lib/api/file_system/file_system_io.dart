import 'dart:async';
import 'dart:io';

import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'file_system.dart';

Future<String> getButterflyDirectory() async {
  final argPath = GeneralFileSystem.dataPath;
  if (argPath != null) {
    return argPath;
  }
  var prefs = await SharedPreferences.getInstance();
  String? path;
  if (prefs.containsKey('document_path')) {
    path = prefs.getString('document_path');
  }
  if (path == '') {
    path = null;
  }
  if (path != null) {
    return path;
  }
  if (Platform.isAndroid) path = (await getExternalStorageDirectory())?.path;
  path ??= (await getApplicationDocumentsDirectory()).path;
  path += '/Linwood/Butterfly';
  return path;
}

class IODocumentFileSystem extends DocumentFileSystem {
  @override
  Future<void> deleteAsset(String path) async {
    var absolutePath = await getAbsolutePath(path);
    var file = File(absolutePath);
    var dir = Directory(absolutePath);
    if (await file.exists()) {
      await file.delete();
    } else if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  @override
  Future<AppDocumentEntity?> getAsset(String path) async {
    // Add leading slash
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    var absolutePath = await getAbsolutePath(path);
    // Test if path is a file
    var file = File(absolutePath);
    // Test if path is a directory
    var directory = Directory(absolutePath);
    if (await file.exists()) {
      var data = await file.readAsBytes();
      try {
        return AppDocumentFile(AssetLocation.local(path), data);
      } catch (e) {
        return null;
      }
    } else if (await directory.exists()) {
      var files = await directory.list().toList();
      var assets = <AppDocumentEntity>[];
      for (var file in files) {
        try {
          var currentPath =
              '$path/${file.path.replaceAll('\\', '/').split('/').last}';
          if (currentPath.startsWith('//')) {
            currentPath = currentPath.substring(1);
          }
          var asset = await getAsset(currentPath);
          if (asset != null) {
            assets.add(asset);
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      }
      // Sort assets, AppDocumentDirectory should be first, AppDocumentFile should be sorted by name
      assets.sort((a, b) => a is AppDocumentDirectory
          ? -1
          : (a as AppDocumentFile).fileName.compareTo(b is AppDocumentDirectory
              ? ''
              : (b as AppDocumentFile).fileName));

      return AppDocumentDirectory(AssetLocation.local(path), assets);
    }
    return null;
  }

  @override
  Future<bool> hasAsset(String path) async {
    return File(await getAbsolutePath(path)).exists();
  }

  @override
  Future<AppDocumentFile> updateFile(String path, List<int> data) async {
    var file = File(await getAbsolutePath(path));
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
    await file.writeAsBytes(data, flush: true);

    return AppDocumentFile(AssetLocation.local(path), data);
  }

  @override
  FutureOr<String> getDirectory() async {
    var path = await getButterflyDirectory();
    // Convert \ to /
    path = path.replaceAll('\\', '/');
    path += '/Documents';
    var directory = Directory(path);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory.path;
  }

  @override
  Future<AppDocumentDirectory> createDirectory(String path) async {
    var dir = Directory(await getAbsolutePath(path));
    if (!(await dir.exists())) {
      await dir.create(recursive: true);
    }
    var assets = <AppDocumentEntity>[];
    var files = await dir.list().toList();
    for (var file in files) {
      var asset = await getAsset(
          '$path/${file.path.replaceAll('\\', '/').split('/').last}');
      if (asset != null) {
        assets.add(asset);
      }
    }
    return AppDocumentDirectory(AssetLocation.local(path), assets);
  }

  @override
  Future<bool> moveAbsolute(String oldPath, String newPath) async {
    if (oldPath.isEmpty) {
      oldPath = await getButterflyDirectory();
    }
    if (newPath.isEmpty) {
      newPath = await getButterflyDirectory();
    }
    if (oldPath == newPath) {
      return false;
    }
    if (Platform.isAndroid) {
      return false;
    }
    var oldDirectory = Directory(oldPath);
    if (await oldDirectory.exists()) {
      var files = await oldDirectory.list().toList();
      for (final file in files) {
        if (file is File) {
          var newFile = File('$newPath/${file.path.split('/').last}');
          final content = await file.readAsBytes();
          await newFile.create(recursive: true);
          await newFile.writeAsBytes(content);
          await file.delete();
        } else if (file is Directory) {
          await moveAbsolute(
              file.path, '$newPath/${file.path.split('/').last}');
        }
      }
    }
    return true;
  }

  @override
  Future<Uint8List?> loadAbsolute(String path) async {
    var file = File(path);
    if (await file.exists()) {
      return await file.readAsBytes();
    }
    return null;
  }
}

class IOTemplateFileSystem extends TemplateFileSystem {
  @override
  Future<bool> createDefault(BuildContext context, {bool force = false}) async {
    var defaults = await DocumentDefaults.getDefaults(context);
    final path = await getDirectory();
    final dir = Directory(path);
    final exists = await dir.exists();
    if (exists && !force) {
      return false;
    }
    if (exists) {
      await dir.delete(recursive: true);
    }
    await dir.create(recursive: true);
    await Future.wait(defaults.map((e) => createTemplate(e)));
    return true;
  }

  @override
  Future<void> deleteTemplate(String name) async {
    await File(await getAbsolutePath('${escapeName(name)}.bfly')).delete();
  }

  @override
  Future<NoteData?> getTemplate(String name) async {
    var file = File(await getAbsolutePath('${escapeName(name)}.bfly'));
    if (await file.exists()) {
      return NoteData.fromData(await file.readAsBytes());
    }
    return null;
  }

  @override
  Future<void> updateTemplate(NoteData template) async {
    final file =
        File(await getAbsolutePath('${escapeName(template.name ?? '')}.bfly'));
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
    final data = template.save();
    await file.writeAsBytes(data, flush: true);
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

  @override
  Future<bool> hasTemplate(String name) async {
    return File(await getAbsolutePath('${escapeName(name)}.bfly')).exists();
  }

  String escapeName(String name) {
    // Escape all non-alphanumeric characters
    return name.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
  }

  @override
  Future<List<NoteData>> getTemplates() async {
    var directory = Directory(await getDirectory());
    if (!(await directory.exists())) return const [];
    var files = await directory.list().toList();
    var templates = <NoteData>[];
    for (var file in files) {
      if (file is! File) continue;
      try {
        templates.add(NoteData.fromData(await file.readAsBytes()));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    return templates;
  }
}

class IOPackFileSystem extends PackFileSystem {
  @override
  Future<void> deletePack(String name) async {
    final file = File(await getAbsolutePath('${escapeName(name)}.bfly'));
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Future<NoteData?> getPack(String name) async {
    var file = File(await getAbsolutePath('${escapeName(name)}.bfly'));
    if (await file.exists()) {
      return NoteData.fromData(await file.readAsBytes());
    }
    return null;
  }

  @override
  Future<void> updatePack(NoteData pack) async {
    final file =
        File(await getAbsolutePath('${escapeName(pack.name ?? '')}.bfly'));
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
    final data = pack.save();
    await file.writeAsBytes(data, flush: true);
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
    path += '/Packs';
    return path;
  }

  @override
  Future<bool> hasPack(String name) async {
    return File(await getAbsolutePath('${escapeName(name)}.bfly')).exists();
  }

  String escapeName(String name) {
    // Escape all non-alphanumeric characters
    return name.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
  }

  @override
  Future<List<NoteData>> getPacks() async {
    var directory = Directory(await getDirectory());
    if (!(await directory.exists())) return const [];
    var files = await directory.list().toList();
    var packs = <NoteData>[];
    for (var file in files) {
      if (file is! File) continue;
      try {
        packs.add(NoteData.fromData(await file.readAsBytes()));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    return packs;
  }

  @override
  Future<bool> createDefault(BuildContext context, {bool force = false}) async {
    final path = await getDirectory();
    final dir = Directory(path);
    if (await dir.exists()) {
      if (force) {
        await dir.delete(recursive: true);
      } else {
        return false;
      }
    }
    await dir.create(recursive: true);
    await createPack(await DocumentDefaults.getCorePack());
    return true;
  }
}
