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
      final radius = shape.cornerRadius / 100 * rect.shortestSide;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          innerRect,
          Radius.circular(radius),
        ),
        _buildPaint(color: Color(shape.fillColor), style: PaintingStyle.fill),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(radius),
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
  void buildSvg(XmlDocument xml, AppDocument document, Rect rect) {
    if (!this.rect.overlaps(rect)) return;
    final shape = element.property.shape;
    if (shape is RectangleShape) {
      xml.getElement('svg')?.createElement(
        'rect',
        attributes: {
          'x': '${this.rect.left}px',
          'y': '${this.rect.top}px',
          'width': '${this.rect.width}px',
          'height': '${this.rect.height}px',
          'rx': '${shape.cornerRadius}%',
          'stroke-width': '${element.property.strokeWidth}px',
          'stroke': element.property.color.toHexColor(),
          'fill': shape.fillColor.toHexColor(),
        },
      );
    } else if (shape is CircleShape) {
      xml.getElement('svg')?.createElement(
        'circle',
        attributes: {
          'cx': '${this.rect.center.dx}px',
          'cy': '${this.rect.center.dy}px',
          'r': '${this.rect.width / 2}px',
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
