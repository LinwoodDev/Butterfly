import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

Future<Uint8List?> fetchConnectionIconBytes({
  required HttpClient client,
  required Uri connectionUrl,
  required Uri url,
  required String username,
  required String password,
}) async {
  if ((url.scheme != 'http' && url.scheme != 'https') ||
      url.userInfo.isNotEmpty) {
    return null;
  }
  final request = await client.getUrl(url);
  if (url.scheme == connectionUrl.scheme &&
      url.host == connectionUrl.host &&
      url.port == connectionUrl.port) {
    request.headers.set(
      HttpHeaders.authorizationHeader,
      'Basic ${base64Encode(utf8.encode('$username:$password'))}',
    );
  }
  // Dart strips sensitive headers on cross-origin redirects.
  final response = await request.close();
  if (response.statusCode < 200 || response.statusCode >= 300) {
    await response.drain<void>();
    return null;
  }
  return consolidateHttpClientResponseBytes(response);
}
