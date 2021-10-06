import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

void openImage(List<int> bytes) {
  getTemporaryDirectory().then((dir) {
    var file = File("${dir.path}/export.png");
    file.writeAsBytesSync(bytes);
    launch("file://${file.path}");
  });
}
