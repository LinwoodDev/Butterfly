import 'dart:ui' as ui;

import 'package:butterfly/renderers/renderer.dart';

class CameraViewport {
  final ui.Image? image;
  final List<Renderer> bakedElements;
  final List<Renderer> unbakedElements;
  final int? width, height;
  final double scale;
  final double x, y;

  const CameraViewport.unbaked([this.unbakedElements = const []])
      : image = null,
        scale = 1,
        width = null,
        height = null,
        bakedElements = const [],
        x = 0,
        y = 0;
  CameraViewport.baked(
      {required this.image,
      required this.width,
      required this.height,
      this.bakedElements = const [],
      this.unbakedElements = const [],
      this.scale = 1,
      this.x = 0,
      this.y = 0});

  ui.Offset toOffset() => ui.Offset(x, y);

  ui.Size toSize() => ui.Size(width?.toDouble() ?? 0, height?.toDouble() ?? 0);

  bool hasSameViewport(CameraViewport other) {
    return other.width == width &&
        other.height == height &&
        other.scale == scale &&
        other.x == x &&
        other.y == y;
  }

  CameraViewport withUnbaked(List<Renderer> unbakedElements) =>
      CameraViewport.baked(
          image: image,
          width: width,
          height: height,
          scale: scale,
          unbakedElements: unbakedElements,
          x: x,
          y: y);
}
