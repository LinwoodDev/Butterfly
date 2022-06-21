import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:butterfly/models/document.dart';
import 'package:butterfly/models/template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

import '../cubits/settings.dart';
import 'file_system.dart';

Future<String> getButterflyDirectory() async {
  String? path;
  if (Platform.isAndroid) path = (await getExternalStorageDirectory())?.path;
  path ??= (await getApplicationDocumentsDirectory()).path;
  path += '/Linwood/Butterfly';
  return path;
}

class IODocumentFileSystem extends DocumentFileSystem {
  @override
  Future<AppDocumentFile> importDocument(AppDocument document,
      {String path = '/'}) async {
    // Add leading slash
    if (!path.startsWith('/')) {
      path = '/$path';
    }
    var encodedName = convertNameToFile(document.name);
    var name = encodedName;
    var counter = 1;
    while (await hasAsset(name)) {
      name = convertNameToFile('${document.name}_${++counter}');
    }
    var file = File('${await getDirectory()}$path/$name');
    file = await file.create(recursive: true);
    await file.writeAsString(json.encode(document.toJson()));
    return AppDocumentFile(
        AssetLocation.local(path == '/' ? '/$name' : '$path/$name'),
        document.toJson());
  }

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
  Future<AppDocumentAsset?> getAsset(String path) async {
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
      var json = await file.readAsString();
      try {
        return AppDocumentFile(AssetLocation.local(path), jsonDecode(json));
      } catch (e) {
        return null;
      }
    } else if (await directory.exists()) {
      var files = await directory.list().toList();
      var assets = <AppDocumentAsset>[];
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
          : (a as AppDocumentFile).name.compareTo(
              b is AppDocumentDirectory ? '' : (b as AppDocumentFile).name));

      return AppDocumentDirectory(AssetLocation.local(path), assets);
    }
    return null;
  }

  @override
  Future<bool> hasAsset(String path) async {
    return File(await getAbsolutePath(path)).exists();
  }

  @override
  Future<AppDocumentFile> updateDocument(
      String path, AppDocument document) async {
    var file = File(await getAbsolutePath(path));
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
    await file.writeAsString(jsonEncode(document.toJson()));

    return AppDocumentFile(AssetLocation.local(path), document.toJson());
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
    path += '/Documents';
    var directory = Directory(path);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory.path;
  }

  @override
  Future<AppDocumentDirectory> createDirectory(String name) async {
    var dir = Directory(await getAbsolutePath(name));
    if (!(await dir.exists())) {
      await dir.create(recursive: true);
    }
    var assets = <AppDocumentAsset>[];
    var files = await dir.list().toList();
    for (var file in files) {
      var asset = await getAsset(
          '$name/${file.path.replaceAll('\\', '/').split('/').last}');
      if (asset != null) {
        assets.add(asset);
      }
    }
    return AppDocumentDirectory(AssetLocation.local(name), assets);
  }
}

class IOTemplateFileSystem extends TemplateFileSystem {
  @override
  Future<bool> createDefault(BuildContext context, {bool force = false}) async {
    var defaults = DocumentTemplate.getDefaults(context);
    var directory = await getDirectory();
    if (await Directory(directory).exists()) {
      if (force) {
        await Directory(directory).delete(recursive: true);
      } else {
        return false;
      }
    }
    await Future.wait(defaults.map((e) => updateTemplate(e)));
    return true;
  }

  @override
  Future<void> deleteTemplate(String name) async {
    await File(await getAbsolutePath('${escapeName(name)}.bfly')).delete();
  }

  @override
  Future<DocumentTemplate?> getTemplate(String name) async {
    var file = File(await getAbsolutePath('${escapeName(name)}.bfly'));
    if (await file.exists()) {
      var json = await file.readAsString();
      return DocumentTemplate.fromJson(
          Map<String, dynamic>.from(jsonDecode(json)));
    }
    return null;
  }

  @override
  Future<void> updateTemplate(DocumentTemplate template) async {
    var file = File(await getAbsolutePath('${escapeName(template.name)}.bfly'));
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
    await file.writeAsString(jsonEncode(template.toJson()));
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
  Future<List<DocumentTemplate>> getTemplates() async {
    var directory = Directory(await getDirectory());
    if (!(await directory.exists())) return const [];
    var files = await directory.list().toList();
    var templates = <DocumentTemplate>[];
    for (var file in files) {
      if (file is! File) continue;
      try {
        var json = await file.readAsString();
        templates.add(DocumentTemplate.fromJson(jsonDecode(json)));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    return templates;
  }
}

class DavRemoteDocumentFileSystem extends DocumentFileSystem {
  @override
  final DavRemoteStorage remote;

  DavRemoteDocumentFileSystem(this.remote);

  final http.Client client = http.Client();
  Future<http.StreamedResponse> _createRequest(List<String> path,
      {String method = 'GET', String? body}) async {
    final url = remote.buildDocumentsUri(path: path);
    final request = http.Request(method, url);
    if (body != null) {
      request.body = body;
    }
    request.headers['Authorization'] =
        'Basic ${base64Encode(utf8.encode('${remote.username}:${await remote.getPassword()}'))}';
    return client.send(request);
  }

  @override
  Future<AppDocumentDirectory> createDirectory(String name) async {
    var path = name;
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    if (!path.endsWith('/')) {
      path = '$path/';
    }
    final response = await _createRequest(path.split('/'), method: 'MKCOL');
    if (response.statusCode != 201) {
      throw Exception('Failed to create directory: ${response.statusCode}');
    }
    return AppDocumentDirectory(
        AssetLocation(
            remote: remote.identifier,
            path: path.substring(0, path.length - 1)),
        const []);
  }

  @override
  Future<void> deleteAsset(String path) async {
    final response = await _createRequest(path.split('/'), method: 'DELETE');
    if (response.statusCode != 204) {
      throw Exception('Failed to delete asset: ${response.statusCode}');
    }
  }

  @override
  Future<AppDocumentAsset?> getAsset(String path) async {
    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    var response = await _createRequest(path.split('/'), method: 'PROPFIND');
    if (response.statusCode != 207) {
      return null;
    }
    var content = await response.stream.bytesToString();
    final xml = XmlDocument.parse(content);
    final fileName = remote.buildDocumentsUri(path: path.split('/')).path;
    final currentElement = xml.findAllElements('d:response').where((element) {
      final current = element.getElement('d:href')?.text;
      return current == fileName || current == '$fileName/';
    }).first;
    final resourceType = currentElement
        .findElements('d:propstat')
        .first
        .findElements('d:prop')
        .first
        .findElements('d:resourcetype')
        .first;
    if (resourceType.getElement('d:collection') != null) {
      final assets = await Future.wait(xml
          .findAllElements('d:response')
          .where((element) =>
              element.getElement('d:href')?.text.startsWith(fileName) ?? false)
          .where((element) {
        final current = element.getElement('d:href')?.text;
        return current != fileName && current != '$fileName/';
      }).map((e) async {
        final currentResourceType = e
            .findElements('d:propstat')
            .first
            .findElements('d:prop')
            .first
            .findElements('d:resourcetype')
            .first;
        var path = e
            .findElements('d:href')
            .first
            .text
            .substring(remote.buildDocumentsUri().path.length);
        if (path.endsWith('/')) {
          path = path.substring(0, path.length - 1);
        }
        if (!path.startsWith('/')) {
          path = '/$path';
        }
        path = Uri.decodeComponent(path);
        if (currentResourceType.getElement('d:collection') != null) {
          return AppDocumentDirectory(
              AssetLocation(remote: remote.identifier, path: path), const []);
        } else {
          response = await _createRequest(path.split('/'), method: 'GET');
          if (response.statusCode != 200) {
            throw Exception('Failed to get asset: ${response.statusCode}');
          }
          content = await response.stream.bytesToString();
          return AppDocumentFile(
              AssetLocation(remote: remote.identifier, path: path),
              json.decode(content));
        }
      }).toList());
      return AppDocumentDirectory(
          AssetLocation(remote: remote.identifier, path: path), assets);
    }
    response = await _createRequest(path.split('/'), method: 'GET');
    if (response.statusCode != 200) {
      throw Exception('Failed to get asset: ${response.statusCode}');
    }
    content = await response.stream.bytesToString();
    return AppDocumentFile(AssetLocation(remote: remote.identifier, path: path),
        json.decode(content));
  }

  @override
  Future<bool> hasAsset(String path) async {
    final response = await _createRequest(path.split('/'));
    return response.statusCode == 200;
  }

  @override
  Future<AppDocumentFile> importDocument(AppDocument document,
      {String path = '/'}) async {
    var fileName = document.name;
    if (fileName.endsWith('.bfly')) {
      fileName = fileName.substring(0, fileName.length - 5);
    }
    if (!path.endsWith('/') && path != '/') {
      path = '$path/';
    }
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    final has = await hasAsset(path);
    if (!has) {
      await createDirectory(path);
    }
    final asset = await getAsset(path);
    if (asset is! AppDocumentDirectory) {
      throw Exception('Failed to get directory: $path');
    }
    final filePath = convertNameToFile('$path$fileName');
    // get unique fileName
    var counter = 1;
    while (asset.assets.any((a) => a.path == filePath)) {
      fileName = convertNameToFile('${document.name}_${++counter}');
    }
    final content = document.toJson();
    final response = await _createRequest(
        path == '' || path == '/' ? [filePath] : [...path.split('/'), fileName],
        method: 'PUT',
        body: json.encode(content));
    if (response.statusCode != 201) {
      throw Exception('Failed to import document: ${response.statusCode}');
    }
    return AppDocumentFile(
        AssetLocation(remote: remote.identifier, path: filePath), content);
  }

  @override
  Future<AppDocumentFile> updateDocument(
      String path, AppDocument document) async {
    final content = document.toJson();
    final response = await _createRequest(path.split('/'),
        method: 'PUT', body: json.encode(content));
    if (response.statusCode != 201 && response.statusCode != 204) {
      throw Exception('Failed to update document: ${response.statusCode}');
    }
    return AppDocumentFile(
        AssetLocation(remote: remote.identifier, path: path), content);
  }
}

class DavRemoteTemplateFileSystem extends TemplateFileSystem {
  @override
  final DavRemoteStorage remote;

  DavRemoteTemplateFileSystem(this.remote);

  final http.Client client = http.Client();
  Future<http.StreamedResponse> _createRequest(String path,
      {String method = 'GET', String? body}) async {
    final url = remote.buildTemplatesUri(path: path.split('/'));
    final request = http.Request(method, url);
    if (body != null) {
      request.body = body;
    }
    request.headers['Authorization'] =
        'Basic ${base64Encode(utf8.encode('${remote.username}:${await remote.getPassword()}'))}';
    return client.send(request);
  }

  @override
  Future<bool> createDefault(BuildContext context, {bool force = false}) async {
    var defaults = DocumentTemplate.getDefaults(context);
    // test if directory exists
    final response = await _createRequest('', method: 'PROPFIND');
    if (response.statusCode != 404 && !force) {
      return false;
    }
    // Create directory if it doesn't exist
    await _createRequest('', method: 'MKCOL');
    await Future.wait(defaults.map((e) => updateTemplate(e)));
    return true;
  }

  @override
  Future<void> deleteTemplate(String name) async {
    final response = await _createRequest(name, method: 'DELETE');
    if (response.statusCode != 204) {
      throw Exception('Failed to delete template: ${response.statusCode}');
    }
  }

  @override
  Future<DocumentTemplate?> getTemplate(String name) async {
    if (name.startsWith('/')) {
      name = name.substring(1);
    }
    final response = await _createRequest(name);
    if (response.statusCode != 200) {
      return null;
    }
    final content = await response.stream.bytesToString();
    return DocumentTemplate.fromJson(json.decode(content));
  }

  @override
  Future<List<DocumentTemplate>> getTemplates() async {
    final response = await _createRequest('', method: 'PROPFIND');
    if (response.statusCode == 404) {
      return [];
    }
    if (response.statusCode != 207) {
      throw Exception('Failed to get templates: ${response.statusCode}');
    }
    final content = await response.stream.bytesToString();
    final xml = XmlDocument.parse(content);
    return (await Future.wait(xml
            .findAllElements('d:href')
            .where((element) => element.text.endsWith('.bfly'))
            .map((e) {
      var path = e.text.substring(remote.buildTemplatesUri().path.length);
      path = Uri.decodeComponent(path);
      return getTemplate(path);
    })))
        .whereType<DocumentTemplate>()
        .toList();
  }

  @override
  Future<bool> hasTemplate(String name) {
    return _createRequest(name).then((response) => response.statusCode == 200);
  }

  @override
  Future<void> updateTemplate(DocumentTemplate template) {
    return _createRequest('${template.name}.bfly',
        method: 'PUT', body: json.encode(template));
  }
}
