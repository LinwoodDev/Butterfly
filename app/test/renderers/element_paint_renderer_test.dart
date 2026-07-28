import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';

const _size = ui.Size(100, 100);
const _bounds = ui.Rect.fromLTWH(0, 0, 100, 100);

Future<Uint8List> _render(ElementGradient gradient) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  final paint = ElementPaintRenderer().build(
    ElementPaint.gradient(gradient: gradient),
    _bounds,
  );
  canvas.drawRect(_bounds, paint);
  final picture = recorder.endRecording();
  ui.Image? image;
  try {
    image = await picture.toImage(_size.width.toInt(), _size.height.toInt());
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    return data!.buffer.asUint8List();
  } finally {
    image?.dispose();
    picture.dispose();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('radial element paint renders its focal point', () async {
    final centered = await _render(const ElementGradient.radial());
    final focused = await _render(
      const ElementGradient.radial(focal: Point(0.2, 0.5)),
    );

    expect(focused, isNot(equals(centered)));
  });

  test('radial element paint renders its focal radius', () async {
    final pointFocal = await _render(
      const ElementGradient.radial(focal: Point(0.2, 0.5)),
    );
    final circleFocal = await _render(
      const ElementGradient.radial(focal: Point(0.2, 0.5), focalRadius: 0.1),
    );

    expect(circleFocal, isNot(equals(pointFocal)));
  });
}
