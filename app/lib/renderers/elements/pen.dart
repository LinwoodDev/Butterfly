part of '../renderer.dart';

class PenRenderer extends Renderer<PenElement> {
  @override
  Rect rect = Rect.zero;

  PenRenderer(
    super.element, [
    super.layer,
    this.rect = Rect.zero,
    this.expandedRect = Rect.zero,
  ]);

  @override
  Rect expandedRect;

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
    if (property.fill.a > 0) {
      final paint = Paint()
        ..color = property.fill.toColor()
        ..style = PaintingStyle.fill
        ..strokeCap = StrokeCap.round;
      final path = Path();
      final first = points.first;
      path.moveTo(first.x, first.y);
      points.sublist(1).forEach((point) => path.lineTo(point.x, point.y));
      canvas.drawPath(path, paint);
    }
    if (property.color.a > 0) {
      final paint = Paint()
        ..color = property.color.toColor()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      final outlinePoints = _getOutlinePoints();

      // 2. Render the points as a path
      final path = Path();

      if (outlinePoints.isEmpty) {
        // If the list is empty, don't do anything.
        return;
      } else if (outlinePoints.length < 2) {
        // If the list only has one point, draw a dot.
        path.addOval(
          Rect.fromCircle(
            center: Offset(outlinePoints[0].dx, outlinePoints[0].dy),
            radius: 1,
          ),
        );
      } else {
        // Otherwise, draw a line that connects each point with a bezier curve segment.
        path.moveTo(outlinePoints[0].dx, outlinePoints[0].dy);

        for (int i = 1; i < outlinePoints.length - 1; ++i) {
          final p0 = outlinePoints[i];
          final p1 = outlinePoints[i + 1];
          path.quadraticBezierTo(
            p0.dx,
            p0.dy,
            (p0.dx + p1.dx) / 2,
            (p0.dy + p1.dy) / 2,
          );
        }
      }

      // 3. Draw the path to the canvas
      canvas.drawPath(path, paint..style = PaintingStyle.fill);
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
        ..setAttribute('fill', property.fill.toHexString())
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
        ..setAttribute('fill', property.color.toHexString())
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
  PathHitCalculator getHitCalculator() =>
      PathHitCalculator(rect, element.points, rotation * pi / 180);
}

class PathHitCalculator extends HitCalculator {
  final Rect elementRect;
  final List<PathPoint> points;
  final double rotation;

  PathHitCalculator(this.elementRect, this.points, this.rotation);

  List<PathPoint> _interpolate(PathPoint a, PathPoint b) {
    final result = <PathPoint>[];

    final distanceX = b.x - a.x;
    final distanceY = b.y - a.y;
    final distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));

    result.add(a.rotate(elementRect.center, rotation));

    for (int i = 1; i <= distance; i++) {
      result.add(
        PathPoint(
          a.x + (distanceX / distance * i).floor(),
          a.y + (distanceY / distance * i).floor(),
        ).rotate(elementRect.center, rotation),
      );
    }

    result.add(b.rotate(elementRect.center, rotation));
    return result;
  }

  List<PathPoint> _getInterpolatedPoints(List<PathPoint> points) {
    final result = <PathPoint>[];

    for (int i = 0; i < points.length - 1; i++) {
      result.addAll(_interpolate(points[i], points[i + 1]));
    }
    if (points.length == 1) {
      result.add(points.first);
    }

    return result;
  }

  @override
  bool hit(Rect rect, {bool full = false}) {
    if (!elementRect.overlaps(rect)) {
      return false;
    }
    if (points.length == 1) {
      return rect.contains(points.first.toOffset());
    }
    final interpolated = _getInterpolatedPoints(points);
    if (full) {
      return interpolated.every((point) => rect.contains(point.toOffset()));
    }
    return interpolated.any((point) => rect.contains(point.toOffset()));
  }

  @override
  bool hitPolygon(List<ui.Offset> polygon, {bool full = false}) {
    final interpolated = _getInterpolatedPoints(points);
    if (full) {
      return interpolated.every(
        (point) => isPointInPolygon(polygon, point.toOffset()),
      );
    }
    return interpolated.any(
      (point) => isPointInPolygon(polygon, point.toOffset()),
    );
  }
}
