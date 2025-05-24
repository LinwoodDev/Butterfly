import 'dart:typed_data';

import 'package:butterfly_api/butterfly_api.dart';

Uint8List? getDataFromSource(NoteData document, String source) {
  if (source.isEmpty) {
    return null;
  }
  final uri = Uri.parse(source);
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

extension PadElementDataExtension on PadElement {
  Map<String, dynamic> toDataJson(NoteData document) {
    String getUriData(String source, String mimeType) => UriData.fromBytes(
      getDataFromSource(document, source) ?? [],
      mimeType: mimeType,
    ).toString();

    return {
      ...toJson(),
      ...switch (this) {
        ImageElement e => {'source': getUriData(e.source, 'image/png')},
        SvgElement e => {'source': getUriData(e.source, 'image/svg+xml')},
        _ => {},
      },
    };
  }
}

extension DocumentPageDataExtension on DocumentPage {
  Map<String, dynamic> toDataJson(NoteData document) => {
    ...toJson(),
    'content': content.map((e) => e.toDataJson(document)),
  };
}
