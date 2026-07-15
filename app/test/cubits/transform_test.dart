import 'dart:math';

import 'package:butterfly/cubits/transform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CameraTransform rotation', () {
    test('converts between screen and document coordinates', () {
      const transform = CameraTransform(1, Offset(10, 20), 2, pi / 3);
      const documentPoint = Offset(35, -12);

      final screenPoint = transform.globalToLocal(documentPoint);
      final restored = transform.localToGlobal(screenPoint);

      expect(restored.dx, closeTo(documentPoint.dx, 1e-9));
      expect(restored.dy, closeTo(documentPoint.dy, 1e-9));
    });

    test('keeps the gesture focal point fixed while rotating', () {
      const transform = CameraTransform(1, Offset(10, 20), 2, pi / 6);
      const focalPoint = Offset(240, 120);
      final documentPoint = transform.localToGlobal(focalPoint);

      final rotated = transform.withRotation(pi / 2, focalPoint);

      final restored = rotated.localToGlobal(focalPoint);
      expect(restored.dx, closeTo(documentPoint.dx, 1e-9));
      expect(restored.dy, closeTo(documentPoint.dy, 1e-9));
    });

    test('keeps the gesture focal point fixed while zooming', () {
      const transform = CameraTransform(1, Offset(10, 20), 2, pi / 4);
      const focalPoint = Offset(240, 120);
      final documentPoint = transform.localToGlobal(focalPoint);

      final zoomed = transform.withSize(4, focalPoint);

      final restored = zoomed.localToGlobal(focalPoint);
      expect(restored.dx, closeTo(documentPoint.dx, 1e-9));
      expect(restored.dy, closeTo(documentPoint.dy, 1e-9));
    });

    test('uses all four corners for a rotated viewport', () {
      const transform = CameraTransform(1, Offset.zero, 1, pi / 4);
      const viewport = Rect.fromLTWH(0, 0, 100, 50);
      final bounds = transform.localToGlobalRect(viewport);
      final corners = [
        viewport.topLeft,
        viewport.topRight,
        viewport.bottomLeft,
        viewport.bottomRight,
      ].map(transform.localToGlobal);

      expect(bounds.left, closeTo(corners.map((e) => e.dx).reduce(min), 1e-9));
      expect(bounds.top, closeTo(corners.map((e) => e.dy).reduce(min), 1e-9));
      expect(bounds.right, closeTo(corners.map((e) => e.dx).reduce(max), 1e-9));
      expect(
        bounds.bottom,
        closeTo(corners.map((e) => e.dy).reduce(max), 1e-9),
      );
    });
  });
}
