import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:path/path.dart' as p;

import '../cubits/settings.dart';
import '../models/document.dart';
import '../models/template.dart';
import 'file_system.dart';
import 'file_system_io.dart';

enum FileSyncStatus { localLatest, remoteLatest, synced, conflict, offline }

@immutable
class SyncFile {
  final bool isDirectory;
  final AssetLocation location;
  final DateTime? localLastModified, syncedLastModified, remoteLastModified;

  const SyncFile(
      {required this.isDirectory,
      required this.location,
      required this.localLastModified,
      required this.syncedLastModified,
      this.remoteLastModified});

  FileSyncStatus get status {
    if (remoteLastModified == null) {
      return FileSyncStatus.offline;
    }
    if (localLastModified == null || syncedLastModified == null) {
      return FileSyncStatus.remoteLatest;
    }
    if (syncedLastModified!.isBefore(remoteLastModified!)) {
      if (localLastModified!.isBefore(remoteLastModified!)) {
        return FileSyncStatus.remoteLatest;
      }
      if (!isDirectory) {
        return FileSyncStatus.conflict;
      }
      return FileSyncStatus.localLatest;
    }
    if (!localLastModified!.isAfter(syncedLastModified!)) {
      return FileSyncStatus.synced;
    }
    if (localLastModified!.isAfter(syncedLastModified!)) {
      return FileSyncStatus.localLatest;
    }
    return FileSyncStatus.remoteLatest;
  }
}

abstract class DavRemoteSystem {
  DavRemoteStorage get remote;

  Future<String> getRemoteCacheDirectory() async {
    var path = await getButterflyDirectory();
    // Convert \ to /
    path = path.replaceAll('\\', '/');
    path = p.join(path, 'Remotes', remote.identifier);
    return path;
  }

  Future<String> getAbsoluteCachePath(String path) async {
    var cacheDir = await getRemoteCacheDirectory();
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    return p.join(cacheDir, path);
  }

  Future<String?> getCachedContent(String path) async {
    if (!remote.hasDocumentCached(path)) return null;
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
    final directory = Directory(absolutePath);
    if (await directory.exists()) return;
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

  Future<void> clearCachedContent() async {
    var cacheDir = await getRemoteCacheDirectory();
    var directory = Directory(cacheDir);
    if (await directory.exists()) {
      await directory.delete(recursive: true);
    }
  }

  Future<Map<String, String>> getCachedFiles() async {
    var cacheDir = await getRemoteCacheDirectory();
    var files = <String, String>{};
    var dir = Directory(cacheDir);
    var list = await dir.list().toList();
    for (var file in list) {
      if (file is File) {
        var name = p.relative(file.path, from: cacheDir);
        var content = await file.readAsString();
        files[name] = content;
      }
    }
    return files;
  }

  Future<DateTime?> getCachedFileModified(String path) async {
    var absolutePath = await getAbsoluteCachePath(path);
    final file = File(absolutePath);
    if (await file.exists()) {
      return file.lastModified();
    }
    final directory = Directory(absolutePath);
    if (await directory.exists()) {
      return remote.lastSynced;
    }
    return null;
  }

  Future<Map<String, DateTime>> getCachedFileModifieds() async {
    var cacheDir = await getRemoteCacheDirectory();
    var files = <String, DateTime>{};
    var dir = Directory(cacheDir);
    var list = await dir.list().toList();
    for (final file in list) {
      final name = p.relative(file.path, from: cacheDir);
      final modified = await getCachedFileModified(name);
      if (modified != null) {
        files[name] = modified;
      }
    }
    return files;
  }

  Future<DateTime?> getRemoteFileModified(String path) async => null;

  Future<SyncFile> getSyncFile(String path) async {
    var localLastModified = await getCachedFileModified(path);
    var remoteLastModified = await getRemoteFileModified(path);
    var syncedLastModified = remote.lastSynced;
    final directory = Directory(await getAbsoluteCachePath(path));

    return SyncFile(
        isDirectory: await directory.exists(),
        location: AssetLocation(remote: remote.identifier, path: path),
        localLastModified: localLastModified,
        remoteLastModified: remoteLastModified,
        syncedLastModified: syncedLastModified);
  }

  Future<List<SyncFile>> getSyncFiles() async {
    var files = <SyncFile>[];
    var cacheDir = await getRemoteCacheDirectory();
    var dir = Directory(cacheDir);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    var list = await dir.list().toList();
    for (var file in list) {
      if (file is File) {
        var name = p.relative(file.path, from: cacheDir);
        var localLastModified = await file.lastModified();
        var remoteLastModified = await getRemoteFileModified(name);
        var syncedLastModified = remote.lastSynced;
        files.add(SyncFile(
            isDirectory: false,
            location: AssetLocation(remote: remote.identifier, path: name),
            localLastModified: localLastModified,
            remoteLastModified: remoteLastModified,
            syncedLastModified: syncedLastModified));
      }
    }
    return files;
  }
}

class DavRemoteDocumentFileSystem extends DocumentFileSystem
    with DavRemoteSystem {
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
  Future<String> getRemoteCacheDirectory() async =>
      p.join(await super.getRemoteCacheDirectory(), 'Documents');

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
  Future<AppDocumentAsset?> getAsset(String path,
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
          AssetLocation(remote: remote.identifier, path: path),
          json.decode(cached));
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
          return AppDocumentFile(
              AssetLocation(remote: remote.identifier, path: path), const {});
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
        ?.text;
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
  Future<AppDocumentFile> importDocument(AppDocument document,
      {String path = '/', bool forceSync = false}) async {
    var fileName = document.name;
    if (fileName.endsWith('.bfly')) {
      fileName = fileName.substring(0, fileName.length - 5);
    }
    if (!path.endsWith('/') && path != '/') {
      path = '$path/';
    }
    if (path.startsWith('/') && path != '/') {
      path = path.substring(1);
    }

    final content = document.toJson();
    final has = await hasAsset(path);
    if (!has) {
      await createDirectory(path);
    }
    final asset = await getAsset(path);
    if (asset is! AppDocumentDirectory) {
      throw Exception('Failed to get directory: $path');
    }
    fileName = convertNameToFile(fileName);
    // get unique fileName
    var counter = 1;
    while (
        asset.assets.any((a) => a.pathWithLeadingSlash == '$path/$fileName')) {
      fileName = convertNameToFile('${document.name}_${++counter}');
    }
    if (!forceSync && remote.hasDocumentCached(path)) {
      cacheContent(path + fileName, json.encode(content));
      return AppDocumentFile(
          AssetLocation(remote: remote.identifier, path: path + fileName),
          content);
    }
    final response = await _createRequest(
        [if (path != '/') ...path.split('/'), fileName],
        method: 'PUT', body: json.encode(content));
    if (response.statusCode != 201) {
      throw Exception(
          'Failed to import document: ${response.statusCode} ${response.reasonPhrase}');
    }
    return AppDocumentFile(
        AssetLocation(remote: remote.identifier, path: path + fileName),
        content);
  }

  @override
  Future<AppDocumentFile> updateDocument(String path, AppDocument document,
      {bool forceSync = false}) async {
    final content = document.toJson();
    if (!forceSync && remote.hasDocumentCached(path)) {
      cacheContent(path, json.encode(content));
      return AppDocumentFile(
          AssetLocation(remote: remote.identifier, path: path), content);
    }
    final response = await _createRequest(path.split('/'),
        method: 'PUT', body: json.encode(content));
    if (response.statusCode != 201 && response.statusCode != 204) {
      throw Exception(
          'Failed to update document: ${response.statusCode} ${response.reasonPhrase}');
    }
    return AppDocumentFile(
        AssetLocation(remote: remote.identifier, path: path), content);
  }

  List<String> getCachedFilePaths() {
    final files = <String>[];

    for (final file in remote.cachedDocuments) {
      final alreadySyncedFile =
          files.firstWhereOrNull((file) => file.startsWith(file));
      if (alreadySyncedFile == file) {
        continue;
      }
      if (alreadySyncedFile != null &&
          alreadySyncedFile.startsWith(file) &&
          !alreadySyncedFile.substring(file.length + 1).contains('/')) {
        files.remove(alreadySyncedFile);
      }
      files.add(file);
    }
    return files;
  }

  Future<List<SyncFile>> getAllSyncFiles() async {
    final paths = getCachedFilePaths();
    final files = <SyncFile>[];
    for (final path in paths) {
      final asset = await getAsset(path);
      if (asset == null) continue;
      files.add(await getSyncFile(asset.pathWithLeadingSlash));
      if (asset is AppDocumentDirectory) {
        for (final file in asset.assets) {
          files.add(await getSyncFile(file.pathWithLeadingSlash));
        }
      }
    }
    return files;
  }

  Future<void> uploadCachedContent(String path) async {
    final content = await getCachedContent(path);
    if (content == null) {
      return;
    }
    final document = AppDocument.fromJson(json.decode(content));
    await updateDocument(path, document, forceSync: true);
  }

  Future<void> cache(String path) async {
    final asset = await getAsset(path);
    if (asset is AppDocumentDirectory) {
      var filePath = path;
      if (filePath.startsWith('/')) {
        filePath = filePath.substring(1);
      }
      filePath = p.join(await getRemoteCacheDirectory(), filePath);
      final directory = Directory(filePath);
      if (!(await directory.exists())) {
        await directory.create(recursive: true);
      }
    } else if (asset is AppDocumentFile) {
      cacheContent(path, json.encode(asset.json));
    }
  }
}

class DavRemoteTemplateFileSystem extends TemplateFileSystem
    with DavRemoteSystem {
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
    try {
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
  Future<DocumentTemplate?> getTemplate(String name) async {
    if (name.startsWith('/')) {
      name = name.substring(1);
    }
    try {
      final response = await _createRequest(name);
      if (response.statusCode != 200) {
        return null;
      }
      final content = await response.stream.bytesToString();
      cacheContent(name, content);
      return DocumentTemplate.fromJson(json.decode(content));
    } catch (e) {
      return getCachedTemplate(name);
    }
  }

  Future<DocumentTemplate?> getCachedTemplate(String name) async {
    final content = await getCachedContent(name);
    if (content == null) {
      return null;
    }
    return DocumentTemplate.fromJson(json.decode(content));
  }

  @override
  Future<List<DocumentTemplate>> getTemplates() async {
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
              .where((element) => element.text.endsWith('.bfly'))
              .map((e) {
        var path = e.text.substring(remote.buildTemplatesUri().path.length);
        path = Uri.decodeComponent(path);
        return getTemplate(path);
      })))
          .whereType<DocumentTemplate>()
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
  Future<void> updateTemplate(DocumentTemplate template) {
    return _createRequest('${template.name}.bfly',
        method: 'PUT', body: json.encode(template));
  }

  Future<List<DocumentTemplate>> getCachedTemplates() async {
    final cachedFiles = await getCachedFiles();
    return cachedFiles.values
        .map((value) => DocumentTemplate.fromJson(json.decode(value)))
        .toList();
  }

  @override
  Future<String> getRemoteCacheDirectory() async =>
      p.join(await super.getRemoteCacheDirectory(), 'Templates');
}
