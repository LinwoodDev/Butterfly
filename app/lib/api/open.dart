import 'dart:async';
import 'dart:io';

import 'package:butterfly/main.dart';
import 'package:butterfly/visualizer/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:file_selector/file_selector.dart' as fs;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:url_launcher/url_launcher.dart';

const kLaunchHost = 'launch.butterfly.linwood.dev';

Uri getLaunchUri(
        {String? path,
        List<String>? pathSegments,
        String? fragment,
        String? query,
        Map<String, dynamic>? queryParameters,
        String? userInfo}) =>
    Uri(
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
      queryParameters: {
        'url': url,
        if (type != null) 'type': type,
      },
    );

String parseConnectUri(Uri uri) {
  if (uri.host != kLaunchHost) {
    return uri.toString();
  }
  return uri.queryParameters['url'] ?? uri.toString();
}

Future<bool> openReleaseNotes() {
  return launchUrl(
    Uri(
        scheme: 'https',
        host: 'linwood.dev',
        pathSegments: ['butterfly', applicationMinorVersion]),
  );
}

Future<bool> openHelp(List<String> pageLocation, [String? fragment]) {
  return launchUrl(
    Uri(
        scheme: 'https',
        host: 'butterfly.linwood.dev',
        fragment: fragment,
        pathSegments: ['docs', 'v2', ...pageLocation]),
  );
}

Future<(Uint8List?, String?)> importFile(BuildContext context,
    [List<AssetFileType>? types]) async {
  final result = await fs.openFile(
    acceptedTypeGroups: (types ?? AssetFileType.values)
        .where((e) => e.getFileExtensions().isNotEmpty)
        .map((e) => fs.XTypeGroup(
              label: e.getLocalizedName(context),
              extensions:
                  kIsWeb || !Platform.isAndroid ? e.getFileExtensions() : null,
              uniformTypeIdentifiers: e.getUniformTypeIdentifiers(),
              mimeTypes: e.getMimeTypes(),
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
