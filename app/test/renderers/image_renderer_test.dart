import 'dart:ui' as ui;

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/renderers/renderer.dart';
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
}
