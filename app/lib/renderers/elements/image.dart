part of '../renderer.dart';

class ImageRenderer extends Renderer<ImageElement> {
  ui.Image? image;

  ImageRenderer(super.element, [this.image]);

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    if (image == null) {
      // Render placeholder
      final paint = Paint()
        ..color = Colors.grey
        ..style = PaintingStyle.fill;
      canvas.drawRect(rect, paint);
      return;
    }
    var paint = Paint();

    canvas.drawImageRect(
      image!.clone(),
      Rect.fromLTWH(0, 0, element.width.toDouble(), element.height.toDouble()),
      rect,
      paint,
    );
  }

  @override
  void buildSvg(XmlDocument xml, AppDocument document, Rect viewportRect) {
    if (!rect.overlaps(rect)) return;
    // Create data url
    final data = element.pixels;
    final encoded = base64Encode(data);
    final dataUrl = 'data:image/png;base64,$encoded';
    // Create image
    xml.getElement('svg')?.createElement('image', attributes: {
      'x': '${rect.left}px',
      'y': '${rect.top}px',
      'width': '${rect.width}px',
      'height': '${rect.height}px',
      'xlink:href': dataUrl,
    });
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
      final scaleX = constraints.scaleX <= 0 ? 1 : constraints.scaleX;
      final scaleY = constraints.scaleY <= 0 ? 1 : constraints.scaleY;
      return Rect.fromLTWH(
          element.position.x,
          element.position.y,
          (element.width * scaleX).toDouble(),
          (element.height * scaleY).toDouble());
    } else if (constraints is FixedElementConstraints) {
      var height = constraints.height;
      var width = constraints.width;
      if (height <= 0) height = element.height.toDouble();
      if (width <= 0) width = element.width.toDouble();
      return Rect.fromLTWH(
          element.position.x, element.position.y, width, height);
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
        final right = element.position.x + element.width;
        width = min(rightArea, right) - element.position.x;
        final bottomArea = areaRect?.bottom ?? 0;
        final bottom = element.position.y + element.height;
        height = min(bottomArea, bottom) - element.position.y;
      }
      if (height <= 0) height = element.height.toDouble();
      if (width <= 0) width = element.width.toDouble();
      return Rect.fromLTWH(
          element.position.x, element.position.y, width, height);
    } else {
      return Rect.fromLTWH(element.position.x, element.position.y,
          element.width.toDouble(), element.height.toDouble());
    }
  }

  @override
  ImageRenderer transform(
      {Offset position = Offset.zero,
      double scaleX = 1,
      double scaleY = 1,
      bool relative = false}) {
    return ImageRenderer(
        element.copyWith(
          position: relative
              ? element.position + position.toPoint()
              : position.toPoint() - Point(rect.width / 2, rect.height / 2),
          constraints: element.constraints.scale(scaleX, scaleY),
        ),
        image);
  }
}
