import 'dart:io';

import 'package:butterfly/api/file_system_io.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void openImage(List<int> bytes) {
  getButterflyDirectory().then((dir) {
    var file = File('$dir/Temp/export.png');
    file.create(recursive: true);
    if (Platform.isAndroid || Platform.isIOS) {
      Share.shareFiles([file.path]);
    } else {
      launchUrl(Uri.file(file.path));
    }
  });
}

void openSvg(String svg) {
  getButterflyDirectory().then((dir) {
    var file = File('$dir/Temp/export.svg');
    file.create(recursive: true);
    file.writeAsStringSync(svg);
    if (Platform.isAndroid || Platform.isIOS) {
      Share.shareFiles([file.path]);
    } else {
      launchUrl(Uri.file(file.path));
    }
  });
}

void openPdf(List<int> bytes) {
  getButterflyDirectory().then((dir) {
    var file = File('$dir/Temp/export.pdf');
    file.create(recursive: true);
    file.writeAsBytesSync(bytes);
    if (Platform.isAndroid || Platform.isIOS) {
      Share.shareFiles([file.path]);
    } else {
      launchUrl(Uri.file(file.path));
    }
  });
}
