import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'point.g.dart';
part 'point.freezed.dart';

@freezed
class PathPoint with _$PathPoint {
  const PathPoint._();
  const factory PathPoint(double x, double y, [@Default(1) double pressure]) =
      _PathPoint;

  factory PathPoint.fromPoint(Point<double> point, [double pressure = 1]) =>
      PathPoint(point.x, point.y, pressure);

  factory PathPoint.fromJson(Map<String, dynamic> json) =>
      _$PathPointFromJson(json);

  Point<double> toPoint() => Point(x, y);
}
