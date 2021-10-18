import 'package:butterfly/models/elements/element.dart';
import 'package:flutter/painting.dart';

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
}

abstract class PathElement extends ElementLayer {
  final List<PathPoint> points;
  final double strokeWidth;
  final double strokeMultiplier;

  const PathElement({this.points = const [], this.strokeWidth = 5, required this.strokeMultiplier});
  PathElement.fromJson(Map<String, dynamic> json)
      : points = List<Map<String, dynamic>>.from(json['points'] ?? [])
            .map((e) => PathPoint.fromJson(e))
            .toList(),
        strokeMultiplier = json['strokeMultiplier'],
        strokeWidth = json['strokeWidth'] ?? 5;

  @override
  Map<String, dynamic> toJson() => {
        'points': points.map((e) => e.toJson()).toList(),
        'strokeWidth': strokeWidth,
      };
  @override
  bool hit(Offset offset) => points.any((element) =>
      (element.x - offset.dx).abs() <= strokeWidth && (element.y - offset.dy).abs() <= strokeWidth);
  Paint buildPaint(int index);
  Path buildPath();

  PathElement copyWith({List<PathPoint>? points, double? strokeWidth});
}
