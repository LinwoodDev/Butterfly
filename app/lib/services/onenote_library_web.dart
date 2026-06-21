import 'package:http/http.dart' as http;

const _oneNoteLibraryFiles = [
  ('pkg/rust_lib_onenote_parser.js', 'JavaScript'),
  ('pkg/rust_lib_onenote_parser_bg.wasm', 'WebAssembly'),
];

Future<void> ensureOneNoteLibraryAvailable() async {
  for (final (path, label) in _oneNoteLibraryFiles) {
    late http.Response response;
    try {
      response = await http.head(Uri.base.resolve(path));
    } catch (error) {
      throw OneNoteLibraryNotFoundException(
        '$label library request failed for “$path”: $error',
      );
    }
    final contentType = response.headers['content-type']?.toLowerCase() ?? '';
    if (response.statusCode < 200 ||
        response.statusCode >= 300 ||
        contentType.contains('text/html')) {
      throw OneNoteLibraryNotFoundException(
        '$label library “$path” was not found '
        '(HTTP ${response.statusCode}, content type '
        '“${contentType.isEmpty ? 'unknown' : contentType}”).',
      );
    }
  }
}

class OneNoteLibraryNotFoundException implements Exception {
  const OneNoteLibraryNotFoundException(this.details);

  final String details;

  @override
  String toString() =>
      'The OneNote parser web library is missing. $details\n\n'
      'Run "dart run tools/build_onenote_web.dart" before starting or '
      'building Butterfly for web.';
}
