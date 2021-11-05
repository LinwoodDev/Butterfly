import 'dart:math';

import 'package:butterfly/models/elements/element.dart';
import 'package:butterfly/models/properties/path.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:vector_math/vector_math.dart';

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
  bool hit(Offset offset) {
    var last = Vector2(points.first.x, points.first.y);
    return points.any((element) {
      var current = Vector2(element.x, element.y);
      var px = current.x - last.x;
      var py = current.y - last.y;
      var temp = (px * px) + (py * py);
      var u = ((offset.dx - last.x) * px + (offset.dy - last.y) * py) / (temp);
      if (u > 1) {
        u = 1;
      } else if (u < 0) {
        u = 0;
      }
      var x = last.x + u * px;
      var y = last.y + u * py;

      var dx = x - offset.dx;
      var dy = y - offset.dy;
      double dist = sqrt(dx * dx + dy * dy);
      var hit = dist <
          (property.strokeWidth +
                  property.strokeMultiplier * element.pressure) *
              2;
      last = current;
      return hit;
    });
  }

  Paint buildPaint([bool preview = false]);

  void paint(Canvas canvas,
      [Offset offset = Offset.zero, bool preview = false]) {
    if (points.isNotEmpty) {
      var first = points.first;
      var previous = first;
      for (var element in points) {
        canvas.drawLine(
            previous.toOffset() + offset,
            element.toOffset() + offset,
            buildPaint(preview)
              ..strokeWidth = property.strokeWidth +
                  element.pressure * property.strokeMultiplier);
        previous = element;
      }
    }
  }

  PathElement copyWith({List<PathPoint>? points});
}
