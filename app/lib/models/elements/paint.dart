import 'package:butterfly/models/elements/element.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PaintElement extends ElementLayer {
  final List<Offset> points;
  final double strokeWidth;
  final Color color;

  PaintElement({this.points = const [], this.strokeWidth = 8.0, this.color = Colors.black});

  PaintElement.fromJson(Map<String, dynamic> json)
      : points = (json['points'] as List<Map<String, dynamic>>)
            .map((e) => Offset(e['x'], e['y']))
            .toList(),
        strokeWidth = json['stroke-width'],
        color = Color(json['color']);

  @override
  Map<String, dynamic> toJson() => {
        'type': 'paint',
        'points': points.map((e) => {"x": e.dx, "y": e.dy}),
        'stroke-width': strokeWidth,
        'color': color.value
      };
  Paint buildPaint() => Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  Path buildPath() {
    var path = Path();
    if (points.length > 1) {
      var first = points.first;
      path.moveTo(first.dx, first.dy);
      points.sublist(1).forEach((element) => path.lineTo(element.dx, element.dy));
    }
    return path;
  }

  PaintElement copyWith({List<Offset>? points, double? strokeWidth, Color? color}) => PaintElement(
      color: color ?? this.color,
      points: points ?? this.points,
      strokeWidth: strokeWidth ?? this.strokeWidth);
}
