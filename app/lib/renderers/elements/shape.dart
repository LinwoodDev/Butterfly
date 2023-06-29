part of '../renderer.dart';

class ShapeRenderer extends Renderer<ShapeElement> {
  @override
  Rect rect;

  ShapeRenderer(super.element, [this.rect = Rect.zero]);

  @override
  FutureOr<void> setup(
      NoteData document, AssetService assetService, DocumentPage page) async {
    _updateRect();
    await super.setup(document, assetService, page);
    _updateRect();
  }

  @override
  FutureOr<bool> onAreaUpdate(DocumentPage page, Area? area) async {
    await super.onAreaUpdate(page, area);
    _updateRect();
    return true;
  }

  void _updateRect() {
    rect = Rect.fromPoints(
        element.firstPosition.toOffset(), element.secondPosition.toOffset());
  }

  @override
  FutureOr<void> build(Canvas canvas, Size size, NoteData document,
      DocumentPage page, DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    _updateRect();
    final shape = element.property.shape;
    final strokeWidth = element.property.strokeWidth;
    final paint = _buildPaint();
    final drawRect = rect.inflate(-strokeWidth / 2);
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
            rect,
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
        canvas.drawOval(rect, paint);
      }
    } else if (shape is LineShape) {
      canvas.drawLine(element.firstPosition.toOffset(),
          element.secondPosition.toOffset(), paint);
    }
  }

  Paint _buildPaint({Color? color, PaintingStyle? style}) => Paint()
    ..color = color ?? Color(element.property.color)
    ..strokeWidth = element.property.strokeWidth
    ..style = style ?? PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  @override
  void buildSvg(XmlDocument xml, DocumentPage page, Rect viewportRect) {
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
          'x1': '${element.firstPosition.x}px',
          'y1': '${element.firstPosition.y}px',
          'x2': '${element.secondPosition.x}px',
          'y2': '${element.secondPosition.y}px',
          'stroke-width': '${element.property.strokeWidth}px',
          'stroke': element.property.color.toHexColor(),
          'fill': 'none',
        },
      );
    }
  }

  @override
  ShapeRenderer transform({
    Offset position = Offset.zero,
    double rotation = 0,
    double scaleX = 1,
    double scaleY = 1,
    bool relative = false,
  }) {
    var rect = this.rect;
    var delta = relative ? position : (position - rect.topLeft);
    var newFirstPos = element.firstPosition.toOffset() + delta;
    var newSecondPos = element.secondPosition.toOffset() + delta;
    var newRect = rect.translate(delta.dx, delta.dy);
    final topLeft = newRect.topLeft;

    newFirstPos = topLeft + (newFirstPos - topLeft).scale(scaleX, scaleY);
    newSecondPos = topLeft + (newSecondPos - topLeft).scale(scaleX, scaleY);

    newRect = newRect.topLeft &
        Size(
          newRect.width * scaleX,
          newRect.height * scaleY,
        );
    return ShapeRenderer(
      element.copyWith(
        firstPosition: newFirstPos.toPoint(),
        secondPosition: newSecondPos.toPoint(),
        rotation: relative ? element.rotation + rotation : rotation,
      ),
      newRect,
    );
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
    bool containsRect() {
      final lrt = rect.containsLine(
        Offset(this.rect.left, this.rect.top),
        Offset(this.rect.right, this.rect.top),
      );
      final tbr = rect.containsLine(
        Offset(this.rect.right, this.rect.top),
        Offset(this.rect.right, this.rect.bottom),
      );
      final lrb = rect.containsLine(
        Offset(this.rect.left, this.rect.bottom),
        Offset(this.rect.right, this.rect.bottom),
      );
      final tbl = rect.containsLine(
        Offset(this.rect.left, this.rect.top),
        Offset(this.rect.left, this.rect.bottom),
      );
      return lrt || tbr || lrb || tbl;
    }

    return shape.map(
        circle: (e) => containsRect(),
        rectangle: (e) => containsRect(),
        line: (e) {
          final firstX = min(element.firstPosition.x, element.secondPosition.x);
          final firstY = min(element.firstPosition.y, element.secondPosition.y);
          final secondX =
              max(element.firstPosition.x, element.secondPosition.x);
          final secondY =
              max(element.firstPosition.y, element.secondPosition.y);
          final firstPos = Offset(firstX, firstY);
          final secondPos = Offset(secondX, secondY);
          return rect.containsLine(firstPos, secondPos);
        });
  }
}
