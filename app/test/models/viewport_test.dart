import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('viewport snapshots use identity equality', () {
    const viewport = CameraViewport.unbaked(width: 100, height: 100);

    expect(viewport.copyWith(), isNot(equals(viewport)));
    expect(viewport, equals(viewport));
  });

  test('baked image uses its exact fractional content extent', () {
    const viewport = CameraViewport.baked(
      width: 100.25,
      height: 50.5,
      pixelRatio: 1.5,
      visibleElements: [],
      visibleUnbakedElements: [],
      resolution: RenderResolution.performance,
    );

    expect(
      viewport.toImageSourceRect(const Size(151, 76)),
      const Rect.fromLTWH(0, 0, 150.375, 75.75),
    );
  });
}
