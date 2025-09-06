import 'package:butterfly_api/butterfly_api.dart';

(NoteData, List<PadElement>) importAssets(
  NoteData data,
  List<PadElement> elements, {
  void Function(String source)? onInvalidate,
  Map<String, String>? alreadyImported,
}) {
  final imported = alreadyImported ?? {};
  String importAsset(SourcedElement element, String fileExtension) {
    final source = element.source;
    onInvalidate?.call(source);
    if (imported.containsKey(source)) {
      return imported[source]!;
    }
    final uri = Uri.tryParse(source);
    final uriData = uri?.data;
    if (uriData == null) {
      if ((uri?.isScheme('file') ?? false) || !(uri?.hasScheme ?? true)) {
        data = data.undoDelete(uri!.path);
      }
      return source;
    }
    final bytes = uriData.contentAsBytes();
    (NoteData, String) result;
    if (element is PdfElement) {
      result = data.importPdf(bytes);
    } else {
      result = data.importImage(bytes, fileExtension);
    }
    data = result.$1;
    final path = Uri.file(result.$2, windows: false).toString();
    imported[source] = path;
    return path;
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
