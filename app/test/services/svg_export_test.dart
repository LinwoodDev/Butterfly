import 'dart:math';

import 'package:archive/archive.dart';
import 'package:butterfly/cubits/editor_runtime.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_leap/material_leap.dart';
import 'package:xml/xml.dart';

import '../helpers/mocks.dart';

const _stops = [
  ElementGradientStop(color: SRGBColor(0xffff0000)),
  ElementGradientStop(offset: 0.35, color: SRGBColor(0x8000ff00)),
  ElementGradientStop(offset: 1, color: SRGBColor(0x000000ff)),
];
const _linear = ElementPaint.gradient(
  gradient: ElementGradient.linear(
    start: Point(0, 0.5),
    end: Point(1, 0.5),
    stops: _stops,
  ),
);
const _radial = ElementPaint.gradient(
  gradient: ElementGradient.radial(
    focal: Point(0.25, 0.75),
    focalRadius: 0.1,
    stops: _stops,
  ),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<XmlElement> export(PadElement element) async {
    final document = NoteData(Archive());
    final page = DocumentPage(
      layers: [
        DocumentLayer(id: 'layer', content: [element]),
      ],
    );
    final assets = AssetService();
    final transform = TransformCubit(1);
    final viewport = await CameraViewport.build(
      transform,
      document,
      assets,
      page,
    );
    final renderer = RendererCubit(MockSettingsCubit());
    addTearDown(() async {
      for (final item in viewport.unbakedElements) {
        item.dispose();
      }
      await renderer.close();
      await transform.close();
      await assets.dispose();
    });
    return renderer
        .renderSVG(
          document,
          page,
          const SvgExportOptions(width: 100, height: 100),
          cameraViewport: viewport,
        )
        .rootElement;
  }

  XmlElement expectGradient(
    XmlElement svg,
    XmlElement element,
    String attribute,
    String gradientType,
  ) {
    final defs = svg.getElement('defs');
    expect(
      defs,
      isNotNull,
      reason: 'Expected a gradient for ${element.name} $attribute',
    );
    final gradient = defs!
        .findElements(gradientType)
        .singleWhere(
          (gradient) =>
              element.getAttribute(attribute) ==
              'url(#${gradient.getAttribute('id')})',
        );
    expect(gradient.getAttribute('gradientUnits'), 'userSpaceOnUse');
    final stops = gradient.findElements('stop');
    expect(stops.map((s) => double.parse(s.getAttribute('offset')!)), [
      0,
      0.35,
      1,
    ]);
    expect(stops.map((s) => s.getAttribute('stop-color')), [
      '#ff0000',
      '#00ff00',
      '#0000ff',
    ]);
    expect(stops.map((s) => double.parse(s.getAttribute('stop-opacity')!)), [
      1,
      128 / 255,
      0,
    ]);
    return gradient;
  }

  for (final (shape, tag) in const [
    (RectangleShape(fillPaint: _linear), 'path'),
    (CircleShape(fillPaint: _linear), 'ellipse'),
    (TriangleShape(fillPaint: _linear), 'path'),
  ]) {
    test(
      'SVG preserves fill and stroke gradients for ${shape.runtimeType}',
      () async {
        final svg = await export(
          ShapeElement(
            firstPosition: const Point(10, 20),
            secondPosition: const Point(50, 50),
            rotation: 30,
            property: ShapeProperty(
              shape: shape,
              paint: _radial,
              strokeWidth: 4,
            ),
          ),
        );
        final geometry = svg.findAllElements(tag).single;
        expect(
          geometry.parentElement?.getAttribute('transform'),
          contains('rotate(30.0)'),
        );
        final fill = expectGradient(svg, geometry, 'fill', 'linearGradient');
        expect(fill.getAttribute('x1'), '10.0');
        expect(fill.getAttribute('x2'), '50.0');
        expect(fill.getAttribute('y1'), '35.0');
        final stroke = expectGradient(
          svg,
          geometry,
          'stroke',
          'radialGradient',
        );
        double attribute(String name) =>
            double.parse(stroke.getAttribute(name)!);
        final width = 40 * cos(pi / 6) + 30 * sin(pi / 6);
        final height = 40 * sin(pi / 6) + 30 * cos(pi / 6);
        final radius = sqrt(width * width + height * height) / 4;
        expect(attribute('cx'), closeTo(30, 1e-9));
        expect(attribute('cy'), closeTo(35, 1e-9));
        expect(attribute('r'), closeTo(radius, 1e-9));
        expect(attribute('fx'), closeTo(30 - width / 4, 1e-9));
        expect(attribute('fy'), closeTo(35 + height / 4, 1e-9));
        expect(attribute('fr'), closeTo(radius / 5, 1e-9));
      },
    );
  }

  test('SVG preserves the stroke gradient on a horizontal line', () async {
    final svg = await export(
      ShapeElement(
        firstPosition: Point(10, 20),
        secondPosition: Point(50, 20),
        property: const ShapeProperty(
          shape: LineShape(),
          paint: _linear,
          strokeWidth: 4,
        ),
      ),
    );
    final line = svg.findAllElements('line').single;
    final stroke = expectGradient(svg, line, 'stroke', 'linearGradient');
    expect(stroke.getAttribute('x1'), '8.0');
    expect(stroke.getAttribute('x2'), '52.0');
    expect(stroke.getAttribute('y1'), '20.0');
  });

  test('SVG preserves polygon fill and stroke gradients', () async {
    final svg = await export(
      PolygonElement(
        points: const [
          PolygonPoint(10, 10),
          PolygonPoint(50, 10),
          PolygonPoint(50, 50),
          PolygonPoint(10, 10),
        ],
        property: const PolygonProperty(fillPaint: _linear, paint: _radial),
      ),
    );
    final path = svg.findAllElements('path').single;
    expectGradient(svg, path, 'fill', 'linearGradient');
    expectGradient(svg, path, 'stroke', 'radialGradient');
  });

  test('SVG preserves pen fill and outline gradients', () async {
    final svg = await export(
      PenElement(
        points: const [PathPoint(10, 10), PathPoint(50, 10), PathPoint(50, 50)],
        property: const PenProperty(fillPaint: _linear, paint: _radial),
      ),
    );
    final [fill, outline] = svg.findAllElements('path').toList();
    expectGradient(svg, fill, 'fill', 'linearGradient');
    expectGradient(svg, outline, 'fill', 'radialGradient');
  });

  test('SVG export preserves gradients in embedded SVG images', () async {
    const source = '''
<svg xmlns="http://www.w3.org/2000/svg" width="40" height="30">
  <defs>
    <linearGradient id="gradient">
      <stop offset="0" stop-color="red"/>
      <stop offset="1" stop-color="blue"/>
    </linearGradient>
  </defs>
  <rect width="40" height="30" fill="url(#gradient)"/>
</svg>''';
    final svg = await export(
      SvgElement(
        width: 40,
        height: 30,
        source: Uri.dataFromString(
          source,
          mimeType: 'image/svg+xml',
        ).toString(),
      ),
    );
    final image = svg.findAllElements('image').single;
    final data = Uri.parse(image.getAttribute('xlink:href')!).data!;
    expect(data.contentAsString(), source);
  });
}
