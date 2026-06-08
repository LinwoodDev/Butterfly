import 'dart:math';
import 'dart:ui';

import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Zero Size Shapes', () {
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
  });

  group('rotation test', () {
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
  });

  group('Shape Interaction Tests by HitElementMode', () {
    ShapeRenderer createShape(PathShape shape) {
      return ShapeRenderer(
        ShapeElement(
          firstPosition: const Point(0, 0),
          secondPosition: const Point(100, 105),
          property: ShapeProperty(shape: shape, strokeWidth: 2),
        ),
      );
    }

    final shapesToTest = {
      'Circle': CircleShape(),
      'Rectangle': RectangleShape(),
      'Triangle': TriangleShape(),
      'Line': LineShape(),
    };

    shapesToTest.forEach((shapeName, shapeVariant) {
      group('$shapeName Element Mode Hits', () {
        late HitCalculator calculator;

        setUp(() {
          calculator = createShape(shapeVariant).getHitCalculator();
        });

        test('HitElementMode.none returns false', () {
          final bigRect = const Rect.fromLTWH(-50, -50, 200, 200);
          expect(
            calculator.hit(bigRect, hitElementMode: HitElementMode.none),
            isFalse,
          );
        });

        test('HitElementMode.full', () {
          final fullyEnclosingRect = const Rect.fromLTWH(-10, -10, 120, 120);
          expect(
            calculator.hit(
              fullyEnclosingRect,
              hitElementMode: HitElementMode.full,
            ),
            isTrue,
          );

          final partialRect = const Rect.fromLTWH(50, 50, 100, 100);
          expect(
            calculator.hit(partialRect, hitElementMode: HitElementMode.full),
            isFalse,
          );
        });

        test('HitElementMode.touchAnywhere', () {
          final partialRect = const Rect.fromLTWH(40, 40, 30, 30);
          expect(
            calculator.hit(
              partialRect,
              hitElementMode: HitElementMode.touchAnywhere,
            ),
            isTrue,
          );

          final distantRect = const Rect.fromLTWH(200, 200, 50, 50);
          expect(
            calculator.hit(
              distantRect,
              hitElementMode: HitElementMode.touchAnywhere,
            ),
            isFalse,
          );
        });

        test('HitElementMode.touchEdges', () {
          final edgeCrossRect = const Rect.fromLTWH(40, -10, 20, 120);
          expect(
            calculator.hit(
              edgeCrossRect,
              hitElementMode: HitElementMode.touchEdges,
            ),
            isTrue,
          );
        });
      });
    });
  });

  group('Lasso / Polygon Interaction Tests', () {
    final shapeElement = ShapeElement(
      firstPosition: const Point(0, 0),
      secondPosition: const Point(100, 100),
      property: const ShapeProperty(shape: RectangleShape(), strokeWidth: 1),
    );

    test('Lasso Full selection contains shape entirely', () {
      final calculator = ShapeRenderer(shapeElement).getHitCalculator();
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

    test(
      'Lasso Partial selection returns false for full but true for TouchAnywhere',
      () {
        final calculator = ShapeRenderer(shapeElement).getHitCalculator();
        final partialLasso = const [
          Offset(50, 50),
          Offset(120, 50),
          Offset(120, 120),
          Offset(50, 120),
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
      },
    );
  });
}
