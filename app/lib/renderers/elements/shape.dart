part of '../renderer.dart';

class ShapeRenderer extends Renderer<ShapeElement> {
  final _strokePaint = ElementPaintRenderer();
  final _fillPaint = ElementPaintRenderer();

  @override
  Rect get rect => Rect.fromPoints(
    element.firstPosition.toOffset(),
    element.secondPosition.toOffset(),
  );

  ShapeRenderer(super.element, [super.layer]);

  ElementPaint get _shapeFillPaint => switch (element.property.shape) {
    CircleShape(:final fillPaint) => fillPaint,
    RectangleShape(:final fillPaint) => fillPaint,
    TriangleShape(:final fillPaint) => fillPaint,
    _ => const ElementPaint.solid(color: SRGBColor.transparent),
  };

  @override
  Future<void> setup(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    await Future.wait([
      _strokePaint.setup(element.property.paint, document, assetService),
      _fillPaint.setup(_shapeFillPaint, document, assetService),
    ]);
    await super.setup(transformCubit, document, assetService, page);
  }

  @override
  void dispose() {
    _strokePaint.dispose();
    _fillPaint.dispose();
    super.dispose();
  }

  @override
  bool onAssetUpdate(
    NoteData document,
    AssetService assetService,
    DocumentPage page,
    String path,
  ) => _strokePaint.uses(path) || _fillPaint.uses(path);

  @override
  Rect get expandedRect {
    final rect = this.rect;
    final expanded = rect.isEmpty
        ? rect.inflate(max(element.property.strokeWidth / 2, 1))
        : rect;
    return Renderer._expandedAabbFor(expanded, rotation * pi / 180);
  }

  /// Creates a dotted path from the source path based on stroke style
  Path _createDashedPath(Path source, StrokeStyle strokeStyle) {
    if (strokeStyle == StrokeStyle.solid) return source;

    final property = element.property;
    final strokeWidth = property.strokeWidth;
    final baseDashLength = strokeWidth; // Dotted: 1x stroke width
    final baseGapLength = strokeWidth * 2;
    final dashLength = baseDashLength * property.dashMultiplier;
    final gapLength = baseGapLength * property.gapMultiplier;

    final dashedPath = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final length = draw ? dashLength : gapLength;
        final end = (distance + length).clamp(0.0, metric.length);
        if (draw) {
          dashedPath.addPath(metric.extractPath(distance, end), Offset.zero);
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
        _buildPaint(paint: shape.fillPaint, style: PaintingStyle.fill),
      );
      if (strokeWidth > 0) {
        final rrect = RRect.fromRectAndCorners(
          drawRect,
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
        _buildPaint(paint: shape.fillPaint, style: PaintingStyle.fill),
      );
      if (strokeWidth > 0) {
        final path = Path()..addOval(drawRect);
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
        _buildPaint(paint: shape.fillPaint, style: PaintingStyle.fill),
      );
      if (strokeWidth > 0) {
        _drawStyledPath(canvas, path, paint);
      }
    }
  }

  Paint _buildPaint({ElementPaint? paint, PaintingStyle? style}) {
    final renderer = paint == null ? _strokePaint : _fillPaint;
    final result = renderer.build(
      paint ?? element.property.paint,
      rect,
      style: style ?? PaintingStyle.stroke,
    );
    return result
      ..strokeWidth = element.property.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
  }

  /// Returns SVG stroke-dasharray attribute value based on stroke style
  String? _getSvgDashArray() {
    final property = element.property;
    final strokeWidth = property.strokeWidth;
    final dashMultiplier = property.dashMultiplier;
    final gapMultiplier = property.gapMultiplier;
    return switch (property.strokeStyle) {
      StrokeStyle.solid => null,
      StrokeStyle.dotted =>
        '${strokeWidth * dashMultiplier},${strokeWidth * 2 * gapMultiplier}',
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
      xml
          .getElement('svg')
          ?.createElement(
            'path',
            attributes: {
              'd': d,
              'fill': shape.fillPaint.previewColor.toHexString(alpha: false),
              'fill-opacity': '${shape.fillPaint.previewColor.a / 255}',
              'stroke': element.property.paint.previewColor.toHexString(
                alpha: false,
              ),
              'stroke-opacity':
                  '${element.property.paint.previewColor.a / 255}',
              'stroke-width': '${element.property.strokeWidth}px',
              'stroke-dasharray': ?dashArray,
            },
          );
    } else if (shape is CircleShape) {
      xml
          .getElement('svg')
          ?.createElement(
            'ellipse',
            attributes: {
              'cx': '${drawRect.center.dx}',
              'cy': '${drawRect.center.dy}',
              'rx': '${(drawRect.width / 2).abs()}',
              'ry': '${(drawRect.height / 2).abs()}',
              'fill': shape.fillPaint.previewColor.toHexString(alpha: false),
              'fill-opacity': '${shape.fillPaint.previewColor.a / 255}',
              'stroke': element.property.paint.previewColor.toHexString(
                alpha: false,
              ),
              'stroke-opacity':
                  '${element.property.paint.previewColor.a / 255}',
              'stroke-width': '${element.property.strokeWidth}px',
              'stroke-dasharray': ?dashArray,
            },
          );
    } else if (shape is LineShape) {
      xml
          .getElement('svg')
          ?.createElement(
            'line',
            attributes: {
              'x1': '${element.firstPosition.x}px',
              'y1': '${element.firstPosition.y}px',
              'x2': '${element.secondPosition.x}px',
              'y2': '${element.secondPosition.y}px',
              'stroke-width': '${element.property.strokeWidth}px',
              'stroke': element.property.paint.previewColor.toHexString(
                alpha: false,
              ),
              'stroke-opacity':
                  '${element.property.paint.previewColor.a / 255}',
              'fill': 'none',
              'stroke-dasharray': ?dashArray,
            },
          );
    } else if (shape is TriangleShape) {
      final topCenter = drawRect.topCenter;
      final d =
          'M${topCenter.dx} ${topCenter.dy} '
          'L${drawRect.right} ${drawRect.bottom} '
          'L${drawRect.left} ${drawRect.bottom} Z';
      xml
          .getElement('svg')
          ?.createElement(
            'path',
            attributes: {
              'd': d,
              'fill': shape.fillPaint.previewColor.toHexString(),
              'stroke': element.property.paint.previewColor.toHexString(),
              'stroke-width': '${element.property.strokeWidth}px',
              'stroke-dasharray': ?dashArray,
            },
          );
    } else if (shape is TriangleShape) {
      final topCenter = drawRect.topCenter;
      final d =
          'M${topCenter.dx} ${topCenter.dy} '
          'L${drawRect.right} ${drawRect.bottom} '
          'L${drawRect.left} ${drawRect.bottom} Z';
      xml
          .getElement('svg')
          ?.createElement(
            'path',
            attributes: {
              'd': d,
              'fill': shape.fillPaint.previewColor.toHexString(),
              'stroke': element.property.paint.previewColor.toHexString(),
              'stroke-width': '${element.property.strokeWidth}px',
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
      ShapeHitCalculator(element, rect, expandedRect, rotation * pi / 180);
}

class ShapeHitCalculator extends HitCalculator {
  static const _pointShapeHitTolerance = 1e-6;

  final ShapeElement element;
  final Rect rect;
  final Rect boundsRect;
  final double rotation;

  ShapeHitCalculator(this.element, this.rect, Rect boundsRect, this.rotation)
    : boundsRect = boundsRect.inflate(element.property.strokeWidth);

  bool get _isPointShape => rect.width == 0 && rect.height == 0;

  @override
  bool hit(
    Rect rect, {
    HitElementMode hitElementMode = HitElementMode.touchAnywhere,
  }) {
    if (hitElementMode == HitElementMode.none) return false;
    if (_isPointShape) {
      return rect.inflate(_pointShapeHitTolerance).contains(this.rect.center);
    }
    if (!boundsRect.overlaps(rect)) {
      return false;
    }
    final shape = element.property.shape;
    final center = this.rect.center;

    bool hitCircle() {
      final circleCenter = this.rect.center;
      final rectCenter = rect.center;
      final dx = (circleCenter.dx - rectCenter.dx).abs();
      final dy = (circleCenter.dy - rectCenter.dy).abs();
      final halfWidth = rect.width / 2;
      final halfHeight = rect.height / 2;
      final radiusX = this.rect.width / 2;
      final radiusY = this.rect.height / 2;

      return switch (hitElementMode) {
        HitElementMode.full =>
          dx + radiusX <= halfWidth && dy + radiusY <= halfHeight,
        HitElementMode.touchEdges => () {
          if (radiusX == 0 || radiusY == 0) return this.rect.overlaps(rect);

          // Is the rectangle fully inside the circle?
          final farthestX = dx + halfWidth;
          final farthestY = dy + halfHeight;
          final normFarX = farthestX / radiusX;
          final normFarY = farthestY / radiusY;
          if (normFarX * normFarX + normFarY * normFarY <= 1) {
            return false;
          }

          // Do their areas overlap?
          final nearestX = dx - halfWidth;
          final nearestY = dy - halfHeight;
          final normalizedX = nearestX <= 0 ? 0 : nearestX / radiusX;
          final normalizedY = nearestY <= 0 ? 0 : nearestY / radiusY;

          return normalizedX * normalizedX + normalizedY * normalizedY <= 1;
        }(),
        HitElementMode.touchAnywhere => () {
          if (radiusX == 0 || radiusY == 0) return this.rect.overlaps(rect);
          final nearestX = dx - halfWidth;
          final nearestY = dy - halfHeight;
          final normalizedX = nearestX <= 0 ? 0 : nearestX / radiusX;
          final normalizedY = nearestY <= 0 ? 0 : nearestY / radiusY;
          return normalizedX * normalizedX + normalizedY * normalizedY <= 1;
        }(),
        _ => false, // this shouldn't happen
      };
    }

    bool hitRect() {
      final topLeft = this.rect.topLeft.rotate(center, rotation);
      final topRight = this.rect.topRight.rotate(center, rotation);
      final bottomLeft = this.rect.bottomLeft.rotate(center, rotation);
      final bottomRight = this.rect.bottomRight.rotate(center, rotation);
      return switch (hitElementMode) {
        HitElementMode.full => () {
          final isTopLeft = rect.contains(topLeft);
          final isTopRight = rect.contains(topRight);
          final isBottomLeft = rect.contains(bottomLeft);
          final isBottomRight = rect.contains(bottomRight);
          return isTopLeft && isTopRight && isBottomLeft && isBottomRight;
        }(),
        HitElementMode.touchEdges =>
          rect.containsLine(topLeft, topRight) ||
              rect.containsLine(topRight, bottomRight) ||
              rect.containsLine(bottomLeft, bottomRight) ||
              rect.containsLine(topLeft, bottomLeft),
        HitElementMode.touchAnywhere => isPolygonInPolygon(
          [rect.topLeft, rect.topRight, rect.bottomRight, rect.bottomLeft],
          [topLeft, topRight, bottomRight, bottomLeft],
        ),
        _ => false, // this shouldn't happen
      };
    }

    bool hitLine() {
      final firstPos = element.firstPosition.toOffset();
      final secondPos = element.secondPosition.toOffset();
      return rect.containsLine(
        firstPos.rotate(center, rotation),
        secondPos.rotate(center, rotation),
        full: hitElementMode == HitElementMode.full,
      );
    }

    bool hitTriangle() {
      final triTop = this.rect.topCenter.rotate(center, rotation);
      final triLeft = this.rect.bottomLeft.rotate(center, rotation);
      final triRight = this.rect.bottomRight.rotate(center, rotation);

      return switch (hitElementMode) {
        HitElementMode.full =>
          rect.contains(triTop) &&
              rect.contains(triLeft) &&
              rect.contains(triRight),
        HitElementMode.touchEdges =>
          rect.containsLine(triRight, triTop) ||
              rect.containsLine(triTop, triLeft) ||
              rect.containsLine(triLeft, triRight),
        HitElementMode.touchAnywhere => isPolygonInPolygon(
          [rect.topLeft, rect.topRight, rect.bottomRight, rect.bottomLeft],
          [triTop, triLeft, triRight],
        ),
        _ => false, // this shouldn't happen
      };
    }

    return switch (shape) {
      CircleShape() => hitCircle(),
      RectangleShape() => hitRect(),
      TriangleShape() => hitTriangle(),
      LineShape() => hitLine(),
    };
  }

  @override
  bool hitPolygon(
    List<ui.Offset> polygon, {
    HitElementMode hitElementMode = HitElementMode.touchAnywhere,
  }) {
    if (hitElementMode == HitElementMode.none) return false;
    final center = rect.center;
    if (_isPointShape) return isPointInPolygon(polygon, center);
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
        var linePoints = [firstPosition, secondPosition];
        var inside = isPolygonInPolygon(polygon, linePoints);
        return switch (hitElementMode) {
          HitElementMode.full =>
            inside &&
                isPointInPolygon(polygon, firstPosition) &&
                isPointInPolygon(polygon, secondPosition),
          HitElementMode.touchEdges || HitElementMode.touchAnywhere => inside,
          _ => false, // this shouldn't happen
        };
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
        return switch (hitElementMode) {
          HitElementMode.full =>
            inside && ellipsePoints.every((p) => isPointInPolygon(polygon, p)),
          HitElementMode.touchEdges =>
            inside && !polygon.every((p) => isPointInPolygon(ellipsePoints, p)),
          HitElementMode.touchAnywhere => inside,
          _ => false, // this shouldn't happen
        };
      case RectangleShape():
        final topLeft = rect.topLeft.rotate(center, rotation);
        final topRight = rect.topRight.rotate(center, rotation);
        final bottomLeft = rect.bottomLeft.rotate(center, rotation);
        final bottomRight = rect.bottomRight.rotate(center, rotation);
        final rectPoints = [topLeft, topRight, bottomRight, bottomLeft];
        final inside = isPolygonInPolygon(polygon, rectPoints);
        return switch (hitElementMode) {
          HitElementMode.full =>
            inside &&
                isPointInPolygon(polygon, topLeft) &&
                isPointInPolygon(polygon, topRight) &&
                isPointInPolygon(polygon, bottomRight) &&
                isPointInPolygon(polygon, bottomLeft),
          HitElementMode.touchEdges =>
            inside && !polygon.every((p) => isPointInPolygon(rectPoints, p)),
          HitElementMode.touchAnywhere => inside,
          _ => false, // this shouldn't happen
        };
      case TriangleShape():
        final topCenter = rect.topCenter.rotate(center, rotation);
        final bottomLeft = rect.bottomLeft.rotate(center, rotation);
        final bottomRight = rect.bottomRight.rotate(center, rotation);
        var triPoints = [topCenter, bottomLeft, bottomRight];
        final inside = isPolygonInPolygon(polygon, triPoints);
        return switch (hitElementMode) {
          HitElementMode.full =>
            inside &&
                isPointInPolygon(polygon, topCenter) &&
                isPointInPolygon(polygon, bottomLeft) &&
                isPointInPolygon(polygon, bottomRight),
          HitElementMode.touchEdges =>
            inside && !polygon.every((p) => isPointInPolygon(triPoints, p)),
          HitElementMode.touchAnywhere => inside,
          _ => false, // this shouldn't happen
        };
    }
  }
}
