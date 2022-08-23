import 'package:butterfly/api/open_stub.dart'
    if (dart.library.io) 'package:butterfly/api/open_io.dart'
    if (dart.library.js) 'package:butterfly/api/open_html.dart' as open;
import 'package:url_launcher/url_launcher.dart';

Future<bool> openHelp(List<String> pageLocation, [String? fragment]) {
  return launchUrl(Uri(
      scheme: 'https',
      host: 'docs.butterfly.linwood.dev',
      fragment: fragment,
      pathSegments: ['docs', '1.5', ...pageLocation]));
}

void openImage(List<int> bytes) {
  open.openImage(bytes);
}

void openSvg(String svg) {
  open.openSvg(svg);
}

void openPdf(List<int> bytes) {
  open.openPdf(bytes);
}

void openZip(List<int> bytes) {
  open.openZip(bytes);
}
