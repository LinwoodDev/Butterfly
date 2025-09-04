import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:dart_leap/dart_leap.dart';
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

SRGBColor _importColor(String value) {
  return SRGBColor.parse(value);
}

String _exportColor(SRGBColor value) {
  return value.toHexString();
}

(NoteData, PadElement?) getElement(
  NoteData data,
  XmlElement element,
  String collectionName,
) {
  PadElement? get() {
    switch (element.qualifiedName) {
      case 'stroke':
        return PenElement(
          property: PenProperty(
            color: _importColor(element.getAttribute('color')!),
            strokeWidth: double.parse(
              element.getAttribute('width')!.split(' ').first,
            ),
          ),
          extra: {'xopp:width': element.getAttribute('width')!},
          points: toPoints(
            element.innerText.split(' ').map((e) => double.parse(e)).toList(),
          ),
          collection: collectionName,
        );
      case 'text':
        return TextElement(
          area: text.TextArea(
            paragraph: text.TextParagraph(
              textSpans: [
                text.InlineSpan.text(
                  text: element.innerText,
                  property: text.SpanProperty.defined(
                    color: _importColor(element.getAttribute('color')!),
                    size: double.parse(element.getAttribute('size')!),
                  ),
                ),
              ],
            ),
          ),
          position: Point(
            double.parse(element.getAttribute('x')!),
            double.parse(element.getAttribute('y')!),
          ),
          collection: collectionName,
        );
      case 'image':
        final imageData = UriData.parse(element.innerText);
        String path;
        (data, path) = data.importImage(imageData.contentAsBytes(), 'png');
        final left = double.parse(element.getAttribute('x')!);
        final top = double.parse(element.getAttribute('y')!);
        final right = double.parse(element.getAttribute('right')!);
        final bottom = double.parse(element.getAttribute('bottom')!);
        return ImageElement(
          source: Uri.file(path, windows: false).toString(),
          position: Point(left, top),
          collection: collectionName,
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
  note = note.setMetadata(
    FileMetadata(
      type: NoteFileType.document,
      name: xournal.getElement('title')!.innerText,
    ),
  );
  for (final entry in xournal.findElements('page').toList().asMap().entries) {
    final elements = <PadElement>[];
    final page = entry.value;
    final layers = {};
    for (final (index, layer) in page.findElements('layer').indexed) {
      final xoppLayerName = layer.getAttribute('name');
      final layerName = xoppLayerName ?? 'Layer ${index + 1}';
      for (final element in layer.childElements) {
        PadElement? current;
        (note, current) = getElement(note, element, layerName);
        if (current != null) {
          elements.add(current);
        }
      }
      layers[layerName] = {
        'hasName': xoppLayerName != null,
        'timestamp': layer.getAttribute('timestamp'),
      };
    }
    final backgroundXml = page.getElement('background')!;
    final backgroundStyle = backgroundXml.getAttribute('style');
    final backgroundColor = _importColor(
      backgroundXml.getAttribute('color')!.substring(1),
    );
    final background = switch (backgroundXml.getAttribute('type')) {
      'solid' => Background.texture(
        texture: SurfaceTexture.pattern(
          boxXColor: backgroundColor,
          boxYColor: backgroundColor,
          boxYSpace: backgroundStyle == 'ruled' || backgroundStyle == 'lined'
              ? 20
              : 0,
          boxXSpace: backgroundStyle == 'ruled' ? 20 : 0,
        ),
      ),
      _ => null,
    };
    (note, _) = note.addPage(
      DocumentPage(
        layers: [DocumentLayer(content: elements, id: createUniqueId())],
        backgrounds: [if (background != null) background],
        extra: {'xopp:layers': layers},
      ),
      '',
    );
  }
  return note;
}

Uint8List xoppExporter(NoteData document) {
  final builder = XmlBuilder();
  builder.processing('xml', 'version="1.0" encoding="UTF-8"');
  builder.element(
    'xournal',
    attributes: {'creator': 'Butterfly', 'fileversion': '4'},
    nest: () {
      final metadata = document.getMetadata();
      builder.element('title', nest: metadata?.name);
      for (final pageName in document.getPages()) {
        final page = document.getPage(pageName);
        if (page == null) continue;
        builder.element(
          'page',
          nest: () {
            builder.element(
              'background',
              attributes: {
                'type': 'solid',
                'color': _exportColor(
                  page.backgrounds.firstOrNull?.defaultColor ?? SRGBColor.white,
                ),
                'style': 'plain',
              },
            );
            builder.element(
              'layer',
              nest: () {
                for (final element in page.content) {
                  switch (element) {
                    case PenElement e:
                      builder.element(
                        'stroke',
                        attributes: {
                          'color': _exportColor(e.property.color),
                          'width': e.property.strokeWidth.toString(),
                          'tool': 'pen',
                        },
                        nest: () {
                          builder.text(
                            e.points.map((e) => '${e.x} ${e.y}').join(' '),
                          );
                        },
                      );
                      break;
                    case LabelElement e:
                      final styleSheet = e.styleSheet;
                      final style = e is TextElement
                          ? styleSheet?.item
                                .resolveParagraphProperty(
                                  e.area.paragraph.property,
                                )
                                ?.span
                          : styleSheet?.item.getParagraphProperty('p')?.span;
                      builder.element(
                        'text',
                        attributes: {
                          'color': _exportColor(
                            style?.color ?? SRGBColor.black,
                          ),
                          'size': (style?.size ?? 12).toString(),
                          'x': e.position.x.toString(),
                          'y': e.position.y.toString(),
                        },
                        nest: () {
                          builder.text(e.text);
                        },
                      );
                    case ImageElement e:
                      final imageData = document.getAsset(
                        Uri.parse(e.source).path,
                      );
                      builder.element(
                        'image',
                        attributes: {
                          'left': e.position.x.toString(),
                          'top': e.position.y.toString(),
                          'right': (e.position.x + e.width).toString(),
                          'bottom': (e.position.y + e.height).toString(),
                        },
                        nest: () {
                          builder.text(
                            UriData.fromBytes(
                              imageData ?? [],
                              mimeType: 'image/png',
                            ).toString(),
                          );
                        },
                      );
                    default:
                      break;
                  }
                }
              },
            );
          },
        );
      }
    },
  );
  return Uint8List.fromList(
    GZipEncoder().encode(
      utf8.encode(builder.buildDocument().toXmlString(pretty: true)),
    ),
  );
}
