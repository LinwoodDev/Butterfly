import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:xml/xml.dart';

List<PathPoint> toPoints(List<double> data) {
  final points = <PathPoint>[];
  final iterator = data.iterator;
  while (iterator.moveNext()) {
    final x = iterator.current;
    if (iterator.moveNext()) {
      final y = iterator.current;
      points.add(PathPoint(x, y));
    }
  }
  return points;
}

int importColor(String value) {
  final number = int.parse(value.substring(1), radix: 16);
  return (number >> 8 | number << 24);
}

(NoteData, PadElement?) getElement(
    NoteData data, XmlElement element, String layerName) {
  PadElement? get() {
    switch (element.qualifiedName) {
      case 'stroke':
        return PenElement(
          property: PenProperty(
            color: importColor(element.getAttribute('color')!),
            strokeWidth: double.parse(element.getAttribute('width')!),
          ),
          points: toPoints(element.innerText
              .split(' ')
              .map((e) => double.parse(e))
              .toList()),
          layer: layerName,
        );
      case 'text':
        return TextElement(
          area: text.TextArea(
              paragraph: text.TextParagraph.text(
            textSpans: [
              text.TextSpan.text(
                text: element.innerText,
                property: text.SpanProperty.defined(
                  color: importColor(element.getAttribute('color')!),
                  size: double.parse(element.getAttribute('size')!),
                ),
              ),
            ],
          )),
          position: Point(double.parse(element.getAttribute('x')!),
              double.parse(element.getAttribute('y')!)),
          layer: layerName,
        );
      case 'image':
        final imageData = UriData.parse(element.innerText);
        String path;
        (data, path) = data.addImage(imageData.contentAsBytes(), 'png');
        final left = double.parse(element.getAttribute('x')!);
        final top = double.parse(element.getAttribute('y')!);
        final right = double.parse(element.getAttribute('right')!);
        final bottom = double.parse(element.getAttribute('bottom')!);
        return ImageElement(
          source: Uri.file(path, windows: false).toString(),
          position: Point(left, top),
          layer: layerName,
          height: bottom - top,
          width: right - left,
        );
      default:
        return null;
    }
  }

  return (data, get());
}

NoteData xoppMigrator(Uint8List data) {
  final doc = XmlDocument.parse(utf8.decode(GZipDecoder().decodeBytes(data)));
  final xournal = doc.getElement('xournal')!;
  var note = NoteData(Archive());
  note = note.setMetadata(FileMetadata(
    type: NoteFileType.document,
    name: xournal.getElement('title')!.innerText,
  ));
  for (final entry in xournal.findElements('page').toList().asMap().entries) {
    final elements = <PadElement>[];
    final page = entry.value;
    final layerName = 'Layer ${entry.key}';
    for (final layer in page.findElements('layer')) {
      for (final element in layer.childElements) {
        PadElement? current;
        (note, current) = getElement(note, element, layerName);
        if (current != null) {
          elements.add(current);
        }
      }
    }
    final backgroundXml = page.getElement('background')!;
    final backgroundStyle = backgroundXml.getAttribute('style');
    final backgroundColor =
        importColor(backgroundXml.getAttribute('color')!.substring(1));
    final background = switch (backgroundXml.getAttribute('type')) {
      'solid' => Background.texture(
            texture: SurfaceTexture.pattern(
          boxXColor: backgroundColor,
          boxYColor: backgroundColor,
          boxYSpace:
              backgroundStyle == 'ruled' || backgroundStyle == 'lined' ? 20 : 0,
          boxXSpace: backgroundStyle == 'ruled' ? 20 : 0,
        )),
      _ => null,
    };
    (note, _) = note.addPage(DocumentPage(
      content: elements,
      backgrounds: [
        if (background != null) background,
      ],
    ));
  }
  return note;
}

// Uint8List xoppExporter(NoteData document) {}
