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

  PaintElement.fromJson(Map<String, dynamic> json, [String? fileVersion])
      : color = json['color'] == null ? Colors.black : Color(json['color']),
        fill = json['fill'] ?? false,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      super.toJson()..addAll({'type': 'paint', 'color': color.value, 'fill': fill});
  @override
  Paint buildPaint() => Paint()
    ..color = color
    ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

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
