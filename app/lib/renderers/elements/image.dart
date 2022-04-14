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
    final constraints = element.constraints;
    if (constraints is ScaledElementConstraints) {
      final scale = constraints.scale <= 0 ? 1 : constraints.scale;
      return Rect.fromLTWH(
          element.position.dx,
          element.position.dy,
          (element.width * scale).toDouble(),
          (element.height * scale).toDouble());
    } else if (constraints is FixedElementConstraints) {
      return Rect.fromLTWH(element.position.dx, element.position.dy,
          constraints.width, constraints.height);
    } else if (constraints is DynamicElementConstraints) {
      var width = constraints.width;
      var height = constraints.height;
      final ratio = constraints.aspectRatio;
      if (ratio != 0) {
        if (width <= 0) width = height * ratio;
        if (height <= 0) height = width / ratio;
      }
      if (constraints.includeArea) {
        final areaRect = area?.rect;
        final rightArea = areaRect?.right ?? 0;
        final right = element.position.dx + element.width;
        width = min(rightArea, right) - element.position.dx;
        final bottomArea = areaRect?.bottom ?? 0;
        final bottom = element.position.dy + element.height;
        height = min(bottomArea, bottom) - element.position.dy;
      }
      return Rect.fromLTWH(
          element.position.dx, element.position.dy, width, height);
    } else {
      return Rect.fromLTWH(element.position.dx, element.position.dy,
          element.width.toDouble(), element.height.toDouble());
    }
  }

  @override
  Renderer<ImageElement> move(Offset position) {
    return ImageRenderer(element.copyWith(position: position), image);
  }
}
