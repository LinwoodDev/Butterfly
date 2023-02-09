import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<void> main(List<String> args) async {
  await updatePdfJs();
}

Future<void> updatePdfJs() async {
  final pdfFile = File('app/web/pdf.js/pdf.min.js');
  final pdfWorkerFile = File('app/web/pdf.js/pdf.worker.min.js');
  // Find latest version
  final fetchedRelease = json.decode((await http.get(Uri.parse(
          'https://api.github.com/repos/mozilla/pdf.js/releases/latest')))
      .body) as Map;
  final latestVersion = fetchedRelease['tag_name'].toString().substring(1);
  final cdnBaseUrl =
      'https://cdnjs.cloudflare.com/ajax/libs/pdf.js/$latestVersion';
  // From cdnjs
  final fetchedPdf = await http.get(Uri.parse('$cdnBaseUrl/pdf.min.js'));
  final fetchedPdfWorker =
      await http.get(Uri.parse('$cdnBaseUrl/pdf.worker.js'));
  // Write to files
  await pdfFile.writeAsString(fetchedPdf.body);
  await pdfWorkerFile.writeAsString(fetchedPdfWorker.body);
  print('Updated pdf.js to version $latestVersion');
}
