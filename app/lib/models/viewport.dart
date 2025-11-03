import 'dart:math';
import 'dart:ui' as ui;

import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
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
  final Map<String, RendererState> rendererStates;
  final Set<String> invisibleLayers;

  const CameraViewport.unbaked({
    this.backgrounds = const [],
    this.unbakedElements = const [],
    List<Renderer<PadElement>>? visibleElements,
    this.width,
    this.height,
    this.pixelRatio = 1,
    this.rendererStates = const {},
    this.invisibleLayers = const {},
  }) : image = null,
       belowLayerImage = null,
       aboveLayerImage = null,
       scale = 1,
       bakedElements = const [],
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
    this.rendererStates = const {},
    this.invisibleLayers = const {},
  });

  static Future<CameraViewport> build(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    final backgrounds = page.backgrounds
        .map((b) => Renderer<Background>.fromInstance(b))
        .toList();
    final renderers = page.content
        .map((e) => Renderer<PadElement>.fromInstance(e))
        .toList();

    for (final renderer in [...backgrounds, ...renderers]) {
      await renderer.setup(transformCubit, document, assetService, page);
    }

    return CameraViewport.unbaked(
      backgrounds: backgrounds,
      unbakedElements: renderers,
    );
  }

  ui.Offset toOffset() => ui.Offset(x, y);

  Point<double> toPoint() => Point(x, y);

  ui.Size toSize([bool scaled = false]) => ui.Size(
    (width?.toDouble() ?? 0) / (scaled ? scale : 1),
    (height?.toDouble() ?? 0) / (scaled ? scale : 1),
  );

  ui.Rect toRect() => toOffset() & toSize(true);

  ui.Size toRealSize([bool scaled = false]) =>
      toSize(scaled) / resolution.multiplier;

  ui.Rect toRealRect() {
    final rect = toRect();
    final size = toRealSize(true);
    return ui.Rect.fromCenter(
      center: rect.center,
      width: size.width,
      height: size.height,
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
    List<Renderer<PadElement>> unbakedElements,
    List<Renderer<PadElement>> visibleElements, [
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
    visibleElements: visibleElements,
    x: x,
    y: y,
    aboveLayerImage: aboveLayerImage,
    belowLayerImage: belowLayerImage,
    resolution: resolution,
    invisibleLayers: invisibleLayers,
  );

  CameraViewport unbake({
    List<Renderer<Background>>? backgrounds,
    List<Renderer<PadElement>>? unbakedElements,
    List<Renderer<PadElement>>? visibleElements,
    Map<String, RendererState>? rendererStates,
  }) => CameraViewport.unbaked(
    backgrounds: backgrounds ?? this.backgrounds,
    unbakedElements:
        unbakedElements ??
        (List<Renderer<PadElement>>.from(this.unbakedElements)
          ..addAll(bakedElements)),
    visibleElements:
        visibleElements ??
        unbakedElements ??
        (List<Renderer<PadElement>>.from(this.unbakedElements)
          ..addAll(bakedElements)),
    rendererStates: rendererStates ?? this.rendererStates,
    width: width,
    height: height,
    pixelRatio: pixelRatio,
    invisibleLayers: invisibleLayers,
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
    Map<String, RendererState>? rendererStates,
    Set<String>? invisibleLayers,
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
    rendererStates: rendererStates ?? this.rendererStates,
    invisibleLayers: invisibleLayers ?? this.invisibleLayers,
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
    rendererStates: rendererStates,
    invisibleLayers: invisibleLayers,
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
        rendererStates: rendererStates,
        invisibleLayers: invisibleLayers,
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
    rendererStates,
    invisibleLayers,
  ];
}
