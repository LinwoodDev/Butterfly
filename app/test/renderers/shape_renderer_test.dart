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
}
