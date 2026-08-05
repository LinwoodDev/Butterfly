import 'dart:ui' as ui;

import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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
