import 'dart:ui' as ui;
import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

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
}
