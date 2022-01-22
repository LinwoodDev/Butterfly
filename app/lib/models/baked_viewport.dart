import 'dart:ui' as ui;

import 'package:butterfly/models/elements/element.dart';

class BakedViewport {
  final ui.Image image;
  final List<PadElement> bakedElements;
  final int width, height;
  final double scale;
  final double x, y;

  BakedViewport(
      {required this.image,
      required this.width,
      required this.height,
      this.bakedElements = const [],
      this.scale = 1,
      this.x = 0,
      this.y = 0});

  void dispose() => image.dispose();

  ui.Offset toOffset() => ui.Offset(x, y);

  ui.Size toSize() => ui.Size(width.toDouble(), height.toDouble());
}
