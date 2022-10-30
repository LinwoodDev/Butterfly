import 'dart:async';

import 'package:butterfly/api/open_stub.dart'
    if (dart.library.io) 'package:butterfly/api/open_io.dart'
    if (dart.library.js) 'package:butterfly/api/open_html.dart' as open;
import 'package:url_launcher/url_launcher.dart';

Future<bool> openHelp(List<String> pageLocation, [String? fragment]) {
  return launchUrl(
      Uri(
          scheme: 'https',
          host: 'docs.butterfly.linwood.dev',
          fragment: fragment,
          pathSegments: ['docs', '1.6', ...pageLocation]),
      mode: LaunchMode.externalApplication);
}

FutureOr<void> openImage(List<int> bytes) {
  return open.openImage(bytes);
}

FutureOr<void> openSvg(String svg) {
  return open.openSvg(svg);
}

FutureOr<void> openPdf(List<int> bytes) {
  return open.openPdf(bytes);
}

FutureOr<void> openZip(List<int> bytes) {
  return open.openZip(bytes);
}
