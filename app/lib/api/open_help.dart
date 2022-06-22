import 'package:url_launcher/url_launcher.dart';

Future<bool> openHelp(List<String> pageLocation, [String? fragment]) {
  return launchUrl(Uri(
      scheme: 'https',
      host: 'docs.butterfly.linwood.dev',
      fragment: fragment,
      pathSegments: ['docs', '1.4', ...pageLocation]));
}
