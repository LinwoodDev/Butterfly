import 'dart:ui';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';

bool lineIntersectsLine(Offset l1p1, Offset l1p2, Offset l2p1, Offset l2p2) {
  final demon =
      (l2p2.dy - l2p1.dy) * (l1p2.dx - l1p1.dx) -
      (l2p2.dx - l2p1.dx) * (l1p2.dy - l1p1.dy);
  if (demon == 0) {
    return false;
  }
  final ua =
      ((l2p2.dx - l2p1.dx) * (l1p1.dy - l2p1.dy) -
              (l2p2.dy - l2p1.dy) * (l1p1.dx - l2p1.dx))
          .toDouble() /
      demon;
  final ub =
      ((l1p2.dx - l1p1.dx) * (l1p1.dy - l2p1.dy) -
              (l1p2.dy - l1p1.dy) * (l1p1.dx - l2p1.dx))
          .toDouble() /
      demon;
  return ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1;
}

extension AreaHelper on Area {
  Rect get rect {
    final topLeft = Offset(
      width < 0 ? position.x + width : position.x,
      height < 0 ? position.y + height : position.y,
    );
    return Rect.fromLTWH(topLeft.dx, topLeft.dy, width.abs(), height.abs());
  }

  bool hit(Offset offset, [double radius = 0]) =>
      rect.inflate(radius).contains(offset);
}

extension DocumentAreaHelper on DocumentPage {
  Area? getAreaByRect(Rect rect) {
    return areas.firstWhereOrNull((e) => rect.overlaps(e.rect));
  }

  Area? getArea(Offset offset) {
    return areas.firstWhereOrNull((e) => e.hit(offset));
  }

  List<Area> getAreasByRect(Rect rect) {
    return areas.where((e) => rect.overlaps(e.rect)).toList();
  }

  List<Area> getAreas(Offset offset, [double radius = 0]) {
    return areas.where((e) => e.hit(offset, radius)).toList();
  }
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

  bool containsLine(Offset first, Offset second, {bool full = false}) {
    if (full) {
      return contains(first) && contains(second);
    } else {
      return contains(first) ||
          contains(second) ||
          lineIntersectsLine(first, second, topLeft, topRight) ||
          lineIntersectsLine(first, second, topRight, bottomRight) ||
          lineIntersectsLine(first, second, bottomRight, bottomLeft) ||
          lineIntersectsLine(first, second, bottomLeft, topLeft);
    }
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
