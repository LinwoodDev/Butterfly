// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:html';
import 'dart:js_util' as js_util;

void openImage(List<int> bytes) {
  // Open image bytes in the web browser
  var d = js_util.callMethod(window, "open", []);
  // Get document from js_util and add base64 image to this document
  var doc = js_util.getProperty(d, "document");
  var img = js_util.callMethod(doc, "createElement", ["img"]);
  js_util.callMethod(img, "setAttribute",
      ["src", "data:image/png;base64," + base64.encode(bytes)]);
  var body = js_util.getProperty(doc, "body");
  js_util.callMethod(body, "append", [img]);
}
