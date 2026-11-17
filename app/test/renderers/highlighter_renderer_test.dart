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

Future<Uint8List> _render(
  List<PenRenderer> renderers, {
  ui.Color background = const ui.Color(0xFFFFFFFF),
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder)..drawColor(background, ui.BlendMode.src);
  ViewPainter(
    NoteData(Archive()),
    const DocumentPage(),
    const DocumentInfo(),
    renderBackground: false,
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

List<int> _pixelAt(Uint8List pixels, int x, int y) {
  final index = (y * _size.width.toInt() + x) * 4;
  return pixels.sublist(index, index + 4);
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

  for (final useFill in [false, true]) {
    final label = useFill ? 'fill' : 'stroke';
    final paint = ElementPaint.solid(
      color: const SRGBColor(0x80FF0000),
      blur: 4,
    );
    final property = useFill
        ? _property.copyWith(
            paint: const ElementPaint.solid(color: SRGBColor.transparent),
            fillPaint: paint,
          )
        : _property.copyWith(paint: paint);

    PenRenderer blurredPen(String id) => PenRenderer(
      PenElement(
        id: id,
        combineId: 'highlighter',
        property: property,
        points: const [PathPoint(20, 80), PathPoint(20, 20), PathPoint(80, 20)],
      ),
      null,
      null,
      const ui.Rect.fromLTRB(10, 10, 90, 90),
    );

    test('a combined pen with blurred $label preserves the canvas', () async {
      const background = ui.Color(0xFF224466);
      final first = _renderer('underneath');
      final single = await _render([first], background: background);
      final combined = await _render([
        first,
        blurredPen('blurred'),
      ], background: background);

      // These pixels lie inside the blurred path's bounds but away from its
      // geometry. The first is on the lower stroke and the second is bare canvas.
      expect(_pixelAt(combined, 65, 50), _pixelAt(single, 65, 50));
      expect(_pixelAt(combined, 60, 65), _pixelAt(single, 60, 65));
      expect(_pixelAt(combined, 24, 30), isNot(_pixelAt(single, 24, 30)));
    });

    test('a blurred $label preserves other pens in the group', () async {
      final first = _renderer('underneath', combineId: 'highlighter');
      final single = await _render([first]);
      final combined = await _render([first, blurredPen('blurred')]);

      expect(_pixelAt(combined, 65, 50), _pixelAt(single, 65, 50));
    });

    test(
      'combined highlights with a blurred $label keep their opacity',
      () async {
        final first = blurredPen('first');
        final single = await _render([first]);
        final combined = await _render([first, blurredPen('second')]);
        final x = useFill ? 35 : 20;
        final y = useFill ? 35 : 40;
        final singleGreen = _pixelAt(single, x, y)[1];

        expect(singleGreen, lessThan(150));
        expect(_pixelAt(combined, x, y)[1], closeTo(singleGreen, 5));
      },
    );
  }
}
