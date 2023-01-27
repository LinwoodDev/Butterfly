import 'dart:math';
import 'dart:ui';

extension OffsetHelper on Offset {
  Offset rotate(Offset pivot, double angle) {
    final x = dx - pivot.dx;
    final y = dy - pivot.dy;
    final cosA = cos(angle);
    final sinA = sin(angle);
    return Offset(
      x * cosA - y * sinA + pivot.dx,
      x * sinA + y * cosA + pivot.dy,
    );
  }

  Offset scaleFromCenter(double zoom, Offset center) => Offset(
        (dx - center.dx) * zoom + center.dx,
        (dy - center.dy) * zoom + center.dy,
      );
}
