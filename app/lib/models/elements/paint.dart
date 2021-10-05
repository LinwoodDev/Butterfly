import 'package:butterfly/models/elements/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PaintElement extends PathElement {
  final Color color;

  PaintElement(
      {List<Offset> points = const [], double strokeWidth = 5.0, this.color = Colors.black})
      : super(points: points, strokeWidth: strokeWidth);

  PaintElement.fromJson(Map<String, dynamic> json)
      : color = Color(json['color']),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() => super.toJson()..addAll({'type': 'paint', 'color': color.value});
  @override
  Paint buildPaint() => Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  Path buildPath() {
    var path = Path();
    if (points.length > 1) {
      var first = points.first;
      path.moveTo(first.dx, first.dy);
      points.sublist(1).forEach((element) => path.lineTo(element.dx, element.dy));
    }
    return path;
  }

  @override
  PaintElement copyWith({List<Offset>? points, double? strokeWidth, Color? color}) => PaintElement(
      color: color ?? this.color,
      points: points ?? this.points,
      strokeWidth: strokeWidth ?? this.strokeWidth);

  @override
  bool hit(Offset offset) => points.any((element) =>
      (element.dx - offset.dx).abs() <= strokeWidth &&
      (element.dy - offset.dy).abs() <= strokeWidth);
}
