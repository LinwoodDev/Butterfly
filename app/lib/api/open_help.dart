import 'package:url_launcher/url_launcher.dart';

Future<bool> openHelp(List<String> pageLocation) {
  return launch(Uri(
      scheme: 'https',
      host: 'docs.butterfly.linwood.dev',
      pathSegments: ['docs', '1.3', ...pageLocation]).toString());
}
