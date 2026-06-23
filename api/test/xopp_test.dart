import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:dart_leap/dart_leap.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart';

Uint8List _gzip(String xml) => GZipEncoder().encodeBytes(utf8.encode(xml));

XmlDocument _exportedXml(NoteData document) => XmlDocument.parse(
  utf8.decode(GZipDecoder().decodeBytes(xoppExporter(document))),
);

void main() {
  const source = '''<?xml version="1.0" encoding="UTF-8"?>
<xournal creator="xournalpp 1.3.5" fileversion="5">
  <title>Round trip</title>
  <page width="612" height="792">
    <background type="solid" color="#ffffffff" style="graph" config="m1=40,rm=1"/>
    <layer name="Ink">
      <stroke tool="highlighter" color="#ff000080" width="2.5 1.25 1.875" capStyle="round" style="dash">1 2 3 4 5 6</stroke>
      <text font="Sans" size="14" x="10" y="20" color="#112233ff">Hello &amp; goodbye</text>
      <link align="center" font="Sans" size="12" x="30" y="40" color="#0000ffff" url="https://example.com?a=1&amp;b=2">Example</link>
      <image left="5" top="6" right="7" bottom="8">iVBORw0KGgo=</image>
    </layer>
  </page>
</xournal>''';

  test('imports and exports supported Xournal++ document data', () {
    final imported = xoppMigrator(_gzip(source));
    final reimported = xoppMigrator(xoppExporter(imported));
    final page = reimported.getPage(reimported.getPages().single)!;

    expect(reimported.getMetadata()!.name, 'Round trip');
    expect(page.extra['xopp:width'], 612);
    expect(page.extra['xopp:height'], 792);
    expect(page.areas.single.position, const Point(0, 0));
    expect(page.areas.single.width, 612);
    expect(page.areas.single.height, 792);
    expect(page.areas.single.isInitial, isTrue);
    expect(page.layers.single.name, 'Ink');
    expect(page.layers.single.content.whereType<PenElement>(), hasLength(1));
    expect(page.layers.single.content.whereType<TextElement>(), hasLength(2));
    expect(page.layers.single.content.whereType<ImageElement>(), hasLength(1));
  });

  test('does not store an original Xournal++ file or auxiliary data files', () {
    final document = xoppMigrator(_gzip(source));

    expect(document.getAssets('xopp/', true), isEmpty);
  });

  test('exports current Butterfly edits', () {
    var document = xoppMigrator(_gzip(source)).setName('Edited');
    final pageName = document.getPages().single;
    final page = document.getPage(pageName)!;
    final layer = page.layers.single;
    final stroke = layer.content.whereType<PenElement>().single;
    final label = layer.content.whereType<TextElement>().first;
    final image = layer.content.whereType<ImageElement>().single;
    final changedContent = layer.content.map((element) {
      if (element == stroke) {
        return stroke.copyWith(
          property: stroke.property.copyWith(strokeWidth: 7),
          points: const [PathPoint(11, 12), PathPoint(13, 14)],
        );
      }
      if (element == label) {
        return label.copyWith(
          position: const Point(50, 60),
          foreground: SRGBColor.red,
        );
      }
      if (element == image) {
        return image.copyWith(
          position: const Point(20, 30),
          width: 40,
          height: 50,
        );
      }
      return element;
    }).toList();
    final changedPage = page.copyWith(
      layers: [layer.copyWith(name: 'Changed layer', content: changedContent)],
    );
    (document, _) = document.setPage(changedPage, pageName);

    final exported = _exportedXml(document);
    final xournal = exported.getElement('xournal')!;
    final exportedStroke = xournal.findAllElements('stroke').single;
    final exportedText = xournal.findAllElements('text').single;
    final exportedImage = xournal.findAllElements('image').single;

    expect(xournal.getElement('title')!.innerText, 'Edited');
    expect(
      xournal.findAllElements('layer').single.getAttribute('name'),
      'Changed layer',
    );
    expect(exportedStroke.getAttribute('width'), '7.0');
    expect(exportedStroke.innerText.trim(), '11.0 12.0 13.0 14.0');
    expect(exportedText.getAttribute('x'), '50.0');
    expect(exportedText.getAttribute('y'), '60.0');
    expect(exportedText.getAttribute('color'), '#ff0000ff');
    expect(exportedImage.getAttribute('left'), '20.0');
    expect(exportedImage.getAttribute('top'), '30.0');
    expect(exportedImage.getAttribute('right'), '60.0');
    expect(exportedImage.getAttribute('bottom'), '80.0');
  });

  test('exports single-point Butterfly strokes as valid Xournal++ strokes', () {
    var document = xoppMigrator(_gzip(source));
    final pageName = document.getPages().single;
    final page = document.getPage(pageName)!;
    final layer = page.layers.single;
    final stroke = layer.content.whereType<PenElement>().single;
    final changedPage = page.copyWith(
      layers: [
        layer.copyWith(
          content: [
            stroke.copyWith(points: const [PathPoint(10, 20)]),
          ],
        ),
      ],
    );
    (document, _) = document.setPage(changedPage, pageName);

    final exported = _exportedXml(document);
    final coordinates = exported
        .findAllElements('stroke')
        .single
        .innerText
        .trim()
        .split(RegExp(r'\s+'));

    expect(coordinates, hasLength(4));
    final reimported = xoppMigrator(xoppExporter(document));
    final reimportedStroke = reimported
        .getPage(reimported.getPages().single)!
        .content
        .whereType<PenElement>()
        .single;
    expect(reimportedStroke.points, hasLength(2));
  });

  test('exports page size and coordinates relative to the initial area', () {
    var document = xoppMigrator(_gzip(source));
    final pageName = document.getPages().single;
    final page = document.getPage(pageName)!;
    final layer = page.layers.single;
    final stroke = layer.content.whereType<PenElement>().single;
    final changedPage = page.copyWith(
      areas: [
        page.areas.single.copyWith(
          position: const Point(100, 200),
          width: 400,
          height: 500,
        ),
      ],
      layers: [
        layer.copyWith(
          content: [
            stroke.copyWith(
              points: const [PathPoint(110, 220), PathPoint(130, 240)],
            ),
          ],
        ),
      ],
    );
    (document, _) = document.setPage(changedPage, pageName);

    final exported = _exportedXml(document);
    final exportedPage = exported.findAllElements('page').single;
    final exportedStroke = exported.findAllElements('stroke').single;

    expect(exportedPage.getAttribute('width'), '400.0');
    expect(exportedPage.getAttribute('height'), '500.0');
    expect(exportedStroke.innerText.trim(), '10.0 20.0 30.0 40.0');
  });

  test('exports every Butterfly area as a separate Xournal++ page', () {
    var document = xoppMigrator(_gzip(source));
    final pageName = document.getPages().single;
    final page = document.getPage(pageName)!;
    final layer = page.layers.single;
    final stroke = layer.content.whereType<PenElement>().single;
    final changedPage = page.copyWith(
      areas: const [
        Area(
          name: 'Left',
          position: Point(0, 0),
          width: 100,
          height: 200,
          isInitial: true,
        ),
        Area(name: 'Right', position: Point(100, 0), width: 300, height: 200),
      ],
      layers: [
        layer.copyWith(
          content: [
            stroke.copyWith(
              points: const [PathPoint(10, 20), PathPoint(30, 40)],
            ),
            stroke.copyWith(
              id: createUniqueId(),
              points: const [PathPoint(110, 20), PathPoint(130, 40)],
            ),
          ],
        ),
      ],
    );
    (document, _) = document.setPage(changedPage, pageName);

    final pages = _exportedXml(document).findAllElements('page').toList();

    expect(pages, hasLength(2));
    expect(pages[0].getAttribute('width'), '100.0');
    expect(pages[1].getAttribute('width'), '300.0');
    expect(
      pages[0].findAllElements('stroke').single.innerText.trim(),
      '10.0 20.0 30.0 40.0',
    );
    expect(
      pages[1].findAllElements('stroke').single.innerText.trim(),
      '10.0 20.0 30.0 40.0',
    );
  });

  test('imports packaged Xournal++ files with attachments', () {
    final packagedXml = source.replaceFirst(
      'iVBORw0KGgo=',
      '<attachment path="image.png"/>',
    );
    final archive = Archive()
      ..addFile(
        ArchiveFile.noCompress(
          'mimetype',
          'application/xournal++'.length,
          utf8.encode('application/xournal++'),
        ),
      )
      ..addFile(ArchiveFile.string('META-INF/version', 'current=5\nmin=0'))
      ..addFile(ArchiveFile.string('content.xml', packagedXml))
      ..addFile(ArchiveFile.bytes('image.png', base64Decode('iVBORw0KGgo=')));

    final document = xoppMigrator(ZipEncoder().encodeBytes(archive));
    final page = document.getPage(document.getPages().single)!;

    expect(page.layers.single.content.whereType<ImageElement>(), hasLength(1));
  });
}
