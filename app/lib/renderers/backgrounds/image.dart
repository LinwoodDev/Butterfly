part of '../renderer.dart';

class ImageBackgroundRenderer extends Renderer<ImageBackground> {
  ui.Image? image;

  ImageBackgroundRenderer(super.element, [this.image]);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    if (image == null) return;
    final sizeX = element.width * element.scaleX * transform.size;
    final sizeY = element.height * element.scaleY * transform.size;
    var offsetX = (transform.position.dx * transform.size) % sizeX;
    if (offsetX > 0) {
      offsetX -= sizeX;
    }
    var offsetY = (transform.position.dy * transform.size) % sizeY;
    if (offsetY > 0) {
      offsetY -= sizeY;
    }

    var paint = Paint();

    for (var x = offsetX; x < size.width; x += sizeX) {
      for (var y = offsetY; y < size.height; y += sizeY) {
        canvas.drawImageRect(
          image!,
          Rect.fromLTWH(
              0, 0, element.width.toDouble(), element.height.toDouble()),
          Rect.fromLTWH(x, y, sizeX, sizeY),
          paint,
        );
      }
    }
  }

  @override
  void buildSvg(XmlDocument xml, DocumentPage page, Rect viewportRect) {}

  @override
  FutureOr<void> setup(
      NoteData document, AssetService assetService, DocumentPage page) async {
    super.setup(document, assetService, page);
    if (image != null) return;
    try {
      image = await assetService.getImage(element.source);
    } catch (_) {}
  }

  @override
  void dispose() {
    image?.dispose();
    image = null;
  }
}
