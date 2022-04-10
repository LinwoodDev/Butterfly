import 'package:url_launcher/url_launcher.dart';

Future<bool> openReleaseNotes() {
  return launch(Uri(
      scheme: 'https',
      host: 'go.linwood.dev',
      pathSegments: ['butterfly', '1-3']).toString());
}
