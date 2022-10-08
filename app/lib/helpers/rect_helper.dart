import 'dart:ui';

import 'package:collection/collection.dart';

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

    final firstX = first.dx;
    final firstY = first.dy;
    final secondX = second.dx;
    final secondY = second.dy;
    final rectFirstX = normalizedRect.left;
    final rectFirstY = normalizedRect.top;
    final rectSecondX = normalizedRect.right;
    final rectSecondY = normalizedRect.bottom;
    final uA = ((secondX - firstX) * (rectFirstY - firstY) -
            (secondY - firstY) * (rectFirstX - firstX)) /
        ((secondY - firstY) * (rectSecondX - rectFirstX) -
            (secondX - firstX) * (rectSecondY - rectFirstY));
    final uB = ((rectSecondX - rectFirstX) * (rectFirstY - firstY) -
            (rectSecondY - rectFirstY) * (rectFirstX - firstX)) /
        ((secondY - firstY) * (rectSecondX - rectFirstX) -
            (secondX - firstX) * (rectSecondY - rectFirstY));
    return uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1;
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
