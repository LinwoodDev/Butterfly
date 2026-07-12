import 'dart:ui';

import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_leap/helpers.dart';

void main() {
  group('No Bezier', () {
    late PolygonHitCalculator calculator;

    setUp(() {
      final points = [
        PolygonPoint(0, 0),
        PolygonPoint(100, 0),
        PolygonPoint(100, 100),
        PolygonPoint(0, 100),
      ];

      final element = PolygonElement(
        points: points,
        property: const PolygonProperty(
          paint: ElementPaint.solid(color: SRGBColor.black),
          fillPaint: ElementPaint.solid(color: SRGBColor.transparent),
          strokeWidth: 2,
        ),
      );

      final calculatedRect = calculatePolygonRect(points);
      calculator = PolygonHitCalculator(
        calculatedRect,
        points,
        0.0,
        element.property,
      );
    });

    test('HitElementMode.none returns false', () {
      final rect = const Rect.fromLTWH(-50, -50, 200, 200);
      expect(
        calculator.hit(rect, hitElementMode: HitElementMode.none),
        isFalse,
      );
    });

    test('HitElementMode.full', () {
      final fullRect = const Rect.fromLTWH(-10, -10, 120, 120);
      expect(
        calculator.hit(fullRect, hitElementMode: HitElementMode.full),
        isTrue,
      );

      final partialRect = const Rect.fromLTWH(50, -10, 100, 150);
      expect(
        calculator.hit(partialRect, hitElementMode: HitElementMode.full),
        isFalse,
      );
    });

    test('HitElementMode.touchAnywhere partial', () {
      final touchingRect = const Rect.fromLTWH(50, -10, 20, 20);
      expect(
        calculator.hit(
          touchingRect,
          hitElementMode: HitElementMode.touchAnywhere,
        ),
        isTrue,
      );

      final farRect = const Rect.fromLTWH(200, 200, 50, 50);
      expect(
        calculator.hit(farRect, hitElementMode: HitElementMode.touchAnywhere),
        isFalse,
      );
    });

    test('closed concave polygon does not use its bounding box for hits', () {
      final points = [
        PolygonPoint(0, 0),
        PolygonPoint(10, 0),
        PolygonPoint(10, 2),
        PolygonPoint(2, 2),
        PolygonPoint(2, 8),
        PolygonPoint(10, 8),
        PolygonPoint(10, 10),
        PolygonPoint(0, 10),
        PolygonPoint(0, 0),
      ];
      const property = PolygonProperty();
      final openCalculator = PolygonHitCalculator(
        calculatePolygonRect(points.sublist(0, points.length - 1)),
        points.sublist(0, points.length - 1),
        0,
        property,
      );
      final closedCalculator = PolygonHitCalculator(
        calculatePolygonRect(points),
        points,
        0,
        property,
      );
      const selection = Rect.fromLTWH(5, 4, 2, 2);

      expect(
        openCalculator.hit(
          selection,
          hitElementMode: HitElementMode.touchAnywhere,
        ),
        isFalse,
      );
      expect(
        closedCalculator.hit(
          selection,
          hitElementMode: HitElementMode.touchAnywhere,
        ),
        isFalse,
      );
    });

    test('handles unbounded spacer rectangles', () {
      final rightSpacerRect = const Rect.fromLTRB(
        50,
        -double.infinity,
        double.infinity,
        double.infinity,
      );
      final leftSpacerRect = const Rect.fromLTRB(
        -double.infinity,
        -double.infinity,
        -50,
        double.infinity,
      );

      expect(
        calculator.hit(
          rightSpacerRect,
          hitElementMode: HitElementMode.touchAnywhere,
        ),
        isTrue,
      );
      expect(
        calculator.hit(
          leftSpacerRect,
          hitElementMode: HitElementMode.touchAnywhere,
        ),
        isFalse,
      );
    });
  });

  group('Bezier', () {
    late PolygonHitCalculator calculator;

    setUp(() {
      final points = [
        PolygonPoint(0, 0, handleOut: const SimplePoint(25, -50)),
        PolygonPoint(100, 0, handleIn: const SimplePoint(75, -50)),
        PolygonPoint(100, 100),
        PolygonPoint(0, 100),
      ];

      final element = PolygonElement(
        points: points,
        property: const PolygonProperty(
          paint: ElementPaint.solid(color: SRGBColor.green),
          fillPaint: ElementPaint.solid(color: SRGBColor.black),
          strokeWidth: 2,
        ),
      );

      final calculatedRect = calculatePolygonRect(points);
      calculator = PolygonHitCalculator(
        calculatedRect,
        points,
        0.0,
        element.property,
      );
    });

    test('HitElementMode.full', () {
      final smallRect = const Rect.fromLTWH(-5, -5, 110, 110);
      expect(
        calculator.hit(smallRect, hitElementMode: HitElementMode.full),
        isFalse,
      );

      final bigRect = const Rect.fromLTWH(-5, -50, 110, 160);
      expect(
        calculator.hit(bigRect, hitElementMode: HitElementMode.full),
        isTrue,
      );
    });

    test('HitElementMode.touchAnywhere', () {
      final curveIntersectionRect = const Rect.fromLTWH(45, -35, 10, 10);
      expect(
        calculator.hit(
          curveIntersectionRect,
          hitElementMode: HitElementMode.touchAnywhere,
        ),
        isTrue,
      );
    });
  });

  group('Lasso tests', () {
    late PolygonHitCalculator calculator;

    setUp(() {
      final points = [
        PolygonPoint(0, 0),
        PolygonPoint(100, 0),
        PolygonPoint(100, 100),
        PolygonPoint(0, 100),
      ];
      final element = PolygonElement(
        points: points,
        property: const PolygonProperty(),
      );
      calculator = PolygonHitCalculator(
        calculatePolygonRect(points),
        points,
        0.0,
        element.property,
      );
    });

    test('Lasso full selection', () {
      final lassoAroundAll = const [
        Offset(-20, -20),
        Offset(120, -20),
        Offset(120, 120),
        Offset(-20, 120),
      ];

      expect(
        calculator.hitPolygon(
          lassoAroundAll,
          hitElementMode: HitElementMode.full,
        ),
        isTrue,
      );
    });

    test('Lasso partial selection', () {
      final partialLasso = const [
        Offset(50, -50),
        Offset(150, -50),
        Offset(150, 50),
        Offset(50, 50),
      ];

      expect(
        calculator.hitPolygon(
          partialLasso,
          hitElementMode: HitElementMode.full,
        ),
        isFalse,
      );
      expect(
        calculator.hitPolygon(
          partialLasso,
          hitElementMode: HitElementMode.touchAnywhere,
        ),
        isTrue,
      );
    });
  });
}
