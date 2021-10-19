import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/properties/path.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

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
  Map<String, dynamic> toJson() => {"x": x, "y": y, "pressure": pressure};

  Offset toOffset() => Offset(x, y);
}

abstract class PathElement extends ElementLayer {
  final List<PathPoint> points;
  PathProperty get property;

  const PathElement({this.points = const []});
  PathElement.fromJson(Map<String, dynamic> json)
      : points = List<Map<String, dynamic>>.from(json['points'] ?? [])
            .map((e) => PathPoint.fromJson(e))
            .toList();

  @override
  Map<String, dynamic> toJson() => {
        'points': points.map((e) => e.toJson()).toList(),
      }..addAll(property.toJson());
  @override
  bool hit(Offset offset) => points.any((element) =>
      (element.x - offset.dx).abs() <= property.strokeWidth &&
      (element.y - offset.dy).abs() <= property.strokeWidth);

  Paint buildPaint();

  void paint(Canvas canvas, [Offset offset = Offset.zero]) {
    if (points.isNotEmpty) {
      var first = points.first;
      var previous = first;
      for (var element in points) {
        canvas.drawLine(
            previous.toOffset() + offset,
            element.toOffset() + offset,
            buildPaint()
              ..strokeWidth = property.strokeWidth + element.pressure * property.strokeMultiplier);
        previous = element;
      }
    }
  }

  PathElement copyWith({List<PathPoint>? points});
}
