import 'package:butterfly/api/full_screen_stub.dart'
    if (dart.library.io) 'package:butterfly/api/full_screen_io.dart'
    if (dart.library.js) 'package:butterfly/api/full_screen_html.dart'
    as full_screen;

void setupFullScreen() {
  full_screen.setupFullScreen();
}

Future<bool> isFullScreen() {
  return full_screen.isFullScreen();
}

Future<void> setFullScreen(bool fullScreen) {
  return full_screen.setFullScreen(fullScreen);
}
