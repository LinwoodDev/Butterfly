import 'package:butterfly/models/elements/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PaintElement extends PathElement {
  final Color color;
  final bool fill;

  PaintElement(
      {List<Offset> points = const [],
      double strokeWidth = 5.0,
      this.color = Colors.black,
      this.fill = false})
      : super(points: points, strokeWidth: strokeWidth);

  PaintElement.fromJson(Map<String, dynamic> json)
      : color = json['color'] == null ? Colors.black : Color(json['color']),
        fill = json['fill'] ?? false,
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({'type': 'paint', 'color': color.value});
  @override
  Paint buildPaint() => Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  Path buildPath() {
    var path = Path();
    if (points.isNotEmpty) {
      var first = points.first;
      path.moveTo(first.dx, first.dy);
      path.lineTo(first.dx, first.dy);
      points.sublist(1).forEach((element) => path.lineTo(element.dx, element.dy));
    }
    return path;
  }

  @override
  PaintElement copyWith({List<Offset>? points, double? strokeWidth, Color? color, bool? fill}) =>
      PaintElement(
          color: color ?? this.color,
          points: points ?? this.points,
          strokeWidth: strokeWidth ?? this.strokeWidth,
          fill: fill ?? this.fill);

  @override
  bool hit(Offset offset) => points.any((element) =>
      (element.dx - offset.dx).abs() <= strokeWidth &&
      (element.dy - offset.dy).abs() <= strokeWidth);
}
