part of 'element.dart';

class PathPoint {
  final double x, y;
  final double pressure;

  PathPoint(this.x, this.y, [this.pressure = 1]);

  PathPoint.fromJson(Map<String, dynamic> json)
      : x = json['x'],
        y = json['y'],
        pressure = json['pressure'] ?? 1;

  PathPoint.fromOffset(Offset offset, [this.pressure = 1])
      : x = offset.dx,
        y = offset.dy;

  Map<String, dynamic> toJson() => {'x': x, 'y': y, 'pressure': pressure};

  Offset toOffset() => Offset(x, y);

  Vector2 toVector2() => Vector2(x, y);
}

abstract class PathElement extends PadElement {
  final List<PathPoint> points;

  PathProperty get property;

  const PathElement({String layer = '', this.points = const []})
      : super(layer: layer);

  PathElement.fromJson(Map<String, dynamic> json)
      : points = List<dynamic>.from(json['points'] ?? [])
            .map((e) => Map<String, dynamic>.from(e))
            .map((e) => PathPoint.fromJson(e))
            .toList(),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'points': points.map((e) => e.toJson()).toList(),
      }
        ..addAll(property.toJson())
        ..addAll(super.toJson());

  @override
  bool hit(Offset offset, [double radius = 1]) {
    if (points.isEmpty) return false;
    var last = points.first.toVector2();
    var vector = Vector2(offset.dx, offset.dy);
    return points.any((element) {
      double distance;
      var current = element.toVector2();
      var lineWidth = pow(
          property.strokeWidth + property.strokeMultiplier * element.pressure,
          2);
      var l2 = current.length2 + last.length2;
      if (l2 == 0) {
        distance = vector.distanceTo(last);
      } else {
        double t = max(0, min(1, (vector - last).dot(current - last) / l2));
        var projection = current + (last - current) * t;
        distance = vector.distanceTo(projection);
      }

      last = current;
      // If distance is less than line width, then it is a hit.
      return distance <= lineWidth / 2;
    });
  }

  Paint buildPaint([bool preview = false]);

  @override
  void paint(Canvas canvas, [bool preview = false]) {
    if (points.isNotEmpty) {
      var first = points.first;
      var previous = first;
      for (var element in points) {
        canvas.drawLine(
            previous.toOffset(),
            element.toOffset(),
            buildPaint(preview)
              ..strokeWidth = property.strokeWidth +
                  element.pressure * property.strokeMultiplier);
        previous = element;
      }
    }
  }

  @override
  Rect get rect {
    var topLeftCorner = points.first.toOffset();
    var bottomRightCorner = points.first.toOffset();
    for (var element in points) {
      topLeftCorner = Offset(
          min(topLeftCorner.dx, element.x), min(topLeftCorner.dy, element.y));
      bottomRightCorner = Offset(max(bottomRightCorner.dx, element.x),
          max(bottomRightCorner.dy, element.y));
    }
    return Rect.fromLTRB(topLeftCorner.dx, topLeftCorner.dy,
        bottomRightCorner.dx, bottomRightCorner.dy);
  }

  @override
  PathElement moveBy(Offset offset) => copyWith(
      points: points
          .map((e) => PathPoint.fromOffset(e.toOffset() + offset, e.pressure))
          .toList());

  @override
  Offset get position {
    var currentRect = rect;
    return Offset(currentRect.left, currentRect.top);
  }

  @override
  PathElement copyWith({List<PathPoint>? points, String? layer});
}
