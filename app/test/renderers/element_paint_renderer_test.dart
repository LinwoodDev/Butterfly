import 'dart:math';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
import 'package:archive/archive.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _Assets extends Mock implements AssetService {}

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

  for (final action in ['dispose', 'change paint']) {
    test('paint releases an image finishing after $action', () async {
      final recorder = ui.PictureRecorder();
      ui.Canvas(recorder)
          .drawColor(const ui.Color(0xFFFF0000), ui.BlendMode.src);
      final picture = recorder.endRecording();
      late ui.Image image;
      try {
        image = await picture.toImage(1, 1);
      } finally {
        picture.dispose();
      }
      final loading = Completer<ui.Image?>();
      final document = NoteData(Archive());
      final assets = _Assets();
      when(() => assets.getImage('test.png', document))
          .thenAnswer((_) => loading.future);
      final renderer = ElementPaintRenderer();
      final setup = renderer.setup(
        ElementPaint.image(source: 'test.png'),
        document,
        assets,
      );
      if (action == 'dispose') {
        renderer.dispose();
      } else {
        await renderer.setup(const ElementPaint.solid(), document, assets);
      }
      loading.complete(image);
      await setup;
      expect(image.debugDisposed, isTrue);
      renderer.dispose();
    });
  }

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
