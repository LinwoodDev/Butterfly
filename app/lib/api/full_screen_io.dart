import 'dart:io';

import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

bool isFullscreen = false;
Future<bool> isFullScreen() async {
  if (Platform.isAndroid || Platform.isIOS) {
    return isFullscreen;
  } else {
    return windowManager.isFullScreen();
  }
}

void setup() {
  if (Platform.isAndroid || Platform.isIOS) {
    SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async =>
        isFullscreen = systemOverlaysAreVisible);
  }
}

Future<void> setFullScreen(bool fullScreen) async {
  if (Platform.isAndroid || Platform.isIOS) {
    if (fullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      isFullscreen = true;
    } else {
      SystemChrome.restoreSystemUIOverlays();
      isFullscreen = false;
    }
  } else {
    windowManager.setFullScreen(fullScreen);
  }
}
