import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:dart_leap/dart_leap.dart';
import 'package:xml/xml.dart';

const _xoppTypeKey = 'xopp:type';

class _XoppContainer {
  final XmlDocument document;
  final Archive? archive;

  const _XoppContainer(this.document, [this.archive]);
}

List<double> _numbers(String? value) =>
    value
        ?.trim()
        .split(RegExp(r'\s+'))
        .where((value) => value.isNotEmpty)
        .map(double.tryParse)
        .nonNulls
        .toList() ??
    [];

double _number(String? value, [double fallback = 0]) =>
    double.tryParse(value ?? '') ?? fallback;

List<PathPoint> _points(XmlElement element) {
  final coordinates = _numbers(element.innerText);
  final widths = _numbers(element.getAttribute('width'));
  final baseWidth = widths.firstOrNull ?? 1;
  final points = <PathPoint>[];
  for (var i = 0; i + 1 < coordinates.length; i += 2) {
    final pressureIndex = i ~/ 2 + 1;
    final pressure = pressureIndex < widths.length && baseWidth > 0
        ? widths[pressureIndex] / baseWidth
        : 1.0;
    points.add(PathPoint(coordinates[i], coordinates[i + 1], pressure));
  }
  return points;
}

SRGBColor _importColor(String? value, [SRGBColor fallback = SRGBColor.black]) {
  const namedColors = {
    'black': SRGBColor.black,
    'blue': SRGBColor.blue,
    'green': SRGBColor.green,
    'red': SRGBColor.red,
    'white': SRGBColor.white,
    'yellow': SRGBColor.yellow,
  };
  if (value == null) return fallback;
  return namedColors[value.toLowerCase()] ??
      SRGBColor.tryParse(value) ??
      fallback;
}

String _exportColor(SRGBColor value) => value.toHexString();

String _extensionForImage(Uint8List data) {
  if (data.length >= 3 &&
      data[0] == 0xff &&
      data[1] == 0xd8 &&
      data[2] == 0xff) {
    return 'jpg';
  }
  if (data.length >= 4 &&
      data[0] == 0x47 &&
      data[1] == 0x49 &&
      data[2] == 0x46 &&
      data[3] == 0x38) {
    return 'gif';
  }
  return 'png';
}

Uint8List? _decodeEmbeddedData(String value) {
  final normalized = value.trim();
  if (normalized.isEmpty) return null;
  try {
    if (normalized.startsWith('data:')) {
      return UriData.parse(normalized).contentAsBytes();
    }
    return base64Decode(normalized.replaceAll(RegExp(r'\s+'), ''));
  } catch (_) {
    return null;
  }
}

Map<String, String> _attributes(XmlElement element) => {
  for (final attribute in element.attributes)
    attribute.name.qualified: attribute.value,
};

_XoppContainer _decodeXopp(Uint8List data) {
  if (data.length >= 4 &&
      data[0] == 0x50 &&
      data[1] == 0x4b &&
      data[2] == 0x03 &&
      data[3] == 0x04) {
    final archive = ZipDecoder().decodeBytes(data);
    final content = archive.findFile('content.xml')?.readBytes();
    if (content == null) {
      throw const FormatException('Xournal++ package has no content.xml');
    }
    return _XoppContainer(XmlDocument.parse(utf8.decode(content)), archive);
  }
  return _XoppContainer(
    XmlDocument.parse(utf8.decode(GZipDecoder().decodeBytes(data))),
  );
}

Uint8List? _elementData(XmlElement element, Archive? archive) {
  final attachment = element.getElement('attachment')?.getAttribute('path');
  if (attachment != null) {
    return archive?.findFile(attachment)?.readBytes();
  }
  return _decodeEmbeddedData(element.innerText);
}

(NoteData, PadElement?) _importElement(
  NoteData data,
  XmlElement element,
  String collectionName,
  Archive? archive,
) {
  final extra = <String, dynamic>{
    _xoppTypeKey: element.qualifiedName,
    'xopp:attributes': _attributes(element),
  };
  switch (element.qualifiedName) {
    case 'stroke':
      final widths = _numbers(element.getAttribute('width'));
      return (
        data,
        PenElement(
          id: createUniqueId(),
          property: PenProperty(
            paint: ElementPaint.solid(
              color: _importColor(element.getAttribute('color')),
            ),
            strokeWidth: widths.firstOrNull ?? 1,
            thinning: widths.length > 1 ? 1 : 0,
          ),
          extra: extra,
          points: _points(element),
          collection: collectionName,
        ),
      );
    case 'text':
    case 'link':
      final color = _importColor(element.getAttribute('color'));
      final size = _number(element.getAttribute('size'), 12);
      return (
        data,
        TextElement(
          id: createUniqueId(),
          area: text.TextArea(
            paragraph: text.TextParagraph(
              textSpans: [
                text.InlineSpan.text(
                  text: element.innerText,
                  property: text.SpanProperty.defined(color: color, size: size),
                ),
              ],
            ),
          ),
          foreground: color,
          position: Point(
            _number(element.getAttribute('x')),
            _number(element.getAttribute('y')),
          ),
          collection: collectionName,
          extra: extra,
        ),
      );
    case 'image':
      final imageData = _elementData(element, archive);
      if (imageData == null) return (data, null);
      final (newData, path) = data.importImage(
        imageData,
        _extensionForImage(imageData),
      );
      final left = _number(
        element.getAttribute('left') ?? element.getAttribute('x'),
      );
      final top = _number(
        element.getAttribute('top') ?? element.getAttribute('y'),
      );
      final right = _number(element.getAttribute('right'), left);
      final bottom = _number(element.getAttribute('bottom'), top);
      return (
        newData,
        ImageElement(
          id: createUniqueId(),
          source: Uri.file(path, windows: false).toString(),
          position: Point(left, top),
          collection: collectionName,
          height: bottom - top,
          width: right - left,
          extra: extra,
        ),
      );
    case 'teximage':
      final pdfData = _elementData(element, archive);
      if (pdfData == null) return (data, null);
      final (newData, path) = data.importPdf(pdfData);
      final left = _number(element.getAttribute('left'));
      final top = _number(element.getAttribute('top'));
      final right = _number(element.getAttribute('right'), left);
      final bottom = _number(element.getAttribute('bottom'), top);
      return (
        newData,
        PdfElement(
          id: createUniqueId(),
          source: Uri.file(path, windows: false).toString(),
          position: Point(left, top),
          collection: collectionName,
          height: bottom - top,
          width: right - left,
          extra: extra,
        ),
      );
    default:
      return (data, null);
  }
}

Background? _importBackground(
  NoteData note,
  XmlElement element,
  double width,
  double height,
  Archive? archive,
) {
  final extra = <String, dynamic>{'xopp:attributes': _attributes(element)};
  final color = _importColor(element.getAttribute('color'), SRGBColor.white);
  if (element.getAttribute('type') == 'solid') {
    final style = element.getAttribute('style');
    return Background.texture(
      texture: SurfaceTexture.pattern(
        boxColor: color,
        boxXColor: color,
        boxYColor: color,
        boxYSpace: style == 'ruled' || style == 'lined' ? 20 : 0,
        boxXSpace: style == 'ruled' ? 20 : 0,
      ),
      extra: extra,
    );
  }
  return null;
}

NoteData xoppMigrator(Uint8List data) {
  final container = _decodeXopp(data);
  final xournal = container.document.getElement('xournal');
  if (xournal == null) {
    throw const FormatException('Xournal++ document has no xournal root');
  }
  var note = NoteData(Archive());
  note = note.setMetadata(
    FileMetadata(
      type: NoteFileType.document,
      name: xournal.getElement('title')?.innerText ?? '',
    ),
  );
  for (final page in xournal.findElements('page')) {
    final width = _number(page.getAttribute('width'), 595.27559);
    final height = _number(page.getAttribute('height'), 841.88976);
    final layers = <DocumentLayer>[];
    for (final (index, layer) in page.findElements('layer').indexed) {
      final hasName = layer.getAttribute('name') != null;
      final layerName = layer.getAttribute('name') ?? 'Layer ${index + 1}';
      final elements = <PadElement>[];
      for (final element in layer.childElements) {
        PadElement? current;
        (note, current) = _importElement(
          note,
          element,
          layerName,
          container.archive,
        );
        if (current != null) {
          elements.add(current);
        }
      }
      layers.add(
        DocumentLayer(id: createUniqueId(), name: layerName, content: elements),
      );
      if (!hasName) {
        // DocumentLayer requires a display name. The original absence is
        // retained in the page XML metadata below.
      }
    }
    final backgroundXml = page.getElement('background');
    final background = backgroundXml == null
        ? null
        : _importBackground(
            note,
            backgroundXml,
            width,
            height,
            container.archive,
          );
    (note, _) = note.addPage(
      DocumentPage(
        layers: layers.isEmpty ? [DocumentLayer(id: createUniqueId())] : layers,
        backgrounds: [?background],
        areas: [
          Area(
            name: 'Page',
            width: width,
            height: height,
            position: const Point(0, 0),
            isInitial: true,
          ),
        ],
        extra: {
          'xopp:width': width,
          'xopp:height': height,
          'xopp:layerAttributes': [
            for (final layer in page.findElements('layer')) _attributes(layer),
          ],
        },
      ),
      '',
    );
  }
  return note;
}

Map<String, String> _preservedAttributes(PadElement element) {
  final value = element.extra['xopp:attributes'];
  if (value is! Map) return {};
  return value.map((key, value) => MapEntry('$key', '$value'));
}

void _exportStroke(
  XmlBuilder builder,
  PenElement element,
  Point<double> offset,
) {
  if (element.points.isEmpty) return;
  final width = element.property.strokeWidth;
  final points = element.points.length == 1
      ? [
          element.points.single,
          element.points.single.copyWith(
            x: element.points.single.x + max(width.abs() * 0.001, 0.001),
          ),
        ]
      : element.points;
  final pressureWidths =
      points.length > 1 && points.any((point) => point.pressure != 1)
      ? [
          width,
          ...points
              .take(points.length - 1)
              .map((point) => width * point.pressure),
        ].join(' ')
      : width.toString();
  final attributes = _preservedAttributes(element)
    ..['color'] = _exportColor(element.property.paint.previewColor)
    ..['width'] = pressureWidths
    ..putIfAbsent('tool', () => 'pen')
    ..putIfAbsent('capStyle', () => 'round');
  builder.element(
    'stroke',
    attributes: attributes,
    nest: () => builder.text(
      points
          .map((point) => '${point.x - offset.x} ${point.y - offset.y}')
          .join(' '),
    ),
  );
}

void _exportLabel(
  XmlBuilder builder,
  LabelElement element,
  Point<double> offset,
) {
  final padElement = element as PadElement;
  final attributes = _preservedAttributes(padElement);
  final isLink = padElement.extra[_xoppTypeKey] == 'link';
  final styleSheet = element.styleSheet;
  final style = element is TextElement
      ? styleSheet?.item
            .resolveParagraphProperty(element.area.paragraph.property)
            ?.span
      : styleSheet?.item.getParagraphProperty('p')?.span;
  attributes
    ..['color'] = _exportColor(style?.color ?? element.foreground)
    ..['size'] = (style?.size ?? _number(attributes['size'], 12)).toString()
    ..['x'] = (element.position.x - offset.x).toString()
    ..['y'] = (element.position.y - offset.y).toString()
    ..putIfAbsent('font', () => 'Sans');
  if (isLink) {
    attributes
      ..putIfAbsent('align', () => 'left')
      ..putIfAbsent('url', () => '');
  }
  builder.element(
    isLink ? 'link' : 'text',
    attributes: attributes,
    nest: () => builder.text(element.text),
  );
}

Uint8List? _assetData(NoteData document, SourcedElement element) =>
    document.getAsset(Uri.parse(element.source).path);

void _exportImage(
  XmlBuilder builder,
  NoteData document,
  ImageElement element,
  Point<double> offset,
) {
  final imageData = _assetData(document, element);
  if (imageData == null) return;
  final attributes = _preservedAttributes(element)
    ..['left'] = (element.position.x - offset.x).toString()
    ..['top'] = (element.position.y - offset.y).toString()
    ..['right'] = (element.position.x - offset.x + element.width).toString()
    ..['bottom'] = (element.position.y - offset.y + element.height).toString();
  builder.element(
    'image',
    attributes: attributes,
    nest: () => builder.text(base64Encode(imageData)),
  );
}

void _exportTexImage(
  XmlBuilder builder,
  NoteData document,
  PdfElement element,
  Point<double> offset,
) {
  final pdfData = _assetData(document, element);
  if (pdfData == null) return;
  final attributes = _preservedAttributes(element)
    ..['left'] = (element.position.x - offset.x).toString()
    ..['top'] = (element.position.y - offset.y).toString()
    ..['right'] = (element.position.x - offset.x + element.width).toString()
    ..['bottom'] = (element.position.y - offset.y + element.height).toString()
    ..putIfAbsent('text', () => '');
  builder.element(
    'teximage',
    attributes: attributes,
    nest: () => builder.text(base64Encode(pdfData)),
  );
}

void _exportBackground(XmlBuilder builder, DocumentPage page) {
  final background = page.backgrounds.firstOrNull;
  final preserved = background?.extra['xopp:attributes'];
  final attributes = preserved is Map
      ? preserved.map((key, value) => MapEntry('$key', '$value'))
      : <String, String>{};
  switch (background) {
    case TextureBackground(:final texture):
      final style = switch (texture) {
        PatternTexture(:final boxXSpace, :final boxYSpace)
            when boxXSpace > 0 && boxYSpace > 0 =>
          'ruled',
        PatternTexture(:final boxYSpace) when boxYSpace > 0 => 'lined',
        _ => 'plain',
      };
      attributes
        ..['type'] = 'solid'
        ..['color'] = _exportColor(background.defaultColor)
        ..putIfAbsent('style', () => style);
    case _:
      attributes
        ..['type'] = 'solid'
        ..['color'] = _exportColor(background?.defaultColor ?? SRGBColor.white)
        ..['style'] = 'plain';
  }
  builder.element('background', attributes: attributes);
}

bool _isInArea(PadElement element, Area? area) {
  if (area == null) return true;
  final left = area.position.x;
  final top = area.position.y;
  final right = left + area.width;
  final bottom = top + area.height;

  bool overlaps(double x, double y, double width, double height) =>
      x <= right && x + width >= left && y <= bottom && y + height >= top;

  return switch (element) {
    PenElement(:final points, :final property) when points.isNotEmpty => () {
      final minX = points.map((point) => point.x).reduce(min);
      final maxX = points.map((point) => point.x).reduce(max);
      final minY = points.map((point) => point.y).reduce(min);
      final maxY = points.map((point) => point.y).reduce(max);
      final padding = property.strokeWidth.abs() / 2;
      return overlaps(
        minX - padding,
        minY - padding,
        maxX - minX + padding * 2,
        maxY - minY + padding * 2,
      );
    }(),
    LabelElement(:final position) =>
      position.x >= left &&
          position.x <= right &&
          position.y >= top &&
          position.y <= bottom,
    ImageElement(:final position, :final width, :final height) ||
    PdfElement(
      :final position,
      :final width,
      :final height,
    ) => overlaps(position.x, position.y, width, height),
    _ => false,
  };
}

String _buildXoppXml(NoteData document) {
  final builder = XmlBuilder();
  builder.processing('xml', 'version="1.0" encoding="UTF-8"');
  builder.element(
    'xournal',
    attributes: {'creator': 'Butterfly', 'fileversion': '5'},
    nest: () {
      builder.element('title', nest: document.getMetadata()?.name ?? '');
      for (final pageName in document.getPages()) {
        final page = document.getPage(pageName);
        if (page == null) continue;
        final exportAreas = page.areas.isEmpty ? <Area?>[null] : page.areas;
        for (final pageArea in exportAreas) {
          final pageOffset = pageArea?.position ?? const Point(0, 0);
          builder.element(
            'page',
            attributes: {
              'width':
                  '${pageArea?.width ?? page.extra['xopp:width'] ?? 595.27559}',
              'height':
                  '${pageArea?.height ?? page.extra['xopp:height'] ?? 841.88976}',
            },
            nest: () {
              _exportBackground(builder, page);
              final layerAttributes = page.extra['xopp:layerAttributes'];
              for (final (index, layer) in page.layers.indexed) {
                final attributes = <String, String>{};
                if (layerAttributes is List &&
                    index < layerAttributes.length &&
                    layerAttributes[index] is Map) {
                  attributes.addAll(
                    (layerAttributes[index] as Map).map(
                      (key, value) => MapEntry('$key', '$value'),
                    ),
                  );
                }
                if (layer.name.isNotEmpty) {
                  attributes['name'] = layer.name;
                } else {
                  attributes.remove('name');
                }
                builder.element(
                  'layer',
                  attributes: attributes,
                  nest: () {
                    for (final element in layer.content.where(
                      (element) => _isInArea(element, pageArea),
                    )) {
                      switch (element) {
                        case PenElement e:
                          _exportStroke(builder, e, pageOffset);
                        case LabelElement e:
                          _exportLabel(builder, e, pageOffset);
                        case ImageElement e:
                          _exportImage(builder, document, e, pageOffset);
                        case PdfElement e
                            when e.extra[_xoppTypeKey] == 'teximage':
                          _exportTexImage(builder, document, e, pageOffset);
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
      }
    },
  );
  return builder.buildDocument().toXmlString(pretty: true);
}

Uint8List xoppExporter(NoteData document) =>
    GZipEncoder().encodeBytes(utf8.encode(_buildXoppXml(document)));
