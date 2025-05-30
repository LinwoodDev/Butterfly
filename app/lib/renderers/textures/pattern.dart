part of 'texture.dart';

void drawPatternTextureOnCanvas(
  PatternTexture texture,
  Canvas canvas,
  double scale,
  Offset offset,
  Size size, [
  Offset translation = Offset.zero,
  bool extraLines = false,
]) {
  canvas.drawRect(
    Rect.fromLTWH(translation.dx, translation.dy, size.width, size.height),
    Paint()
      ..color = texture.boxColor.toColor()
      ..style = PaintingStyle.fill,
  );
  if (scale <= 0) return;
  if (texture.boxWidth > 0 && texture.boxXCount > 0) {
    var relativeWidth = texture.boxWidth * scale;
    var relativeSpace = texture.boxXSpace * scale;
    final part = texture.boxWidth * texture.boxXCount + texture.boxXSpace;
    int xCount = (offset.dx / part).floor();
    if (extraLines) xCount--;
    double x = xCount * part - offset.dx;
    x *= scale;

    int count = 0;
    while (x < size.width) {
      canvas.drawLine(
        Offset(x + translation.dx, 0 + translation.dy),
        Offset(x + translation.dx, size.height + translation.dy),
        Paint()
          ..strokeWidth = texture.boxXStroke * scale
          ..color = texture.boxXColor.toColor(),
      );
      count++;
      if (count >= texture.boxXCount) {
        count = 0;
        x += relativeSpace;
      }
      x += relativeWidth;
    }
  }
  if (texture.boxHeight > 0 && texture.boxYCount > 0) {
    var relativeHeight = texture.boxHeight * scale;
    var relativeSpace = texture.boxYSpace * scale;
    final part = texture.boxHeight * texture.boxYCount + texture.boxYSpace;
    int yCount = (offset.dy / part).floor();
    if (extraLines) yCount--;
    double y = yCount * part + -offset.dy;
    y *= scale;
    int count = 0;
    while (y < size.height) {
      canvas.drawLine(
        Offset(0 + translation.dx, y + translation.dy),
        Offset(size.width + translation.dx, y + translation.dy),
        Paint()
          ..strokeWidth = texture.boxYStroke * scale
          ..color = texture.boxYColor.toColor(),
      );
      count++;
      if (count >= texture.boxYCount) {
        count = 0;
        y += relativeSpace;
      }
      y += relativeHeight;
    }
  }
}

void drawPatternTextureOnSvg(
  PatternTexture texture,
  XmlDocument xml,
  Offset offset,
  Size size, [
  Offset translation = Offset.zero,
]) {
  final id = createUniqueId();
  var g = xml
      .getOrCreateElement('svg')
      .createElement('g', id: 'pattern-texture-$id');

  g.createElement(
    'rect',
    attributes: {
      'x': '${offset.dx + translation.dx}px',
      'y': '${offset.dy + translation.dy}px',
      'width': '${size.width}px',
      'height': '${size.height}px',
      'fill': texture.boxColor.toHexString(),
    },
  );
  if (texture.boxWidth > 0 && texture.boxXCount > 0) {
    final part = texture.boxWidth * texture.boxXCount + texture.boxXSpace;
    int xCount = (offset.dx / part).floor();
    double x = -xCount * part + offset.dx;

    int count = 0;
    while (x < size.width) {
      g.createElement(
        'line',
        attributes: {
          'x1': '${x + offset.dx + translation.dx}px',
          'y1': '${offset.dy + translation.dy}px',
          'x2': '${x + offset.dx + translation.dx}px',
          'y2': '${offset.dy + size.height + translation.dy}px',
          'stroke': texture.boxXColor.toHexString(),
          'stroke-width': '${texture.boxXStroke}',
        },
      );
      count++;
      if (count >= texture.boxXCount) {
        count = 0;
        x += texture.boxXSpace;
      }
      x += texture.boxWidth;
    }
  }
  if (texture.boxHeight > 0 && texture.boxYCount > 0) {
    final part = texture.boxHeight * texture.boxYCount + texture.boxYSpace;
    int yCount = (offset.dy / part).floor();
    double y = -yCount * part + offset.dy;

    int count = 0;
    while (y < size.height) {
      g.createElement(
        'line',
        attributes: {
          'x1': '${offset.dx + translation.dx}px',
          'y1': '${y + offset.dy + translation.dy}px',
          'x2': '${offset.dx + size.width + translation.dx}px',
          'y2': '${y + offset.dy + translation.dy}px',
          'stroke': texture.boxYColor.toHexString(),
          'stroke-width': '${texture.boxYStroke}',
        },
      );
      count++;
      if (count >= texture.boxYCount) {
        count = 0;
        y += texture.boxYSpace;
      }
      y += texture.boxHeight;
    }
  }
}
