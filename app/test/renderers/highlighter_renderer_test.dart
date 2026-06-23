import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:archive/archive.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/view_painter.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:flutter_test/flutter_test.dart';

const _size = ui.Size(100, 100);
const _strokeRect = ui.Rect.fromLTRB(20, 50, 80, 50);
const _expandedStrokeRect = ui.Rect.fromLTRB(10, 40, 90, 60);
const _property = PenProperty(
  strokeWidth: 20,
  thinning: 0,
  paint: ElementPaint.solid(color: SRGBColor(0x80FF0000)),
);

PenRenderer _renderer(String id, {String? combineId}) => PenRenderer(
  PenElement(
    id: id,
    combineId: combineId,
    property: _property,
    points: const [
      PathPoint(20, 50),
      PathPoint(40, 50),
      PathPoint(60, 50),
      PathPoint(80, 50),
    ],
  ),
  null,
  _strokeRect,
  _expandedStrokeRect,
);

Future<Uint8List> _render(List<PenRenderer> renderers) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  ViewPainter(
    NoteData(Archive()),
    const DocumentPage(),
    const DocumentInfo(),
    cameraViewport: CameraViewport.unbaked(
      unbakedElements: renderers,
      visibleElements: renderers,
      visibleUnbakedElements: renderers,
    ),
  ).paint(canvas, _size);
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

int _greenAtCenter(Uint8List pixels) {
  const x = 50, y = 50;
  return pixels[(y * _size.width.toInt() + x) * 4 + 1];
}

void main() {
  test('combined highlights do not darken their overlap', () async {
    final single = await _render([_renderer('single')]);
    final combined = await _render([
      _renderer('first', combineId: 'highlighter'),
      _renderer('second', combineId: 'highlighter'),
    ]);
    final separate = await _render([_renderer('first'), _renderer('second')]);

    expect(_greenAtCenter(combined), _greenAtCenter(single));
    expect(_greenAtCenter(separate), lessThan(_greenAtCenter(single)));
  });
}
