import 'dart:math';
import 'dart:ui' as ui;

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class CameraViewport extends Equatable {
  final ui.Image? image, belowLayerImage, aboveLayerImage;
  final List<Renderer<Background>> backgrounds;
  final List<Renderer<PadElement>> bakedElements,
      unbakedElements,
      visibleElements;
  final int? width, height;
  final double pixelRatio;
  final double scale;
  final double x, y;
  final RenderResolution resolution;

  const CameraViewport.unbaked([
    this.backgrounds = const [],
    this.unbakedElements = const [],
    List<Renderer<PadElement>>? visibleElements,
    this.width,
    this.height,
  ]) : image = null,
       belowLayerImage = null,
       aboveLayerImage = null,
       scale = 1,
       bakedElements = const [],
       pixelRatio = 1,
       x = 0,
       y = 0,
       visibleElements = visibleElements ?? unbakedElements,
       resolution = RenderResolution.performance;

  const CameraViewport.baked({
    this.backgrounds = const [],
    required this.image,
    this.belowLayerImage,
    this.aboveLayerImage,
    required this.width,
    required this.height,
    required this.pixelRatio,
    this.bakedElements = const [],
    this.unbakedElements = const [],
    required this.visibleElements,
    this.scale = 1,
    this.x = 0,
    required this.resolution,
    this.y = 0,
  });

  get center => null;

  ui.Offset toOffset() => ui.Offset(x, y);

  Point<double> toPoint() => Point(x, y);

  ui.Size toSize([bool scaled = false]) => ui.Size(
    (width?.toDouble() ?? 0) / (scaled ? scale : 1),
    (height?.toDouble() ?? 0) / (scaled ? scale : 1),
  );

  ui.Rect toRect() => toOffset() & toSize(true);

  ui.Size toRealSize() => toSize() / resolution.multiplier;

  ui.Rect toRealRect() {
    final rect = toRect();
    final size = toRealSize();
    return ui.Rect.fromLTWH(
      rect.left + rect.width / 4,
      rect.top + rect.height / 4,
      size.width,
      size.height,
    );
  }

  Area toArea() => Area(
    name: '',
    position: toPoint(),
    width: (width?.toDouble() ?? 0) / scale,
    height: (height?.toDouble() ?? 0) / scale,
  );

  bool hasSameViewport(CameraViewport other) {
    return other.width == width &&
        other.height == height &&
        other.scale == scale &&
        other.x == x &&
        other.y == y;
  }

  CameraViewport withUnbaked(
    List<Renderer<PadElement>> unbakedElements, [
    List<Renderer<Background>>? backgrounds,
  ]) => CameraViewport.baked(
    backgrounds: backgrounds ?? this.backgrounds,
    image: image,
    width: width,
    height: height,
    scale: scale,
    unbakedElements: unbakedElements,
    bakedElements: bakedElements,
    pixelRatio: pixelRatio,
    visibleElements: List<Renderer<PadElement>>.from(visibleElements)
      ..addAll(unbakedElements),
    x: x,
    y: y,
    aboveLayerImage: aboveLayerImage,
    belowLayerImage: belowLayerImage,
    resolution: resolution,
  );

  CameraViewport unbake({
    List<Renderer<Background>>? backgrounds,
    List<Renderer<PadElement>>? unbakedElements,
    List<Renderer<PadElement>>? visibleElements,
  }) => CameraViewport.unbaked(
    backgrounds ?? this.backgrounds,
    unbakedElements ??
        (List<Renderer<PadElement>>.from(this.unbakedElements)
          ..addAll(bakedElements)),
    visibleElements ??
        unbakedElements ??
        (List<Renderer<PadElement>>.from(this.unbakedElements)
          ..addAll(bakedElements)),
    width,
    height,
  );

  CameraViewport bake({
    required ui.Image image,
    required int width,
    required int height,
    required double pixelRatio,
    ui.Image? belowLayerImage,
    ui.Image? aboveLayerImage,
    List<Renderer<PadElement>> bakedElements = const [],
    List<Renderer<PadElement>> unbakedElements = const [],
    required List<Renderer<PadElement>> visibleElements,
    double scale = 1,
    double x = 0,
    double y = 0,
    required RenderResolution resolution,
  }) => CameraViewport.baked(
    backgrounds: backgrounds,
    image: image,
    width: width,
    height: height,
    scale: scale,
    pixelRatio: pixelRatio,
    bakedElements: bakedElements,
    unbakedElements: unbakedElements,
    x: x,
    y: y,
    visibleElements: visibleElements,
    aboveLayerImage: aboveLayerImage,
    belowLayerImage: belowLayerImage,
    resolution: resolution,
  );

  CameraViewport withoutLayers() => CameraViewport.baked(
    backgrounds: backgrounds,
    image: image,
    width: width,
    height: height,
    scale: scale,
    pixelRatio: pixelRatio,
    bakedElements: bakedElements,
    unbakedElements: unbakedElements,
    x: x,
    y: y,
    visibleElements: visibleElements,
    aboveLayerImage: null,
    belowLayerImage: null,
    resolution: resolution,
  );

  CameraViewport withBackgrounds(List<Renderer<Background>> backgrounds) =>
      CameraViewport.baked(
        backgrounds: backgrounds,
        pixelRatio: pixelRatio,
        image: image,
        width: width,
        height: height,
        scale: scale,
        bakedElements: bakedElements,
        unbakedElements: unbakedElements,
        x: x,
        y: y,
        visibleElements: visibleElements,
        aboveLayerImage: aboveLayerImage,
        belowLayerImage: belowLayerImage,
        resolution: resolution,
      );

  @override
  List<Object?> get props => [
    image,
    backgrounds,
    bakedElements,
    unbakedElements,
    width,
    height,
    scale,
    x,
    y,
    pixelRatio,
    visibleElements,
    aboveLayerImage,
    belowLayerImage,
    resolution,
  ];
}
