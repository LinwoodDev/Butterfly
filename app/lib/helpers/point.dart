import 'dart:math';
import 'dart:ui';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_leap/material_leap.dart';
import 'package:perfect_freehand/perfect_freehand.dart' as freehand show Point;
import 'package:vector_math/vector_math.dart' show Vector2;

extension PointHelper on Point<double> {
  Offset toOffset() => Offset(x, y);
}

extension FreeHandHelper on freehand.Point {
  String roundedX() => x.toStringAsFixed(kRoundPrecision);
  String roundedY() => y.toStringAsFixed(kRoundPrecision);
  String roundedBetweenX(freehand.Point p) =>
      ((x + p.x) / 2).toStringAsFixed(kRoundPrecision);
  String roundedBetweenY(freehand.Point p) =>
      ((y + p.y) / 2).toStringAsFixed(kRoundPrecision);
}

extension PathPointHelper on PathPoint {
  static PathPoint fromVector(Vector2 vector, [double pressure = 1]) =>
      PathPoint(vector.x, vector.y, pressure);

  Vector2 toVector() => Vector2(x, y);

  freehand.Point toFreehandPoint([double thinning = 1]) =>
      freehand.Point(x, y, pressure * thinning);

  Offset toOffset() => Offset(x, y);

  PathPoint scale(double zoom, Offset center) => PathPoint.fromPoint(
      toOffset().scaleFromCenter(zoom, center).toPoint(), pressure);

  PathPoint rotate(Offset center, double angle) {
    final rotated = toOffset().rotate(center, angle);
    return PathPoint(rotated.dx, rotated.dy, pressure);
  }
}
