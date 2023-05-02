import 'dart:typed_data';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:http/http.dart' as http;

Future<List<int>?> getDataFromSource(NoteData document, String source) async {
  if (source.isEmpty) {
    return [];
  }
  final uri = Uri.parse(source);
  if (uri.scheme.isEmpty) {
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
  Future<List<int>?> getData(NoteData document) =>
      getDataFromSource(document, source);
}
