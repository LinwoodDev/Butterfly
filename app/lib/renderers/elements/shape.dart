part of '../renderer.dart';

class ShapeRenderer extends Renderer<ShapeElement> {
  @override
  Rect rect;

  ShapeRenderer(super.element, [this.rect = Rect.zero]);

  @override
  FutureOr<void> setup(AppDocument document) async {
    _updateRect();
    await super.setup(document);
    _updateRect();
  }

  @override
  FutureOr<bool> onAreaUpdate(AppDocument document, Area? area) async {
    await super.onAreaUpdate(document, area);
    _updateRect();
    return true;
  }

  void _updateRect() {
    final shape = element.property.shape;
    rect = Rect.fromPoints(element.firstPosition, element.secondPosition);
    if (shape is CircleShape) {
      rect = Rect.fromCircle(center: rect.center, radius: rect.width / 2);
    }
  }

  @override
  FutureOr<void> build(Canvas canvas, Size size, CameraTransform transform,
      [bool foreground = false]) {
    final shape = element.property.shape;
    final paint = _buildPaint();
    final innerRect = rect.inflate(element.property.strokeWidth / -2);
    if (shape is RectangleShape) {
      // Percentage-based radius
      final topLeftCornerRadius =
          Radius.circular(shape.topLeftCornerRadius / 100 * rect.shortestSide);
      final topRightCornerRadius =
          Radius.circular(shape.topRightCornerRadius / 100 * rect.shortestSide);
      final bottomLeftCornerRadius = Radius.circular(
          shape.bottomLeftCornerRadius / 100 * rect.shortestSide);
      final bottomRightCornerRadius = Radius.circular(
          shape.bottomRightCornerRadius / 100 * rect.shortestSide);
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          innerRect,
          topLeft: topLeftCornerRadius,
          topRight: topRightCornerRadius,
          bottomLeft: bottomLeftCornerRadius,
          bottomRight: bottomRightCornerRadius,
        ),
        _buildPaint(color: Color(shape.fillColor), style: PaintingStyle.fill),
      );
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          rect,
          topLeft: topLeftCornerRadius,
          topRight: topRightCornerRadius,
          bottomLeft: bottomLeftCornerRadius,
          bottomRight: bottomRightCornerRadius,
        ),
        paint,
      );
    } else if (shape is CircleShape) {
      canvas.drawCircle(rect.center, rect.width / 2, paint);
      canvas.drawCircle(
          innerRect.center,
          innerRect.width / 2,
          _buildPaint(
              color: Color(shape.fillColor), style: PaintingStyle.fill));
    } else if (shape is LineShape) {
      canvas.drawLine(element.firstPosition, element.secondPosition, paint);
    }
  }

  Paint _buildPaint({Color? color, PaintingStyle? style}) => Paint()
    ..color = color ?? Color(element.property.color)
    ..strokeWidth = element.property.strokeWidth
    ..style = style ?? PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  @override
  void buildSvg(XmlDocument xml, AppDocument document, Rect viewportRect) {
    if (!rect.overlaps(rect)) return;
    final shape = element.property.shape;
    if (shape is RectangleShape) {
      final topLeftRadius = shape.topLeftCornerRadius / 100 * rect.shortestSide;
      final topRightRadius =
          shape.topRightCornerRadius / 100 * rect.shortestSide;
      final bottomLeftRadius =
          shape.bottomLeftCornerRadius / 100 * rect.shortestSide;
      final bottomRightRadius =
          shape.bottomRightCornerRadius / 100 * rect.shortestSide;
      // Build d path with radius
      var d = 'M${rect.left + topLeftRadius} ${rect.top} ';
      // Top right corner
      d += 'L${rect.right - topRightRadius} ${rect.top} ';
      d += 'A$topRightRadius $topRightRadius 0 0 1 ';
      d += '${rect.right} ${rect.top + topRightRadius} ';
      // Bottom right corner
      d += 'L${rect.right} ${rect.bottom - bottomRightRadius} ';
      d += 'A$bottomRightRadius $bottomRightRadius 0 0 1 ';
      d += '${rect.right - bottomRightRadius} ${rect.bottom} ';
      // Bottom left corner
      d += 'L${rect.left + bottomLeftRadius} ${rect.bottom} ';
      d += 'A$bottomLeftRadius $bottomLeftRadius 0 0 1 ';
      d += '${rect.left} ${rect.bottom - bottomLeftRadius} ';
      // Top left corner
      d += 'L${rect.left} ${rect.top + topLeftRadius} ';
      d += 'A$topLeftRadius $topLeftRadius 0 0 1 ';
      d += '${rect.left + topLeftRadius} ${rect.top} ';
      d += 'Z';
      xml.getElement('svg')?.createElement(
        'path',
        attributes: {
          'd': d,
          'fill': shape.fillColor.toHexColor(),
          'stroke': element.property.color.toHexColor(),
          'stroke-width': '${element.property.strokeWidth}px',
        },
      );
    } else if (shape is CircleShape) {
      xml.getElement('svg')?.createElement(
        'circle',
        attributes: {
          'cx': '${rect.center.dx}px',
          'cy': '${rect.center.dy}px',
          'r': '${rect.width / 2}px',
          'stroke-width': '${element.property.strokeWidth}px',
          'stroke': element.property.color.toHexColor(),
          'fill': shape.fillColor.toHexColor(),
        },
      );
    } else if (shape is LineShape) {
      xml.getElement('svg')?.createElement(
        'line',
        attributes: {
          'x1': '${element.firstPosition.dx}px',
          'y1': '${element.firstPosition.dy}px',
          'x2': '${element.secondPosition.dx}px',
          'y2': '${element.secondPosition.dy}px',
          'stroke-width': '${element.property.strokeWidth}px',
          'stroke': element.property.color.toHexColor(),
          'fill': 'none',
        },
      );
    }
  }

  @override
  ShapeElement move(Offset position) {
    // Center of firstPosition and secondPosition
    final elementPosition =
        Rect.fromPoints(element.firstPosition, element.secondPosition).center;
    final offset = position - elementPosition;
    return element.copyWith(
      firstPosition: element.firstPosition + offset,
      secondPosition: element.secondPosition + offset,
    );
  }
}
