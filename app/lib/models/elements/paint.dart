import 'package:butterfly/models/elements/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PaintElement extends PathElement {
  final Color color;
  final bool fill;

  const PaintElement(
      {List<PathPoint> points = const [],
      double strokeWidth = 5.0,
      double strokeMultiplier = 1.0,
      this.color = Colors.black,
      this.fill = false})
      : super(points: points, strokeWidth: strokeWidth, strokeMultiplier: strokeMultiplier);

  PaintElement.fromJson(Map<String, dynamic> json, [int? fileVersion])
      : color = json['color'] == null ? Colors.black : Color(json['color']),
        fill = json['fill'] ?? false,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      super.toJson()..addAll({'type': 'paint', 'color': color.value, 'fill': fill});
  @override
  Paint buildPaint(int index) => Paint()
    ..color = color
    ..strokeWidth = strokeWidth + points[index].pressure * strokeMultiplier
    ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  Path buildPath() {
    var path = Path();
    if (points.isNotEmpty) {
      var first = points.first;
      path.moveTo(first.x, first.y);
      path.lineTo(first.x, first.y);
      points.sublist(1).forEach((element) => path.lineTo(element.x, element.y));
    }
    return path;
  }

  @override
  PaintElement copyWith({List<PathPoint>? points, double? strokeWidth, Color? color, bool? fill}) =>
      PaintElement(
          color: color ?? this.color,
          points: points ?? this.points,
          strokeWidth: strokeWidth ?? this.strokeWidth,
          fill: fill ?? this.fill);

  @override
  bool hit(Offset offset) => points.any((element) =>
      (element.x - offset.dx).abs() <= strokeWidth && (element.y - offset.dy).abs() <= strokeWidth);
}
