import 'dart:ui';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly/helpers/point.dart';
import 'package:dart_leap/dart_leap.dart';

Path? elementToPath(PadElement element) {
  if (element is ShapeElement) {
    final rect = Rect.fromPoints(
      element.firstPosition.toOffset(),
      element.secondPosition.toOffset(),
    );
    final shape = element.property.shape;
    final drawRect = rect.inflate(-element.property.strokeWidth / 2);

    if (shape is RectangleShape) {
      final topLeft = shape.topLeftCornerRadius / 100 * drawRect.shortestSide;
      final topRight = shape.topRightCornerRadius / 100 * drawRect.shortestSide;
      final bottomLeft =
          shape.bottomLeftCornerRadius / 100 * drawRect.shortestSide;
      final bottomRight =
          shape.bottomRightCornerRadius / 100 * drawRect.shortestSide;
      return Path()..addRRect(
        RRect.fromRectAndCorners(
          drawRect,
          topLeft: Radius.circular(topLeft),
          topRight: Radius.circular(topRight),
          bottomLeft: Radius.circular(bottomLeft),
          bottomRight: Radius.circular(bottomRight),
        ),
      );
    } else if (shape is CircleShape) {
      return Path()..addOval(drawRect);
    } else if (shape is TriangleShape) {
      final topCenter = drawRect.topCenter;
      return Path()
        ..moveTo(topCenter.dx, topCenter.dy)
        ..lineTo(drawRect.right, drawRect.bottom)
        ..lineTo(drawRect.left, drawRect.bottom)
        ..close();
    } else if (shape is LineShape) {
      // Lines don't have area for boolean ops usually, unless stroked.
      // But for now let's ignore or treat as thin rectangle?
      // Treating as path is fine, but combine might fail or do nothing if it has no area.
      return Path()
        ..moveTo(element.firstPosition.x, element.firstPosition.y)
        ..lineTo(element.secondPosition.x, element.secondPosition.y);
    }
  } else if (element is PolygonElement) {
    final points = element.points;
    if (points.isEmpty) return null;
    final path = Path();
    final first = points.first;
    path.moveTo(first.x, first.y);
    for (var i = 1; i < points.length; i++) {
      final point = points[i];
      final prev = points[i - 1];

      if (prev.handleOut != null || point.handleIn != null) {
        path.cubicTo(
          prev.handleOut?.x ?? prev.x,
          prev.handleOut?.y ?? prev.y,
          point.handleIn?.x ?? point.x,
          point.handleIn?.y ?? point.y,
          point.x,
          point.y,
        );
      } else {
        path.lineTo(point.x, point.y);
      }
    }
    path.close(); // Polygons should be closed for boolean ops
    return path;
  }
  return null;
}

List<PolygonElement> performPathOperation(
  List<PadElement> elements,
  PathOperation operation,
) {
  if (elements.isEmpty) return [];
  var currentPath = elementToPath(elements.first);
  if (currentPath == null) return [];

  for (var i = 1; i < elements.length; i++) {
    final nextPath = elementToPath(elements[i]);
    if (nextPath != null) {
      currentPath = Path.combine(operation, currentPath!, nextPath);
    }
  }

  if (currentPath == null) return [];

  // Convert back to polygons
  final polygons = <PolygonElement>[];
  final metrics = currentPath.computeMetrics();

  for (final metric in metrics) {
    final points = <PolygonPoint>[];
    // Sample points
    final length = metric.length;
    final startTangent = metric.getTangentForOffset(0);
    if (startTangent != null) {
      _addPoint(points, startTangent.position);
      final endTangent = metric.getTangentForOffset(length);
      if (endTangent != null) {
        _adaptiveSample(
          metric,
          0,
          length,
          startTangent.position,
          endTangent.position,
          points,
        );
      }
    }

    if (points.length > 2) {
      // Copy properties from the first element or use default
      final first = elements.first;
      ShapeProperty? shapeProp;
      PolygonProperty? polyProp;

      if (first is ShapeElement) shapeProp = first.property;
      if (first is PolygonElement) polyProp = first.property;

      final newProp =
          polyProp ??
          (shapeProp != null
              ? PolygonProperty(
                  strokeWidth: shapeProp.strokeWidth,
                  color: shapeProp.color,
                  fill: shapeProp.shape is! LineShape
                      ? (shapeProp.shape as dynamic).fillColor
                      : SRGBColor.transparent,
                )
              : const PolygonProperty());

      polygons.add(PolygonElement(points: points, property: newProp));
    }
  }
  return polygons;
}

bool _isFlat(Offset p1, Offset p2, Offset p3) {
  final d1 = (p2 - p1).distance;
  final d2 = (p3 - p2).distance;
  final d3 = (p3 - p1).distance;
  return (d1 + d2 - d3).abs() < 0.05;
}

void _addPoint(List<PolygonPoint> points, Offset pos) {
  final x = pos.dx;
  final y = pos.dy;

  if (points.isNotEmpty) {
    final last = points.last;
    if ((x - last.x).abs() < 0.05 && (y - last.y).abs() < 0.05) {
      return;
    }

    if (points.length >= 2) {
      final secondLast = points[points.length - 2];
      final dx1 = last.x - secondLast.x;
      final dy1 = last.y - secondLast.y;
      final dx2 = x - last.x;
      final dy2 = y - last.y;

      final cross = dx1 * dy2 - dy1 * dx2;
      if (cross.abs() < 0.1) {
        points.removeLast();
      }
    }
  }
  points.add(PolygonPoint(x, y));
}

void _adaptiveSample(
  PathMetric metric,
  double start,
  double end,
  Offset pStart,
  Offset pEnd,
  List<PolygonPoint> points,
) {
  if (end - start < 0.5) {
    _addPoint(points, pEnd);
    return;
  }

  final mid = (start + end) / 2;
  final tMid = metric.getTangentForOffset(mid);
  if (tMid == null) {
    _addPoint(points, pEnd);
    return;
  }
  final pMid = tMid.position;

  if (_isFlat(pStart, pMid, pEnd)) {
    _addPoint(points, pEnd);
  } else {
    _adaptiveSample(metric, start, mid, pStart, pMid, points);
    _adaptiveSample(metric, mid, end, pMid, pEnd, points);
  }
}
