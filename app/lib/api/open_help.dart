import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openHelp(List<String> pageLocation) async {
  var packageInfo = await PackageInfo.fromPlatform();
  var version = packageInfo.version;
  return launch(Uri(
      scheme: 'https',
      host: 'docs.butterfly.linwood.dev',
      pathSegments: ['docs', version, ...pageLocation]).toString());
}
