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
    rect = Rect.fromPoints(element.firstPosition, element.secondPosition);
  }

  @override
  FutureOr<void> build(Canvas canvas, Size size, CameraTransform transform,
      [bool foreground = false]) {
    final shape = element.property.shape;
    final paint = _buildPaint();
    final innerRect = rect.inflate(element.property.strokeWidth);
    if (shape is RectangleShape) {
      // Percentage-based radius
      final radius = shape.cornerRadius / 100 * rect.shortestSide;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(radius),
        ),
        paint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          innerRect,
          Radius.circular(radius),
        ),
        _buildPaint(color: Color(shape.fillColor), style: PaintingStyle.fill),
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
  void buildSvg(XmlDocument xml, AppDocument document, Rect rect) {
    if (!this.rect.overlaps(rect)) return;
    final shape = element.property.shape;
    final innerRect = rect.inflate(element.property.strokeWidth);
    if (shape is RectangleShape) {
      xml.getElement('svg')?.createElement(
        'rect',
        attributes: {
          'x': '${rect.top}px',
          'y': '${rect.left}px',
          'width': '${rect.width}px',
          'height': '${rect.height}px',
          'rx': '${shape.cornerRadius}%',
          'stroke-width': '${element.property.strokeWidth}px',
          'stroke': element.property.color.toHex(),
        },
      ).createElement(
        'rect',
        attributes: {
          'x': '${innerRect.top}px',
          'y': '${innerRect.left}px',
          'width': '${innerRect.width}px',
          'height': '${innerRect.height}px',
          'rx': '${shape.cornerRadius}%',
          'fill': shape.fillColor.toHex(),
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
          'stroke': element.property.color.toHex(),
        },
      ).createElement(
        'circle',
        attributes: {
          'cx': '${innerRect.center.dx}px',
          'cy': '${innerRect.center.dy}px',
          'r': '${innerRect.width / 2}px',
          'fill': shape.fillColor.toHex(),
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
          'stroke': element.property.color.toHex(),
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
