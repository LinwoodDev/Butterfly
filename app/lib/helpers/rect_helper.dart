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
