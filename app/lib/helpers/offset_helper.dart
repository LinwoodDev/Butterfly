import 'dart:math';
import 'dart:ui';

extension OffsetHelper on Offset {
  Offset rotate(Offset pivot, double radians) {
    final x = dx - pivot.dx;
    final y = dy - pivot.dy;
    final cosA = cos(radians);
    final sinA = sin(radians);
    return Offset(
      x * cosA - y * sinA + pivot.dx,
      x * sinA + y * cosA + pivot.dy,
    );
  }

  Offset scaleFromCenter(double zoom, Offset center) => Offset(
        (dx - center.dx) * zoom + center.dx,
        (dy - center.dy) * zoom + center.dy,
      );

  double getRotation(Offset pivot) {
    final x = dx - pivot.dx;
    final y = dy - pivot.dy;
    return atan2(y, x);
  }

  Point<double> toPoint() => Point(dx, dy);
}
