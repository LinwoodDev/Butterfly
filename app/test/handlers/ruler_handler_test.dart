import 'dart:ui';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('default ruler pivots around the center of the viewport', () {
    final handler = RulerHandler(RulerTool());

    expect(
      handler.getRect(const Size(800, 600)).center,
      const Offset(400, 300),
    );
  });

  test('transformed ruler pivots around the center of the viewport', () {
    final handler = RulerHandler(RulerTool());
    const transform = CameraTransform(1, Offset(10, 20), 2);

    expect(
      handler.getRect(const Size(800, 600), transform).center,
      const Offset(210, 170),
    );
  });

  test('ruler rotation snaps to horizontal and vertical quarter turns', () {
    expect(snapRulerRotation(4), 0);
    expect(snapRulerRotation(87), 90);
    expect(snapRulerRotation(184), 180);
    expect(snapRulerRotation(273), 270);
    expect(snapRulerRotation(356), 0);
    expect(snapRulerRotation(-3), 0);
  });

  test('ruler rotation keeps angles outside the snap threshold', () {
    expect(snapRulerRotation(6), 6);
    expect(snapRulerRotation(84), 84);
    expect(snapRulerRotation(96), 96);
    expect(snapRulerRotation(-6), 354);
  });
}
