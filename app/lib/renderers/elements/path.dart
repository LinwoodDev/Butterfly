part of '../renderer.dart';

abstract class PathRenderer<T extends PadElement> extends Renderer<T> {
  @override
  Rect rect = Rect.zero;

  PathRenderer(super.element, [this.rect = Rect.zero]);

  double get zoom => 1.0;

  Paint buildPaint([AppDocument? document, bool foreground = false]);

  @override
  FutureOr<void> setup(AppDocument document) {
    final current = element as PathElement;
    final points = current.points;
    final property = current.property;
    var topLeftCorner = points.first.toOffset();
    var bottomRightCorner = points.first.toOffset();
    for (var element in points) {
      final width =
          property.strokeWidth + element.pressure * property.strokeMultiplier;
      topLeftCorner = Offset(min(topLeftCorner.dx, element.x - width),
          min(topLeftCorner.dy, element.y - width));
      bottomRightCorner = Offset(max(bottomRightCorner.dx, element.x + width),
          max(bottomRightCorner.dy, element.y + width));
    }
    rect = Rect.fromLTRB(topLeftCorner.dx, topLeftCorner.dy,
        bottomRightCorner.dx, bottomRightCorner.dy);
    super.setup(document);
  }

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    final current = element as PathElement;
    final points = current.points;
    final property = current.property;
    final paint = buildPaint(document, foreground);
    if (points.isNotEmpty) {
      if (paint.style == PaintingStyle.fill) {
        final path = Path();
        final first = points.first;
        path.moveTo(first.x, first.y);
        points.sublist(1).forEach((point) => path.lineTo(point.x, point.y));
        canvas.drawPath(path, paint);
        return;
      }
      final center = rect.center;
      // 1. Get the outline points from the input points
      var outlinePoints = getStroke(
        points
            .map((e) => e.scale(zoom, center))
            .map((e) => e.toFreehandPoint())
            .toList(),
        size: property.strokeWidth * zoom,
        thinning: property.strokeMultiplier.clamp(0, 1),
        smoothing: property.smoothing.clamp(0, 1),
        streamline: property.streamline.clamp(0, 1),
        simulatePressure: true,
      );

      // Unscale the points
      outlinePoints = outlinePoints.map((e) {
        var point = Offset(e.x, e.y);
        point = point.scaleFromCenter(1 / zoom, center);
        return Point(point.dx, point.dy, e.p);
      }).toList();

      // 2. Render the points as a path
      final path = Path();

      if (outlinePoints.isEmpty) {
        // If the list is empty, don't do anything.
        return;
      } else if (outlinePoints.length < 2) {
        // If the list only has one point, draw a dot.
        path.addOval(Rect.fromCircle(
            center: Offset(outlinePoints[0].x, outlinePoints[0].y), radius: 1));
      } else {
        // Otherwise, draw a line that connects each point with a bezier curve segment.
        path.moveTo(outlinePoints[0].x, outlinePoints[0].y);

        for (int i = 1; i < outlinePoints.length - 1; ++i) {
          final p0 = outlinePoints[i];
          final p1 = outlinePoints[i + 1];
          path.quadraticBezierTo(
              p0.x, p0.y, (p0.x + p1.x) / 2, (p0.y + p1.y) / 2);
        }
      }

      // 3. Draw the path to the canvas
      canvas.drawPath(path, paint..style = PaintingStyle.fill);
    }
  }

  List<PathPoint> movePoints(Offset position, double scaleX, double scaleY,
      [bool relative = false]) {
    var current = element as PathElement;
    final topLeft = rect.topLeft;
    if (relative) {
      return current.points.map((e) {
        final next = e.toOffset();
        final x = (next.dx - topLeft.dx) * scaleX + topLeft.dx + position.dx;
        final y = (next.dy - topLeft.dy) * scaleY + topLeft.dy + position.dy;
        return e.copyWith(x: x, y: y);
      }).toList();
    }
    var diff = position - topLeft;
    var points = current.points.map((element) {
      final next = element.toOffset() + diff;
      final x = (next.dx - topLeft.dx) * scaleX + topLeft.dx;
      final y = (next.dy - topLeft.dy) * scaleY + topLeft.dy;
      return element.copyWith(x: x, y: y);
    }).toList();
    return points;
  }

  Rect moveRect(Offset position, double scaleX, double scaleY,
      [bool relative = false]) {
    final size = Size(rect.width * scaleX, rect.height * scaleY);
    if (relative) {
      return (rect.topLeft + position) & size;
    }
    return position & size;
  }

  @override
  PathHitCalculator getHitCalculator() =>
      PathHitCalculator(rect, (element as PathElement).points);
}

class PathHitCalculator extends HitCalculator {
  final Rect elementRect;
  final List<PathPoint> points;

  PathHitCalculator(this.elementRect, this.points);

  List<PathPoint> _interpolate(PathPoint a, PathPoint b) {
    final result = <PathPoint>[];

    final distanceX = b.x - a.x;
    final distanceY = b.y - a.y;
    final distance = sqrt(pow(distanceX, 2) + pow(distanceY, 2));

    result.add(a);

    for (int i = 1; i <= distance; i++) {
      result.add(PathPoint(a.x + (distanceX / distance * i).floor(),
          a.y + (distanceY / distance * i).floor()));
    }

    result.add(b);
    return result;
  }

  List<PathPoint> _getInterpolatedPoints(List<PathPoint> points) {
    final result = <PathPoint>[];

    for (int i = 0; i < points.length - 1; i++) {
      result.addAll(_interpolate(points[i], points[i + 1]));
    }

    return result;
  }

  @override
  bool hit(Rect rect) {
    if (!elementRect.overlaps(rect)) {
      return false;
    }
    return _getInterpolatedPoints(points)
        .any((point) => rect.contains(point.toOffset()));
  }
}
