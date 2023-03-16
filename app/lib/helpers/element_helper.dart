import 'package:butterfly_api/butterfly_api.dart';
import 'package:http/http.dart' as http;

Future<List<int>> getDataFromSource(String source) async {
  final uri = Uri.parse(source);
  final response = await http.get(uri);
  return response.bodyBytes;
}

extension ImageElementDataExtension on ImageElement {
  Future<List<int>> getData() => getDataFromSource(source);
}
