import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void openImage(List<int> bytes) {
  getApplicationDocumentsDirectory().then((dir) {
    var file = File('${dir.path}/export.png');
    file.writeAsBytesSync(bytes);
    if (Platform.isAndroid || Platform.isIOS) {
      Share.shareFiles([file.path]);
    } else {
      launch('file://${file.path}');
    }
  });
}

void openSvg(String svg) {
  getApplicationDocumentsDirectory().then((dir) {
    var file = File('${dir.path}/export.svg');
    file.writeAsStringSync(svg);
    if (Platform.isAndroid || Platform.isIOS) {
      Share.shareFiles([file.path]);
    } else {
      launch('file://${file.path}');
    }
  });
}
