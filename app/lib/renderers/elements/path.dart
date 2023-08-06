part of '../renderer.dart';

abstract class PathRenderer<T extends PadElement> extends Renderer<T> {
  @override
  Rect rect = Rect.zero;

  PathRenderer(super.element,
      [this.rect = Rect.zero, this.expandedRect = Rect.zero]);

  double? get zoom => null;

  @override
  Rect expandedRect = Rect.zero;

  Paint buildPaint([DocumentPage? page, bool foreground = false]);

  @override
  FutureOr<void> setup(
      NoteData document, AssetService assetService, DocumentPage page) {
    final current = element as PathElement;
    final points = current.points;
    final property = current.property;
    var topLeftCorner = points.first.toOffset();
    var bottomRightCorner = points.first.toOffset();
    for (final element in points) {
      topLeftCorner = Offset(
          min(topLeftCorner.dx, element.x), min(topLeftCorner.dy, element.y));
      bottomRightCorner = Offset(max(bottomRightCorner.dx, element.x),
          max(bottomRightCorner.dy, element.y));
    }
    rect = Rect.fromLTRB(topLeftCorner.dx, topLeftCorner.dy,
        bottomRightCorner.dx, bottomRightCorner.dy);
    final center = Rect.fromPoints(topLeftCorner, bottomRightCorner).center;
    final rotatedPoints =
        points.map((e) => e.rotate(center, rotation / 180 * pi)).toList();
    topLeftCorner = rotatedPoints.first.toOffset();
    bottomRightCorner = rotatedPoints.first.toOffset();
    for (final element in rotatedPoints) {
      final width = property.strokeWidth + element.pressure * property.thinning;
      topLeftCorner = Offset(min(topLeftCorner.dx, element.x - width),
          min(topLeftCorner.dy, element.y - width));
      bottomRightCorner = Offset(max(bottomRightCorner.dx, element.x + width),
          max(bottomRightCorner.dy, element.y + width));
    }
    expandedRect = Rect.fromLTRB(topLeftCorner.dx, topLeftCorner.dy,
        bottomRightCorner.dx, bottomRightCorner.dy);
    super.setup(document, assetService, page);
  }

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    final current = element as PathElement;
    final points = current.points;
    final currentZoom = zoom ?? kMaxZoom;
    final property = current.property;
    final paint = buildPaint(page, foreground);
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
      var outlinePoints = freehand.getStroke(
        points
            .map((e) => e.scale(zoom ?? kMaxZoom, center))
            .map((e) => e.toFreehandPoint())
            .toList(),
        size: property.strokeWidth * currentZoom,
        thinning: property.thinning.clamp(0, 1),
        smoothing: property.smoothing.clamp(0, 1),
        streamline: property.streamline.clamp(.1, 1),
        simulatePressure: true,
      );

      // Unscale the points
      outlinePoints = outlinePoints.map((e) {
        var point = Offset(e.x, e.y);
        point = point.scaleFromCenter(1 / currentZoom, center);
        return freehand.Point(point.dx, point.dy, e.p);
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

  List<PathPoint> movePoints(
    Offset position,
    double scaleX,
    double scaleY,
  ) {
    var current = element as PathElement;
    final topLeft = expandedRect.topLeft;
    final points = current.points.map((element) {
      final old = element.toOffset() - topLeft;
      final x = old.dx * scaleX + position.dx;
      final y = old.dy * scaleY + position.dy;
      return element.copyWith(x: x, y: y);
    }).toList();
    return points;
  }

  Rect moveRect(Offset position, double scaleX, double scaleY) {
    final size = Size(rect.width * scaleX, rect.height * scaleY);
    return position & size;
  }

  @override
  PathHitCalculator getHitCalculator() => PathHitCalculator(
      rect, (element as PathElement).points, rotation * pi / 180);
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

    result.add(a);

    for (int i = 1; i <= distance; i++) {
      result.add(PathPoint(a.x + (distanceX / distance * i).floor(),
              a.y + (distanceY / distance * i).floor())
          .rotate(
        elementRect.center,
        rotation,
      ));
    }

    result.add(b);
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
  bool hit(Rect rect) {
    if (!elementRect.overlaps(rect)) {
      return false;
    }
    return _getInterpolatedPoints(points)
        .any((point) => rect.contains(point.toOffset()));
  }
}
