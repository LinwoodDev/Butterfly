import 'dart:math';

import 'package:butterfly/renderers/foregrounds/select.dart';
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
