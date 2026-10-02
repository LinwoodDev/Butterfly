import 'dart:convert';

import 'package:butterfly/services/logger.dart';
import 'package:svg_normalizer/svg_normalizer.dart';

final _svgNormalizer = SvgNormalizer();

/// Normalizes a derived render source while retaining the original asset bytes.
String normalizeSvgBytes(List<int> bytes) => _svgNormalizer.normalize(
  utf8.decode(bytes),
  onWarning: (warning) => talker.warning('SVG normalization: $warning'),
);
