import 'dart:math';
import 'dart:ui';

import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart' show Axis;

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
    test('rotation past a quarter turn does not introduce a reflection', () {
      final renderer = ShapeRenderer(
        ShapeElement(
          firstPosition: const Point(0, 0),
          secondPosition: const Point(100, 50),
        ),
      );

      for (final rotation in [91.0, 135.0, 180.0, 269.0]) {
        final transformed = renderer.transform(rotation: rotation)!;
        final element = transformed.element;

        expect(transformed.rotation, closeTo(rotation, 1e-9));
        expect(element.secondPosition.x - element.firstPosition.x, 100);
        expect(element.secondPosition.y - element.firstPosition.y, 50);
      }
    });

    test('non-uniform scaling preserves the affine shape of a rotation', () {
      final renderer = ShapeRenderer(
        ShapeElement(
          rotation: 45,
          firstPosition: const Point(0, 0),
          secondPosition: const Point(100, 50),
        ),
      );

      final transformed = renderer.transform(scaleX: 2, scaleY: 1)!;
      final rect = transformed.rect!;
      final horizontal =
          transformed.transformPoint(rect.topRight) -
          transformed.transformPoint(rect.topLeft);
      final vertical =
          transformed.transformPoint(rect.bottomLeft) -
          transformed.transformPoint(rect.topLeft);
      final expectedHorizontal = Offset(200 * cos(pi / 4), 100 * sin(pi / 4));
      final expectedVertical = Offset(-100 * sin(pi / 4), 50 * cos(pi / 4));

      expect(transformed.shear, isNot(0));
      expect(horizontal.dx, closeTo(expectedHorizontal.dx, 1e-9));
      expect(horizontal.dy, closeTo(expectedHorizontal.dy, 1e-9));
      expect(vertical.dx, closeTo(expectedVertical.dx, 1e-9));
      expect(vertical.dy, closeTo(expectedVertical.dy, 1e-9));
    });

    test('horizontal flip keeps signed width without adding a half turn', () {
      final renderer = ShapeRenderer(
        ShapeElement(
          firstPosition: const Point(10, 20),
          secondPosition: const Point(110, 70),
        ),
      );

      final transformed = renderer.transform(scaleX: -1)!;
      final element = transformed.element;

      expect(transformed.rotation, closeTo(0, 1e-9));
      expect(
        element.secondPosition.x - element.firstPosition.x,
        closeTo(-100, 1e-9),
      );
      expect(
        element.secondPosition.y - element.firstPosition.y,
        closeTo(50, 1e-9),
      );
    });

    test('flip mirrors the renderer inside the selection bounds', () {
      final renderer = ShapeRenderer(
        ShapeElement(
          firstPosition: const Point(120, 210),
          secondPosition: const Point(220, 260),
        ),
      );

      final horizontal = renderer.flip(
        axis: Axis.horizontal,
        selectionRect: const Rect.fromLTWH(100, 200, 200, 100),
      )!;
      final vertical = renderer.flip(
        axis: Axis.vertical,
        selectionRect: const Rect.fromLTWH(100, 200, 200, 100),
      )!;

      expect(horizontal.expandedRect, const Rect.fromLTWH(180, 210, 100, 50));
      expect(vertical.expandedRect, const Rect.fromLTWH(120, 240, 100, 50));
    });

    test('horizontal flip keeps a rotated element in the target bounds', () {
      final renderer = ShapeRenderer(
        ShapeElement(
          rotation: 30,
          firstPosition: const Point(100, 100),
          secondPosition: const Point(200, 150),
        ),
      );
      final originalBounds = renderer.expandedRect;
      final targetBounds = originalBounds.shift(
        Offset(-originalBounds.width, 0),
      );

      final transformed = renderer.transform(
        position: Offset(-originalBounds.width, 0),
        scaleX: -1,
        positionIsBounds: true,
      )!;
      final element = transformed.element;
      final transformedBounds = transformed.expandedRect!;

      expect(transformed.rotation, closeTo(330, 1e-9));
      expect(
        element.secondPosition.x - element.firstPosition.x,
        closeTo(-100, 1e-9),
      );
      expect(transformedBounds.left, closeTo(targetBounds.left, 1e-9));
      expect(transformedBounds.top, closeTo(targetBounds.top, 1e-9));
      expect(transformedBounds.width, closeTo(targetBounds.width, 1e-9));
      expect(transformedBounds.height, closeTo(targetBounds.height, 1e-9));
    });

    test('documents without shear keep the identity default', () {
      final json = ShapeElement().toJson()..remove('shear');

      expect(PadElement.fromJson(json).shear, 0);
    });

    test('negative horizontal scale mirrors the element', () {
      final renderer = ShapeRenderer(
        ShapeElement(
          firstPosition: const Point(0, 0),
          secondPosition: const Point(100, 50),
        ),
      );

      final mirrored = renderer.transform(scaleX: -1)!;
      final mirroredElement = mirrored.element;
      expect(
        mirroredElement.firstPosition.x,
        greaterThan(mirroredElement.secondPosition.x),
      );

      final restored = mirrored.transform(scaleX: -1)!;
      final restoredElement = restored.element;
      expect(
        restoredElement.firstPosition.x,
        lessThan(restoredElement.secondPosition.x),
      );
    });

    test('negative scale positions from the original transformed origin', () {
      final renderer = ShapeRenderer(
        ShapeElement(
          firstPosition: const Point(10, 0),
          secondPosition: const Point(30, 50),
        ),
      );

      // Mirroring around x = 0 maps the original left edge (10) to -5 and
      // the original right edge (30) to -15 at a scale of -0.5.
      final mirrored = renderer.transform(
        position: const Offset(-15, 0),
        scaleX: -0.5,
      )!;

      expect(mirrored.element.firstPosition.x, closeTo(-5, 1e-9));
      expect(mirrored.element.secondPosition.x, closeTo(-15, 1e-9));
    });

    test('negative vertical scale mirrors a triangle', () {
      final renderer = ShapeRenderer(
        ShapeElement(
          firstPosition: const Point(0, 0),
          secondPosition: const Point(100, 50),
          property: const ShapeProperty(shape: TriangleShape()),
        ),
      );

      final mirrored = renderer.transform(scaleY: -1)!;
      expect(mirrored.rotation, closeTo(0, 1e-9));
      expect(
        mirrored.element.secondPosition.y - mirrored.element.firstPosition.y,
        closeTo(-50, 1e-9),
      );
      final hitCalculator = mirrored.getHitCalculator();
      expect(hitCalculator.hit(const Rect.fromLTWH(10, -48, 10, 8)), isTrue);
      expect(hitCalculator.hit(const Rect.fromLTWH(10, -10, 10, 8)), isFalse);

      final restored = mirrored.transform(scaleY: -1)!;
      expect(restored.rotation, closeTo(0, 1e-9));
      expect(
        restored.element.secondPosition.y - restored.element.firstPosition.y,
        closeTo(50, 1e-9),
      );
    });

    test('negative pen scale keeps valid cached bounds', () {
      final renderer = PenRenderer(
        PenElement(points: const [PathPoint(0, 0), PathPoint(100, 50)]),
        null,
        const Rect.fromLTWH(0, 0, 100, 50),
        const Rect.fromLTWH(0, 0, 100, 50),
      );

      final mirrored = renderer.transform(scaleX: -1)!;

      expect(mirrored.rect, const Rect.fromLTWH(-100, 0, 100, 50));
      expect(mirrored.rect!.isEmpty, isFalse);
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
  });

  group('Spacer rectangle hits', () {
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

    test(
      'default rectangular renderers handle unbounded spacer rectangles',
      () {
        final calculator = DefaultHitCalculator(
          const Rect.fromLTWH(100, 100, 40, 40),
          const Rect.fromLTWH(100, 100, 40, 40),
          0,
        );

        expect(calculator.hit(rightSpacerRect), isTrue);
        expect(calculator.hit(leftSpacerRect), isFalse);
      },
    );

    for (final entry in {
      'circle': CircleShape(),
      'rectangle': RectangleShape(),
      'triangle': TriangleShape(),
      'line': LineShape(),
    }.entries) {
      test('${entry.key} handles unbounded spacer rectangles', () {
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
