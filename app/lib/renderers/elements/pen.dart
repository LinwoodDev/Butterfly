part of '../renderer.dart';

class PenRenderer extends Renderer<PenElement> {
  @override
  Rect rect;

  PenRenderer(
    super.element, [
    super.layer,
    this.rect = Rect.zero,
    this.expandedRect = Rect.zero,
  ]);

  @override
  Rect expandedRect;

  Path? _cachedFillPath;
  Path? _cachedStrokePath;
  PathHitCalculator? _cachedHitCalculator;

  void _computePaths() {
    final points = element.points;
    if (points.isEmpty) return;
    final property = element.property;

    if (property.fill.a > 0) {
      _cachedFillPath = Path();
      final first = points.first;
      _cachedFillPath!.moveTo(first.x, first.y);
      for (final point in points.sublist(1)) {
        _cachedFillPath!.lineTo(point.x, point.y);
      }
    }

    if (property.color.a > 0) {
      final outlinePoints = _getOutlinePoints();
      if (outlinePoints.isNotEmpty) {
        _cachedStrokePath = Path();
        if (outlinePoints.length < 2) {
          _cachedStrokePath!.addOval(
            Rect.fromCircle(center: outlinePoints[0], radius: 1),
          );
        } else {
          _cachedStrokePath!.moveTo(outlinePoints[0].dx, outlinePoints[0].dy);
          for (int i = 1; i < outlinePoints.length - 1; ++i) {
            final p0 = outlinePoints[i];
            final p1 = outlinePoints[i + 1];
            _cachedStrokePath!.quadraticBezierTo(
              p0.dx,
              p0.dy,
              (p0.dx + p1.dx) / 2,
              (p0.dy + p1.dy) / 2,
            );
          }
        }
      }
    }
  }

  bool shouldSimulatePressure() {
    final points = element.points.sublist(1);
    var pressure = points.firstOrNull?.pressure ?? 0;
    return points.every((element) => element.pressure == pressure);
  }

  @override
  void setup(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) {
    final points = element.points;
    if (points.isEmpty) return;
    final property = element.property;
    var topLeftCorner = points.first.toOffset();
    var bottomRightCorner = points.first.toOffset();
    for (final element in points) {
      topLeftCorner = Offset(
        min(topLeftCorner.dx, element.x),
        min(topLeftCorner.dy, element.y),
      );
      bottomRightCorner = Offset(
        max(bottomRightCorner.dx, element.x),
        max(bottomRightCorner.dy, element.y),
      );
    }
    rect = Rect.fromLTRB(
      topLeftCorner.dx,
      topLeftCorner.dy,
      bottomRightCorner.dx,
      bottomRightCorner.dy,
    );
    final center = Rect.fromPoints(topLeftCorner, bottomRightCorner).center;
    final rotatedPoints = points
        .map((e) => e.rotate(center, rotation / 180 * pi))
        .toList();
    topLeftCorner = rotatedPoints.first.toOffset();
    bottomRightCorner = rotatedPoints.first.toOffset();
    for (final element in rotatedPoints) {
      final width = property.strokeWidth + element.pressure * property.thinning;
      topLeftCorner = Offset(
        min(topLeftCorner.dx, element.x - width),
        min(topLeftCorner.dy, element.y - width),
      );
      bottomRightCorner = Offset(
        max(bottomRightCorner.dx, element.x + width),
        max(bottomRightCorner.dy, element.y + width),
      );
    }
    expandedRect = Rect.fromLTRB(
      topLeftCorner.dx,
      topLeftCorner.dy,
      bottomRightCorner.dx,
      bottomRightCorner.dy,
    );
    _computePaths();
    super.setup(transformCubit, document, assetService, page);
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
    final points = element.points;
    if (points.isEmpty) return;
    final property = element.property;

    if (_cachedFillPath == null && _cachedStrokePath == null) {
      _computePaths();
    }

    if (property.fill.a > 0 && _cachedFillPath != null) {
      final paint = Paint()
        ..color = property.fill.toColor()
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(_cachedFillPath!, paint);
    }
    if (property.color.a > 0 && _cachedStrokePath != null) {
      final paint = Paint()
        ..color = property.color.toColor()
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(_cachedStrokePath!, paint);
    }
  }

  List<Offset> _getOutlinePoints() {
    final currentZoom = element.zoom ?? kMaxZoom;
    final property = element.property;
    final center = rect.center;
    // 1. Get the outline points from the input points
    var outlinePoints = freehand.getStroke(
      element.points
          .map((e) => e.scale(currentZoom, center))
          .map((e) => e.toFreehandPoint())
          .toList(),
      options: freehand.StrokeOptions(
        size: property.strokeWidth * currentZoom,
        thinning: property.thinning.clamp(0, 1),
        smoothing: property.smoothing.clamp(0, 1),
        streamline: property.streamline.clamp(.1, 1),
        simulatePressure: shouldSimulatePressure(),
      ),
    );

    // Unscale the points
    outlinePoints = outlinePoints
        .map((e) => e.scaleFromCenter(1 / currentZoom, center))
        .toList();
    return outlinePoints;
  }

  @override
  void buildSvg(
    XmlDocument xml,
    NoteData document,
    DocumentPage page,
    Rect viewportRect,
  ) {
    final points = element.points;
    final property = element.property;
    if (points.isEmpty) return;
    if (property.fill.a > 0) {
      final first = points.first;
      var path = 'M ${first.x} ${first.y}';
      points.sublist(1).forEach((point) => path += ' L ${point.x} ${point.y}');
      xml.getElement('svg')?.createElement('path')
        ?..setAttribute('d', path)
        ..setAttribute('fill', property.fill.toHexString(alpha: false))
        ..setAttribute('fill-opacity', '${property.fill.a / 255}')
        ..setAttribute('stroke', 'none')
        ..setAttribute('stroke-linecap', 'round')
        ..setAttribute('stroke-linejoin', 'round');
    }
    if (property.color.a > 0) {
      var path = '';

      // 1. Get the outline points from the input points
      var outlinePoints = _getOutlinePoints();

      // 2. Render the points as a path
      if (outlinePoints.isEmpty) {
        // If the list is empty, don't do anything.
        return;
      }

      final first = outlinePoints.first;
      path += 'M ${first.roundedX()} ${first.roundedY()}';
      for (int i = 1; i < outlinePoints.length - 1; ++i) {
        final p0 = outlinePoints[i];
        final p1 = outlinePoints[i + 1];
        path +=
            ' Q ${p0.roundedX()} ${p0.roundedY()} ${p0.roundedBetweenX(p1)} ${p0.roundedBetweenY(p1)}';
      }

      xml.getElement('svg')?.createElement('path')
        ?..setAttribute('d', path)
        ..setAttribute('fill', property.color.toHexString(alpha: false))
        ..setAttribute('fill-opacity', '${property.color.a / 255}')
        ..setAttribute('stroke', 'none')
        ..setAttribute('stroke-linecap', 'round')
        ..setAttribute('stroke-linejoin', 'round');
    }
  }

  List<PathPoint> movePoints(Offset position, double scaleX, double scaleY) {
    var topLeft = element.points
        .map((e) => e.toOffset())
        .reduce(
          (value, element) =>
              Offset(min(value.dx, element.dx), min(value.dy, element.dy)),
        );
    return element.points
        .map(
          (point) => point.copyWith(
            x: (point.x - topLeft.dx) * scaleX + position.dx,
            y: (point.y - topLeft.dy) * scaleY + position.dy,
          ),
        )
        .toList();
  }

  Rect moveRect(
    Offset position,
    double scaleX,
    double scaleY, [
    bool expanded = false,
  ]) {
    final rect = expanded ? expandedRect : this.rect;
    final size = Size(rect.width * scaleX, rect.height * scaleY);
    return position & size;
  }

  @override
  PenRenderer _transform({
    required Offset position,
    required double rotation,
    double scaleX = 1,
    double scaleY = 1,
  }) => PenRenderer(
    element.copyWith(
      rotation: rotation,
      points: movePoints(position, scaleX, scaleY),
    ),
    layer,
    moveRect(position, scaleX, scaleY),
    moveRect(position, scaleX, scaleY, true),
  );

  @override
  PathHitCalculator getHitCalculator() {
    _cachedHitCalculator ??= PathHitCalculator(rect, element.points, rotation * pi / 180);
    return _cachedHitCalculator!;
  }
}

class PathHitCalculator extends HitCalculator {
  final Rect elementRect;
  final List<PathPoint> points;
  final double rotation;

  PathHitCalculator(this.elementRect, this.points, this.rotation);

  /// Check if a line segment intersects with a rectangle
  bool _lineIntersectsRect(Offset p1, Offset p2, Rect rect) {
    // Quick check: if both points are on the same side of any edge, no intersection
    if ((p1.dx < rect.left && p2.dx < rect.left) ||
        (p1.dx > rect.right && p2.dx > rect.right) ||
        (p1.dy < rect.top && p2.dy < rect.top) ||
        (p1.dy > rect.bottom && p2.dy > rect.bottom)) {
      return false;
    }
    
    // Check if either endpoint is inside the rect
    if (rect.contains(p1) || rect.contains(p2)) {
      return true;
    }
    
    // Check intersection with each edge of the rectangle
    // Using parametric line intersection
    final dx = p2.dx - p1.dx;
    final dy = p2.dy - p1.dy;
    
    // Check left edge (x = rect.left)
    if (dx != 0) {
      final t = (rect.left - p1.dx) / dx;
      if (t >= 0 && t <= 1) {
        final y = p1.dy + t * dy;
        if (y >= rect.top && y <= rect.bottom) return true;
      }
      // Check right edge (x = rect.right)
      final t2 = (rect.right - p1.dx) / dx;
      if (t2 >= 0 && t2 <= 1) {
        final y = p1.dy + t2 * dy;
        if (y >= rect.top && y <= rect.bottom) return true;
      }
    }
    
    // Check top edge (y = rect.top)
    if (dy != 0) {
      final t = (rect.top - p1.dy) / dy;
      if (t >= 0 && t <= 1) {
        final x = p1.dx + t * dx;
        if (x >= rect.left && x <= rect.right) return true;
      }
      // Check bottom edge (y = rect.bottom)
      final t2 = (rect.bottom - p1.dy) / dy;
      if (t2 >= 0 && t2 <= 1) {
        final x = p1.dx + t2 * dx;
        if (x >= rect.left && x <= rect.right) return true;
      }
    }
    
    return false;
  }

  /// Check if a point is inside the rectangle with some tolerance for lines
  bool _segmentFullyInRect(Offset p1, Offset p2, Rect rect) {
    return rect.contains(p1) && rect.contains(p2);
  }

  Offset _rotatePoint(PathPoint point) {
    if (rotation == 0) return point.toOffset();
    final center = elementRect.center;
    final cosR = cos(rotation);
    final sinR = sin(rotation);
    final dx = point.x - center.dx;
    final dy = point.y - center.dy;
    return Offset(
      center.dx + dx * cosR - dy * sinR,
      center.dy + dx * sinR + dy * cosR,
    );
  }

  @override
  bool hit(Rect rect, {bool full = false}) {
    // Quick bounds check first
    if (!elementRect.overlaps(rect)) {
      return false;
    }
    
    if (points.isEmpty) return false;
    
    if (points.length == 1) {
      final rotated = _rotatePoint(points.first);
      return rect.contains(rotated);
    }
    
    if (full) {
      // All segments must be fully inside the rect
      for (int i = 0; i < points.length - 1; i++) {
        final p1 = _rotatePoint(points[i]);
        final p2 = _rotatePoint(points[i + 1]);
        if (!_segmentFullyInRect(p1, p2, rect)) {
          return false;
        }
      }
      return true;
    } else {
      // Any segment intersects the rect
      for (int i = 0; i < points.length - 1; i++) {
        final p1 = _rotatePoint(points[i]);
        final p2 = _rotatePoint(points[i + 1]);
        if (_lineIntersectsRect(p1, p2, rect)) {
          return true;
        }
      }
      // Also check if the last point is in the rect
      return rect.contains(_rotatePoint(points.last));
    }
  }

  @override
  bool hitPolygon(List<ui.Offset> polygon, {bool full = false}) {
    if (points.isEmpty) return false;
    
    if (full) {
      // All points must be inside the polygon
      for (final point in points) {
        final rotated = _rotatePoint(point);
        if (!isPointInPolygon(polygon, rotated)) {
          return false;
        }
      }
      return true;
    } else {
      // Any point inside the polygon is a hit
      for (final point in points) {
        final rotated = _rotatePoint(point);
        if (isPointInPolygon(polygon, rotated)) {
          return true;
        }
      }
      return false;
    }
  }
}
