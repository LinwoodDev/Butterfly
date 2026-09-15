import 'package:butterfly_api/butterfly_api.dart';
import 'package:test/test.dart';

void main() {
  test('sourced elements expose their asset', () {
    for (final element in <PadElement>[
      PdfElement(source: 'shared.pdf', width: 100, height: 100),
      ImageElement(source: 'shared.pdf', width: 100, height: 100),
      SvgElement(source: 'shared.pdf', width: 100, height: 100),
    ]) {
      expect(element.sources, ['shared.pdf']);
    }
  });

  test('elements expose stroke and fill paint sources', () {
    const stroke = ElementPaint.image(source: 'stroke.png');
    const fill = ElementPaint.svg(source: 'fill.svg');
    final elements = <PadElement>[
      PenElement(
        property: const PenProperty(paint: stroke, fillPaint: fill),
      ),
      PolygonElement(
        property: const PolygonProperty(paint: stroke, fillPaint: fill),
      ),
      for (final shape in <PathShape>[
        const CircleShape(fillPaint: fill),
        const RectangleShape(fillPaint: fill),
        const TriangleShape(fillPaint: fill),
      ])
        ShapeElement(
          property: ShapeProperty(paint: stroke, shape: shape),
        ),
    ];
    for (final element in elements) {
      expect(element.sources, ['stroke.png', 'fill.svg']);
    }
    expect(
      ShapeElement(
        property: const ShapeProperty(paint: stroke, shape: LineShape()),
      ).sources,
      ['stroke.png'],
    );
    expect(PenElement().sources, isEmpty);
  });

  test('page sources include backgrounds and paints and remove duplicates', () {
    final page = DocumentPage(
      backgrounds: [
        Background.image(source: 'shared.png', width: 100, height: 100),
      ],
      layers: [
        DocumentLayer(
          content: [
            ImageElement(source: 'shared.png', width: 100, height: 100),
            PenElement(
              property: const PenProperty(
                paint: ElementPaint.svg(source: 'paint.svg'),
              ),
            ),
          ],
        ),
      ],
    );
    expect(page.sources, {'shared.png', 'paint.svg'});
    expect(page.usesSource('paint.svg'), isTrue);
    expect(page.usesSource('unused.pdf'), isFalse);
  });
}
