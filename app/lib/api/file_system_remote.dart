import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';
import 'package:path/path.dart' as p;

import '../cubits/settings.dart';
import '../models/document.dart';
import '../models/template.dart';
import 'file_system.dart';
import 'file_system_io.dart';

abstract class DavRemoteSystem {
  DavRemoteStorage get remote;

  Future<String> getRemoteCacheDirectory() async {
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
    path = p.join(path, 'Remotes', remote.identifier);
    return path;
  }

  Future<String> getAbsoluteCachePath(String path) async {
    var cacheDir = await getRemoteCacheDirectory();
    return p.join(cacheDir, path);
  }

  Future<String?> getCachedContent(String path) async {
    var absolutePath = await getAbsoluteCachePath(path);
    var file = File(absolutePath);
    if (await file.exists()) {
      return await file.readAsString();
    }
    return null;
  }

  Future<void> cacheContent(String path, String content) async {
    var absolutePath = await getAbsoluteCachePath(path);
    var file = File(absolutePath);
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }
    await file.writeAsString(content);
  }

  Future<void> deleteCachedContent(String path) async {
    var absolutePath = await getAbsoluteCachePath(path);
    var file = File(absolutePath);
    if (await file.exists()) {
      await file.delete();
    }
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
