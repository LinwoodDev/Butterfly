part of '../renderer.dart';

({Offset tip, Offset left, Offset right}) _trianglePoints(
  Rect rect,
  ShapeElement element,
) {
  final flippedVertically = element.secondPosition.y < element.firstPosition.y;
  return flippedVertically
      ? (tip: rect.bottomCenter, left: rect.topLeft, right: rect.topRight)
      : (tip: rect.topCenter, left: rect.bottomLeft, right: rect.bottomRight);
}

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
    _ => const ElementPaint.solid(color: .transparent),
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
    return Renderer._expandedAabbFor(expanded, rotation * pi / 180, shear);
  }

  /// Creates a dotted path from the source path based on stroke style
  Path _createDashedPath(Path source, StrokeStyle strokeStyle) {
    if (strokeStyle == .solid) return source;

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
    if (strokeStyle == .solid) {
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
        _buildPaint(paint: shape.fillPaint, style: .fill),
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
        _buildPaint(paint: shape.fillPaint, style: .fill),
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
      final points = _trianglePoints(drawRect, element);
      final path = Path()
        ..moveTo(points.tip.dx, points.tip.dy)
        ..lineTo(points.right.dx, points.right.dy)
        ..lineTo(points.left.dx, points.left.dy)
        ..close();
      canvas.drawPath(path, _buildPaint(paint: shape.fillPaint, style: .fill));
      if (strokeWidth > 0) {
        _drawStyledPath(canvas, path, paint);
      }
    }
  }

  Paint _buildPaint({ElementPaint? paint, PaintingStyle? style}) {
    final renderer = paint == null ? _strokePaint : _fillPaint;
    final effectiveStyle = style ?? PaintingStyle.stroke;
    final bounds = effectiveStyle == .stroke ? expandedRect : rect;
    final result = renderer.build(
      paint ?? element.property.paint,
      bounds,
      style: effectiveStyle,
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
      .solid => null,
      .dotted =>
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
      final points = _trianglePoints(drawRect, element);
      final d =
          'M${points.tip.dx} ${points.tip.dy} '
          'L${points.right.dx} ${points.right.dy} '
          'L${points.left.dx} ${points.left.dy} Z';
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
    }
  }

  @override
  ShapeRenderer _transform({
    required Offset position,
    required double rotation,
    required double shear,
    double scaleX = 1,
    double scaleY = 1,
  }) {
    final rect = this.rect;
    final previous = rect.topLeft;
    final localFirst = element.firstPosition.toOffset() - previous;
    final localSecond = element.secondPosition.toOffset() - previous;
    return ShapeRenderer(
      element.copyWith(
        shear: shear,
        firstPosition: (localFirst.scale(scaleX, scaleY) + position).toPoint(),
        secondPosition: (localSecond.scale(scaleX, scaleY) + position)
            .toPoint(),
        rotation: rotation,
      ),
      layer,
    );
  }

  @override
  HitCalculator createHitCalculator() {
    return ShapeHitCalculator(element, rect, 0);
  }
}

class ShapeHitCalculator extends HitCalculator {
  final ShapeElement element;
  final Rect rect;
  final double rotation;

  ShapeHitCalculator(this.element, this.rect, this.rotation);

  bool get _isPointShape => rect.width == 0 && rect.height == 0;

  bool _hitEllipse(List<Offset> polygon, HitElementMode mode) {
    if (polygon.isEmpty || !isFinitePolygon(polygon)) return false;
    final rx = rect.width / 2, ry = rect.height / 2;
    if (rx == 0 || ry == 0) {
      final ends = [
        rect.topLeft,
        rect.bottomRight,
      ].map((point) => point.rotate(rect.center, rotation)).toList();
      return mode == .full
          ? ends.every((point) => isPointInPolygon(polygon, point))
          : isPolygonInPolygon(polygon, ends);
    }
    // Transform the query into unit-circle space. Segment distances give exact
    // ellipse intersections, including point clicks between tessellation steps.
    final points = polygon.map((point) {
      final local = point.rotate(rect.center, -rotation) - rect.center;
      return Offset(local.dx / rx, local.dy / ry);
    }).toList();
    var nearest = points.first.distanceSquared;
    for (var i = 0; i < points.length; i++) {
      final start = points[i], end = points[(i + 1) % points.length];
      final delta = end - start;
      final t = delta.distanceSquared == 0
          ? 0.0
          : (-(start.dx * delta.dx + start.dy * delta.dy) /
                    delta.distanceSquared)
                .clamp(0.0, 1.0);
      nearest = min(nearest, (start + delta * t).distanceSquared);
    }
    final containsCenter = isPointInPolygon(points, Offset.zero);
    final overlaps = containsCenter || nearest <= 1 + 1e-10;
    return switch (mode) {
      .full => containsCenter && nearest >= 1 - 1e-10,
      .touchEdges =>
        overlaps && !points.every((point) => point.distanceSquared < 1 - 1e-10),
      .touchAnywhere => overlaps,
      .none => false,
    };
  }

  @override
  bool hitPolygon(
    List<ui.Offset> polygon, {
    HitElementMode hitElementMode = .touchAnywhere,
  }) {
    if (hitElementMode == .none) return false;
    final center = rect.center;
    if (_isPointShape) return isPointInPolygon(polygon, center);
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
        final linePoints = [firstPosition, secondPosition];
        final inside = isPolygonInPolygon(polygon, linePoints);
        return switch (hitElementMode) {
          .full =>
            inside &&
                isPointInPolygon(polygon, firstPosition) &&
                isPointInPolygon(polygon, secondPosition),
          .touchEdges || HitElementMode.touchAnywhere => inside,
          _ => false, // this shouldn't happen
        };
      case CircleShape():
        return _hitEllipse(polygon, hitElementMode);
      case RectangleShape():
        final topLeft = rect.topLeft.rotate(center, rotation);
        final topRight = rect.topRight.rotate(center, rotation);
        final bottomLeft = rect.bottomLeft.rotate(center, rotation);
        final bottomRight = rect.bottomRight.rotate(center, rotation);
        final rectPoints = [topLeft, topRight, bottomRight, bottomLeft];
        return hitShape(polygon, rectPoints, hitElementMode);
      case TriangleShape():
        final points = _trianglePoints(rect, element);
        final topCenter = points.tip.rotate(center, rotation);
        final bottomLeft = points.left.rotate(center, rotation);
        final bottomRight = points.right.rotate(center, rotation);
        final triPoints = [topCenter, bottomLeft, bottomRight];
        return hitShape(polygon, triPoints, hitElementMode);
    }
  }
}
