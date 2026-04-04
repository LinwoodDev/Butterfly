import 'dart:async';

import 'package:butterfly/main.dart';
import 'package:butterfly/services/logger.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:url_launcher/url_launcher.dart';

const kLaunchHost = 'launch.butterfly.linwood.dev';

Uri getLaunchUri({
  String? path,
  List<String>? pathSegments,
  String? fragment,
  String? query,
  Map<String, dynamic>? queryParameters,
  String? userInfo,
}) => Uri(
  scheme: 'https',
  host: kLaunchHost,
  path: path,
  pathSegments: pathSegments,
  fragment: fragment,
  query: query,
  queryParameters: queryParameters,
  userInfo: userInfo,
);

Uri getConnectUri(String url, [String? type]) => getLaunchUri(
  pathSegments: ['connect'],
  queryParameters: {'url': url, 'type': ?type},
);

String parseConnectUri(Uri uri) {
  if (uri.host != kLaunchHost) {
    return uri.toString();
  }
  return uri.queryParameters['url'] ?? uri.toString();
}

Future<bool> openReleaseNotes() {
  talker.info('Opening release notes');
  return launchUrl(
    Uri(
      scheme: 'https',
      host: 'linwood.dev',
      pathSegments: ['butterfly', applicationMinorVersion],
    ),
  );
}

Future<bool> openHelp(List<String> pageLocation, [String? fragment]) {
  return launchUrl(
    Uri(
      scheme: 'https',
      host: 'butterfly.linwood.dev',
      fragment: fragment,
      pathSegments: ['docs', 'v2', ...pageLocation],
    ),
  );
}

Future<(Uint8List?, String?, String?)> importFile(
  BuildContext context, [
  List<AssetFileType>? types,
]) async {
  final files = await importFiles(context, types, false);
  final file = files.firstOrNull;
  if (file == null) {
    return (null, null, null);
  }
  return file;
}

Future<List<(Uint8List, String, String)>> importFiles(
  BuildContext context, [
  List<AssetFileType>? types,
  bool allowMultiple = true,
]) async {
  final result = await FilePicker.pickFiles(
    allowedExtensions: (types ?? AssetFileType.values)
        .expand((e) => e.getFileExtensions())
        .toList(),
    type: FileType.custom,
    withData: kIsWeb,
    withReadStream: !kIsWeb,
    allowMultiple: allowMultiple,
  );
  if (result == null) {
    return [];
  }
  final files = <(Uint8List, String, String)>[];
  for (final file in result.files) {
    Uint8List? data = file.bytes;
    if (!kIsWeb) {
      final stream = file.readStream;
      final size = file.size;
      if (stream != null) {
        // Allocate size
        data = Uint8List(size);
        int offset = 0;
        await for (final chunk in stream) {
          data.setRange(offset, offset + chunk.length, chunk);
          offset += chunk.length;
        }
      }
    }
    if (data != null) {
      final fileName = file.name;
      final nameWithoutExtension = fileName.contains('.')
          ? fileName.substring(0, fileName.lastIndexOf('.'))
          : fileName;
      files.add((
        data,
        fileName.split('.').lastOrNull ?? '',
        nameWithoutExtension,
      ));
    }
  }
  return files;
}

Future<void> openFile(
  BuildContext context,
  bool replace,
  AssetLocation location, [
  Object? data,
]) {
  final fileType = location.fileType?.name;
  if (location.isRemote) {
    final pathParams = {
      'remote': location.remote,
      'path': location.pathWithoutLeadingSlash,
    };
    final queryParams = <String, String>{'type': ?fileType};
    if (replace) {
      return GoRouter.of(context).pushReplacementNamed(
        'remote',
        pathParameters: pathParams,
        queryParameters: queryParams,
        extra: data,
      );
    } else {
      return GoRouter.of(context).pushNamed(
        'remote',
        pathParameters: pathParams,
        queryParameters: queryParams,
        extra: data,
      );
    }
  }
  final pathParams = {'path': location.pathWithoutLeadingSlash};
  final queryParams = <String, String>{'type': ?fileType};
  if (replace) {
    return GoRouter.of(context).pushReplacementNamed(
      'local',
      pathParameters: pathParams,
      queryParameters: queryParams,
      extra: data,
    );
  } else {
    return GoRouter.of(context).pushNamed(
      'local',
      pathParameters: pathParams,
      queryParameters: queryParams,
      extra: data,
    );
  }
}
