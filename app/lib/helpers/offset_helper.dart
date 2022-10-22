import 'dart:math';
import 'dart:ui';

extension OffsetHelper on Offset {
  Offset rotate(Offset pivot, double angle) {
    final s = sin(angle);
    final c = cos(angle);

    final translated = translate(-pivot.dx, -pivot.dy);

    final xnew = translated.dx * c + translated.dy * s;
    final ynew = translated.dx * s + translated.dy * c;

    return Offset(xnew + pivot.dx, ynew + pivot.dy);
  }
}
