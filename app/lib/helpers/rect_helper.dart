import 'dart:ui';

import 'package:collection/collection.dart';

bool lineIntersectsLine(Offset l1p1, Offset l1p2, Offset l2p1, Offset l2p2) {
  var q = (l1p1.dx - l2p1.dy) * (l2p2.dx - l2p1.dx) -
      (l1p1.dx - l2p1.dx) * (l2p2.dy - l2p1.dy);
  final d = (l1p2.dx - l1p1.dx) * (l2p2.dy - l2p1.dy) -
      (l1p2.dy - l1p1.dy) * (l2p2.dx - l2p1.dx);

  if (d == 0) {
    return false;
  }

  final r = q / d;

  q = (l1p1.dy - l2p1.dy) * (l1p2.dx - l1p1.dx) -
      (l1p1.dx - l2p1.dx) * (l1p2.dy - l1p1.dy);
  final s = q / d;

  if (r < 0 || r > 1 || s < 0 || s > 1) {
    return false;
  }

  return true;
}

extension RectHelper on Rect {
  Rect normalized() {
    var firstX = left;
    var firstY = top;
    var secondX = right;
    var secondY = bottom;
    if (firstX > secondX) {
      final temp = firstX;
      firstX = secondX;
      secondX = temp;
    }
    if (firstY > secondY) {
      final temp = firstY;
      firstY = secondY;
      secondY = temp;
    }
    return Rect.fromLTRB(firstX, firstY, secondX, secondY);
  }

  bool containsLine(Offset first, Offset second) {
    final normalizedRect = normalized();
    final topLeft = normalizedRect.topLeft;
    final topRight = normalizedRect.topRight;
    final bottomLeft = normalizedRect.bottomLeft;
    final bottomRight = normalizedRect.bottomRight;
    return lineIntersectsLine(topLeft, topRight, first, second) ||
        lineIntersectsLine(topRight, bottomRight, first, second) ||
        lineIntersectsLine(bottomRight, bottomLeft, first, second) ||
        lineIntersectsLine(bottomLeft, topLeft, first, second) ||
        (normalizedRect.contains(first) && normalizedRect.contains(second));
  }
}

extension RectsHelper on Iterable<Rect> {
  Rect? expandRects() {
    var rect = firstOrNull;
    for (final current in this) {
      rect = rect?.expandToInclude(current);
    }
    return rect;
  }
}
