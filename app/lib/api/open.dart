import 'dart:async';
import 'dart:io';

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

Future<(Uint8List, String, String)> _readPlatformFile(PlatformFile file) async {
  final data = await file.readAsBytes();
  final fileName = file.name;
  final nameWithoutExtension = fileName.contains('.')
      ? fileName.substring(0, fileName.lastIndexOf('.'))
      : fileName;
  return (data, fileName.split('.').lastOrNull ?? '', nameWithoutExtension);
}

(FileType, List<String>?) _getImportPickerOptions(Iterable<String> extensions) {
  // Android's system picker filters by MIME type, not extension. The picker
  // plugin drops unknown extensions such as bfly and tbfly while converting
  // them to MIME types, making Butterfly files unselectable when known file
  // types are requested alongside them.
  if (!kIsWeb && Platform.isAndroid) {
    return (FileType.any, null);
  }
  return (FileType.custom, extensions.toList());
}

Future<(Uint8List?, String?, String?)> importFile(
  BuildContext context, [
  List<AssetFileType>? types,
]) async {
  final (fileType, allowedExtensions) = _getImportPickerOptions(
    (types ?? AssetFileType.values).expand((e) => e.getFileExtensions()),
  );
  final file = await FilePicker.pickFile(
    allowedExtensions: allowedExtensions,
    type: fileType,
  );
  if (file == null) {
    return (null, null, null);
  }
  return await _readPlatformFile(file);
}

Future<List<(Uint8List, String, String)>> importFiles(
  BuildContext context, [
  List<AssetFileType>? types,
]) async {
  final (fileType, allowedExtensions) = _getImportPickerOptions(
    (types ?? AssetFileType.values).expand((e) => e.getFileExtensions()),
  );
  final result = await FilePicker.pickFiles(
    allowedExtensions: allowedExtensions,
    type: fileType,
  );
  final files = <(Uint8List, String, String)>[];
  for (final file in result) {
    files.add(await _readPlatformFile(file));
  }
  return files;
}

Future<List<(Uint8List, String, String)>> importFilesWithExtensions(
  List<String> extensions,
) async {
  final (fileType, allowedExtensions) = _getImportPickerOptions(extensions);
  final result = await FilePicker.pickFiles(
    allowedExtensions: allowedExtensions,
    type: fileType,
  );
  final files = <(Uint8List, String, String)>[];
  for (final file in result) {
    files.add(await _readPlatformFile(file));
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
      GoRouter.of(context).goNamed(
        'remote',
        pathParameters: pathParams,
        queryParameters: queryParams,
        extra: data,
      );
      return Future.value();
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
    GoRouter.of(context).goNamed(
      'local',
      pathParameters: pathParams,
      queryParameters: queryParams,
      extra: data,
    );
    return Future.value();
  } else {
    return GoRouter.of(context).pushNamed(
      'local',
      pathParameters: pathParams,
      queryParameters: queryParams,
      extra: data,
    );
  }
}
