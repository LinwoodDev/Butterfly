// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

void setup() {
  window.document.onContextMenu.listen((evt) => evt.preventDefault());
}
