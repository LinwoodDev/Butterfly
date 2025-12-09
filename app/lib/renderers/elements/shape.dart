part of '../renderer.dart';

class ShapeRenderer extends Renderer<ShapeElement> {
  @override
  Rect get rect => Rect.fromPoints(
    element.firstPosition.toOffset(),
    element.secondPosition.toOffset(),
  );

  ShapeRenderer(super.element, [super.layer]);

  /// Creates a dashed path from the source path based on stroke style
  Path _createDashedPath(Path source, StrokeStyle strokeStyle) {
    if (strokeStyle == StrokeStyle.solid) return source;

    final strokeWidth = element.property.strokeWidth;
    final dashLength = strokeStyle == StrokeStyle.dashed
        ? strokeWidth * 3 // Dashed: 3x stroke width
        : strokeWidth; // Dotted: 1x stroke width
    final gapLength = strokeWidth * 2;

    final dashedPath = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final length = draw ? dashLength : gapLength;
        final end = (distance + length).clamp(0.0, metric.length);
        if (draw) {
          dashedPath.addPath(
            metric.extractPath(distance, end),
            Offset.zero,
          );
        }
        distance = end;
        draw = !draw;
      }
    }
    return dashedPath;
  }

  /// Draws a path with the appropriate stroke style (solid, dashed, or dotted)
  void _drawStyledPath(Canvas canvas, Path path, Paint paint) {
    final strokeStyle = element.property.strokeStyle;
    if (strokeStyle == StrokeStyle.solid) {
      canvas.drawPath(path, paint);
    } else {
      final dashedPath = _createDashedPath(path, strokeStyle);
      canvas.drawPath(dashedPath, paint);
    }
  }

  @override
  void build(
    Canvas canvas,
    Size size,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    CameraTransform transform, [
    ColorScheme? colorScheme,
    bool foreground = false,
  ]) {
    final shape = element.property.shape;
    final strokeWidth = element.property.strokeWidth;
    final paint = _buildPaint();
    final drawRect = rect.inflate(-strokeWidth / 2);
    if (shape is RectangleShape) {
      // Percentage-based radius
      final topLeftCornerRadius = Radius.circular(
        shape.topLeftCornerRadius / 100 * drawRect.shortestSide,
      );
      final topRightCornerRadius = Radius.circular(
        shape.topRightCornerRadius / 100 * drawRect.shortestSide,
      );
      final bottomLeftCornerRadius = Radius.circular(
        shape.bottomLeftCornerRadius / 100 * drawRect.shortestSide,
      );
      final bottomRightCornerRadius = Radius.circular(
        shape.bottomRightCornerRadius / 100 * drawRect.shortestSide,
      );
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          drawRect,
          topLeft: topLeftCornerRadius,
          topRight: topRightCornerRadius,
          bottomLeft: bottomLeftCornerRadius,
          bottomRight: bottomRightCornerRadius,
        ),
        _buildPaint(
          color: shape.fillColor.toColor(),
          style: PaintingStyle.fill,
        ),
      );
      if (strokeWidth > 0) {
        final rrect = RRect.fromRectAndCorners(
          rect,
          topLeft: topLeftCornerRadius,
          topRight: topRightCornerRadius,
          bottomLeft: bottomLeftCornerRadius,
          bottomRight: bottomRightCornerRadius,
        );
        final path = Path()..addRRect(rrect);
        _drawStyledPath(canvas, path, paint);
      }
    } else if (shape is CircleShape) {
      canvas.drawOval(
        drawRect,
        _buildPaint(
          color: shape.fillColor.toColor(),
          style: PaintingStyle.fill,
        ),
      );
      if (strokeWidth > 0) {
        final path = Path()..addOval(rect);
        _drawStyledPath(canvas, path, paint);
      }
    } else if (shape is LineShape) {
      final path = Path()
        ..moveTo(element.firstPosition.x, element.firstPosition.y)
        ..lineTo(element.secondPosition.x, element.secondPosition.y);
      _drawStyledPath(canvas, path, paint);
    } else if (shape is TriangleShape) {
      final topCenter = drawRect.topCenter;
      final path = Path()
        ..moveTo(topCenter.dx, topCenter.dy)
        ..lineTo(drawRect.right, drawRect.bottom)
        ..lineTo(drawRect.left, drawRect.bottom)
        ..close();
      canvas.drawPath(
        path,
        _buildPaint(
          color: shape.fillColor.toColor(),
          style: PaintingStyle.fill,
        ),
      );
      if (strokeWidth > 0) {
        _drawStyledPath(canvas, path, paint);
      }
    }
  }

  Paint _buildPaint({Color? color, PaintingStyle? style}) => Paint()
    ..color = color ?? element.property.color.toColor()
    ..strokeWidth = element.property.strokeWidth
    ..style = style ?? PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  /// Returns SVG stroke-dasharray attribute value based on stroke style
  String? _getSvgDashArray() {
    final strokeWidth = element.property.strokeWidth;
    return switch (element.property.strokeStyle) {
      StrokeStyle.solid => null,
      StrokeStyle.dotted => '$strokeWidth,${strokeWidth * 2}',
      StrokeStyle.dashed => '${strokeWidth * 3},${strokeWidth * 2}',
    };
  }

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) {
    if (!rect.overlaps(viewportRect)) return;
    final shape = element.property.shape;
    final strokeWidth = element.property.strokeWidth;
    final drawRect = rect.inflate(-strokeWidth);
    final dashArray = _getSvgDashArray();

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
          'fill': shape.fillColor.toHexString(),
          'stroke': element.property.color.toHexString(),
          'stroke-width': '${element.property.strokeWidth}px',
          if (dashArray != null) 'stroke-dasharray': dashArray,
        },
      );
    } else if (shape is CircleShape) {
      xml.getElement('svg')?.createElement(
        'ellipse',
        attributes: {
          'cx': '${drawRect.center.dx}',
          'cy': '${drawRect.center.dy}',
          'rx': '${(drawRect.width / 2).abs()}',
          'ry': '${(drawRect.height / 2).abs()}',
          'fill': shape.fillColor.toHexString(),
          'stroke': element.property.color.toHexString(),
          'stroke-width': '${element.property.strokeWidth}px',
          if (dashArray != null) 'stroke-dasharray': dashArray,
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
          'stroke': element.property.color.toHexString(),
          'fill': 'none',
          if (dashArray != null) 'stroke-dasharray': dashArray,
        },
      );
    } else if (shape is TriangleShape) {
      final topCenter = drawRect.topCenter;
      final d =
          'M${topCenter.dx} ${topCenter.dy} '
          'L${drawRect.right} ${drawRect.bottom} '
          'L${drawRect.left} ${drawRect.bottom} Z';
      xml.getElement('svg')?.createElement(
        'path',
        attributes: {
          'd': d,
          'fill': shape.fillColor.toHexString(),
          'stroke': element.property.color.toHexString(),
          'stroke-width': '${element.property.strokeWidth}px',
          if (dashArray != null) 'stroke-dasharray': dashArray,
        },
      );
    }
  }

  @override
  ShapeRenderer _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) {
    final rect = this.rect;
    final previous = rect.topLeft;
    final localFirst = element.firstPosition.toOffset() - previous;
    final localSecond = element.secondPosition.toOffset() - previous;
    return ShapeRenderer(
      element.copyWith(
        firstPosition: (localFirst.scale(scaleX, scaleY) + position).toPoint(),
        secondPosition: (localSecond.scale(scaleX, scaleY) + position)
            .toPoint(),
        rotation: rotation,
      ),
      layer,
    );
  }

  @override
  HitCalculator getHitCalculator() =>
      ShapeHitCalculator(element, rect, rotation * pi / 180);
}

class ShapeHitCalculator extends HitCalculator {
  final ShapeElement element;
  final Rect rect;
  final double rotation;

  ShapeHitCalculator(this.element, this.rect, this.rotation);

  @override
  bool hit(Rect rect, {bool full = false}) {
    if (!this.rect.inflate(element.property.strokeWidth).overlaps(rect)) {
      return false;
    }
    final shape = element.property.shape;
    final center = this.rect.center;

    bool hitCircle() {
      final radius = this.rect.shortestSide / 2;
      final circleCenter = this.rect.center;
      final rectCenter = rect.center;
      final dx = (circleCenter.dx - rectCenter.dx).abs();
      final dy = (circleCenter.dy - rectCenter.dy).abs();
      final halfWidth = rect.width / 2;
      final halfHeight = rect.height / 2;

      if (full) {
        return dx + radius <= halfWidth && dy + radius <= halfHeight;
      } else {
        final cornerDistanceSq =
            (dx - halfWidth).clamp(0, radius) *
                (dx - halfWidth).clamp(0, radius) +
            (dy - halfHeight).clamp(0, radius) *
                (dy - halfHeight).clamp(0, radius);
        return cornerDistanceSq <= radius * radius;
      }
    }

    bool hitRect() {
      final topLeft = rect.topLeft.rotate(center, rotation);
      final topRight = rect.topRight.rotate(center, rotation);
      final bottomLeft = rect.bottomLeft.rotate(center, rotation);
      final bottomRight = rect.bottomRight.rotate(center, rotation);
      if (full) {
        final isTopLeft = isPointInPolygon([
          topLeft,
          topRight,
          bottomRight,
          bottomLeft,
        ], this.rect.topLeft);
        final isTopRight = isPointInPolygon([
          topLeft,
          topRight,
          bottomRight,
          bottomLeft,
        ], this.rect.topRight);
        final isBottomLeft = isPointInPolygon([
          topLeft,
          topRight,
          bottomRight,
          bottomLeft,
        ], this.rect.bottomLeft);
        final isBottomRight = isPointInPolygon([
          topLeft,
          topRight,
          bottomRight,
          bottomLeft,
        ], this.rect.bottomRight);
        return isTopLeft && isTopRight && isBottomLeft && isBottomRight;
      }
      return isPolygonInPolygon(
        [topLeft, topRight, bottomRight, bottomLeft],
        [
          this.rect.topLeft,
          this.rect.topRight,
          this.rect.bottomRight,
          this.rect.bottomLeft,
        ],
      );
    }

    bool hitLine() {
      final firstPos = element.firstPosition.toOffset();
      final secondPos = element.secondPosition.toOffset();
      return rect.containsLine(
        firstPos.rotate(center, rotation),
        secondPos.rotate(center, rotation),
        full: full,
      );
    }

    bool hitTriangle() {
      final topCenter = this.rect.topCenter.rotate(center, rotation);
      final bottomLeft = this.rect.bottomLeft.rotate(center, rotation);
      final bottomRight = this.rect.bottomRight.rotate(center, rotation);
      if (full) {
        final isTopCenter = isPointInPolygon([
          topCenter,
          bottomLeft,
          bottomRight,
        ], this.rect.topCenter);
        final isBottomLeft = isPointInPolygon([
          topCenter,
          bottomLeft,
          bottomRight,
        ], this.rect.bottomLeft);
        final isBottomRight = isPointInPolygon([
          topCenter,
          bottomLeft,
          bottomRight,
        ], this.rect.bottomRight);
        return isTopCenter && isBottomLeft && isBottomRight;
      }
      return isPolygonInPolygon(
        [rect.topLeft, rect.topRight, rect.bottomRight, rect.bottomLeft],
        [topCenter, bottomLeft, bottomRight],
      );
    }

    return switch (shape) {
      CircleShape() => hitCircle(),
      RectangleShape() => hitRect(),
      TriangleShape() => hitTriangle(),
      LineShape() => hitLine(),
    };
  }

  @override
  bool hitPolygon(List<ui.Offset> polygon, {bool full = false}) {
    final center = rect.center;
    // use isPointInPolygon
    switch (element.property.shape) {
      case LineShape():
        final firstPosition = element.firstPosition.toOffset().rotate(
          center,
          rotation,
        );
        final secondPosition = element.secondPosition.toOffset().rotate(
          center,
          rotation,
        );
        if (full) {
          return isPolygonInPolygon(polygon, [firstPosition, secondPosition]) &&
              isPointInPolygon(polygon, firstPosition) &&
              isPointInPolygon(polygon, secondPosition);
        }
        return isPolygonInPolygon(polygon, [firstPosition, secondPosition]);
      case CircleShape():
        final steps = 36;
        final ellipsePoints = List.generate(steps, (i) {
          final angle = (2 * pi * i) / steps;
          final rx = rect.width / 2;
          final ry = rect.height / 2;
          final offset = Offset(rx * cos(angle), ry * sin(angle));
          return (center + offset).rotate(center, rotation);
        });
        final inside = isPolygonInPolygon(polygon, ellipsePoints);
        if (full) {
          return inside &&
              ellipsePoints.every((p) => isPointInPolygon(polygon, p));
        }
        return inside;
      case RectangleShape():
        final topLeft = rect.topLeft.rotate(center, rotation);
        final topRight = rect.topRight.rotate(center, rotation);
        final bottomLeft = rect.bottomLeft.rotate(center, rotation);
        final bottomRight = rect.bottomRight.rotate(center, rotation);
        final polygonInPolygon = isPolygonInPolygon(polygon, [
          topLeft,
          topRight,
          bottomRight,
          bottomLeft,
        ]);
        if (full) {
          return polygonInPolygon &&
              isPointInPolygon(polygon, topLeft) &&
              isPointInPolygon(polygon, topRight) &&
              isPointInPolygon(polygon, bottomRight) &&
              isPointInPolygon(polygon, bottomLeft);
        }
        return polygonInPolygon;
      case TriangleShape():
        final topCenter = rect.topCenter.rotate(center, rotation);
        final bottomLeft = rect.bottomLeft.rotate(center, rotation);
        final bottomRight = rect.bottomRight.rotate(center, rotation);
        final polygonInPolygon = isPolygonInPolygon(polygon, [
          topCenter,
          bottomLeft,
          bottomRight,
        ]);
        if (full) {
          return polygonInPolygon &&
              isPointInPolygon(polygon, topCenter) &&
              isPointInPolygon(polygon, bottomLeft) &&
              isPointInPolygon(polygon, bottomRight);
        }
        return polygonInPolygon;
    }
  }
}
