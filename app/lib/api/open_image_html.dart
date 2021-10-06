import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:js_util' as js_util;

void openImage(List<int> bytes) {
  // Open image bytes in the web browser
  var d = js_util.callMethod(window, "open", []);
  print("0");
  // Get document from js_util and add base64 image to this document
  var doc = js_util.getProperty(d, "document");
  print("1");
  var img = js_util.callMethod(doc, "createElement", ["img"]);
  print("2");
  js_util.callMethod(img, "setAttribute", ["src", "data:image/png;base64," + base64.encode(bytes)]);
  print("3");
  var body = js_util.getProperty(doc, "body");
  js_util.callMethod(body, "append", [img]);
}
