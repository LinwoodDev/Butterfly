import 'package:butterfly/models/elements/element.dart';
import 'package:flutter/painting.dart';

abstract class PathElement extends ElementLayer {
  final List<Offset> points;
  final double strokeWidth;

  const PathElement({this.points = const [], this.strokeWidth = 5});
  PathElement.fromJson(Map<String, dynamic> json)
      : points = List<Map<String, dynamic>>.from(json['points'])
            .map((e) => Offset(e['x'], e['y']))
            .toList(),
        strokeWidth = json['strokeWidth'];

  @override
  Map<String, dynamic> toJson() => {
        'points': points.map((e) => {'x': e.dx, 'y': e.dy}).toList(),
        'strokeWidth': strokeWidth,
      };
  @override
  bool hit(Offset offset) => points.any((element) =>
      (element.dx - offset.dx).abs() <= strokeWidth &&
      (element.dy - offset.dy).abs() <= strokeWidth);
  Paint buildPaint();
  Path buildPath();

  PathElement copyWith({List<Offset>? points, double? strokeWidth});
}
