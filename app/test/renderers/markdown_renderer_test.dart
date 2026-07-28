import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:archive/archive.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter_test/flutter_test.dart';

Future<Uint8List> _renderMarkdown(String source) async {
  const size = ui.Size(240, 120);
  const page = DocumentPage();
  const info = DocumentInfo();
  final document = NoteData(Archive());
  final renderer = MarkdownRenderer(
    MarkdownElement(
      position: const Point(10, 10),
      text: source,
      constraint: const ElementConstraint(size: 200),
    ),
  );
  final transform = TransformCubit(1);
  final assets = AssetService();
  await renderer.setup(transform, document, assets, page);
  final recorder = ui.PictureRecorder();
  renderer.build(
    ui.Canvas(recorder),
    size,
    document,
    page,
    info,
    transform.state,
  );
  final picture = recorder.endRecording();
  ui.Image? image;
  try {
    image = await picture.toImage(size.width.toInt(), size.height.toInt());
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    return data!.buffer.asUint8List();
  } finally {
    image?.dispose();
    picture.dispose();
    renderer.dispose();
    transform.close();
  }
}

int _paintedPixels(Uint8List pixels) {
  var count = 0;
  for (var offset = 3; offset < pixels.length; offset += 4) {
    if (pixels[offset] != 0) count++;
  }
  return count;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('extracts GitHub Markdown tables for native rendering', () {
    final tables = parseMarkdownTables('''
Before

| Name | Value |
| --- | ---: |
| Butterfly | **42** |

After
''');

    expect(tables, hasLength(1));
    expect(tables.single.headerRows, 1);
    expect(tables.single.columns, 2);
    expect(tables.single.rows, [
      ['Name', 'Value'],
      ['Butterfly', '42'],
    ]);
  });

  test('ignores pipe text that is not a Markdown table', () {
    expect(parseMarkdownTables('Butterfly | 42'), isEmpty);
  });

  test('paints Markdown table cell text', () async {
    final empty = await _renderMarkdown('''
|   |   |
|---|---|
|   |   |
''');
    final populated = await _renderMarkdown('''
| Name | Value |
|---|---|
| Butterfly | 42 |
''');

    expect(populated, isNot(equals(empty)));
    expect(_paintedPixels(populated), greaterThan(_paintedPixels(empty)));
  });
}
