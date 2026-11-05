import 'dart:math';
import 'dart:ui';

import 'package:butterfly_api/butterfly_api.dart';
import 'package:lw_sysapi/lw_sysapi.dart';

const kCanvasUnitsPerMillimeter = kCanvasUnitsPerInch / 25.4;

class DisplayCalibrationProfile {
  final String key;
  final DisplayMetrics? metrics;
  final double pixelRatio;

  const DisplayCalibrationProfile(this.key, this.metrics, this.pixelRatio);

  double? get automaticZoom =>
      metrics == null ? null : actualSizeZoom(metrics!, pixelRatio);
}

/// Camera zoom that matches the document's printed size on this display.
double actualSizeZoom(DisplayMetrics metrics, double devicePixelRatio) {
  final pixelsPerMillimeter = metrics.millimetersToCanvasUnits(
    const Size.square(1),
    devicePixelRatio: devicePixelRatio,
  );
  // Keep the document's proportions. Small X/Y differences commonly come from
  // rounded panel dimensions; their geometric mean treats both axes equally.
  return sqrt(pixelsPerMillimeter.width * pixelsPerMillimeter.height) /
      kCanvasUnitsPerMillimeter;
}
