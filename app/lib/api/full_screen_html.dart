// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

void setup() {}
Future<bool> isFullScreen() async {
  return document.fullscreenElement != null;
}

Future<void> setFullScreen(bool fullScreen) async {
  if (fullScreen) {
    await document.body?.requestFullscreen();
  } else {
    document.exitFullscreen();
  }
}
