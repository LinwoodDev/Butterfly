import 'dart:convert';
import 'dart:math';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';

/// Calculates the scale for an imported visual asset.
///
/// Assets keep their native on-screen size when they fit within the configured
/// viewport fraction. Larger assets are scaled down to that limit. Dividing by
/// the current viewport scale keeps the initial on-screen size independent of
/// the zoom level at which the asset is imported.
double calculateImportAssetScale({
  required double assetWidth,
  required double assetHeight,
  required double viewportWidth,
  required double viewportHeight,
  required double viewportScale,
  required double maxViewportFraction,
}) {
  final fraction = maxViewportFraction.clamp(0.0, 1.0);
  var fitScale = 1.0;
  if (assetWidth > 0 && viewportWidth.isFinite) {
    fitScale = min(fitScale, viewportWidth * fraction / assetWidth);
  }
  if (assetHeight > 0 && viewportHeight.isFinite) {
    fitScale = min(fitScale, viewportHeight * fraction / assetHeight);
  }
  final zoom = viewportScale.isFinite && viewportScale > 0
      ? viewportScale
      : 1.0;
  return fitScale / zoom;
}

Uint8List? getDataFromSource(NoteData document, String source) {
  if (source.isEmpty) {
    return null;
  }
  final uri = Uri.tryParse(source);
  if (uri == null) {
    return null;
  }
  if (!uri.hasScheme || uri.isScheme('file')) {
    final data = document.getAsset(uri.path);
    if (data == null) {
      return null;
    }
    return Uint8List.fromList(data);
  }
  final data = uri.data;
  return data?.contentAsBytes();
}

Uint8List? _getDataFromSource((NoteData, String) message) =>
    getDataFromSource(message.$1, message.$2);

Future<Uint8List?> computeDataFromSource(NoteData document, String source) =>
    compute(_getDataFromSource, (document, source));

UriData? getUriDataFromSource(
  NoteData document,
  String source,
  String mimeType,
) {
  final data = getDataFromSource(document, source);
  if (data == null) {
    return null;
  }
  return UriData.fromBytes(data, mimeType: mimeType);
}

extension ImageElementDataExtension on SourcedElement {
  Uint8List? getData(NoteData document) => getDataFromSource(document, source);
  UriData? getUriData(NoteData document, String mimeType) =>
      getUriDataFromSource(document, source, mimeType);
}

extension DocumentPageDataExtension on DocumentPage {
  Map<String, dynamic> toDataJson(NoteData document) {
    final assets = <String, String>{};
    for (final source in content.expand((e) => e.sources).toSet()) {
      if (source.startsWith('data:')) continue;
      final bytes = getDataFromSource(document, source);
      if (bytes != null) assets[source] = base64Encode(bytes);
    }
    return {...toJson(), if (assets.isNotEmpty) 'assets': assets};
  }

  static DocumentPage fromDataJson(Map<String, dynamic> json) {
    final page = DocumentPage.fromJson(json);
    final assets = json['assets'];
    if (assets is! Map<String, dynamic>) return page;

    final embeddedSources = <(String, AssetFileType), String>{};
    String embedSource(String source, AssetFileType type, String _) {
      final data = assets[source];
      if (data is! String) return source;
      return embeddedSources.putIfAbsent((
        source,
        type,
      ), () => 'data:${type.getMimeTypes().first};base64,$data');
    }

    return page.mapLayers(
      (layer) => layer.copyWith(
        content: layer.content.map((e) => e.mapSources(embedSource)).toList(),
      ),
    );
  }
}
