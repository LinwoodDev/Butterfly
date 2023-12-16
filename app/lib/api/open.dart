import 'dart:async';
import 'dart:io';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openHelp(List<String> pageLocation, [String? fragment]) {
  return launchUrl(
      Uri(
          scheme: 'https',
          host: 'docs.butterfly.linwood.dev',
          fragment: fragment,
          pathSegments: ['docs', '2.0', ...pageLocation]),
      mode: LaunchMode.externalApplication);
}

Future<(Uint8List?, String?)> openSupported(
    [List<String>? fileExtension]) async {
  final isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  final files = await FilePicker.platform.pickFiles(
    type: isMobile ? FileType.any : FileType.custom,
    allowedExtensions: isMobile
        ? null
        : (fileExtension ??
            AssetFileType.values.expand((e) => e.getFileExtensions()).toList()),
    allowMultiple: false,
    withData: true,
  );
  if (files?.files.isEmpty ?? true) return (null, null);
  var e = files!.files.first;
  return (e.bytes, e.extension);
}

Future<void> openFile(
    BuildContext context, bool replace, AssetLocation location,
    [Object? data]) {
  if (location.isRemote) {
    final pathParams = {
      'remote': location.remote,
      'path': location.pathWithoutLeadingSlash,
    };
    final queryParams = {
      'type': location.fileType?.name,
    };
    if (replace) {
      return GoRouter.of(context).pushReplacementNamed('remote',
          pathParameters: pathParams,
          queryParameters: queryParams,
          extra: data);
    } else {
      return GoRouter.of(context).pushNamed('remote',
          pathParameters: pathParams,
          queryParameters: queryParams,
          extra: data);
    }
  }
  final pathParams = {
    'path': location.pathWithoutLeadingSlash,
  };
  final queryParams = {
    'type': location.fileType?.name,
  };
  if (replace) {
    return GoRouter.of(context).pushReplacementNamed('local',
        pathParameters: pathParams, queryParameters: queryParams, extra: data);
  } else {
    return GoRouter.of(context).pushNamed('local',
        pathParameters: pathParams, queryParameters: queryParams, extra: data);
  }
}
