import 'dart:async';

import 'package:butterfly/visualizer/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:file_selector/file_selector.dart' as fs;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openReleaseNotes() {
  return launchUrl(
      Uri(
          scheme: 'https',
          host: 'go.linwood.dev',
          pathSegments: ['butterfly', '2.0']),
      mode: LaunchMode.externalApplication);
}

Future<bool> openHelp(List<String> pageLocation, [String? fragment]) {
  return launchUrl(
      Uri(
          scheme: 'https',
          host: 'docs.butterfly.linwood.dev',
          fragment: fragment,
          pathSegments: ['docs', '2.0', ...pageLocation]),
      mode: LaunchMode.externalApplication);
}

Future<(Uint8List?, String?)> importFile(BuildContext context,
    [List<AssetFileType>? types]) async {
  final result = await fs.openFile(
    acceptedTypeGroups: (types ?? AssetFileType.values)
        .where((e) => e.getFileExtensions().isNotEmpty)
        .map((e) => fs.XTypeGroup(
              label: e.getLocalizedName(context),
              extensions: e.getFileExtensions(),
              mimeTypes: [e.getMime()],
            ))
        .toList(),
  );
  final data = await result?.readAsBytes();
  return (data, result?.name.split('.').lastOrNull);
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
