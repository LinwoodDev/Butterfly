import 'dart:math';

import 'package:butterfly/renderers/foregrounds/select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('tiny selections keep a usable interaction target', () {
    final manager = RectSelectionForegroundManager()
      ..select(const Rect.fromLTWH(10, 10, 2, 2));
    const scale = 2.0;
    const sensitivity = 1.0;

    expect(
      manager.getHitRect(scale, sensitivity),
      const Rect.fromLTWH(1, 1, 20, 20),
    );
    expect(
      manager.shouldTransform(const Offset(2, 2), scale, sensitivity),
      isTrue,
    );
    expect(
      manager.shouldTransform(const Offset(-20, -20), scale, sensitivity),
      isFalse,
    );
  });

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

  test('dragging a handle across an axis keeps a valid mirrored selection', () {
    final manager = RectSelectionForegroundManager()
      ..select(const Rect.fromLTWH(0, 0, 100, 50))
      ..startTransformWithCorner(
        SelectionTransformCorner.bottomRight,
        const Offset(100, 50),
      )
      ..updateCurrentPosition(const Offset(-50, 100));

    final transform = manager.getTransform()!;
    expect(transform.scaleX, -0.5);
    expect(transform.scaleY, 2);
    expectRectCloseTo(
      manager.getTransformedSelection(),
      const Rect.fromLTWH(-50, 0, 50, 100),
    );
  });

  test('proportional negative scale keeps the opposite corner anchored', () {
    final manager = RectSelectionForegroundManager()
      ..select(const Rect.fromLTWH(0, 0, 100, 50))
      ..transform(
        SelectionScaleMode.scaleProp,
        SelectionTransformCorner.topLeft,
      )
      ..startTransformWithCorner(SelectionTransformCorner.topLeft, Offset.zero)
      ..updateCurrentPosition(const Offset(150, 0));

    final transform = manager.getTransform()!;
    expect(transform.scaleX, -0.5);
    expect(transform.scaleY, -0.5);
    expectRectCloseTo(
      manager.getTransformedSelection(),
      const Rect.fromLTWH(100, 50, 50, 25),
    );
  });

  test('negative scale uses the opposite element corner for placement', () {
    const selection = Rect.fromLTWH(0, 0, 200, 100);
    const element = Rect.fromLTWH(50, 20, 100, 40);
    const transform = (
      position: Offset.zero,
      rotation: 0.0,
      scaleX: -1.0,
      scaleY: 1.0,
    );

    expectRectCloseTo(
      transform.scaleRect(element, selection),
      const Rect.fromLTWH(-150, 20, 100, 40),
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
