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
  FutureOr<void> build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [bool foreground = false]) {
    _updateRect();
    final shape = element.property.shape;
    final strokeWidth = element.property.strokeWidth;
    final paint = _buildPaint();
    final drawRect = rect.inflate(-strokeWidth);
    if (shape is RectangleShape) {
      // Percentage-based radius
      final topLeftCornerRadius = Radius.circular(
          shape.topLeftCornerRadius / 100 * drawRect.shortestSide);
      final topRightCornerRadius = Radius.circular(
          shape.topRightCornerRadius / 100 * drawRect.shortestSide);
      final bottomLeftCornerRadius = Radius.circular(
          shape.bottomLeftCornerRadius / 100 * drawRect.shortestSide);
      final bottomRightCornerRadius = Radius.circular(
          shape.bottomRightCornerRadius / 100 * drawRect.shortestSide);
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          drawRect,
          topLeft: topLeftCornerRadius,
          topRight: topRightCornerRadius,
          bottomLeft: bottomLeftCornerRadius,
          bottomRight: bottomRightCornerRadius,
        ),
        _buildPaint(color: Color(shape.fillColor), style: PaintingStyle.fill),
      );
      if (strokeWidth > 0) {
        canvas.drawRRect(
          RRect.fromRectAndCorners(
            drawRect,
            topLeft: topLeftCornerRadius,
            topRight: topRightCornerRadius,
            bottomLeft: bottomLeftCornerRadius,
            bottomRight: bottomRightCornerRadius,
          ),
          paint,
        );
      }
    } else if (shape is CircleShape) {
      canvas.drawOval(
          drawRect,
          _buildPaint(
              color: Color(shape.fillColor), style: PaintingStyle.fill));
      if (strokeWidth > 0) {
        canvas.drawOval(drawRect, paint);
      }
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
    final strokeWidth = element.property.strokeWidth;
    final drawRect = rect.inflate(-strokeWidth);
    if (shape is RectangleShape) {
      final topLeftRadius =
          shape.topLeftCornerRadius / 100 * drawRect.shortestSide;
      final topRightRadius =
          shape.topRightCornerRadius / 100 * drawRect.shortestSide;
      final bottomLeftRadius =
          shape.bottomLeftCornerRadius / 100 * drawRect.shortestSide;
      final bottomRightRadius =
          shape.bottomRightCornerRadius / 100 * drawRect.shortestSide;
      // Build d path with radius
      var d = 'M${drawRect.left + topLeftRadius} ${drawRect.top} ';
      // Top right corner
      d += 'L${drawRect.right - topRightRadius} ${drawRect.top} ';
      d += 'A$topRightRadius $topRightRadius 0 0 1 ';
      d += '${drawRect.right} ${drawRect.top + topRightRadius} ';
      // Bottom right corner
      d += 'L${drawRect.right} ${drawRect.bottom - bottomRightRadius} ';
      d += 'A$bottomRightRadius $bottomRightRadius 0 0 1 ';
      d += '${drawRect.right - bottomRightRadius} ${drawRect.bottom} ';
      // Bottom left corner
      d += 'L${drawRect.left + bottomLeftRadius} ${drawRect.bottom} ';
      d += 'A$bottomLeftRadius $bottomLeftRadius 0 0 1 ';
      d += '${drawRect.left} ${drawRect.bottom - bottomLeftRadius} ';
      // Top left corner
      d += 'L${drawRect.left} ${drawRect.top + topLeftRadius} ';
      d += 'A$topLeftRadius $topLeftRadius 0 0 1 ';
      d += '${drawRect.left + topLeftRadius} ${drawRect.top} ';
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
        'ellipse',
        attributes: {
          'cx': '${drawRect.center.dx}',
          'cy': '${drawRect.center.dy}',
          'rx': '${drawRect.width / 2}',
          'ry': '${drawRect.height / 2}',
          'fill': shape.fillColor.toHexColor(),
          'stroke': element.property.color.toHexColor(),
          'stroke-width': '${element.property.strokeWidth}px',
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
  ShapeRenderer transform(
      {Offset position = Offset.zero,
      double scaleX = 1,
      double scaleY = 1,
      bool relative = false}) {
    if (relative) {
      var newFirstPos = element.firstPosition + position;
      var newSecondPos = element.secondPosition + position;
      // Apply scale
      if (newFirstPos.dx > newSecondPos.dx) {
        newFirstPos = Offset(newFirstPos.dx * scaleX, newFirstPos.dy);
      } else {
        newSecondPos = Offset(newSecondPos.dx * scaleX, newSecondPos.dy);
      }
      if (newFirstPos.dy > newSecondPos.dy) {
        newFirstPos = Offset(newFirstPos.dx, newFirstPos.dy * scaleY);
      } else {
        newSecondPos = Offset(newSecondPos.dx, newSecondPos.dy * scaleY);
      }
      var rect = Rect.fromPoints(newFirstPos, newSecondPos).normalized();
      rect = rect.topLeft & Size(rect.width * scaleX, rect.height * scaleY);
      return ShapeRenderer(
          element.copyWith(
            firstPosition: element.firstPosition + position,
            secondPosition: element.secondPosition + position,
          ),
          rect);
    }
    // Center of firstPosition and secondPosition
    final center = (element.firstPosition + element.secondPosition) / 2;
    // Apply scale
    final newFirstPos = (element.firstPosition - center) * scaleX + center;
    final newSecondPos = (element.secondPosition - center) * scaleY + center;
    var rect = Rect.fromPoints(newFirstPos, newSecondPos).normalized();
    rect = rect.topLeft & Size(rect.width * scaleX, rect.height * scaleY);
    return ShapeRenderer(
        element.copyWith(
          firstPosition: rect.topLeft,
          secondPosition: rect.topRight,
        ),
        rect);
  }

  @override
  HitCalculator getHitCalculator() => ShapeHitCalculator(element, rect);
}

class ShapeHitCalculator extends HitCalculator {
  final ShapeElement element;
  final Rect rect;

  ShapeHitCalculator(this.element, this.rect);

  @override
  bool hit(Rect rect) {
    if (!this.rect.inflate(element.property.strokeWidth).overlaps(rect)) {
      return false;
    }
    final shape = element.property.shape;
    if (shape is RectangleShape) {
      return !this.rect.deflate(element.property.strokeWidth).overlaps(rect);
    }
    if (shape is CircleShape) {
      // Test if rect is inside circle
      final circleRect = this.rect.inflate(element.property.strokeWidth);
      final circleCenter = circleRect.center;
      final circleRadius = circleRect.width / 2;
      final topLeft = rect.topLeft;
      final topRight = rect.topRight;
      final bottomLeft = rect.bottomLeft;
      final bottomRight = rect.bottomRight;
      return (topLeft - circleCenter).distance <= circleRadius &&
          (topRight - circleCenter).distance <= circleRadius &&
          (bottomLeft - circleCenter).distance <= circleRadius &&
          (bottomRight - circleCenter).distance <= circleRadius;
    }
    if (shape is LineShape) {
      final firstX = min(element.firstPosition.dx, element.secondPosition.dx);
      final firstY = min(element.firstPosition.dy, element.secondPosition.dy);
      final secondX = max(element.firstPosition.dx, element.secondPosition.dx);
      final secondY = max(element.firstPosition.dy, element.secondPosition.dy);
      final firstPos = Offset(firstX, firstY);
      final secondPos = Offset(secondX, secondY);
      return rect.containsLine(firstPos, secondPos);
    }
    return false;
  }
}
