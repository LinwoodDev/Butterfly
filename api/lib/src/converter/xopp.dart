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
        final tool = element.getAttribute('tool');
        if (tool == 'eraser') return null;
        var color = _importColor(element.getAttribute('color')!);
        if (tool == 'highlighter') {
          color = color.withValues(a: 128);
        }
        return PenElement(
          property: PenProperty(
            color: color,
            strokeWidth: double.parse(
              element.getAttribute('width')!.split(' ').first,
            ),
          ),
          extra: {
            'xopp:width': element.getAttribute('width')!,
            if (tool != null) 'xopp:tool': tool,
          },
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
        final left = double.parse(
          element.getAttribute('left') ?? element.getAttribute('x')!,
        );
        final top = double.parse(
          element.getAttribute('top') ?? element.getAttribute('y')!,
        );
        final right = double.parse(element.getAttribute('right')!);
        final bottom = double.parse(element.getAttribute('bottom')!);
        return ImageElement(
          source: Uri.file(path, windows: false).toString(),
          position: Point(left, top),
          collection: collectionName,
          height: bottom - top,
          width: right - left,
        );
      case 'teximage':
        final left = double.parse(
          element.getAttribute('left') ?? element.getAttribute('x') ?? '0',
        );
        final top = double.parse(
          element.getAttribute('top') ?? element.getAttribute('y') ?? '0',
        );
        return TextElement(
          position: Point(left, top),
          area: text.TextArea(
            paragraph: text.TextParagraph(
              textSpans: [
                text.InlineSpan.math(
                  text: element.innerText,
                  property: const text.SpanProperty.defined(),
                ),
              ],
            ),
          ),
          collection: collectionName,
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
    final documentLayers = <DocumentLayer>[];
    final page = entry.value;
    final layersMeta = {};

    final backgroundXml = page.getElement('background')!;
    final backgroundType = backgroundXml.getAttribute('type');
    final pageWidth = double.tryParse(page.getAttribute('width') ?? '') ?? 0.0;
    final pageHeight =
        double.tryParse(page.getAttribute('height') ?? '') ?? 0.0;

    if (backgroundType == 'pdf') {
      final filename = backgroundXml.getAttribute('filename');
      final pageNo =
          int.tryParse(backgroundXml.getAttribute('page') ?? '1') ?? 1;
      if (filename != null) {
        documentLayers.add(
          DocumentLayer(
            content: [
              PadElement.pdf(
                source: filename,
                page: pageNo - 1,
                width: pageWidth,
                height: pageHeight,
              ),
            ],
            id: createUniqueId(),
          ),
        );
      }
    }

    for (final (index, layer) in page.findElements('layer').indexed) {
      final layerElements = <PadElement>[];
      final xoppLayerName = layer.getAttribute('name');
      final layerName = xoppLayerName ?? 'Layer ${index + 1}';
      for (final element in layer.childElements) {
        PadElement? current;
        (note, current) = getElement(note, element, layerName);
        if (current != null) {
          layerElements.add(current);
        }
      }
      documentLayers.add(
        DocumentLayer(content: layerElements, id: createUniqueId()),
      );
      layersMeta[layerName] = {
        'hasName': xoppLayerName != null,
        'timestamp': layer.getAttribute('timestamp'),
      };
    }

    final backgroundStyle = backgroundXml.getAttribute('style');
    final backgroundColorStr = backgroundXml.getAttribute('color');
    final backgroundColor = backgroundColorStr != null
        ? _importColor(backgroundColorStr.substring(1))
        : SRGBColor.white;

    final background = switch (backgroundType) {
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
        layers: documentLayers,
        backgrounds: [if (background != null) background],
        extra: {'xopp:layers': layersMeta},
      ),
      '',
    );
  }
  return note;
}

void _exportLabelElement(XmlBuilder builder, LabelElement e) {
  final styleSheet = e.styleSheet;
  final style = e is TextElement
      ? styleSheet?.item
            .resolveParagraphProperty(e.area.paragraph.property)
            ?.span
      : styleSheet?.item.getParagraphProperty('p')?.span;
  builder.element(
    'text',
    attributes: {
      'color': _exportColor(style?.color ?? SRGBColor.black),
      'size': (style?.size ?? 12).toString(),
      'x': e.position.x.toString(),
      'y': e.position.y.toString(),
    },
    nest: () {
      builder.text(e.text);
    },
  );
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
            for (final layer in page.layers) {
              builder.element(
                'layer',
                nest: () {
                  for (final element in layer.content) {
                    switch (element) {
                      case PenElement e:
                        final tool = e.extra['xopp:tool'] as String? ?? 'pen';
                        builder.element(
                          'stroke',
                          attributes: {
                            'color': _exportColor(e.property.color),
                            'width': e.property.strokeWidth.toString(),
                            'tool': tool,
                          },
                          nest: () {
                            builder.text(
                              e.points.map((e) => '${e.x} ${e.y}').join(' '),
                            );
                          },
                        );
                        break;
                      case LabelElement e:
                        if (e is TextElement &&
                            e.area.paragraph.textSpans.length == 1 &&
                            e.area.paragraph.textSpans.first
                                is text.MathTextSpan) {
                          final mathSpan =
                              e.area.paragraph.textSpans.first
                                  as text.MathTextSpan;
                          builder.element(
                            'teximage',
                            attributes: {
                              'left': e.position.x.toString(),
                              'top': e.position.y.toString(),
                            },
                            nest: () {
                              builder.text(mathSpan.text);
                            },
                          );
                        } else {
                          _exportLabelElement(builder, e);
                        }
                        break;
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
            }
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
