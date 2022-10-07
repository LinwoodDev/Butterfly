import 'dart:async';
import 'dart:io';

import 'package:butterfly/api/file_system_io.dart';
import 'package:cross_file/cross_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

FutureOr<void> openImage(List<int> bytes) async {
  final dir = getButterflyDirectory();
  var file = File('$dir/Temp/export.png');
  file.create(recursive: true);
  await file.writeAsBytes(bytes);
  if (Platform.isAndroid || Platform.isIOS) {
    Share.shareXFiles([XFile(file.path, mimeType: 'image/png')]);
  } else {
    launchUrl(Uri.file(file.path));
  }
}

FutureOr<void> openSvg(String svg) async {
  final dir = await getButterflyDirectory();
  var file = File('$dir/Temp/export.svg');
  file.create(recursive: true);
  await file.writeAsString(svg);
  if (Platform.isAndroid || Platform.isIOS) {
    Share.shareXFiles([XFile(file.path, mimeType: 'image/svg+xml')]);
  } else {
    launchUrl(Uri.file(file.path));
  }
}

FutureOr<void> openPdf(List<int> bytes) async {
  final dir = await getButterflyDirectory();
  var file = File('$dir/Temp/export.pdf');
  file.create(recursive: true);
  await file.writeAsBytes(bytes);
  if (Platform.isAndroid || Platform.isIOS) {
    Share.shareXFiles([XFile(file.path, mimeType: 'application/pdf')]);
  } else {
    launchUrl(Uri.file(file.path));
  }
}

FutureOr<void> openZip(List<int> bytes) async {
  final dir = await getButterflyDirectory();
  var file = File('$dir/Temp/export.zip');
  await file.create(recursive: true);
  await file.writeAsBytes(bytes);
  if (Platform.isAndroid || Platform.isIOS) {
    Share.shareXFiles([XFile(file.path, mimeType: 'application/zip')]);
  } else {
    launchUrl(Uri.file(file.path));
  }
}
