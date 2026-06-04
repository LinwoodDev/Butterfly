import 'dart:ui';

import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestHitCalculator extends HitCalculator {
  @override
  bool hit(
    Rect rect, {
    HitElementMode hitElementMode = HitElementMode.touchAnywhere,
  }) => false;

  @override
  bool hitPolygon(
    List<Offset> polygon, {
    HitElementMode hitElementMode = HitElementMode.touchAnywhere,
  }) => false;
}

void main() {
  group('HitCalculator.isPolygonInPolygon', () {
    test('does not hit a polygon in the hollow of a concave lasso', () {
      final calculator = _TestHitCalculator();
      final lasso = [
        Offset(0, 0),
        Offset(10, 0),
        Offset(10, 2),
        Offset(2, 2),
        Offset(2, 8),
        Offset(10, 8),
        Offset(10, 10),
        Offset(0, 10),
      ];
      final shapeInHollow = [
        Offset(5, 4),
        Offset(7, 4),
        Offset(7, 6),
        Offset(5, 6),
      ];

      expect(calculator.isPolygonInPolygon(lasso, shapeInHollow), isFalse);
    });

    test('hits intersecting polygons', () {
      final calculator = _TestHitCalculator();
      final lasso = [
        Offset(0, 0),
        Offset(10, 0),
        Offset(10, 2),
        Offset(2, 2),
        Offset(2, 8),
        Offset(10, 8),
        Offset(10, 10),
        Offset(0, 10),
      ];
      final crossingShape = [
        Offset(1, 1),
        Offset(3, 1),
        Offset(3, 3),
        Offset(1, 3),
      ];

      expect(calculator.isPolygonInPolygon(lasso, crossingShape), isTrue);
    });
  });
}
