import 'dart:math';

import 'package:archive/archive.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/painting.dart' show Axis;
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const start = Point<double>(100, 100);
  const end = Point<double>(200, 150);
  final elements = <PadElement>[
    PenElement(points: const [PathPoint(100, 100), PathPoint(200, 150)]),
    PolygonElement(points: [PolygonPoint(100, 100), PolygonPoint(200, 150)]),
    ShapeElement(firstPosition: start, secondPosition: end),
    TableElement(firstPosition: start, secondPosition: end),
    TextureElement(firstPosition: start, secondPosition: end),
    SvgElement(source: 'test.svg', position: start, width: 100, height: 50),
    TextElement(
      position: start,
      area: const text.TextArea(
        paragraph: text.TextParagraph(
          textSpans: [text.InlineSpan.text(text: 'Text label')],
        ),
      ),
    ),
    MarkdownElement(position: start, text: 'Markdown label'),
  ];

  for (final element in elements) {
    for (final axis in Axis.values) {
      for (final byOperation in [false, true]) {
        final method = byOperation ? 'operation' : 'resize handle';
        test(
          '${element.runtimeType} moves after $axis flip via $method',
          () async {
            final document = NoteData(Archive());
            final camera = TransformCubit(1);
            final assets = AssetService();
            const page = DocumentPage();
            addTearDown(camera.close);
            addTearDown(assets.dispose);

            final original = Renderer.fromInstance(element);
            addTearDown(original.dispose);
            await original.setup(camera, document, assets, page);
            final bounds = original.rect!;
            final flipped = byOperation
                ? original.flip(axis: axis, selectionRect: bounds)!
                : original.transform(
                    center: bounds.center,
                    scaleX: axis == Axis.horizontal ? -1 : 1,
                    scaleY: axis == Axis.vertical ? -1 : 1,
                  )!;
            addTearDown(flipped.dispose);
            await flipped.setup(camera, document, assets, page);
            final flippedBounds = flipped.rect!;
            const delta = Offset(17, 29);
            final moved = flipped.transform(
              center: flippedBounds.center + delta,
            )!;
            addTearDown(moved.dispose);
            await moved.setup(camera, document, assets, page);

            expect(moved.rect, flippedBounds.shift(delta));
            expect(flippedBounds.isEmpty, isFalse);
          },
        );
      }
    }
  }
}
