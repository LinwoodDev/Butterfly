import 'dart:typed_data';

import 'package:butterfly_api/butterfly_api.dart';

const kAssetScheme = 'asset';

typedef ImportAssetOptions = (
  NoteData data,
  List<PadElement> elements, {
  void Function(String source)? onInvalidate,
  Map<String, String>? alreadyImported,
  Map<String, Uint8List>? assets,
});

(NoteData, List<PadElement>) importAssets(ImportAssetOptions options) {
  final imported = options.alreadyImported ?? {};
  final importedTextures = <String, String>{};
  var data = options.$1;

  String importAsset(String source, AssetFileType type, String directory) {
    // A standalone image and a paint may embed the same data URI.
    final paths = directory == kTexturesArchiveDirectory
        ? importedTextures
        : imported;
    final existing = paths[source];
    if (existing != null) return existing;

    final uri = Uri.tryParse(source);
    if (uri?.isScheme('file') ?? false) {
      paths[source] = uri!.toFilePath(windows: false);
    }
    var bytes = uri?.data?.contentAsBytes();
    if (uri?.isScheme(kAssetScheme) ?? false) {
      bytes = options.assets?[source];
    }
    if (bytes == null) return source;

    final (updated, path) = data.importAsset(
      directory,
      bytes,
      type.getFileExtensions().first,
    );
    data = updated;
    return paths[source] = Uri.file(path, windows: false).toString();
  }

  final elements = options.$2
      .map((e) => e.mapSources(importAsset))
      .map((e) => e.copyWith(id: e.id ?? createUniqueId()))
      .toList();
  return (data, elements);
}
