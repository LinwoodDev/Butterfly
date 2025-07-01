import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'point.g.dart';
part 'point.freezed.dart';

@freezed
abstract class SimplePoint with _$SimplePoint {
  const SimplePoint._();
  const factory SimplePoint(double x, double y) = _SimplePoint;

  factory SimplePoint.fromPoint(Point<double> point) =>
      SimplePoint(point.x, point.y);

  factory SimplePoint.fromJson(Map<String, dynamic> json) =>
      _$SimplePointFromJson(json);

  Point<double> toPoint() => Point(x, y);

  SimplePoint move(
    double dx,
    double dy, [
    double scaleX = 1,
    double scaleY = 1,
  ]) => SimplePoint(x * scaleX + dx, y * scaleY + dy);
}

@freezed
sealed class PathPoint extends SimplePoint with _$PathPoint {
  const PathPoint._() : super._();
  const factory PathPoint(double x, double y, [@Default(1) double pressure]) =
      _PathPoint;

  factory PathPoint.fromPoint(Point<double> point, [double pressure = 1]) =>
      PathPoint(point.x, point.y, pressure);

  factory PathPoint.fromJson(Map<String, dynamic> json) =>
      _$PathPointFromJson(json);
}

@freezed
sealed class PolygonPoint extends SimplePoint with _$PolygonPoint {
  const PolygonPoint._() : super._();
  const factory PolygonPoint(
    double x,
    double y, {
    SimplePoint? handleIn,
    SimplePoint? handleOut,
  }) = _PolygonPoint;

  factory PolygonPoint.fromJson(Map<String, dynamic> json) =>
      _$PolygonPointFromJson(json);
}
