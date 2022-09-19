// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html';

FutureOr<void> openImage(List<int> bytes) {
  final a = document.createElement('a') as AnchorElement;
  // Create data URL
  final blob = Blob([bytes], 'image/png');
  final url = Url.createObjectUrl(blob);
  a.href = url;
  a.download = 'butterfly.png';
  a.click();
}

FutureOr<void> openSvg(String data) {
  final a = document.createElement('a') as AnchorElement;
  // Create data URL
  final blob = Blob([data], 'image/svg+xml');
  final url = Url.createObjectUrl(blob);
  a.href = url;
  a.download = 'butterfly.svg';
  a.click();
}

FutureOr<void> openPdf(List<int> bytes) {
  final a = document.createElement('a') as AnchorElement;
  // Create data URL
  final blob = Blob([bytes], 'application/pdf');
  final url = Url.createObjectUrl(blob);
  a.href = url;
  a.download = 'butterfly.pdf';
  a.click();
}

FutureOr<void> openZip(List<int> bytes) {
  final a = document.createElement('a') as AnchorElement;
  // Create data URL
  final blob = Blob([bytes], 'application/zip');
  final url = Url.createObjectUrl(blob);
  a.href = url;
  a.download = 'butterfly.zip';
  a.click();
}
