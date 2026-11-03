import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

Future<Uint8List?> decodeConnectionIcon(Uint8List bytes) async {
  try {
    final codec = await ui.instantiateImageCodecWithSize(
      await ui.ImmutableBuffer.fromUint8List(bytes),
      getTargetSize: (width, height) => width >= height
          ? ui.TargetImageSize(width: math.min(width, 128))
          : ui.TargetImageSize(height: math.min(height, 128)),
    );
    try {
      final frame = await codec.getNextFrame();
      try {
        return (await frame.image.toByteData(format: ui.ImageByteFormat.png))
            ?.buffer
            .asUint8List();
      } finally {
        frame.image.dispose();
      }
    } finally {
      codec.dispose();
    }
  } catch (_) {
    try {
      final image = img.decodeImage(bytes);
      if (image == null) return null;
      final resized = img.copyResize(
        image,
        width: image.width >= image.height ? math.min(image.width, 128) : null,
        height: image.height > image.width ? math.min(image.height, 128) : null,
      );
      return Uint8List.fromList(img.encodePng(resized));
    } catch (_) {
      return null;
    }
  }
}

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
