import 'dart:convert';
import 'dart:typed_data';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:http/http.dart' as http;

Future<Uint8List?> getDataFromSource(NoteData document, String source) async {
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
  if (data != null) {
    return data.contentAsBytes();
  }
  try {
    final response = await http.get(uri);
    return response.bodyBytes;
  } catch (e) {
    return null;
  }
}

extension ImageElementDataExtension on ImageElement {
  Future<Uint8List?> getData(NoteData document) =>
      getDataFromSource(document, source);
}

extension SvgElementDataExtension on SvgElement {
  Future<String?> getData(NoteData document) =>
      getDataFromSource(document, source)
          .then((value) => value == null ? null : utf8.decode(value));
}

extension PadElementDataExtension on PadElement {
  Future<Map<String, dynamic>> toDataJson(NoteData document) async {
    Future<String> getUriData(String source, String mimeType) async =>
        UriData.fromBytes(
          await getDataFromSource(document, source) ?? [],
          mimeType: mimeType,
        ).toString();

    return {
      ...toJson(),
      ...await maybeMap(
        image: (value) async => {
          'source': await getUriData(value.source, 'image/png'),
        },
        svg: (value) async => {
          'source': await getUriData(value.source, 'image/svg+xml'),
        },
        orElse: () => {},
      ),
    };
  }
}

extension DocumentPageDataExtension on DocumentPage {
  Future<Map<String, dynamic>> toDataJson(NoteData document) async => {
        ...toJson(),
        'content': await Future.wait(
          content.map((e) => e.toDataJson(document)),
        ),
      };
}
