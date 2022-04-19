import 'package:butterfly/api/open_image_stub.dart'
    if (dart.library.io) 'package:butterfly/api/open_image_io.dart'
    if (dart.library.js) 'package:butterfly/api/open_image_html.dart'
    as open_image;

void openImage(List<int> bytes) {
  open_image.openImage(bytes);
}

void openSvg(String svg) {
  open_image.openSvg(svg);
}
