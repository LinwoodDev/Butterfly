import 'dart:convert';
import 'dart:ui';

import 'package:butterfly/services/logger.dart';
import 'package:svg_normalizer/svg_normalizer.dart';
import 'package:xml/xml.dart';

import 'xml.dart';

final _svgNormalizer = SvgNormalizer();

/// Normalizes a derived render source while retaining the original asset bytes.
String normalizeSvgBytes(List<int> bytes) => _svgNormalizer.normalize(
  utf8.decode(bytes),
  onWarning: (warning) => talker.warning('SVG normalization: $warning'),
);

void addSvgImage(
  XmlDocument xml,
  Rect bounds,
  String href, {
  required bool flipX,
  required bool flipY,
}) {
  final transform = flipX || flipY
      ? 'translate(${flipX ? bounds.left + bounds.right : 0} '
            '${flipY ? bounds.top + bounds.bottom : 0}) '
            'scale(${flipX ? -1 : 1} ${flipY ? -1 : 1})'
      : null;
  xml
      .getElement('svg')
      ?.createElement(
        'image',
        attributes: {
          'x': '${bounds.left}px',
          'y': '${bounds.top}px',
          'width': '${bounds.width}px',
          'height': '${bounds.height}px',
          'xlink:href': href,
          'transform': ?transform,
        },
      );
}
