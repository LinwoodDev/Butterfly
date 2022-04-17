import 'dart:ui' as ui;

import 'package:butterfly/models/background.dart';
import 'package:butterfly/renderers/renderer.dart';

import 'element.dart';

class CameraViewport {
  final ui.Image? image;
  final Renderer<Background> background;
  final List<Renderer<PadElement>> bakedElements;
  final List<Renderer<PadElement>> unbakedElements;
  final int? width, height;
  final double scale;
  final double x, y;

  const CameraViewport.unbaked(this.background,
      [this.unbakedElements = const []])
      : image = null,
        scale = 1,
        width = null,
        height = null,
        bakedElements = const [],
        x = 0,
        y = 0;
  CameraViewport.baked(this.background,
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

  CameraViewport withUnbaked(List<Renderer<PadElement>> unbakedElements) =>
      CameraViewport.baked(background,
          image: image,
          width: width,
          height: height,
          scale: scale,
          unbakedElements: unbakedElements,
          bakedElements: bakedElements,
          x: x,
          y: y);
  CameraViewport unbake([List<Renderer<PadElement>>? unbakedElements]) =>
      CameraViewport.unbaked(
          background,
          unbakedElements ??
              (List<Renderer<PadElement>>.from(this.unbakedElements)
                ..addAll(bakedElements)));
  CameraViewport bake({
    required ui.Image image,
    required int width,
    required int height,
    List<Renderer<PadElement>> bakedElements = const [],
    List<Renderer<PadElement>> unbakedElements = const [],
    double scale = 1,
    double x = 0,
    double y = 0,
  }) =>
      CameraViewport.baked(background,
          image: image,
          width: width,
          height: height,
          scale: scale,
          bakedElements: bakedElements,
          unbakedElements: unbakedElements,
          x: x,
          y: y);

  withBackground(Renderer<Background> background) =>
      CameraViewport.baked(background,
          image: image,
          width: width,
          height: height,
          scale: scale,
          bakedElements: bakedElements,
          unbakedElements: unbakedElements,
          x: x,
          y: y);
}
