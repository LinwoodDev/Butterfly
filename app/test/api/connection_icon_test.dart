import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:butterfly/api/connection_icon.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final authorization = 'Basic ${base64Encode(utf8.encode('user:password'))}';
  const icon = [1, 2, 3];

  Future<Uri> serve(void Function(HttpRequest) handle) async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final handling = server.forEach((request) async {
      handle(request);
      await request.response.close();
    });
    addTearDown(() async {
      await server.close(force: true);
      await handling;
    });
    return Uri(scheme: 'http', host: server.address.host, port: server.port);
  }

  Future<Uint8List?> Function(Uri) createFetcher(Uri connectionUrl) {
    final client = HttpClient();
    addTearDown(() => client.close(force: true));
    return (url) => fetchConnectionIconBytes(
      client: client,
      connectionUrl: connectionUrl,
      url: url,
      username: 'user',
      password: 'password',
    );
  }

  test('authenticates icons on the connection origin', () async {
    String? receivedAuthorization;
    final origin = await serve((request) {
      receivedAuthorization = request.headers.value(
        HttpHeaders.authorizationHeader,
      );
      request.response.add(icon);
    });

    expect(
      await createFetcher(origin.resolve('/dav/'))(
        origin.resolve('/favicon.ico'),
      ),
      icon,
    );
    expect(receivedAuthorization, authorization);
  });

  for (final difference in ['host', 'port', 'scheme']) {
    test(
      'does not send credentials to an icon with a different $difference',
      () async {
        String? receivedAuthorization;
        final iconUrl = await serve((request) {
          receivedAuthorization = request.headers.value(
            HttpHeaders.authorizationHeader,
          );
          request.response.add(icon);
        });
        final connectionUrl = switch (difference) {
          'host' => iconUrl.replace(host: 'localhost'),
          'port' => iconUrl.replace(port: 1),
          _ => iconUrl.replace(scheme: 'https'),
        };

        expect(await createFetcher(connectionUrl)(iconUrl), icon);
        expect(receivedAuthorization, isNull);
      },
    );
  }

  test('rejects URL credentials and non-HTTP URLs', () async {
    var requests = 0;
    final origin = await serve((request) => requests++);
    final fetch = createFetcher(origin);
    for (final url in [
      origin.replace(userInfo: 'injected:secret'),
      Uri.parse('file:///tmp/icon'),
      Uri.parse('data:image/png;base64,AQID'),
    ]) {
      expect(await fetch(url), isNull);
    }
    expect(requests, 0);
  });
}
