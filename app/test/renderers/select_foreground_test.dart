import 'dart:math';

import 'package:butterfly/renderers/foregrounds/select.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('resize cursor follows viewport rotation', () {
    final manager = RectSelectionForegroundManager()
      ..select(const Rect.fromLTWH(100, 100, 300, 200))
      ..updateCurrentPosition(const Offset(100, 200));
    for (final (angle, cursor) in [
      (0.0, SystemMouseCursors.resizeLeftRight),
      (pi / 4, SystemMouseCursors.resizeUpLeftDownRight),
      (pi / 2, SystemMouseCursors.resizeUpDown),
      (-pi / 4, SystemMouseCursors.resizeUpRightDownLeft),
    ]) {
      manager.updateCursor(1, 1, angle);
      expect(manager.cursor, cursor);
    }
  });

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

  test('proportional modifier preserves the aspect ratio', () {
    final manager = RectSelectionForegroundManager()
      ..select(const Rect.fromLTWH(0, 0, 100, 100))
      ..startTransformWithCorner(
        SelectionTransformCorner.bottomRight,
        const Offset(100, 100),
      )
      ..updateModifiers(proportional: true, centered: false)
      ..updateCurrentPosition(const Offset(150, 120));

    final transform = manager.getTransform()!;
    expect(transform.scaleX, 1.5);
    expect(transform.scaleY, 1.5);
    expect(
      manager.getTransformedSelection(),
      const Rect.fromLTWH(0, 0, 150, 150),
    );
  });

  test('centered modifier keeps the selection center fixed', () {
    final manager = RectSelectionForegroundManager()
      ..select(const Rect.fromLTWH(0, 0, 100, 100))
      ..startTransformWithCorner(
        SelectionTransformCorner.centerRight,
        const Offset(100, 50),
      )
      ..updateModifiers(proportional: false, centered: true)
      ..updateCurrentPosition(const Offset(110, 50));

    final transform = manager.getTransform()!;
    expect(transform.scaleX, closeTo(1.2, 1e-10));
    expect(transform.scaleY, 1);
    final transformed = manager.getTransformedSelection();
    expect(transformed.left, closeTo(-10, 1e-10));
    expect(transformed.top, 0);
    expect(transformed.right, closeTo(110, 1e-10));
    expect(transformed.bottom, 100);
  });

  test('centered modifier does not affect moving a selection', () {
    final manager = RectSelectionForegroundManager()
      ..select(const Rect.fromLTWH(0, 0, 100, 100))
      ..startTransformWithCorner(null, const Offset(50, 50))
      ..updateModifiers(proportional: false, centered: true)
      ..updateCurrentPosition(const Offset(60, 70));

    final transform = manager.getTransform()!;
    expect(transform.position, const Offset(10, 20));
    expect(transform.scaleX, 1);
    expect(transform.scaleY, 1);
  });

  test(
    'Shift and proportional lock constrain movement independently of resizing',
    () {
      for (final forceProportional in [false, true]) {
        for (final (target, expected) in [
          (const Offset(90, 57), const Offset(40, 0)),
          (const Offset(47, 10), const Offset(0, -40)),
          (const Offset(80, 76), const Offset(28, 28)),
        ]) {
          final manager = RectSelectionForegroundManager()
            ..select(const Rect.fromLTWH(0, 0, 100, 100))
            ..setForceProportional(forceProportional)
            ..startTransformWithCorner(null, const Offset(50, 50))
            ..updateCurrentPosition(target);
          expect(
            manager.getTransform()!.position,
            target - const Offset(50, 50),
          );
          manager.updateModifiers(proportional: true, centered: false);
          expect(manager.getTransform()!.position, offsetCloseTo(expected));
          manager.toggleTransformMode();
          expect(
            manager.getTransform()!.position,
            target - const Offset(50, 50),
          );
          manager.updateModifiers(proportional: false, centered: false);
          expect(manager.getTransform()!.position, offsetCloseTo(expected));
        }
      }
    },
  );

  test('forced proportional resizing survives mode and modifier changes', () {
    final manager = RectSelectionForegroundManager()
      ..select(const Rect.fromLTWH(0, 0, 100, 50))
      ..setForceProportional(true)
      ..startTransformWithCorner(
        SelectionTransformCorner.bottomRight,
        const Offset(100, 50),
      )
      ..updateCurrentPosition(const Offset(140, 60));
    for (final shift in [false, true]) {
      manager.updateModifiers(proportional: shift, centered: false);
      for (var mode = 0; mode < 2; mode++) {
        final transform = manager.getTransform()!;
        expect(transform.scaleX, closeTo(1.4, 1e-9));
        expect(transform.scaleY, closeTo(1.4, 1e-9));
        expect(transform.position, Offset.zero);
        manager.toggleTransformMode();
      }
    }
  });

  test('rotation ignores positional snapping and proportional scaling', () {
    final manager = RectSelectionForegroundManager()
      ..select(const Rect.fromLTWH(0, 0, 100, 100))
      ..startTransformWithCorner(
        SelectionTransformCorner.center,
        const Offset(50, -50),
      )
      ..updateModifiers(proportional: true, centered: false)
      ..updateCurrentPosition(
        const Offset(150, 50),
        snapPosition: (_) => throw StateError('Rotation must not snap'),
      );
    expect(manager.getTransform()!.rotation, closeTo(90, 1e-9));
    expect(manager.getTransform()!.position, Offset.zero);
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
