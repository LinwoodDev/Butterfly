// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'dart:js' as js;

import 'package:flutter/foundation.dart';

void setupFullScreen() {}

bool isFullScreen() {
  return document.fullscreenElement != null;
}

Future<void> setFullScreen(bool fullScreen) async {
  try {
    final state = isFullScreen();
    if (fullScreen && !state) {
      await document.body?.requestFullscreen();
    } else if (state) {
      js.context.callMethod('eval', [
        '(document.exitFullscreen||document.webkitExitFullscreen)?.call(document)'
      ]);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
