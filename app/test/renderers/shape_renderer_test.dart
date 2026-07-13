import 'dart:math';
import 'dart:ui';

import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('zero-size shape exposes a non-empty selection rectangle', () {
    final renderer = ShapeRenderer(
      ShapeElement(
        firstPosition: const Point(10, 10),
        secondPosition: const Point(10, 10),
      ),
    );

    expect(renderer.rect.isEmpty, isTrue);
    expect(renderer.expandedRect.isEmpty, isFalse);
    expect(renderer.expandedRect.center, const Offset(10, 10));
  });

  test('zero-size shape is hit by rectangle selection', () {
    final hitCalculator = ShapeRenderer(
      ShapeElement(
        firstPosition: const Point(10, 10),
        secondPosition: const Point(10, 10),
      ),
    ).getHitCalculator();

    expect(hitCalculator.hit(const Rect.fromLTWH(9, 9, 2, 2)), isTrue);
    expect(hitCalculator.hit(const Rect.fromLTWH(11, 11, 2, 2)), isFalse);
  });

  test('zero-size shape is hit by lasso selection', () {
    final hitCalculator = ShapeRenderer(
      ShapeElement(
        firstPosition: const Point(10, 10),
        secondPosition: const Point(10, 10),
        property: const ShapeProperty(shape: LineShape()),
      ),
    ).getHitCalculator();

    expect(
      hitCalculator.hitPolygon(const [
        Offset(9, 9),
        Offset(11, 9),
        Offset(11, 11),
        Offset(9, 11),
      ]),
      isTrue,
    );
    expect(
      hitCalculator.hitPolygon(const [
        Offset(11, 11),
        Offset(13, 11),
        Offset(13, 13),
        Offset(11, 13),
      ]),
      isFalse,
    );
  });

  test('rotated pen stroke is hit outside its original bounds', () {
    final hitCalculator = PenRenderer(
      PenElement(
        rotation: 90,
        points: const [PathPoint(10, 0), PathPoint(10, 100)],
      ),
      null,
      const Rect.fromLTRB(10, 0, 10, 100),
      const Rect.fromLTRB(-40, 49, 60, 51),
    ).getHitCalculator();

    expect(hitCalculator.hit(const Rect.fromLTWH(58, 49, 4, 2)), isTrue);
  });

  test('rotated shape is hit outside its original bounds', () {
    final hitCalculator = ShapeRenderer(
      ShapeElement(
        rotation: 90,
        firstPosition: const Point(0, 0),
        secondPosition: const Point(10, 100),
      ),
    ).getHitCalculator();

    expect(hitCalculator.hit(const Rect.fromLTWH(50, 49, 2, 2)), isTrue);
  });

  test('default rotated renderer is hit outside its original bounds', () {
    final hitCalculator = DefaultHitCalculator(
      const Rect.fromLTWH(0, 0, 10, 100),
      const Rect.fromLTWH(-45, 45, 100, 10),
      pi / 2,
    );

    expect(hitCalculator.hit(const Rect.fromLTWH(50, 49, 2, 2)), isTrue);
  });

  group('unbounded spacer rectangles', () {
    const rightSpacerRect = Rect.fromLTRB(
      50,
      -double.infinity,
      double.infinity,
      double.infinity,
    );
    const leftSpacerRect = Rect.fromLTRB(
      -double.infinity,
      -double.infinity,
      50,
      double.infinity,
    );

    test('default renderers', () {
      final calculator = DefaultHitCalculator(
        const Rect.fromLTWH(100, 100, 40, 40),
        const Rect.fromLTWH(100, 100, 40, 40),
        0,
      );

      expect(calculator.hit(rightSpacerRect), isTrue);
      expect(calculator.hit(leftSpacerRect), isFalse);
    });

    for (final entry in {
      'circle': CircleShape(),
      'rectangle': RectangleShape(),
      'triangle': TriangleShape(),
      'line': LineShape(),
    }.entries) {
      test('${entry.key} shapes', () {
        final calculator = ShapeRenderer(
          ShapeElement(
            firstPosition: const Point(100, 100),
            secondPosition: const Point(140, 140),
            property: ShapeProperty(shape: entry.value, strokeWidth: 2),
          ),
        ).getHitCalculator();

        expect(calculator.hit(rightSpacerRect), isTrue);
        expect(calculator.hit(leftSpacerRect), isFalse);
      });
    }

    test('polygons', () {
      final calculator = PolygonHitCalculator(
        const Rect.fromLTWH(100, 100, 40, 40),
        const [
          PolygonPoint(100, 100),
          PolygonPoint(140, 100),
          PolygonPoint(140, 140),
          PolygonPoint(100, 140),
        ],
        0,
        const PolygonProperty(strokeWidth: 2),
      );

      expect(calculator.hit(rightSpacerRect), isTrue);
      expect(calculator.hit(leftSpacerRect), isFalse);
    });
  });
}
