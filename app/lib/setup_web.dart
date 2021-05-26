import 'dart:html';

void setup() {
  window.document.onContextMenu.listen((evt) => evt.preventDefault());
}
