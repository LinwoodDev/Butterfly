import 'dart:io';

import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

late bool isFullscreen;
Future<bool> isFullScreen() async {
  if (Platform.isAndroid || Platform.isIOS) {
    return isFullscreen;
  } else {
    return windowManager.isFullScreen();
  }
}

void setup() {
  isFullscreen = false;
}

Future<void> setFullScreen(bool fullScreen) async {
  if (Platform.isAndroid || Platform.isIOS) {
    if (fullScreen) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      isFullscreen = true;
    } else {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
      isFullscreen = false;
    }
  } else {
    await windowManager.setFullScreen(fullScreen);
  }
}
