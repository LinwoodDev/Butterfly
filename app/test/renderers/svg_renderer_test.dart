import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:math';

import 'package:archive/archive.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final background in [false, true]) {
    test(
      'SVG ${background ? 'background' : 'element'} releases late pictures',
      () async {
        final created = <ui.Picture>[];
        final original = ui.Picture.onCreate;
        ui.Picture.onCreate = created.add;
        addTearDown(() => ui.Picture.onCreate = original);
        final Renderer renderer = background
            ? SvgBackgroundRenderer(
                SvgBackground(source: 'test.svg', width: 1, height: 1),
              )
            : SvgRenderer(SvgElement(source: 'test.svg', width: 1, height: 1));
        final document = NoteData(Archive()).setAsset(
          'test.svg',
          utf8.encode(
            '<svg xmlns="http://www.w3.org/2000/svg" width="1" height="1">'
            '<rect width="1" height="1"/></svg>',
          ),
        );
        final transform = TransformCubit(1);
        final assets = AssetService();
        addTearDown(transform.close);
        addTearDown(assets.dispose);
        final setup = renderer.setup(
          transform,
          document,
          assets,
          const DocumentPage(),
        );
        renderer.dispose();
        await setup;
        if (renderer is SvgRenderer) expect(renderer.pictureInfo, isNull);
        expect(created, isNotEmpty);
        expect(created.every((picture) => picture.debugDisposed), isTrue);
        renderer.dispose();
      },
    );
  }

  test('transformed SVG renderer does not own shared picture info', () async {
    final pictureInfo = await vg.loadPicture(
      SvgStringLoader(
        '<svg viewBox="0 0 1 1" xmlns="http://www.w3.org/2000/svg">'
        '<rect width="1" height="1" />'
        '</svg>',
      ),
      null,
    );
    final renderer = SvgRenderer(
      SvgElement(source: 'test.svg', width: 1, height: 1),
      null,
      pictureInfo,
    );
    final transformed =
        renderer.transform(position: ui.Offset.zero)! as SvgRenderer;

    expect(transformed.pictureInfo, same(pictureInfo));
    expect(transformed.ownsPictureInfo, isFalse);

    transformed.dispose();
    expect(pictureInfo.picture.debugDisposed, isFalse);

    renderer.dispose();
    expect(pictureInfo.picture.debugDisposed, isTrue);
  });

  test(
    'flipped SVG paints and exports the mirrored image after moving',
    () async {
      const source =
          '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 10 10">'
          '<rect width="5" height="5" fill="red" /></svg>';
      final document = NoteData(Archive())
          .setAsset('test.svg', utf8.encode(source));
      final pictureInfo = await vg.loadPicture(
        const SvgStringLoader(source),
        null,
      );
      final renderer = SvgRenderer(
        SvgElement(source: 'test.svg', width: 10, height: 10),
        null,
        pictureInfo,
      );
      addTearDown(renderer.dispose);
      final flipped = renderer.transform(
        center: renderer.rect.center,
        scaleX: -1,
        scaleY: -1,
      )!;
      addTearDown(flipped.dispose);
      final moved = flipped.transform(position: const ui.Offset(10, 20))!;
      addTearDown(moved.dispose);
      const viewport = ui.Rect.fromLTWH(0, 0, 20, 30);
      expect(moved.rect, const ui.Rect.fromLTWH(10, 20, 10, 10));
      expect(moved.element.position, const Point<double>(20, 30));

      final recorder = ui.PictureRecorder();
      moved.build(
        ui.Canvas(recorder),
        viewport.size,
        document,
        const DocumentPage(),
        const DocumentInfo(),
        const CameraTransform(),
      );
      final picture = recorder.endRecording();
      addTearDown(picture.dispose);
      final image = await picture.toImage(20, 30);
      addTearDown(image.dispose);
      final pixels = (await image.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      ))!;
      expect(pixels.getUint32((22 * 20 + 12) * 4), 0x00000000);
      expect(pixels.getUint32((27 * 20 + 17) * 4), 0xFF0000FF);

      final svg = XmlDocument.parse('<svg/>');
      moved.buildSvg(svg, document, const DocumentPage(), viewport);
      expect(
        svg.rootElement.getElement('image')?.getAttribute('transform'),
        'translate(30.0 50.0) scale(-1 -1)',
      );
    },
  );
}
