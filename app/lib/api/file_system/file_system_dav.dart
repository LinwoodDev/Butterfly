import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:xml/xml.dart';

import '../../cubits/settings.dart';
import '../../models/defaults.dart';
import 'file_system.dart';
import 'file_system_remote.dart';

class DavRemoteDocumentFileSystem extends DocumentRemoteSystem {
  @override
  final DavRemoteStorage remote;

  DavRemoteDocumentFileSystem(this.remote);

  final http.Client client = http.Client();
  Future<http.StreamedResponse> _createRequest(List<String> path,
      {String method = 'GET', List<int>? body}) async {
    path = List<String>.from(path);
    if (path.firstOrNull?.isEmpty ?? false) {
      path.removeAt(0);
    }
    final url = remote.buildDocumentsUri(path: path);
    final request = http.Request(method, url);
    if (body != null) {
      request.bodyBytes = body;
    }
    request.headers['Authorization'] =
        'Basic ${base64Encode(utf8.encode('${remote.username}:${await remote.getRemotePassword()}'))}';
    return client.send(request);
  }

  @override
  Future<String> getRemoteCacheDirectory() async =>
      p.join(await super.getRemoteCacheDirectory(), 'Documents');

  @override
  Future<AppDocumentDirectory> createDirectory(String path) async {
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
  Future<AppDocumentEntity?> getAsset(String path,
      {bool forceRemote = false}) async {
    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    final cached = await getCachedContent(path);
    if (cached != null && !forceRemote) {
      return AppDocumentFile(
          AssetLocation(remote: remote.identifier, path: path), cached);
    }

    var response = await _createRequest(path.split('/'), method: 'PROPFIND');
    if (response.statusCode != 207) {
      return null;
    }
    var content = await response.stream.bytesToString();
    final xml = XmlDocument.parse(content);
    final fileName = remote.buildDocumentsUri(path: path.split('/')).path;
    final currentElement = xml.findAllElements('d:response').where((element) {
      final current = element.getElement('d:href')?.value;
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
              element.getElement('d:href')?.value?.startsWith(fileName) ??
              false)
          .where((element) {
        final current = element.getElement('d:href')?.value;
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
                .value
                ?.substring(remote.buildDocumentsUri().path.length) ??
            '';
        if (path.endsWith('/')) {
          path = path.substring(0, path.length - 1);
        }
        if (!path.startsWith('/')) {
          path = '/$path';
        }
        path = Uri.decodeComponent(path);
        if (currentResourceType.getElement('d:collection') != null) {
          return AppDocumentEntity.file(
              AssetLocation(remote: remote.identifier, path: path), const []);
        } else {
          return AppDocumentEntity.fileFromMap(
              AssetLocation(remote: remote.identifier, path: path), const {});
        }
      }).toList());
      return AppDocumentEntity.directory(
          AssetLocation(remote: remote.identifier, path: path), assets);
    }
    response = await _createRequest(path.split('/'), method: 'GET');
    if (response.statusCode != 200) {
      throw Exception('Failed to get asset: ${response.statusCode}');
    }
    var fileContent = await response.stream.toBytes();
    return AppDocumentFile(
        AssetLocation(remote: remote.identifier, path: path), fileContent);
  }

  @override
  Future<DateTime?> getRemoteFileModified(String path) async {
    final response = await _createRequest(path.split('/'), method: 'PROPFIND');
    if (response.statusCode != 207) {
      return null;
    }
    final body = await response.stream.bytesToString();
    final xml = XmlDocument.parse(body);
    final lastModified = xml
        .findAllElements('d:response')
        .firstOrNull
        ?.findElements('d:propstat')
        .firstOrNull
        ?.findElements('d:prop')
        .firstOrNull
        ?.findElements('d:getlastmodified')
        .firstOrNull
        ?.value;
    if (lastModified == null) {
      return null;
    }
    //  Parse lastModified rfc1123-date to Iso8601

    return HttpDate.parse(lastModified);
  }

  @override
  Future<bool> hasAsset(String path) async {
    final response = await _createRequest(path.split('/'));
    return response.statusCode == 200;
  }

  @override
  Future<AppDocumentFile> updateFile(String path, List<int> data,
      {bool forceSync = false}) async {
    if (!forceSync && remote.hasDocumentCached(path)) {
      cacheContent(path, data);
      return AppDocumentFile(
          AssetLocation(remote: remote.identifier, path: path), data);
    }
    // Create directory if not exists
    final directoryPath = path.substring(0, path.lastIndexOf('/'));
    if (!await hasAsset(directoryPath)) {
      await createDirectory(directoryPath);
    }
    final response =
        await _createRequest(path.split('/'), method: 'PUT', body: data);
    if (response.statusCode != 201 && response.statusCode != 204) {
      throw Exception(
          'Failed to update document: ${response.statusCode} ${response.reasonPhrase}');
    }
    return AppDocumentFile(
        AssetLocation(remote: remote.identifier, path: path), data);
  }

  @override
  Future<AppDocumentFile> updateDocument(String path, NoteData document,
          {bool forceSync = false}) =>
      updateFile(path, document.save(), forceSync: forceSync);

  @override
  Future<AppDocumentFile> importDocument(NoteData document,
      {String path = '', bool forceSync = false}) {
    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    return createFile('$path/${document.name}.bfly', document.save(),
        forceSync: forceSync);
  }

  @override
  Future<AppDocumentFile> createFile(String path, List<int> data,
          {bool forceSync = false}) async =>
      updateFile(await findAvailableName(path), data);
}

class DavRemoteTemplateFileSystem extends TemplateFileSystem with RemoteSystem {
  @override
  final DavRemoteStorage remote;

  DavRemoteTemplateFileSystem(this.remote);

  final http.Client client = http.Client();
  Future<http.StreamedResponse> _createRequest(String path,
      {String method = 'GET', String? body, Uint8List? bodyBytes}) async {
    final url = remote.buildTemplatesUri(path: path.split('/'));
    final request = http.Request(method, url);
    if (body != null) {
      request.body = body;
    } else if (bodyBytes != null) {
      request.bodyBytes = bodyBytes;
    }
    request.headers['Authorization'] =
        'Basic ${base64Encode(utf8.encode('${remote.username}:${await remote.getRemotePassword()}'))}';
    return client.send(request);
  }

  @override
  Future<bool> createDefault(BuildContext context, {bool force = false}) async {
    try {
      var defaults = await DocumentDefaults.getDefaults(context);
      // test if directory exists
      final response = await _createRequest('', method: 'PROPFIND');
      if (response.statusCode != 404 && !force) {
        return false;
      }
      // Create directory if it doesn't exist
      await _createRequest('', method: 'MKCOL');
      await Future.wait(defaults.map((e) => updateTemplate(e)));
      return true;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Future<void> deleteTemplate(String name) async {
    final response = await _createRequest(name, method: 'DELETE');
    if (response.statusCode != 204) {
      throw Exception('Failed to delete template: ${response.statusCode}');
    }
  }

  @override
  Future<NoteData?> getTemplate(String name) async {
    if (name.startsWith('/')) {
      name = name.substring(1);
    }
    try {
      final response = await _createRequest(name);
      if (response.statusCode != 200) {
        return null;
      }
      final content = await response.stream.toBytes();
      cacheContent(name, content);
      return NoteData.fromData(content);
    } catch (e) {
      return getCachedTemplate(name);
    }
  }

  Future<NoteData?> getCachedTemplate(String name) async {
    final content = await getCachedContent(name);
    if (content == null) {
      return null;
    }
    return NoteData.fromData(content);
  }

  @override
  Future<List<NoteData>> getTemplates() async {
    try {
      final response = await _createRequest('', method: 'PROPFIND');
      if (response.statusCode == 404) {
        return [];
      }
      if (response.statusCode != 207) {
        throw Exception(
            'Failed to get templates: ${response.statusCode} ${response.reasonPhrase}');
      }
      final content = await response.stream.bytesToString();
      final xml = XmlDocument.parse(content);
      clearCachedContent();
      return (await Future.wait(xml
              .findAllElements('d:href')
              .where((element) => element.value?.endsWith('.bfly') ?? false)
              .map((e) {
        var path = e.value!.substring(remote.buildTemplatesUri().path.length);
        path = Uri.decodeComponent(path);
        return getTemplate(path);
      })))
          .whereNotNull()
          .toList();
    } on SocketException catch (_) {
      return await getCachedTemplates();
    }
  }

  @override
  Future<bool> hasTemplate(String name) {
    return _createRequest(name).then((response) => response.statusCode == 200);
  }

  @override
  Future<void> updateTemplate(NoteData template) {
    return _createRequest('${template.name}.bfly',
        method: 'PUT', bodyBytes: Uint8List.fromList(template.save()));
  }

  Future<List<NoteData>> getCachedTemplates() async {
    final cachedFiles = await getCachedFiles();
    return cachedFiles.values.map(NoteData.fromData).toList();
  }

  @override
  Future<String> getRemoteCacheDirectory() async =>
      p.join(await super.getRemoteCacheDirectory(), 'Templates');
}

class DavRemotePackFileSystem extends PackFileSystem with RemoteSystem {
  @override
  final DavRemoteStorage remote;

  DavRemotePackFileSystem(this.remote);

  final http.Client client = http.Client();
  Future<http.StreamedResponse> _createRequest(String path,
      {String method = 'GET', Uint8List? bodyBytes, String? body}) async {
    final url = remote.buildPacksUri(path: path.split('/'));
    final request = http.Request(method, url);
    if (body != null) {
      request.body = body;
    } else if (bodyBytes != null) {
      request.bodyBytes = bodyBytes;
    }
    request.headers['Authorization'] =
        'Basic ${base64Encode(utf8.encode('${remote.username}:${await remote.getRemotePassword()}'))}';
    return client.send(request);
  }

  @override
  Future<void> deletePack(String name) async {
    final response = await _createRequest(name, method: 'DELETE');
    if (response.statusCode != 204) {
      throw Exception('Failed to delete pack: ${response.statusCode}');
    }
  }

  @override
  Future<NoteData?> getPack(String name) async {
    if (name.startsWith('/')) {
      name = name.substring(1);
    }
    try {
      final response = await _createRequest(name);
      if (response.statusCode != 200) {
        return null;
      }
      final content = await response.stream.toBytes();
      cacheContent(name, content);
      return NoteData.fromData(content);
    } catch (e) {
      return getCachedPack(name);
    }
  }

  Future<NoteData?> getCachedPack(String name) async {
    final content = await getCachedContent(name);
    if (content == null) {
      return null;
    }
    return NoteData.fromData(content);
  }

  @override
  Future<List<NoteData>> getPacks() async {
    try {
      final response = await _createRequest('', method: 'PROPFIND');
      if (response.statusCode == 404) {
        return [];
      }
      if (response.statusCode != 207) {
        throw Exception(
            'Failed to get packs: ${response.statusCode} ${response.reasonPhrase}');
      }
      final content = await response.stream.bytesToString();
      final xml = XmlDocument.parse(content);
      clearCachedContent();
      return (await Future.wait(xml
              .findAllElements('d:href')
              .where((element) => element.value?.endsWith('.bfly') ?? false)
              .map((e) {
        var path = e.value!.substring(remote.buildPacksUri().path.length);
        path = Uri.decodeComponent(path);
        return getPack(path);
      })))
          .whereNotNull()
          .toList();
    } on SocketException catch (_) {
      return await getCachedPacks();
    }
  }

  @override
  Future<bool> hasPack(String name) {
    return _createRequest(name).then((response) => response.statusCode == 200);
  }

  @override
  Future<void> updatePack(NoteData pack) {
    return _createRequest('${pack.name}.bfly',
        method: 'PUT', bodyBytes: Uint8List.fromList(pack.save()));
  }

  Future<List<NoteData>> getCachedPacks() async {
    final cachedFiles = await getCachedFiles();
    return cachedFiles.values.map(NoteData.fromData).toList();
  }

  @override
  Future<String> getRemoteCacheDirectory() async =>
      p.join(await super.getRemoteCacheDirectory(), 'Packs');

  @override
  Future<bool> createDefault(BuildContext context, {bool force = false}) async {
    try {
      // test if directory exists
      final response = await _createRequest('', method: 'PROPFIND');
      if (response.statusCode != 404 && !force) {
        return false;
      }
      // Create directory if it doesn't exist
      await _createRequest('', method: 'MKCOL');
      await updatePack(await DocumentDefaults.getCorePack());
      return true;
    } on SocketException catch (_) {
      return false;
    }
  }
}
