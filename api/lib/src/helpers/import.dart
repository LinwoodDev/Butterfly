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
  var data = options.$1;
  var elements = options.$2;
  String importBytes(
    SourcedElement element,
    String fileExtension,
    Uint8List bytes,
  ) {
    (NoteData, String) result;
    if (element is PdfElement) {
      result = data.importPdf(bytes);
    } else {
      result = data.importImage(bytes, fileExtension);
    }
    data = result.$1;
    final path = Uri.file(result.$2, windows: false).toString();
    return imported[element.source] = path;
  }

  String importAsset(SourcedElement element, String fileExtension) {
    final source = element.source;
    options.onInvalidate?.call(source);
    if (imported.containsKey(source)) {
      return imported[source]!;
    }
    final uri = Uri.tryParse(source);
    final uriData = uri?.data;
    if (uriData == null) {
      if ((uri?.isScheme('file') ?? false)) {
        imported[source] = uri!.toFilePath(windows: false);
      }
      if (uri?.isScheme(kAssetScheme) ?? false) {
        final bytes = options.assets?[source];
        if (bytes != null) {
          return importBytes(element, fileExtension, bytes);
        }
      }
      return source;
    }
    final bytes = uriData.contentAsBytes();
    return importBytes(element, fileExtension, bytes);
  }

  elements = elements
      .map(
        (e) => switch (e) {
          ImageElement e => e.copyWith(source: importAsset(e, 'png')),
          SvgElement e => e.copyWith(source: importAsset(e, 'svg')),
          PdfElement e => e.copyWith(source: importAsset(e, 'pdf')),
          _ => e,
        },
      )
      .map((e) => e.copyWith(id: e.id ?? createUniqueId()))
      .toList();
  return (data, elements);
}
