import 'package:flutter/services.dart';
import 'package:lw_sysapi/lw_sysapi.dart';

const _intentChannel = MethodChannel('linwood.dev/butterfly');

Future<(String, Uint8List)?> getImportIntent() async {
  final intent = await _intentChannel.invokeMapMethod<String, Object?>(
    'getImportIntent',
  );
  return switch (intent) {
    {'type': final String type, 'source': final String uri} => (
      type,
      await SystemFileDialogs.readFile(uri),
    ),
    {'type': final String type, 'source': final Uint8List bytes} => (
      type,
      bytes,
    ),
    _ => null,
  };
}
