import 'dart:math';

import 'package:butterfly/renderers/foregrounds/select.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('overlapping transform handles resolve to nearest handle', () {
    final manager = RectSelectionForegroundManager()
      ..select(const Rect.fromLTWH(0, 0, 20, 20));
    const scale = 1.0;
    const sensitivity = 3.6;

    expect(
      manager.getCornerHit(
        SelectionTransformCorner.topCenter.getFromRect(
          manager.selection,
          scale: scale,
        ),
        scale,
        sensitivity,
      ),
      SelectionTransformCorner.topCenter,
    );
    expect(
      manager.getCornerHit(
        SelectionTransformCorner.center.getFromRect(
          manager.selection,
          scale: scale,
        ),
        scale,
        sensitivity,
      ),
      SelectionTransformCorner.center,
    );
  });

  for (final rotation in [15.0, 30.0, 44.0, 46.0, 75.0]) {
    for (final (:corner, :delta) in [
      (corner: SelectionTransformCorner.topLeft, delta: const Offset(-30, -20)),
      (corner: SelectionTransformCorner.topCenter, delta: const Offset(0, -20)),
      (corner: SelectionTransformCorner.topRight, delta: const Offset(30, -20)),
      (
        corner: SelectionTransformCorner.centerLeft,
        delta: const Offset(-30, 0),
      ),
      (
        corner: SelectionTransformCorner.centerRight,
        delta: const Offset(30, 0),
      ),
      (
        corner: SelectionTransformCorner.bottomCenter,
        delta: const Offset(0, 20),
      ),
      (
        corner: SelectionTransformCorner.bottomLeft,
        delta: const Offset(-30, 20),
      ),
      (
        corner: SelectionTransformCorner.bottomRight,
        delta: const Offset(30, 20),
      ),
    ]) {
      test(
        'rotated element AABB scaling is converted before _transform at $rotation degrees from $corner',
        () {
          final renderer = ShapeRenderer(
            ShapeElement(
              firstPosition: const Point(0, 0),
              secondPosition: const Point(100, 50),
              rotation: rotation,
            ),
          );
          final selection = renderer.expandedRect!;
          final manager = RectSelectionForegroundManager()..select(selection);
          final start = corner.getFromRect(selection);
          manager.startTransformWithCorner(corner, start);
          manager.updateCurrentPosition(start + delta);

          final transform = manager.getTransform()!;
          final transformed = renderer.transform(
            position: transform.position,
            scaleX: transform.scaleX,
            scaleY: transform.scaleY,
          )!;
          final originalRect = renderer.rect;
          final originalCenter = originalRect.center;
          final originalRadians = rotation * pi / 180;
          final originalRotatedTopLeft = rotatePoint(
            originalRect.topLeft,
            originalCenter,
            originalRadians,
          );
          final originalRotatedTopRight = rotatePoint(
            originalRect.topRight,
            originalCenter,
            originalRadians,
          );
          final expectedRotatedTopLeft = scaleInSelection(
            originalRotatedTopLeft,
            selection,
            transform,
          );
          final expectedRotatedTopRight = scaleInSelection(
            originalRotatedTopRight,
            selection,
            transform,
          );
          final expectedTopEdge =
              expectedRotatedTopRight - expectedRotatedTopLeft;
          final expectedRotation =
              atan2(expectedTopEdge.dy, expectedTopEdge.dx) * 180 / pi;
          final expectedScaleX = expectedTopEdge.distance / originalRect.width;
          final expectedScaleY =
              transform.scaleX * transform.scaleY / expectedScaleX;
          final transformedRect = transformed.rect!;
          final transformedRotatedTopLeft = rotatePoint(
            transformedRect.topLeft,
            transformedRect.center,
            transformed.rotation * pi / 180,
          );

          expect(transformed.rotation, closeTo(expectedRotation, 1e-9));
          expect(
            transformedRotatedTopLeft,
            offsetCloseTo(expectedRotatedTopLeft),
          );
          expect(transformed.rect!.width, closeTo(100 * expectedScaleX, 1e-9));
          expect(transformed.rect!.height, closeTo(50 * expectedScaleY, 1e-9));
        },
      );
    }
  }

  test('rotated element uniform scaling follows expanded bounds', () {
    final renderer = ShapeRenderer(
      ShapeElement(
        firstPosition: const Point(0, 0),
        secondPosition: const Point(100, 50),
        rotation: 44,
      ),
    );
    final selection = renderer.expandedRect!;
    final manager = RectSelectionForegroundManager()..select(selection);
    manager.startTransformWithCorner(
      SelectionTransformCorner.bottomRight,
      selection.bottomRight,
    );
    manager.updateCurrentPosition(
      selection.bottomRight +
          Offset(selection.width * 0.25, selection.height * 0.25),
    );

    final transform = manager.getTransform()!;
    final transformed = renderer.transform(
      position: transform.position,
      scaleX: transform.scaleX,
      scaleY: transform.scaleY,
    )!;

    expectRectCloseTo(
      transformed.expandedRect!,
      manager.getTransformedSelection(),
    );
  });
}

void expectRectCloseTo(Rect actual, Rect expected) {
  expect(actual.left, closeTo(expected.left, 1e-9));
  expect(actual.top, closeTo(expected.top, 1e-9));
  expect(actual.width, closeTo(expected.width, 1e-9));
  expect(actual.height, closeTo(expected.height, 1e-9));
}

Offset scaleInSelection(
  Offset point,
  Rect selection,
  TransformResult transform,
) {
  final relative = point - selection.topLeft;
  return selection.topLeft +
      transform.position +
      Offset(relative.dx * transform.scaleX, relative.dy * transform.scaleY);
}

Offset rotatePoint(Offset point, Offset center, double radians) {
  final translated = point - center;
  final c = cos(radians);
  final s = sin(radians);
  return center +
      Offset(
        translated.dx * c - translated.dy * s,
        translated.dx * s + translated.dy * c,
      );
}

Matcher offsetCloseTo(Offset expected) => _OffsetCloseTo(expected);

class _OffsetCloseTo extends Matcher {
  final Offset expected;

  const _OffsetCloseTo(this.expected);

  @override
  Description describe(Description description) =>
      description.add('an offset close to $expected');

  @override
  bool matches(Object? item, Map matchState) =>
      item is Offset &&
      (item.dx - expected.dx).abs() < 1e-9 &&
      (item.dy - expected.dy).abs() < 1e-9;
}
