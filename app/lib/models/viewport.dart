// ignore_for_file: unused_element_parameter

import 'dart:math';
import 'dart:ui' as ui;

import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/services/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'viewport.freezed.dart';

@freezed
sealed class CameraViewport with _$CameraViewport {
  const CameraViewport._();

  const factory CameraViewport.unbaked({
    @Default([]) List<Renderer<Background>> backgrounds,
    @Default([]) List<Renderer<PadElement>> bakedElements,
    @Default([]) List<Renderer<PadElement>> unbakedElements,
    @Default([]) List<Renderer<PadElement>> visibleElements,
    @Default([]) List<Renderer<PadElement>> visibleUnbakedElements,
    double? width,
    double? height,
    ui.Size? viewportSize,
    @Default(1) double pixelRatio,
    @Default(1) double scale,
    @Default(0) double x,
    @Default(0) double y,
    @Default(RenderResolution.performance) RenderResolution resolution,
    @Default({}) Map<String, RendererState> rendererStates,
    @Default({}) Set<String> invisibleLayers,
    @Default(null) ui.Image? image,
    @Default(null) ui.Image? belowLayerImage,
    @Default(null) ui.Image? aboveLayerImage,
  }) = CameraViewportUnbaked;

  const factory CameraViewport.baked({
    @Default([]) List<Renderer<Background>> backgrounds,
    ui.Image? image,
    ui.Image? belowLayerImage,
    ui.Image? aboveLayerImage,
    required double? width,
    required double? height,
    ui.Size? viewportSize,
    required double pixelRatio,
    @Default([]) List<Renderer<PadElement>> bakedElements,
    @Default([]) List<Renderer<PadElement>> unbakedElements,
    required List<Renderer<PadElement>> visibleElements,
    required List<Renderer<PadElement>> visibleUnbakedElements,
    @Default(1) double scale,
    @Default(0) double x,
    required RenderResolution resolution,
    @Default(0) double y,
    @Default({}) Map<String, RendererState> rendererStates,
    @Default({}) Set<String> invisibleLayers,
  }) = CameraViewportBaked;

  static List<Renderer<PadElement>> _filterVisibleUnbaked(
    List<Renderer<PadElement>> visibleElements,
    List<Renderer<PadElement>> unbakedElements,
  ) {
    if (visibleElements.isEmpty || unbakedElements.isEmpty) return const [];
    if (identical(visibleElements, unbakedElements)) return visibleElements;
    final unbakedSet = unbakedElements.toSet();
    return visibleElements.where(unbakedSet.contains).toList(growable: false);
  }

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
      visibleElements: renderers,
      visibleUnbakedElements: renderers,
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
    isInitial: false,
  );

  bool hasSameViewport(CameraViewport other) {
    return other.width == width &&
        other.height == height &&
        other.scale == scale &&
        other.x == x &&
        other.y == y;
  }

  CameraViewport withUnbaked(
    List<Renderer<PadElement>> unbakedElements, {
    List<Renderer<PadElement>>? visibleElements,
    List<Renderer<PadElement>>? visibleUnbakedElements,
    List<Renderer<Background>>? backgrounds,
  }) {
    final nextVisibleElements = visibleElements ?? this.visibleElements;
    final nextVisibleUnbakedElements =
        visibleUnbakedElements ??
        _filterVisibleUnbaked(nextVisibleElements, unbakedElements);
    return copyWith(
      backgrounds: backgrounds ?? this.backgrounds,
      unbakedElements: unbakedElements,
      visibleElements: nextVisibleElements,
      visibleUnbakedElements: nextVisibleUnbakedElements,
    );
  }

  CameraViewport replaceUnbaked(
    List<Renderer<PadElement>> unbakedElements, {
    List<Renderer<PadElement>>? visibleElements,
    List<Renderer<PadElement>>? visibleUnbakedElements,
    List<Renderer<Background>>? backgrounds,
    Map<String, RendererState>? rendererStates,
  }) {
    final nextVisibleElements = visibleElements ?? unbakedElements;
    final nextVisibleUnbakedElements =
        visibleUnbakedElements ??
        _filterVisibleUnbaked(nextVisibleElements, unbakedElements);
    return copyWith(
      backgrounds: backgrounds ?? this.backgrounds,
      bakedElements: const [],
      unbakedElements: unbakedElements,
      visibleElements: nextVisibleElements,
      visibleUnbakedElements: nextVisibleUnbakedElements,
      rendererStates: rendererStates ?? this.rendererStates,
    );
  }

  CameraViewport unbake({
    List<Renderer<Background>>? backgrounds,
    List<Renderer<PadElement>>? unbakedElements,
    List<Renderer<PadElement>>? visibleElements,
    List<Renderer<PadElement>>? visibleUnbakedElements,
    Map<String, RendererState>? rendererStates,
  }) {
    final nextUnbakedElements =
        unbakedElements ??
        (List<Renderer<PadElement>>.from(this.unbakedElements)
          ..addAll(bakedElements));
    final nextVisibleElements =
        visibleElements ?? unbakedElements ?? nextUnbakedElements;
    return CameraViewport.unbaked(
      backgrounds: backgrounds ?? this.backgrounds,
      unbakedElements: nextUnbakedElements,
      visibleElements: nextVisibleElements,
      visibleUnbakedElements:
          visibleUnbakedElements ??
          _filterVisibleUnbaked(nextVisibleElements, nextUnbakedElements),
      rendererStates: rendererStates ?? this.rendererStates,
      width: width,
      height: height,
      viewportSize: viewportSize,
      pixelRatio: pixelRatio,
      scale: scale,
      x: x,
      y: y,
      resolution: resolution,
      invisibleLayers: invisibleLayers,
    );
  }

  CameraViewport bake({
    required ui.Image image,
    required double width,
    required double height,
    ui.Size? viewportSize,
    required double pixelRatio,
    ui.Image? belowLayerImage,
    ui.Image? aboveLayerImage,
    List<Renderer<PadElement>> bakedElements = const [],
    List<Renderer<PadElement>> unbakedElements = const [],
    required List<Renderer<PadElement>> visibleElements,
    List<Renderer<PadElement>>? visibleUnbakedElements,
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
    viewportSize: viewportSize ?? this.viewportSize,
    scale: scale,
    pixelRatio: pixelRatio,
    bakedElements: bakedElements,
    unbakedElements: unbakedElements,
    x: x,
    y: y,
    visibleElements: visibleElements,
    visibleUnbakedElements:
        visibleUnbakedElements ??
        _filterVisibleUnbaked(visibleElements, unbakedElements),
    aboveLayerImage: aboveLayerImage,
    belowLayerImage: belowLayerImage,
    resolution: resolution,
    rendererStates: rendererStates ?? this.rendererStates,
    invisibleLayers: invisibleLayers ?? this.invisibleLayers,
  );

  CameraViewport withoutLayers() =>
      copyWith(belowLayerImage: null, aboveLayerImage: null);

  CameraViewport withBackgrounds(List<Renderer<Background>> backgrounds) =>
      copyWith(backgrounds: backgrounds);

  bool get baked => this is CameraViewportBaked;

  void disposeImages({CameraViewport? except}) {
    try {
      if (!identical(image, except?.image)) image?.dispose();
    } catch (_) {}
    try {
      if (!identical(belowLayerImage, except?.belowLayerImage)) {
        belowLayerImage?.dispose();
      }
    } catch (_) {}
    try {
      if (!identical(aboveLayerImage, except?.aboveLayerImage)) {
        aboveLayerImage?.dispose();
      }
    } catch (_) {}
  }
}
