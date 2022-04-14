part of '../renderer.dart';

class ImageRenderer extends Renderer<ImageElement> {
  Image? image;

  ImageRenderer(ImageElement element, [this.image]) : super(element);

  @override
  FutureOr<void> build(Canvas canvas, Size size, CameraTransform transform,
      [bool foreground = false]) async {
    if (image == null) return;
    var paint = Paint()..isAntiAlias = true;
    canvas.drawImageRect(
      image!,
      Rect.fromLTWH(0, 0, element.width.toDouble(), element.height.toDouble()),
      rect,
      paint,
    );
  }

  @override
  FutureOr<void> setup(AppDocument document) async {
    image = await decodeImageFromList(element.pixels);
    super.setup(document);
  }

  @override
  Rect get rect {
    final scale = element.scale <= 0 ? 1 : element.scale;
    return Rect.fromLTWH(
        element.position.dx,
        element.position.dy,
        (element.width * scale).toDouble(),
        (element.height * scale).toDouble());
  }

  @override
  Renderer<ImageElement> move(Offset position) {
    return ImageRenderer(element.copyWith(position: position), image);
  }
}
