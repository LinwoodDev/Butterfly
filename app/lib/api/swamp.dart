import 'dart:convert';

import 'package:butterfly/services/logger.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swamp_api/connection.dart' show kSwampSchemePrefix;

typedef SwampAccessToken = ({String value, bool remember});

Uri normalizeSwampAddress(Uri uri) {
  if (!uri.hasAuthority) return Uri.parse('wss://$uri');
  final scheme = uri.scheme;
  if (scheme.isEmpty) return uri.replace(scheme: 'wss');
  if (scheme.startsWith(kSwampSchemePrefix)) {
    return uri.replace(scheme: scheme.substring(kSwampSchemePrefix.length));
  }
  return uri;
}

enum SwampTokenStorage {
  host,
  join;

  static const _storage = FlutterSecureStorage();

  String _key(Uri address) {
    final uri = normalizeSwampAddress(address);
    final defaultPort = uri.scheme == 'ws' ? 80 : 443;
    final endpoint = Uri(
      scheme: uri.scheme,
      host: uri.host,
      port: uri.hasPort ? uri.port : defaultPort,
      path: uri.path.isEmpty ? '/' : uri.path,
      query: uri.hasQuery ? uri.query : null,
    );
    final identifier = sha256.convert(utf8.encode(endpoint.toString()));
    return 'swamp/$name/$identifier';
  }

  Future<String?> read(Uri address) async {
    try {
      return await _storage.read(key: _key(address));
    } catch (_) {
      talker.warning('Could not load the saved Swamp access token');
      return null;
    }
  }

  Future<bool> save(Uri address, SwampAccessToken token) async {
    try {
      final key = _key(address);
      if (token.remember && token.value.isNotEmpty) {
        await _storage.write(key: key, value: token.value);
      } else {
        await _storage.delete(key: key);
      }
      return true;
    } catch (_) {
      talker.warning('Could not update the saved Swamp access token');
      return false;
    }
  }
}
