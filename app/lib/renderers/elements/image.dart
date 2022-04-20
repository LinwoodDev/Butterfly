part of '../renderer.dart';

class ImageRenderer extends Renderer<ImageElement> {
  Image? image;

  ImageRenderer(ImageElement element, [this.image]) : super(element);

  @override
  void build(Canvas canvas, Size size, CameraTransform transform,
      [bool foreground = false]) {
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
  void buildSvg(XmlDocument xml, AppDocument document, Rect rect) {
    // Create data url
    final data = element.pixels;
    final encoded = base64Encode(data);
    final dataUrl = 'data:image/png;base64,$encoded';
    // Create image
    xml.getElement('svg')?.createElement('image', attributes: {
      'x': '${this.rect.left}',
      'y': '${this.rect.top}',
      'width': '${this.rect.width}',
      'height': '${this.rect.height}',
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
      final scale = constraints.scale <= 0 ? 1 : constraints.scale;
      return Rect.fromLTWH(
          element.position.dx,
          element.position.dy,
          (element.width * scale).toDouble(),
          (element.height * scale).toDouble());
    } else if (constraints is FixedElementConstraints) {
      var height = constraints.height;
      var width = constraints.width;
      if (height <= 0) height = element.height.toDouble();
      if (width <= 0) width = element.width.toDouble();
      return Rect.fromLTWH(
          element.position.dx, element.position.dy, width, height);
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
      if (height <= 0) height = element.height.toDouble();
      if (width <= 0) width = element.width.toDouble();
      return Rect.fromLTWH(
          element.position.dx, element.position.dy, width, height);
    } else {
      return Rect.fromLTWH(element.position.dx, element.position.dy,
          element.width.toDouble(), element.height.toDouble());
    }
  }

  @override
  ImageElement move(Offset position) => element.copyWith(position: position);
}
