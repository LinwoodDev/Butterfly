import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/view_painter.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEditorController extends Mock implements EditorController {}

class MockDocumentLoaded extends Mock implements DocumentLoaded {}

Future<ui.Image> _createImage() async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  canvas.drawColor(const ui.Color(0xFFFF0000), ui.BlendMode.src);
  final picture = recorder.endRecording();
  try {
    return await picture.toImage(1, 1);
  } finally {
    picture.dispose();
  }
}

Future<ui.Image> _createStripImage() async {
  final recorder = ui.PictureRecorder();
  ui.Canvas(recorder)
    ..drawRect(
      const ui.Rect.fromLTWH(0, 0, 5, 1),
      ui.Paint()..color = const ui.Color(0xFFFF0000),
    )
    ..drawRect(
      const ui.Rect.fromLTWH(5, 0, 5, 1),
      ui.Paint()..color = const ui.Color(0xFF0000FF),
    );
  final picture = recorder.endRecording();
  try {
    return await picture.toImage(10, 1);
  } finally {
    picture.dispose();
  }
}

Future<Uint8List> _render(ImageRenderer renderer) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  ViewPainter(
    NoteData(Archive()),
    const DocumentPage(),
    const DocumentInfo(),
    cameraViewport: CameraViewport.unbaked(
      unbakedElements: [renderer],
      visibleElements: [renderer],
      visibleUnbakedElements: [renderer],
    ),
  ).paint(canvas, const ui.Size(10, 1));
  final picture = recorder.endRecording();
  ui.Image? image;
  try {
    image = await picture.toImage(10, 1);
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    return data!.buffer.asUint8List();
  } finally {
    image?.dispose();
    picture.dispose();
  }
}

ui.Color _pixel(Uint8List pixels, int x) {
  final offset = x * 4;
  return ui.Color.fromARGB(
    pixels[offset + 3],
    pixels[offset],
    pixels[offset + 1],
    pixels[offset + 2],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'hidden image renderer unloads decoded image outside viewport',
    () async {
      final image = await _createImage();
      final renderer = ImageRenderer(
        ImageElement(source: 'test.png', width: 1, height: 1),
        null,
        image,
      );

      renderer.onHidden(
        MockEditorController(),
        MockDocumentLoaded(),
        const CameraTransform(),
        ui.Size.zero,
      );

      expect(renderer.image, isNull);
      renderer.dispose();
    },
  );

  test('negative image scale keeps mirrored bounds', () {
    final renderer = ImageRenderer(
      ImageElement(source: 'test.png', width: 100, height: 50),
    );

    final mirrored = renderer.transform(scaleX: -1)!;

    expect(mirrored.rotation, 0);
    expect(mirrored.rect, const ui.Rect.fromLTWH(-100, 0, 100, 50));
    expect(
      (mirrored.element.constraints as ScaledElementConstraints).scaleX,
      -1,
    );
  });

  test('flipped rotated image stays in the target bounds', () {
    final renderer = ImageRenderer(
      ImageElement(
        source: 'test.png',
        width: 100,
        height: 50,
        position: const Point(100, 100),
        rotation: 30,
      ),
    );
    final originalBounds = renderer.expandedRect!;
    final targetBounds = originalBounds.shift(
      ui.Offset(-originalBounds.width, 0),
    );

    final mirrored = renderer.transform(
      position: ui.Offset(-originalBounds.width, 0),
      scaleX: -1,
      positionIsBounds: true,
    )!;
    final mirroredBounds = mirrored.expandedRect!;

    expect(mirrored.rotation, closeTo(330, 1e-9));
    expect(mirroredBounds.left, closeTo(targetBounds.left, 1e-9));
    expect(mirroredBounds.top, closeTo(targetBounds.top, 1e-9));
    expect(mirroredBounds.width, closeTo(targetBounds.width, 1e-9));
    expect(mirroredBounds.height, closeTo(targetBounds.height, 1e-9));
  });

  test('negative image scale mirrors pixels', () async {
    final image = await _createStripImage();
    final renderer = ImageRenderer(
      ImageElement(source: 'test.png', width: 10, height: 1),
      null,
      image,
    );
    final mirrored =
        renderer.transform(position: const ui.Offset(10, 0), scaleX: -1)!
            as ImageRenderer;

    final pixels = await _render(mirrored);

    expect(_pixel(pixels, 2), const ui.Color(0xFF0000FF));
    expect(_pixel(pixels, 7), const ui.Color(0xFFFF0000));
    renderer.dispose();
  });
}
