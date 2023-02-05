import 'dart:ui';

import 'package:butterfly/helpers/offset_helper.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:perfect_freehand/perfect_freehand.dart' show Point;
import 'package:vector_math/vector_math.dart' show Vector2;

extension PathPointHelper on PathPoint {
  static PathPoint fromVector(Vector2 vector, [double pressure = 1]) =>
      PathPoint(vector.x, vector.y, pressure);

  Vector2 toVector() => Vector2(x, y);

  Point toFreehandPoint([double thinning = 1]) =>
      Point(x, y, pressure * thinning);

  PathPoint scale(double zoom, Offset center) =>
      PathPoint.fromOffset(toOffset().scaleFromCenter(zoom, center), pressure);
}
