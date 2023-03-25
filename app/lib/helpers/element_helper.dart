import 'package:butterfly_api/butterfly_api.dart';
import 'package:http/http.dart' as http;

Future<List<int>> getDataFromSource(String source) async {
  if (source.isEmpty) {
    return [];
  }
  final uri = Uri.parse(source);
  final data = uri.data;
  if (data != null) {
    return data.contentAsBytes();
  }
  final response = await http.get(uri);
  return response.bodyBytes;
}

extension ImageElementDataExtension on ImageElement {
  Future<List<int>> getData() => getDataFromSource(source);
}

extension DocumentDataExtension on AppDocument {
  Future<List<int>> getThumbnailData() => getDataFromSource(thumbnail);
}
