import 'dart:async';
import 'dart:io';

import 'package:butterfly/services/document_state.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lw_file_system/lw_file_system.dart';

void main() {
  test('remote state works across differently named connections', () async {
    final laptopCache = await Directory.systemTemp.createTemp('state_laptop_');
    final tabletCache = await Directory.systemTemp.createTemp('state_tablet_');
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final methods = <String>[];
    final uploaded = Completer<void>();
    final laptopLocation = const AssetLocation(
      remote: 'Laptop connection',
      path: '/notes/example.bfly',
    );
    final tabletLocation = const AssetLocation(
      remote: 'Tablet connection',
      path: '/notes/example.bfly',
    );
    final stateKey = documentStatePathKey(laptopLocation, remoteStorage: true);
    final statePath = '/state/$stateKey';
    List<int>? storedState;
    final handling = server.forEach((request) async {
      methods.add(request.method);
      switch (request.method) {
        case 'GET':
          request.response.statusCode = HttpStatus.ok;
          if (request.uri.path == statePath && storedState != null) {
            request.response.add(storedState!);
          }
        case 'PUT':
          storedState = await request.fold<List<int>>([], (bytes, chunk) {
            bytes.addAll(chunk);
            return bytes;
          });
          request.response.statusCode = HttpStatus.created;
          uploaded.complete();
        case 'PROPFIND':
          request.response
            ..statusCode = HttpStatus.multiStatus
            ..write('''<?xml version="1.0"?>
<d:multistatus xmlns:d="DAV:">
  <d:response>
    <d:href>${request.uri.path}</d:href>
    <d:propstat><d:prop><d:resourcetype/><d:getcontentlength>${storedState?.length ?? 0}</d:getcontentlength></d:prop><d:status>HTTP/1.1 200 OK</d:status></d:propstat>
  </d:response>
</d:multistatus>''');
        default:
          request.response.statusCode = HttpStatus.methodNotAllowed;
      }
      await request.response.close();
    });
    addTearDown(() async {
      await server.close(force: true);
      await handling;
      await laptopCache.delete(recursive: true);
      await tabletCache.delete(recursive: true);
    });

    TypedKeyFileSystem<PersistedDocumentState> buildSystem(
      String name,
      Directory cache,
    ) => TypedKeyFileSystem<PersistedDocumentState>.build(
      FileSystemConfig(
        storeName: 'documentstates',
        variant: 'documentstates',
        getDirectory: (_) async => cache.path,
        database: 'test_db',
        databaseVersion: 1,
      ),
      storage: DavRemoteStorage(
        name: name,
        username: 'test',
        url: 'http://${server.address.host}:${server.port}',
        paths: const {'documentstates': 'state'},
      ),
      onEncode: encodePersistedDocumentState,
      onDecode: decodePersistedDocumentState,
    );

    final laptop = buildSystem('Laptop connection', laptopCache);

    await DocumentStateService(laptop).save(
      const PersistedDocumentState(pageName: 'Page 1'),
      pathKey: stateKey,
      persistentChanged: true,
    );
    await uploaded.future.timeout(const Duration(seconds: 5));

    expect(methods, contains('PUT'));
    expect(methods, isNot(contains('PROPFIND')));
    expect(documentStatePathKey(tabletLocation, remoteStorage: true), stateKey);
    final tablet = buildSystem('Tablet connection', tabletCache);
    expect(
      (await DocumentStateService(tablet).load(pathKey: stateKey))?.pageName,
      'Page 1',
    );
  });
}
