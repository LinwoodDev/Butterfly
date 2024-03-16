import 'dart:io';
import 'dart:typed_data';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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
    final location = AssetLocation(
        remote: remote.identifier, path: path.substring(0, path.length - 1));
    final response = await createRequest(path.split('/'), method: 'MKCOL');
    if (response == null) return AppDocumentDirectory(location);
    if (response.statusCode != 201) {
      throw Exception('Failed to create directory: ${response.statusCode}');
    }
    return AppDocumentDirectory(location, const []);
  }

  @override
  Future<void> deleteAsset(String path) async {
    final response = await createRequest(path.split('/'), method: 'DELETE');
    if (response == null) return;
    if (response.statusCode != 204) {
      throw Exception('Failed to delete asset: ${response.statusCode}');
    }
  }

  @override
  Stream<AppDocumentEntity?> fetchAsset(String path,
      [bool? listFiles = true, bool forceRemote = false]) async* {
    if (path.endsWith('/')) {
      path = path.substring(0, path.length - 1);
    }
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    final cached = await getCachedContent(path);
    if (cached != null && !forceRemote) {
      yield await getAppDocumentFile(
          AssetLocation(remote: remote.identifier, path: path), cached,
          cached: true);
      return;
    }

    var response = await createRequest(path.split('/'), method: 'PROPFIND');
    final fileName = remote.buildDocumentsUri(path: path.split('/'))?.path;
    final rootDirectory = remote.buildDocumentsUri();
    if (response == null) {
      yield null;
      return;
    }
    var content = await getBodyString(response);
    if (response.statusCode == 404 && path.isEmpty) {
      await createRequest([], method: 'MKCOL');
      response = await createRequest(path.split('/'), method: 'PROPFIND');
    }
    if (response?.statusCode != 207 ||
        fileName == null ||
        rootDirectory == null) {
      yield null;
      return;
    }
    final xml = XmlDocument.parse(content);
    final currentElement = xml.findAllElements('d:response').where((element) {
      final current = element.getElement('d:href')?.innerText;
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
              element.getElement('d:href')?.innerText.startsWith(fileName) ??
              false)
          .where((element) {
        final current = element.getElement('d:href')?.innerText;
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
            .innerText
            .substring(rootDirectory.path.length);
        if (path.endsWith('/')) {
          path = path.substring(0, path.length - 1);
        }
        if (!path.startsWith('/')) {
          path = '/$path';
        }
        path = Uri.decodeComponent(path);
        if (currentResourceType.getElement('d:collection') != null) {
          return AppDocumentEntity.directory(
              AssetLocation(remote: remote.identifier, path: path), const []);
        } else {
          final dataResponse =
              await createRequest(path.split('/'), method: 'GET');
          var fileContent = dataResponse == null
              ? const <int>[]
              : await getBodyBytes(dataResponse);
          return getAppDocumentFile(
              AssetLocation(remote: remote.identifier, path: path),
              fileContent);
        }
      }).toList());
      yield AppDocumentEntity.directory(
          AssetLocation(remote: remote.identifier, path: path), assets);
      return;
    }
    response = await createRequest(path.split('/'), method: 'GET');
    if (response == null) {
      yield null;
      return;
    }
    var fileContent = await getBodyBytes(response);
    if (response.statusCode != 200) {
      throw Exception('Failed to get asset: ${response.statusCode}');
    }
    yield await getAppDocumentFile(
        AssetLocation(remote: remote.identifier, path: path), fileContent);
  }

  @override
  Future<DateTime?> getRemoteFileModified(String path) async {
    final response = await createRequest(path.split('/'), method: 'PROPFIND');
    if (response?.statusCode != 207) {
      return null;
    }
    final body = await getBodyString(response!);
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
        ?.innerText;
    if (lastModified == null) {
      return null;
    }
    //  Parse lastModified rfc1123-date to Iso8601

    return HttpDate.parse(lastModified);
  }

  @override
  Future<bool> hasAsset(String path) async {
    final response = await createRequest(path.split('/'));
    return response?.statusCode == 200;
  }

  @override
  Future<void> updateFile(String path, List<int> data,
      {bool forceSync = false}) async {
    if (!forceSync && remote.hasDocumentCached(path)) {
      cacheContent(path, data);
    }
    var last = path.lastIndexOf('/');
    if (last == -1) {
      last = path.length;
    }
    // Create directory if not exists
    final directoryPath = path.substring(0, last);
    if (!await hasAsset(directoryPath)) {
      await createDirectory(directoryPath);
    }
    final response =
        await createRequest(path.split('/'), method: 'PUT', bodyBytes: data);
    if (response?.statusCode != 201 && response?.statusCode != 204) {
      throw Exception(
          'Failed to update document: ${response?.statusCode} ${response?.reasonPhrase}');
    }
  }

  @override
  Future<void> updateDocument(String path, NoteData document,
          {bool forceSync = false}) =>
      updateFile(path, document.save(), forceSync: forceSync);

  @override
  Future<AppDocumentFile> importDocument(NoteData document,
      {String path = '', bool forceSync = false}) {
    path = normalizePath(path);
    return createFile('$path/${document.name}.bfly', document.save(),
        forceSync: forceSync);
  }

  @override
  Future<AppDocumentFile> createFile(String path, List<int> data,
      {bool forceSync = false}) async {
    final uniquePath = await findAvailableName(path);
    return updateFile(uniquePath, data).then((_) => getAppDocumentFile(
        AssetLocation(remote: remote.identifier, path: uniquePath), data));
  }
}

class DavRemoteTemplateFileSystem extends TemplateRemoteSystem {
  @override
  final DavRemoteStorage remote;

  DavRemoteTemplateFileSystem(this.remote);

  @override
  Future<bool> createDefault(BuildContext context, {bool force = false}) async {
    try {
      var defaults = await DocumentDefaults.getDefaults(context);
      // test if directory exists
      final response = await createRequest([], method: 'PROPFIND');
      if (response?.statusCode != 404 && !force) {
        return false;
      }
      // Create directory if it doesn't exist
      await createRequest([], method: 'MKCOL');
      await Future.wait(defaults.map((e) => updateTemplate(e)));
      return true;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Future<void> deleteTemplate(String name) async {
    final response = await createRequest([name], method: 'DELETE');
    if (response?.statusCode != 204) {
      throw Exception('Failed to delete template: ${response?.statusCode}');
    }
  }

  @override
  Future<NoteData?> getTemplate(String name) async {
    if (name.startsWith('/')) {
      name = name.substring(1);
    }
    try {
      final response = await createRequest([name]);
      if (response?.statusCode != 200) {
        return null;
      }
      final content = await getBodyBytes(response!);
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
      final response = await createRequest([], method: 'PROPFIND');
      if (response?.statusCode == 404) {
        return [];
      }
      if (response?.statusCode != 207) {
        throw Exception(
            'Failed to get templates: ${response?.statusCode} ${response?.reasonPhrase}');
      }
      final content = await getBodyString(response!);
      final xml = XmlDocument.parse(content);
      final rootDirectory = remote.buildTemplatesUri();
      if (rootDirectory == null) return [];
      clearCachedContent();
      return (await Future.wait(xml
              .findAllElements('d:href')
              .where((element) => element.innerText.endsWith('.bfly'))
              .map((e) {
        var path = e.innerText.substring(rootDirectory.path.length);
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
    return createRequest([name])
        .then((response) => response?.statusCode == 200);
  }

  @override
  Future<void> updateTemplate(NoteData template) {
    return createRequest(['${template.name}.bfly'],
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

class DavRemotePackFileSystem extends PackRemoteSystem {
  @override
  final DavRemoteStorage remote;

  DavRemotePackFileSystem(this.remote);

  @override
  Future<void> deletePack(String name) async {
    final response = await createRequest([name], method: 'DELETE');
    if (response?.statusCode != 204) {
      throw Exception('Failed to delete pack: ${response?.statusCode}');
    }
  }

  @override
  Future<NoteData?> getPack(String name) async {
    if (name.startsWith('/')) {
      name = name.substring(1);
    }
    try {
      final response = await createRequest([name]);
      if (response?.statusCode != 200) {
        return null;
      }
      final content = await getBodyBytes(response!);
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
      final response = await createRequest([], method: 'PROPFIND');
      if (response?.statusCode == 404) {
        return [];
      }
      if (response?.statusCode != 207) {
        throw Exception(
            'Failed to get packs: ${response?.statusCode} ${response?.reasonPhrase}');
      }
      final content = await getBodyString(response!);
      final xml = XmlDocument.parse(content);
      final rootDirectory = remote.buildPacksUri();
      if (rootDirectory == null) return [];
      clearCachedContent();
      return (await Future.wait(xml
              .findAllElements('d:href')
              .where((element) => element.innerText.endsWith('.bfly'))
              .map((e) {
        var path = e.innerText.substring(rootDirectory.path.length);
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
    return createRequest([name])
        .then((response) => response?.statusCode == 200);
  }

  @override
  Future<void> updatePack(NoteData pack) {
    return createRequest(['${pack.name}.bfly'],
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
      final response = await createRequest([], method: 'PROPFIND');
      if (response?.statusCode != 404 && !force) {
        return false;
      }
      // Create directory if it doesn't exist
      await createRequest([], method: 'MKCOL');
      await updatePack(await DocumentDefaults.getCorePack());
      return true;
    } on SocketException catch (_) {
      return false;
    }
  }
}
