import 'dart:math';
import 'dart:ui' as ui;

import 'package:butterfly/api/image.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/embed/embedding.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/helpers/async.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/selections/selection.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/editor_session.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly/services/logger.dart';
import 'package:butterfly/helpers/xml.dart';
import 'package:butterfly/view_painter.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image/image.dart' as img;
import 'package:lw_file_system/lw_file_system.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:synchronized/synchronized.dart';
import 'package:xml/xml.dart';

part 'editor_runtime.freezed.dart';

Future<NoteFile> _toFile((NoteData, bool) args) async {
  return args.$1.toFile(isTextBased: args.$2);
}

enum SaveState { saved, saving, unsaved, absoluteRead }

enum HideState { visible, keyboard, touch }

enum RendererState { visible, temporary, hidden }

enum TemporaryState { allowClick, removeAfterClick, removeAfterRelease }

@Freezed(equal: false)
sealed class RendererRuntimeState with _$RendererRuntimeState {
  const RendererRuntimeState._();

  const factory RendererRuntimeState({
    @Default(CameraViewport.unbaked()) CameraViewport cameraViewport,
    @Default({}) Map<String, RendererState> rendererStates,
    @Default({}) Map<String, RendererState>? temporaryRendererStates,
  }) = _RendererRuntimeState;

  Map<String, RendererState> get allRendererStates => {
    ...rendererStates,
    ...?temporaryRendererStates,
  };
}

class RendererCubit extends Cubit<RendererRuntimeState> {
  RendererCubit(
    this.settingsCubit, [
    super.initial = const RendererRuntimeState(),
  ]);

  final SettingsCubit settingsCubit;

  final initializedElements = <Renderer<PadElement>>{};
  final bakeLock = Lock();
  final delayedBakeRunner = CoalescedAsyncRunner(
    delay: const Duration(milliseconds: 100),
  );

  void cancelDelayedBake() {
    delayedBakeRunner.cancel();
  }

  void replace(RendererRuntimeState state) => emit(state);

  void setViewport(CameraViewport cameraViewport) =>
      emit(state.copyWith(cameraViewport: cameraViewport));

  void setRendererStates({
    Map<String, RendererState>? rendererStates,
    Map<String, RendererState>? temporaryRendererStates,
  }) => emit(
    state.copyWith(
      rendererStates: rendererStates ?? state.rendererStates,
      temporaryRendererStates:
          temporaryRendererStates ?? state.temporaryRendererStates,
    ),
  );

  List<Renderer<PadElement>> get renderers =>
      List<Renderer<PadElement>>.from(state.cameraViewport.bakedElements)
        ..addAll(state.cameraViewport.unbakedElements);

  Renderer? getRenderer(PadElement element) =>
      renderers.firstWhereOrNull((renderer) => renderer.element == element);

  bool sameRendererList(
    List<Renderer<PadElement>> a,
    List<Renderer<PadElement>> b,
  ) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (!identical(a[i], b[i])) return false;
    }
    return true;
  }

  void invalidateRenderers(Iterable<Renderer<PadElement>> renderers) {
    initializedElements.removeAll(renderers);
  }

  Rect getViewportRect(TransformCubit transformCubit, {Size? viewportSize}) {
    var size = viewportSize ?? state.cameraViewport.toSize();
    final transform = transformCubit.state;
    final resolution = settingsCubit.state.renderResolution;
    final friction = transform.friction;
    final realWidth = size.width / transform.size;
    final realHeight = size.height / transform.size;
    Rect rect = Rect.fromLTWH(
      transform.position.dx,
      transform.position.dy,
      realWidth,
      realHeight,
    );
    if (friction != null) {
      final beginPosition = transform.position - friction.beginOffset;
      final topLeft = Offset(
        min(transform.position.dx, beginPosition.dx),
        min(transform.position.dy, beginPosition.dy),
      );
      final frictionSize = Size(
        realWidth + (friction.beginOffset.dx * transform.size).abs(),
        realHeight + (friction.beginOffset.dy * transform.size).abs(),
      );
      rect = topLeft & frictionSize;
    }
    return _snapViewportRect(rect, size, transform, resolution);
  }

  Rect _snapViewportRect(
    Rect rect,
    Size size,
    CameraTransform transform,
    RenderResolution resolution,
  ) {
    final screenRect = Rect.fromPoints(
      transform.globalToLocal(rect.topLeft),
      transform.globalToLocal(rect.bottomRight),
    );
    final snappedRect = _expandScreenRect(
      Rect.fromLTRB(
        screenRect.left.floorToDouble(),
        screenRect.top.floorToDouble(),
        screenRect.right.ceilToDouble(),
        screenRect.bottom.ceilToDouble(),
      ),
      Size(
        (size.width * resolution.multiplier).ceilToDouble(),
        (size.height * resolution.multiplier).ceilToDouble(),
      ),
    );
    return Rect.fromPoints(
      transform.localToGlobal(snappedRect.topLeft),
      transform.localToGlobal(snappedRect.bottomRight),
    );
  }

  Rect _expandScreenRect(Rect rect, Size minimumSize) {
    final dx = max(0.0, minimumSize.width - rect.width);
    final dy = max(0.0, minimumSize.height - rect.height);
    return Rect.fromLTRB(
      rect.left - (dx / 2).floorToDouble(),
      rect.top - (dy / 2).floorToDouble(),
      rect.right + (dx / 2).ceilToDouble(),
      rect.bottom + (dy / 2).ceilToDouble(),
    );
  }

  bool rectContains(Rect outer, Rect inner) {
    const tolerance = precisionErrorTolerance;
    return outer.left <= inner.left + tolerance &&
        outer.top <= inner.top + tolerance &&
        outer.right >= inner.right - tolerance &&
        outer.bottom >= inner.bottom - tolerance;
  }

  Rect getPageRect({Set<String>? invisibleLayers}) {
    Rect? rect;
    for (final renderer in renderers) {
      final rendererRect = renderer.expandedRect;
      if (rendererRect == null) continue;
      if (invisibleLayers?.contains(renderer.layer) ?? false) continue;
      rect = rect?.expandToInclude(rendererRect) ?? rendererRect;
    }
    return rect ?? Rect.zero;
  }

  Future<void> updateVisibleElements(
    EditorController controller,
    DocumentBloc? bloc,
  ) async {
    if (controller.isClosed) return;
    final unbaked = state.cameraViewport.unbakedElements;
    final baked = state.cameraViewport.bakedElements;

    final rect = getViewportRect(controller.transformCubit);
    final currentVisible = state.cameraViewport.visibleElements;
    final currentVisibleUnbaked = state.cameraViewport.visibleUnbakedElements;

    final visibleUnbaked = unbaked.where((e) => e.isVisible(rect)).toList();
    final visible = <Renderer<PadElement>>[
      ...baked.where((e) => e.isVisible(rect)),
      ...visibleUnbaked,
    ];

    if (sameRendererList(visible, currentVisible) &&
        sameRendererList(visibleUnbaked, currentVisibleUnbaked)) {
      return;
    }

    final newViewport = state.cameraViewport.withUnbaked(
      unbaked,
      visibleElements: visible,
      visibleUnbakedElements: visibleUnbaked,
    );

    final docState = bloc?.state;
    if (docState is DocumentLoaded) {
      await updateOnVisible(controller, newViewport, docState);
      if (!controller.isClosed && bloc != null && !bloc.isClosed) {
        bloc.delayedBake();
      }
    }

    if (controller.isClosed) return;

    setViewport(newViewport);
  }

  Future<void> updateOnVisible(
    EditorController controller,
    CameraViewport newViewport,
    DocumentLoaded blocState, {
    CameraTransform? renderTransform,
    ui.Size? targetSize,
  }) async {
    final newVisibleList = newViewport.visibleElements;
    final nextVisibleSet = newVisibleList.toSet();

    final newVisible = newVisibleList
        .where((e) => !initializedElements.contains(e))
        .toList();

    final newlyHidden = initializedElements
        .where((e) => !nextVisibleSet.contains(e))
        .toList();

    if (newVisible.isEmpty && newlyHidden.isEmpty) return;

    final transform = renderTransform ?? controller.transformCubit.state;
    final size = targetSize ?? newViewport.toSize();

    initializedElements.removeAll(newlyHidden);

    if (newVisible.isNotEmpty) {
      talker.verbose('Updating visible elements: ${newVisible.length} new');
      final initialized = await Future.wait(
        newVisible.map((element) async {
          try {
            await Future.sync(
              () => element.onVisible(controller, blocState, transform, size),
            );
            return element;
          } catch (error, stackTrace) {
            talker.error(
              'Failed to initialize visible renderer $element',
              error,
              stackTrace,
            );
          }
          return null;
        }),
      );
      initializedElements.addAll(initialized.nonNulls);
    }

    if (newlyHidden.isNotEmpty) {
      await Future.wait(
        newlyHidden.map(
          (element) async =>
              await element.onHidden(controller, blocState, transform, size),
        ),
      );
    }
  }

  Future<void> delayedBake(
    EditorController controller,
    DocumentLoaded blocState, {
    ui.Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
    bool testTransform = false,
  }) => delayedBakeRunner.schedule(() async {
    final newTransform = controller.transformCubit.state;
    final viewport = state.cameraViewport;

    if (testTransform &&
        newTransform.size == viewport.scale &&
        newTransform.position == viewport.toOffset()) {
      return;
    }

    await controller.rendererCubit.bake(
      controller,
      blocState,
      viewportSize: viewportSize,
      pixelRatio: pixelRatio,
      reset: reset,
    );
  });

  Future<void> bake(
    EditorController controller,
    DocumentLoaded blocState, {
    Size? viewportSize,
    double? pixelRatio,
    bool reset = false,
    bool resetAllLayers = false,
  }) => bakeLock.synchronized(() async {
    final rendererCubit = this;
    final transformCubit = controller.transformCubit;
    final settingsCubit = controller.settingsCubit;
    if (controller.isClosed) return;
    var cameraViewport = rendererCubit.state.cameraViewport;
    final startTransform = transformCubit.state;
    final startViewport = cameraViewport;
    final resolution = settingsCubit.state.renderResolution;
    var size = viewportSize ?? cameraViewport.toSize();
    final ratio = pixelRatio ?? cameraViewport.pixelRatio;
    if (size.height <= 0 || size.width <= 0) {
      return;
    }
    if (viewportSize == null) {
      size /= resolution.multiplier;
    }
    var transform = transformCubit.state;
    var renderers = List<Renderer<PadElement>>.from(rendererCubit.renderers);
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);
    final rect = rendererCubit.getViewportRect(
      transformCubit,
      viewportSize: size,
    );
    size = rect.size * transform.size;
    final renderTransform = transform.improve(resolution, rect);
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final imageWidth = (size.width * ratio).ceil();
    final imageHeight = (size.height * ratio).ceil();
    var allRendererStates = rendererCubit.state.allRendererStates;
    final rendererStatesChanged = !mapEquals(
      allRendererStates,
      cameraViewport.rendererStates,
    );
    if (!rendererStatesChanged) {
      allRendererStates = cameraViewport.rendererStates;
    }
    final invisibleLayers = blocState.invisibleLayers;
    final viewportAlreadyCoversRect =
        cameraViewport.image != null &&
        cameraViewport.scale == transform.size &&
        cameraViewport.resolution == resolution &&
        cameraViewport.pixelRatio == ratio &&
        !rendererStatesChanged &&
        setEquals(cameraViewport.invisibleLayers, invisibleLayers) &&
        rendererCubit.rectContains(cameraViewport.toRect(), rect);
    final viewChanged =
        !viewportAlreadyCoversRect &&
        (cameraViewport.width != size.width.ceil() ||
            cameraViewport.height != size.height.ceil() ||
            cameraViewport.pixelRatio != ratio ||
            cameraViewport.resolution != resolution ||
            cameraViewport.x != renderTransform.position.dx ||
            cameraViewport.y != renderTransform.position.dy ||
            cameraViewport.scale != transform.size ||
            rendererStatesChanged ||
            !setEquals(cameraViewport.invisibleLayers, invisibleLayers));
    reset = reset || viewChanged;
    resetAllLayers = resetAllLayers || viewChanged;
    if (cameraViewport.unbakedElements.isEmpty && !reset) return;
    final currentLayer = blocState.currentLayer;
    List<Renderer<PadElement>> visibleElements;
    final oldVisible = cameraViewport.visibleElements;
    final oldVisibleSet = oldVisible.toSet();
    talker.verbose(
      'Baking viewport (reset: $reset, viewChanged: $viewChanged, '
      'rendererStatesChanged: $rendererStatesChanged)',
    );

    if (reset) {
      visibleElements = renderers
          .where((renderer) => renderer.isVisible(rect))
          .toList();
    } else {
      visibleElements = List.from(oldVisible)
        ..addAll(
          cameraViewport.unbakedElements.where(
            (renderer) =>
                !oldVisibleSet.contains(renderer) && renderer.isVisible(rect),
          ),
        );
    }

    final visibleElementsSet = visibleElements.toSet();

    await rendererCubit.updateOnVisible(
      controller,
      cameraViewport.unbake(visibleElements: visibleElements),
      blocState,
      renderTransform: renderTransform,
      targetSize: size,
    );

    canvas.scale(ratio);

    if (viewChanged && visibleElements.isNotEmpty) {
      await Future.wait(
        visibleElements.map(
          (e) async =>
              await e.updateView(controller, blocState, renderTransform, size),
        ),
      );
    }

    // Wait one frame
    await Future.delayed(const Duration(milliseconds: 1));

    ViewPainter(
      document,
      page,
      info,
      transform: renderTransform,
      cameraViewport: reset
          ? cameraViewport.unbake(
              rendererStates: allRendererStates,
              unbakedElements: visibleElements
                  .where((e) => currentLayer == e.layer)
                  .toList(),
              visibleElements: visibleElements,
            )
          : cameraViewport,
      renderBackground: false,
      renderBaked: !reset,
      renderBakedLayers: false,
      invisibleLayers: invisibleLayers,
    ).paint(canvas, size);

    final picture = recorder.endRecording();
    ui.Image newImage;
    try {
      newImage = await picture.toImage(imageWidth, imageHeight);
    } finally {
      picture.dispose();
    }

    var belowLayerImage = cameraViewport.belowLayerImage;
    var aboveLayerImage = cameraViewport.aboveLayerImage;

    if (resetAllLayers) {
      final belowLayerRecorder = ui.PictureRecorder();
      final belowLayerCanvas = ui.Canvas(belowLayerRecorder);
      belowLayerCanvas.scale(ratio);
      final aboveLayerRecorder = ui.PictureRecorder();
      final aboveLayerCanvas = ui.Canvas(aboveLayerRecorder);
      aboveLayerCanvas.scale(ratio);
      final belowLayers = <String>{}, aboveLayers = <String>{};
      bool above = false;
      for (final layer in page.layers) {
        if (layer.id == currentLayer) {
          above = true;
          continue;
        }
        final layerId = layer.id;
        if (layerId == null) continue;
        if (above) {
          aboveLayers.add(layerId);
        } else {
          belowLayers.add(layerId);
        }
      }

      ViewPainter(
        document,
        page,
        info,
        transform: renderTransform,
        cameraViewport: cameraViewport.unbake(
          rendererStates: allRendererStates,
          unbakedElements: visibleElements
              .where((e) => e.layer != null && belowLayers.contains(e.layer))
              .toList(),
          visibleElements: visibleElements,
        ),
        renderBackground: false,
        renderBaked: false,
        invisibleLayers: invisibleLayers,
      ).paint(belowLayerCanvas, size);
      ViewPainter(
        document,
        page,
        info,
        transform: renderTransform,
        cameraViewport: cameraViewport.unbake(
          rendererStates: allRendererStates,
          unbakedElements: visibleElements
              .where((e) => e.layer != null && aboveLayers.contains(e.layer))
              .toList(),
          visibleElements: visibleElements,
        ),
        renderBackground: false,
        renderBaked: false,
        invisibleLayers: invisibleLayers,
      ).paint(aboveLayerCanvas, size);

      final belowPicture = belowLayerRecorder.endRecording();
      final abovePicture = aboveLayerRecorder.endRecording();
      try {
        final result = await Future.wait([
          belowPicture.toImage(imageWidth, imageHeight),
          abovePicture.toImage(imageWidth, imageHeight),
        ]);
        belowLayerImage = result[0];
        aboveLayerImage = result[1];
      } finally {
        belowPicture.dispose();
        abovePicture.dispose();
      }
    }

    final bakedElementsSet = cameraViewport.bakedElements
        .map((e) => e.element)
        .toSet();
    final unbakedElementsSet = cameraViewport.unbakedElements
        .map((e) => e.element)
        .toSet();

    final newlyUnbaked =
        (reset
                ? rendererCubit.renderers
                : rendererCubit.state.cameraViewport.unbakedElements)
            .where(
              (element) =>
                  !bakedElementsSet.contains(element.element) &&
                  !unbakedElementsSet.contains(element.element) &&
                  !visibleElementsSet.contains(element),
            )
            .toList();

    if (controller.isClosed) return;

    // If state changed while baking (e.g. fast move submitted a newer viewport),
    // this bake output is stale and must not overwrite the latest viewport.
    final currentViewport = rendererCubit.state.cameraViewport;
    final currentTransform = transformCubit.state;
    if (!identical(currentViewport, startViewport) ||
        currentTransform != startTransform) {
      newImage.dispose();
      final oldBelow = startViewport.belowLayerImage;
      final oldAbove = startViewport.aboveLayerImage;
      if (!identical(belowLayerImage, oldBelow)) {
        belowLayerImage?.dispose();
      }
      if (!identical(aboveLayerImage, oldAbove)) {
        aboveLayerImage?.dispose();
      }
      Future.microtask(() async {
        final latestState = controller.activeDocumentState;
        if (latestState == null) return;
        await bake(
          controller,
          latestState,
          viewportSize: viewportSize,
          pixelRatio: pixelRatio,
          reset: reset,
          resetAllLayers: resetAllLayers,
        );
      });
      return;
    }

    final newViewport = cameraViewport.bake(
      height: size.height,
      width: size.width,
      pixelRatio: ratio,
      resolution: resolution,
      scale: transform.size,
      x: renderTransform.position.dx,
      y: renderTransform.position.dy,
      image: newImage,
      bakedElements: renderers,
      unbakedElements: newlyUnbaked,
      visibleElements: visibleElements,
      visibleUnbakedElements: newlyUnbaked
          .where((renderer) => renderer.isVisible(rect))
          .toList(),
      belowLayerImage: belowLayerImage,
      aboveLayerImage: aboveLayerImage,
      rendererStates: allRendererStates,
      invisibleLayers: invisibleLayers,
    );
    rendererCubit.setViewport(newViewport);
  });

  Future<ui.Image?> renderImage(
    EditorController controller,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    ImageExportOptions options, {
    CameraViewport? cameraViewport,
    Set<String>? invisibleLayers,
    DocumentLoaded? docState,
  }) async {
    final rendererCubit = this;
    final realWidth = (options.width * options.quality).ceil();
    final realHeight = (options.height * options.quality).ceil();
    final realZoom = options.scale;
    if (realWidth <= 0 || realHeight <= 0) {
      return null;
    }
    final size = Size(options.width, options.height);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.scale(options.quality);
    final viewport =
        cameraViewport ??
        rendererCubit.state.cameraViewport.unbake(
          unbakedElements: rendererCubit.renderers,
        );
    final transform = CameraTransform(
      options.quality,
      Offset(options.x, options.y),
      realZoom,
    );
    final hiddenRenderers = <Renderer<PadElement>>[];
    if (docState != null) {
      final exportRect = Rect.fromLTWH(
        options.x,
        options.y,
        options.width,
        options.height,
      );
      for (final renderer in viewport.unbakedElements) {
        if (renderer.isVisible(exportRect)) {
          final wasInitialized = rendererCubit.initializedElements.contains(
            renderer,
          );
          if (!wasInitialized) {
            await renderer.onVisible(controller, docState, transform, size);
            hiddenRenderers.add(renderer);
          }
        }
      }
    }
    final painter = ViewPainter(
      document,
      page,
      info,
      renderBackground: options.renderBackground,
      invisibleLayers: invisibleLayers,
      cameraViewport: viewport,
      transform: transform,
    );
    painter.paint(canvas, size);
    for (final renderer in hiddenRenderers) {
      await renderer.onHidden(controller, docState!, transform, size);
    }
    final picture = recorder.endRecording();
    ui.Image? image;
    try {
      image = await picture.toImage(realWidth, realHeight);
    } finally {
      picture.dispose();
    }
    return image;
  }

  Future<ByteData?> render(
    EditorController controller,
    NoteData document,
    DocumentPage page,
    DocumentInfo info,
    ImageExportOptions options, {
    CameraViewport? cameraViewport,
    Set<String>? invisibleLayers,
    DocumentLoaded? docState,
  }) async {
    final image = await renderImage(
      controller,
      document,
      page,
      info,
      options,
      cameraViewport: cameraViewport,
      invisibleLayers: invisibleLayers,
      docState: docState,
    );
    ByteData? bytes;
    try {
      bytes = await image?.toByteData(format: ui.ImageByteFormat.png);
    } finally {
      image?.dispose();
    }
    return bytes;
  }

  XmlDocument renderSVG(
    NoteData document,
    DocumentPage page,
    SvgExportOptions options, {
    Set<String>? invisibleLayers,
  }) {
    final rendererCubit = this;
    final xml = XmlDocument();
    xml.createElement(
      'svg',
      attributes: {
        'xmlns': 'http://www.w3.org/2000/svg',
        'xmlns:xlink': 'http://www.w3.org/1999/xlink',
        'version': '1.1',
        'width': '${options.width}px',
        'height': '${options.height}px',
        'viewBox':
            '${options.x} ${options.y} ${options.width} ${options.height}',
      },
    );

    final rect = Rect.fromLTWH(
      options.x,
      options.y,
      options.width.toDouble(),
      options.height.toDouble(),
    );
    if (options.renderBackground) {
      for (final e in rendererCubit.state.cameraViewport.backgrounds) {
        e.buildSvg(xml, document, page, rect);
      }
    }
    for (var e in rendererCubit.renderers) {
      if ((invisibleLayers?.contains(e.layer) ?? false) || !e.isVisible(rect)) {
        continue;
      }
      e.buildSvg(xml, document, page, rect);
    }
    return xml;
  }

  Future<void> unbake(
    EditorController controller,
    DocumentLoaded blocState, {
    List<Renderer<Background>>? backgrounds,
    List<Renderer<PadElement>>? unbakedElements,
  }) async {
    final rendererCubit = this;
    final transformCubit = controller.transformCubit;
    final elementsToCheck = unbakedElements ?? rendererCubit.renderers;
    final oldViewport = rendererCubit.state.cameraViewport;
    final newViewport = oldViewport.unbake(
      unbakedElements: unbakedElements,
      visibleElements: elementsToCheck
          .where(
            (e) => e.isVisible(rendererCubit.getViewportRect(transformCubit)),
          )
          .toList(),
      backgrounds: backgrounds,
    );
    await rendererCubit.updateOnVisible(controller, newViewport, blocState);
    rendererCubit.setViewport(newViewport);
  }

  Future<void> replaceUnbaked(
    EditorController controller,
    DocumentLoaded blocState,
    List<Renderer<PadElement>> unbakedElements, {
    List<Renderer<Background>>? backgrounds,
  }) async {
    final rendererCubit = this;
    final transformCubit = controller.transformCubit;
    final visibleElements = unbakedElements
        .where(
          (e) => e.isVisible(rendererCubit.getViewportRect(transformCubit)),
        )
        .toList();
    final newViewport = rendererCubit.state.cameraViewport.replaceUnbaked(
      unbakedElements,
      visibleElements: visibleElements,
      visibleUnbakedElements: visibleElements,
      backgrounds: backgrounds,
    );
    await rendererCubit.updateOnVisible(controller, newViewport, blocState);
    rendererCubit.setViewport(newViewport);
  }

  Future<void> loadElements(
    EditorController controller,
    DocumentState docState, {
    bool reset = false,
  }) async {
    final rendererCubit = this;
    final transformCubit = controller.transformCubit;
    if (docState is! DocumentLoaded) return;
    final document = docState.data;
    final assetService = docState.assetService;
    final page = docState.page;
    var existing = rendererCubit.renderers;
    if (reset) {
      for (var e in existing) {
        rendererCubit.initializedElements.remove(e);
        e.dispose();
      }
      existing = [];
    }
    final elements = page.layers
        .where((e) => !docState.invisibleLayers.contains(e.id))
        .expand((l) => l.content.map((e) => (e, l.id)))
        .toList();
    final elementKeys = elements
        .map((element) => (element.$1, element.$2))
        .toSet();
    final existingByKey = {
      for (final renderer in existing)
        (renderer.element, renderer.layer): renderer,
    };
    final reusable = <Renderer<PadElement>>[];
    final reusableKeys = <(PadElement, String?)>{};
    for (final element in elements) {
      final key = (element.$1, element.$2);
      final renderer = existingByKey[key];
      if (renderer != null) {
        reusable.add(renderer);
        reusableKeys.add(key);
      }
    }
    final dropped = existing
        .where(
          (renderer) =>
              !elementKeys.contains((renderer.element, renderer.layer)),
        )
        .toList();
    for (final e in dropped) {
      rendererCubit.initializedElements.remove(e);
      e.dispose();
    }
    final newRenderers = elements
        .where((e) => !reusableKeys.contains((e.$1, e.$2)))
        .map((e) => Renderer.fromInstance(e.$1, e.$2))
        .toList();
    await Future.wait(
      newRenderers.map(
        (e) async =>
            await e.setup(transformCubit, document, assetService, page),
      ),
    );
    // Build layer index map for O(1) lookups instead of O(n) indexOf calls
    final layersList = page.layers.map((e) => e.id).toList();
    final layerIndexMap = <String?, int>{};
    for (var i = 0; i < layersList.length; i++) {
      layerIndexMap[layersList[i]] = i;
    }

    // Build element index map for O(1) lookups
    final elementIndexMap = <PadElement, int>{};
    for (var i = 0; i < elements.length; i++) {
      elementIndexMap[elements[i].$1] = i;
    }

    final combined = [...reusable, ...newRenderers]
      ..sort((a, b) {
        final layerA = layerIndexMap[a.layer] ?? layersList.length;
        final layerB = layerIndexMap[b.layer] ?? layersList.length;
        if (layerA != layerB) return layerA.compareTo(layerB);
        final indexA = elementIndexMap[a.element] ?? -1;
        final indexB = elementIndexMap[b.element] ?? -1;
        return indexA.compareTo(indexB);
      });
    final backgrounds = page.backgrounds.map(Renderer.fromInstance).toList();
    await Future.wait(
      backgrounds.map(
        (e) async =>
            await e.setup(transformCubit, document, assetService, page),
      ),
    );
    final rect = rendererCubit.getViewportRect(transformCubit);
    final visibleElements = combined.where((e) => e.isVisible(rect)).toList();
    final oldViewport = rendererCubit.state.cameraViewport;
    final newViewport = oldViewport.unbake(
      unbakedElements: combined,
      visibleElements: visibleElements,
      backgrounds: backgrounds,
    );
    await rendererCubit.updateOnVisible(controller, newViewport, docState);
    controller.saveCubit.setSaveState(
      location:
          controller.saveCubit.state.embedding?.location ??
          controller.saveCubit.state.location,
    );
    rendererCubit.setViewport(newViewport);
  }

  Future<void> addUnbaked(
    EditorController controller,
    DocumentLoaded blocState,
    List<Renderer<PadElement>> unbakedElements, [
    List<Renderer<PadElement>>? visibleElements,
  ]) async {
    final rendererCubit = this;
    final transformCubit = controller.transformCubit;
    final rect = rendererCubit.getViewportRect(transformCubit);
    visibleElements ??= unbakedElements
        .where((e) => e.isVisible(rect))
        .toList();
    final nextUnbaked = [
      ...rendererCubit.state.cameraViewport.unbakedElements,
      ...unbakedElements,
    ];
    final newViewport = rendererCubit.state.cameraViewport.withUnbaked(
      nextUnbaked,
      visibleElements: [
        ...rendererCubit.state.cameraViewport.visibleElements,
        ...visibleElements,
      ],
      visibleUnbakedElements: [
        ...rendererCubit.state.cameraViewport.visibleUnbakedElements,
        ...visibleElements,
      ],
    );
    await rendererCubit.updateOnVisible(controller, newViewport, blocState);
    rendererCubit.setViewport(newViewport);
  }

  Future<Uint8List?> renderPDF(
    EditorController controller,
    DocumentLoaded docState, {
    required List<AreaPreset> areas,
    bool renderBackground = true,
    void Function(double progress)? onProgress,
    Set<String>? invisibleLayers,
  }) async {
    final transformCubit = controller.transformCubit;
    var name = docState.metadata.name;
    if (name.isEmpty) {
      name = 'document';
    }
    final pdf = await PdfDocument.createNew(sourceName: '$name.pdf');
    final document = docState.data;
    final info = docState.info;
    final pages = <PdfPage>[];
    final documents = <PdfDocument>[];
    for (var i = 0; i < areas.length; i++) {
      onProgress?.call(i / areas.length);
      final preset = areas[i];
      final areaName = preset.name;
      final quality = preset.quality;
      final currentOpened = docState.pageName == preset.page;
      final page = currentOpened
          ? docState.page
          : document.getPage(preset.page);
      final area = preset.area ?? page?.getAreaByName(areaName);
      if (area == null || page == null) {
        continue;
      }
      final image = await renderImage(
        controller,
        document,
        page,
        info,
        ImageExportOptions(
          width: area.width,
          height: area.height,
          x: area.position.x,
          y: area.position.y,
          quality: quality,
          renderBackground: renderBackground,
        ),
        cameraViewport: await CameraViewport.build(
          transformCubit,
          document,
          docState.assetService,
          page,
        ),
        docState: docState,
        invisibleLayers: invisibleLayers ?? docState.invisibleLayers,
      );
      if (image == null) continue;
      final imgImage = await convertFlutterUiToImage(image);
      final pdfImage = await compute(
        (image) => img.JpegEncoder().encode(image),
        imgImage,
      );
      final imageDoc = await PdfDocument.createFromJpegData(
        pdfImage,
        width: area.width,
        height: area.height,
        sourceName: '$name-$areaName.jpg',
      );
      pages.addAll(imageDoc.pages);
      image.dispose();
      documents.add(imageDoc);
    }
    onProgress?.call(1.0);
    pdf.pages = pages;
    final bytes = await pdf.encodePdf();
    pdf.dispose();
    for (final doc in documents) {
      doc.dispose();
    }
    return bytes;
  }

  Future<void> disposeRuntime() async {
    delayedBakeRunner.cancel();
    await delayedBakeRunner.disposeAndWait();
    initializedElements.clear();
    state.cameraViewport.disposeImages();
    for (final renderer in renderers) {
      renderer.dispose();
    }
  }
}

@Freezed(equal: false)
sealed class ToolRuntimeState with _$ToolRuntimeState {
  const ToolRuntimeState._();

  const factory ToolRuntimeState({
    int? index,
    required Handler handler,
    Handler<Tool>? temporaryHandler,
    int? temporaryIndex,
    @Default([]) List<Renderer> foregrounds,
    Selection? selection,
    @Default(false) bool pinned,
    List<Renderer>? temporaryForegrounds,
    @Default({}) Map<int, Handler<Tool>> toggleableHandlers,
    @Default([]) List<Renderer> networkingForegrounds,
    @Default({}) Map<int, List<Renderer>> toggleableForegrounds,
    @Default(MouseCursor.defer) MouseCursor cursor,
    MouseCursor? temporaryCursor,
    @Default(TemporaryState.allowClick) TemporaryState temporaryState,
    PreferredSizeWidget? toolbar,
    PreferredSizeWidget? temporaryToolbar,
  }) = _ToolRuntimeState;

  MouseCursor get currentCursor => temporaryCursor ?? cursor;

  List<Renderer> getAllForegrounds([bool networking = true]) => [
    ...foregrounds,
    ...?temporaryForegrounds,
    ...toggleableForegrounds.values.expand((e) => e),
    if (networking) ...networkingForegrounds,
  ];
}

class ToolCubit extends Cubit<ToolRuntimeState> {
  ToolCubit([ToolRuntimeState? initial])
    : super(initial ?? ToolRuntimeState(handler: HandHandler()));

  final foregroundRefreshRunner = CoalescedAsyncRunner(delay: Duration.zero);

  void replace(ToolRuntimeState state) => emit(state);

  Handler getHandler({bool disableTemporary = false, bool editable = true}) {
    if (!editable) return HandHandler();
    return disableTemporary
        ? state.handler
        : state.temporaryHandler ?? state.handler;
  }

  T? fetchHandler<T extends Handler>({
    bool disableTemporary = false,
    bool editable = true,
  }) {
    final handler = getHandler(
      disableTemporary: disableTemporary,
      editable: editable,
    );
    if (handler is T) return handler;
    return null;
  }

  void setActiveTool({
    required int? index,
    required Handler handler,
    required MouseCursor cursor,
    required List<Renderer> foregrounds,
    required PreferredSizeWidget? toolbar,
    required Map<String, RendererState> rendererStates,
  }) => emit(
    state.copyWith(
      index: index,
      handler: handler,
      cursor: cursor,
      foregrounds: foregrounds,
      toolbar: toolbar,
      temporaryForegrounds: null,
      temporaryHandler: null,
      temporaryToolbar: null,
      temporaryCursor: null,
      temporaryIndex: null,
    ),
  );

  void setTemporaryTool({
    required Handler<Tool>? handler,
    required int? index,
    required List<Renderer>? foregrounds,
    required PreferredSizeWidget? toolbar,
    required MouseCursor? cursor,
    required Map<String, RendererState>? rendererStates,
    TemporaryState? temporaryState,
  }) => emit(
    state.copyWith(
      temporaryHandler: handler,
      temporaryIndex: index,
      temporaryForegrounds: foregrounds,
      temporaryToolbar: toolbar,
      temporaryCursor: cursor,
      temporaryState: temporaryState ?? state.temporaryState,
    ),
  );

  void setToggleable({
    Map<int, Handler<Tool>>? handlers,
    Map<int, List<Renderer>>? foregrounds,
  }) => emit(
    state.copyWith(
      toggleableHandlers: handlers ?? state.toggleableHandlers,
      toggleableForegrounds: foregrounds ?? state.toggleableForegrounds,
    ),
  );

  void setForegrounds({
    List<Renderer>? foregrounds,
    List<Renderer>? temporaryForegrounds,
    Map<int, List<Renderer>>? toggleableForegrounds,
    List<Renderer>? networkingForegrounds,
    MouseCursor? cursor,
    MouseCursor? temporaryCursor,
    Map<String, RendererState>? rendererStates,
    Map<String, RendererState>? temporaryRendererStates,
  }) => emit(
    state.copyWith(
      foregrounds: foregrounds ?? state.foregrounds,
      temporaryForegrounds: temporaryForegrounds ?? state.temporaryForegrounds,
      toggleableForegrounds:
          toggleableForegrounds ?? state.toggleableForegrounds,
      networkingForegrounds:
          networkingForegrounds ?? state.networkingForegrounds,
      cursor: cursor ?? state.cursor,
      temporaryCursor: temporaryCursor ?? state.temporaryCursor,
    ),
  );

  void setToolbar({
    PreferredSizeWidget? toolbar,
    PreferredSizeWidget? temporaryToolbar,
  }) => emit(
    state.copyWith(
      toolbar: toolbar ?? state.toolbar,
      temporaryToolbar: temporaryToolbar ?? state.temporaryToolbar,
    ),
  );

  void setCursor(MouseCursor cursor) {
    if (state.cursor != cursor) emit(state.copyWith(cursor: cursor));
  }

  void setIndex(int? index) => emit(state.copyWith(index: index));

  void setSelection(Selection? selection) =>
      emit(state.copyWith(selection: selection));

  void insertSelection(dynamic selected, [bool toggle = true]) {
    final selection = state.selection;
    if (selection == null) {
      setSelection(Selection.from(selected));
      return;
    }
    Selection? next;
    if (selection.selected.contains(selected) && toggle) {
      if (selection.selected.length != 1) {
        next = selection.remove(selected);
      }
    } else {
      next = selection.insert(selected);
    }
    setSelection(next);
  }

  void changeSelection(dynamic selected, [bool toggle = true]) {
    Selection? selection;
    if (selected is Selection?) {
      selection = selected;
    } else if (!toggle ||
        !(state.selection?.selected.contains(selected) ?? false)) {
      selection = Selection.from(selected);
    }
    setSelection(selection);
  }

  void removeSelection(List selected) {
    Selection? selection = state.selection;
    if (selection == null) return;
    for (final s in selected) {
      selection = selection?.remove(s);
    }
    setSelection(selection);
  }

  void resetSelection({bool force = false}) {
    if (force || !state.pinned) emit(state.copyWith(selection: null));
  }

  Tool? getTool(DocumentInfo info) {
    final index = state.index;
    if (index == null ||
        info.tools.isEmpty ||
        index < 0 ||
        index >= info.tools.length) {
      return null;
    }
    return info.tools[index];
  }

  T? fetchTool<T extends Tool>(DocumentInfo info) {
    final tool = getTool(info);
    if (tool is T) return tool;
    return null;
  }

  void togglePin() => emit(state.copyWith(pinned: !state.pinned));

  void setTemporaryState(TemporaryState temporaryState) =>
      emit(state.copyWith(temporaryState: temporaryState));

  void resetRuntime() => emit(ToolRuntimeState(handler: HandHandler()));

  Future<void> resetInput(dynamic bloc, EditorInputCubit inputCubit) async {
    await state.handler.resetInput(bloc);
    inputCubit.resetInputState();
  }

  void changeTemporaryHandlerMove(RendererCubit rendererCubit) {
    setTemporaryTool(
      handler: HandHandler(),
      index: null,
      foregrounds: null,
      toolbar: null,
      cursor: null,
      rendererStates: null,
    );
    rendererCubit.setRendererStates(temporaryRendererStates: const {});
  }

  Future<void> updateHandler(
    DocumentBloc bloc,
    RendererCubit rendererCubit,
    Handler handler,
  ) async {
    replace(
      state.copyWith(
        handler: handler,
        cursor: handler.cursor ?? MouseCursor.defer,
        toolbar: await handler.getToolbar(bloc),
      ),
    );
    rendererCubit.setRendererStates(rendererStates: handler.rendererStates);
  }

  Future<void> updateTool(
    EditorController controller,
    DocumentBloc bloc,
    Tool tool,
  ) async {
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;
    state.handler.dispose(bloc);
    final handler = Handler.fromTool(tool);
    for (final renderer in state.foregrounds) {
      renderer.dispose();
    }
    final foregrounds = handler.createForegrounds(
      controller,
      docState.data,
      docState.page,
      docState.info,
      docState.currentArea,
    );
    if (handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async => await e.setup(
            controller.transformCubit,
            docState.data,
            docState.assetService,
            docState.page,
          ),
        ),
      );
    }
    setActiveTool(
      index: state.index,
      handler: handler,
      cursor: handler.cursor ?? MouseCursor.defer,
      foregrounds: foregrounds,
      toolbar: await handler.getToolbar(bloc),
      rendererStates: handler.rendererStates,
    );
    controller.rendererCubit.setRendererStates(
      rendererStates: handler.rendererStates,
    );
  }

  Future<void> updateTemporaryTool(
    EditorController controller,
    DocumentBloc bloc,
    Tool tool,
  ) async {
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;
    state.temporaryHandler?.dispose(bloc);
    final handler = Handler.fromTool(tool);
    for (final renderer in state.temporaryForegrounds ?? const <Renderer>[]) {
      renderer.dispose();
    }
    final foregrounds = handler.createForegrounds(
      controller,
      docState.data,
      docState.page,
      docState.info,
      docState.currentArea,
    );
    if (handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async => await e.setup(
            controller.transformCubit,
            docState.data,
            docState.assetService,
            docState.page,
          ),
        ),
      );
    }
    setTemporaryTool(
      handler: handler,
      index: state.temporaryIndex,
      foregrounds: foregrounds,
      toolbar: await handler.getToolbar(bloc),
      cursor: handler.cursor,
      rendererStates: handler.rendererStates,
    );
    controller.rendererCubit.setRendererStates(
      temporaryRendererStates: handler.rendererStates,
    );
  }

  Future<void> updateTogglingTools(
    EditorController controller,
    DocumentBloc bloc,
    List<Tool> tools,
  ) async {
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return;
    final newHandlers = Map<int, Handler<Tool>>.from(state.toggleableHandlers);
    final newForegrounds = Map<int, List<Renderer>>.from(
      state.toggleableForegrounds,
    );
    final currentTools = blocState.info.tools;
    for (final tool in tools) {
      if (tool.id == null) continue;
      final index = currentTools.indexWhere((element) => element.id == tool.id);
      if (index == -1) continue;
      final old = state.toggleableHandlers[index];
      if (old == null || old.data == tool) continue;
      old.dispose(bloc);
      for (final renderer in state.toggleableForegrounds[index] ?? []) {
        renderer.dispose();
      }
      final handler = Handler.fromTool(tool);
      final foregrounds = handler.createForegrounds(
        controller,
        blocState.data,
        blocState.page,
        blocState.info,
        blocState.currentArea,
      );
      if (handler.setupForegrounds) {
        await Future.wait(
          foregrounds.map(
            (e) async => await e.setup(
              controller.transformCubit,
              blocState.data,
              blocState.assetService,
              blocState.page,
            ),
          ),
        );
      }
      newHandlers[index] = handler;
      newForegrounds[index] = foregrounds;
    }
    setToggleable(handlers: newHandlers, foregrounds: newForegrounds);
  }

  void disposeForegrounds() {
    for (final r in state.foregrounds) {
      r.dispose();
    }
  }

  void disposeTemporaryForegrounds() {
    for (final r in state.temporaryForegrounds ?? []) {
      r.dispose();
    }
  }

  void disposeNetworkingForegrounds() {
    for (final r in state.networkingForegrounds) {
      r.dispose();
    }
  }

  void disposeToggleableForegrounds() {
    for (final r in state.toggleableForegrounds.values.expand((e) => e)) {
      r.dispose();
    }
  }

  void disposeAllForegrounds() {
    disposeForegrounds();
    disposeTemporaryForegrounds();
    disposeNetworkingForegrounds();
    disposeToggleableForegrounds();
  }

  R useHandler<R>(
    DocumentBloc bloc,
    int index,
    R Function(Handler<Tool> handler) callback, {
    required bool editable,
  }) {
    Handler<Tool>? handler;
    bool needsDispose = false;
    if (state.index == index) {
      handler = fetchHandler<Handler<Tool>>(
        disableTemporary: true,
        editable: editable,
      );
    } else if (state.toggleableHandlers.containsKey(index)) {
      handler = state.toggleableHandlers[index];
    }
    if (handler == null) {
      List<Tool> tools = const [];
      final blocState = bloc.state;
      if (blocState is DocumentLoaded) tools = blocState.info.tools;
      final tool = tools.elementAtOrNull(index) ?? HandTool();
      handler = Handler.fromTool(tool);
      needsDispose = true;
    }
    final result = callback(handler);
    if (needsDispose) {
      if (result is Future) {
        result.then((value) => handler?.dispose(bloc));
      } else {
        handler.dispose(bloc);
      }
    }
    return result;
  }

  Future<Handler?> changeTool(
    EditorController controller,
    DocumentBloc bloc, {
    int? index,
    BuildContext? context,
    Handler<Tool>? handler,
    bool allowBake = true,
  }) async {
    talker.verbose('Changing tool to index: $index');
    await resetInput(bloc, controller.inputCubit);
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    if (controller.saveCubit.state.embedding?.editable == false) {
      return null;
    }
    final document = blocState.data;
    final info = blocState.info;
    index ??= state.index ?? 0;
    if (handler == null && (index < 0 || index >= info.tools.length)) {
      return null;
    }
    handler ??= Handler.fromTool(info.tools[index]);
    var selectState = SelectState.normal;
    if (context != null) {
      selectState = await handler.onSelected(context);
    }
    if (selectState != SelectState.none) {
      state.handler.dispose(bloc);
      state.temporaryHandler?.dispose(bloc);
      disposeTemporaryForegrounds();
      disposeForegrounds();
      final foregrounds = handler.createForegrounds(
        controller,
        document,
        blocState.page,
        info,
        blocState.currentArea,
      );
      if (handler.setupForegrounds) {
        await Future.wait(
          foregrounds.map(
            (e) async => await e.setup(
              controller.transformCubit,
              document,
              blocState.assetService,
              blocState.page,
            ),
          ),
        );
      }
      if (selectState == SelectState.normal) {
        controller.editorSessionCubit?.updateSelectedTool(handler.data, index);
        setActiveTool(
          index: index,
          handler: handler,
          cursor: handler.cursor ?? MouseCursor.defer,
          foregrounds: foregrounds,
          toolbar: await handler.getToolbar(bloc),
          rendererStates: handler.rendererStates,
        );
        controller.rendererCubit.setRendererStates(
          rendererStates: handler.rendererStates,
          temporaryRendererStates: const {},
        );
        if (allowBake) {
          await controller.rendererCubit.bake(controller, blocState);
        }
      } else {
        if (isHandlerEnabled(index)) {
          disableHandler(bloc, index);
        } else {
          setToggleable(
            handlers: {...state.toggleableHandlers, index: handler},
            foregrounds: {...state.toggleableForegrounds, index: foregrounds},
          );
        }
      }
    }
    return handler;
  }

  Future<void> toggleHandler(
    EditorController controller,
    DocumentBloc bloc,
    int index,
  ) async {
    if (state.toggleableHandlers.containsKey(index)) {
      disableHandler(bloc, index);
    } else {
      await enableHandler(controller, bloc, index);
    }
  }

  Future<Handler?> enableHandler(
    EditorController controller,
    DocumentBloc bloc,
    int index,
  ) async {
    final blocState = bloc.state;
    if (blocState is! DocumentLoaded) return null;
    if (index < 0 || index >= blocState.info.tools.length) {
      return null;
    }
    final tool = blocState.info.tools[index];
    final handler = Handler.fromTool(tool);
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final currentArea = blocState.currentArea;
    final foregrounds = handler.createForegrounds(
      controller,
      document,
      page,
      info,
      currentArea,
    );
    if (handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async => await e.setup(
            controller.transformCubit,
            document,
            blocState.assetService,
            page,
          ),
        ),
      );
    }
    setToggleable(
      handlers: Map.from(state.toggleableHandlers)..[index] = handler,
      foregrounds: Map.from(state.toggleableForegrounds)..[index] = foregrounds,
    );
    return handler;
  }

  bool disableHandler(DocumentBloc bloc, int index) {
    final handler = state.toggleableHandlers[index];
    if (handler == null) {
      return false;
    }
    handler.dispose(bloc);
    final foregrounds = Map<int, List<Renderer>>.from(
      state.toggleableForegrounds,
    );
    final current = foregrounds.remove(index);
    for (final r in current ?? []) {
      r.dispose();
    }
    setToggleable(
      handlers: Map.from(state.toggleableHandlers)..remove(index),
      foregrounds: foregrounds,
    );
    return true;
  }

  bool isHandlerEnabled(int index) =>
      state.toggleableHandlers.containsKey(index);

  void reset(EditorController controller, DocumentBloc bloc) {
    for (final r in controller.rendererCubit.renderers) {
      r.dispose();
    }
    controller.rendererCubit.initializedElements.clear();
    state.handler.dispose(bloc);
    state.temporaryHandler?.dispose(bloc);
    for (var e in state.toggleableHandlers.values) {
      e.dispose(bloc);
    }
    disposeAllForegrounds();
    resetRuntime();
    controller.rendererCubit.replace(const RendererRuntimeState());
  }

  Future<Handler?> changeTemporaryHandlerIndex(
    BuildContext context,
    EditorController controller,
    int index, {
    DocumentBloc? bloc,
    TemporaryState temporaryState = TemporaryState.allowClick,
    bool force = false,
  }) async {
    bloc ??= context.read<DocumentBloc>();
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    if (index < 0 || index >= blocState.info.tools.length) {
      return null;
    }
    final tool = blocState.info.tools[index];
    final temporaryHandler = state.temporaryHandler;
    if (!force && index == state.temporaryIndex && temporaryHandler != null) {
      return temporaryHandler;
    }
    return changeTemporaryHandler(
      context,
      controller,
      tool,
      bloc: bloc,
      temporaryState: temporaryState,
      index: index,
    );
  }

  Future<Handler<T>?> changeTemporaryHandler<T extends Tool>(
    BuildContext context,
    EditorController controller,
    T tool, {
    DocumentBloc? bloc,
    int? index,
    TemporaryState temporaryState = TemporaryState.allowClick,
  }) async {
    bloc ??= context.read<DocumentBloc>();
    final handler = Handler.fromTool(tool);
    final blocState = bloc.state;
    if (blocState is! DocumentLoadSuccess) return null;
    final document = blocState.data;
    final page = blocState.page;
    final currentArea = blocState.currentArea;
    state.temporaryHandler?.dispose(bloc);
    final selectState = await handler.onSelected(context);

    if (selectState == SelectState.normal) {
      disposeTemporaryForegrounds();
      final temporaryForegrounds = handler.createForegrounds(
        controller,
        document,
        page,
        blocState.info,
        currentArea,
      );
      if (handler.setupForegrounds) {
        await Future.wait(
          temporaryForegrounds.map(
            (e) async => await e.setup(
              controller.transformCubit,
              document,
              blocState.assetService,
              page,
            ),
          ),
        );
      }
      setTemporaryTool(
        handler: handler,
        index: index,
        foregrounds: temporaryForegrounds,
        toolbar: await handler.getToolbar(bloc),
        cursor: handler.cursor,
        rendererStates: handler.rendererStates,
        temporaryState: temporaryState,
      );
      controller.rendererCubit.setRendererStates(
        temporaryRendererStates: handler.rendererStates,
      );
      await controller.rendererCubit.bake(controller, blocState);
    } else if (selectState == SelectState.toggle && index != null) {
      await toggleHandler(controller, bloc, index);
    }
    return handler;
  }

  void resetReleaseHandler(DocumentBloc bloc, [RendererCubit? rendererCubit]) {
    if (state.temporaryState == TemporaryState.removeAfterRelease) {
      resetTemporaryHandler(bloc, true, rendererCubit);
    }
  }

  void resetDownHandler(DocumentBloc bloc, [RendererCubit? rendererCubit]) {
    resetTemporaryHandler(bloc, false, rendererCubit);
  }

  void resetTemporaryHandler(
    DocumentBloc bloc, [
    bool force = false,
    RendererCubit? rendererCubit,
  ]) {
    if (state.temporaryHandler == null) {
      return;
    }
    if (!force && state.temporaryState != TemporaryState.removeAfterClick) {
      if (state.temporaryState == TemporaryState.allowClick) {
        setTemporaryState(TemporaryState.removeAfterClick);
      }
      return;
    }
    state.temporaryHandler?.dispose(bloc);
    disposeTemporaryForegrounds();
    setTemporaryTool(
      handler: null,
      index: null,
      foregrounds: null,
      toolbar: null,
      cursor: null,
      rendererStates: null,
    );
    rendererCubit?.setRendererStates(temporaryRendererStates: const {});
  }

  Future<void> refresh(
    EditorController controller,
    DocumentLoaded blocState, {
    bool allowBake = true,
  }) async {
    talker.verbose('Refreshing tools');
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final assetService = blocState.assetService;
    final currentArea = blocState.currentArea;
    const mapEq = MapEquality();
    if (!controller.isClosed) {
      disposeAllForegrounds();
      final temporaryForegrounds = state.temporaryHandler?.createForegrounds(
        controller,
        document,
        page,
        info,
        currentArea,
      );
      if (temporaryForegrounds != null &&
          state.temporaryHandler?.setupForegrounds == true) {
        await Future.wait(
          temporaryForegrounds.map(
            (e) async => await e.setup(
              controller.transformCubit,
              document,
              assetService,
              page,
            ),
          ),
        );
      }
      final foregrounds = state.handler.createForegrounds(
        controller,
        document,
        page,
        info,
        currentArea,
      );
      if (state.handler.setupForegrounds) {
        await Future.wait(
          foregrounds.map(
            (e) async => await e.setup(
              controller.transformCubit,
              document,
              assetService,
              page,
            ),
          ),
        );
      }
      final toggleableForegrounds = <int, List<Renderer>>{};
      for (final entry in state.toggleableHandlers.entries) {
        final handler = entry.value;
        final index = entry.key;
        final foregrounds = handler.createForegrounds(
          controller,
          document,
          page,
          info,
          currentArea,
        );
        if (handler.setupForegrounds) {
          await Future.wait(
            foregrounds.map(
              (e) async => await e.setup(
                controller.transformCubit,
                document,
                assetService,
                page,
              ),
            ),
          );
        }
        toggleableForegrounds[index] = foregrounds;
      }
      final rendererStates = state.handler.rendererStates;
      final temporaryRendererStates = state.temporaryHandler?.rendererStates;
      final statesChanged = !mapEq.equals(
        controller.rendererCubit.state.rendererStates,
        rendererStates,
      );
      final temporaryStatesChanged = !mapEq.equals(
        controller.rendererCubit.state.temporaryRendererStates,
        temporaryRendererStates,
      );
      final shouldBake = statesChanged || temporaryStatesChanged;
      setForegrounds(
        temporaryForegrounds: temporaryForegrounds,
        toggleableForegrounds: toggleableForegrounds,
        foregrounds: foregrounds,
        cursor: state.handler.cursor ?? MouseCursor.defer,
        temporaryCursor: state.temporaryHandler?.cursor,
      );
      controller.rendererCubit.setRendererStates(
        rendererStates: statesChanged
            ? rendererStates
            : controller.rendererCubit.state.rendererStates,
        temporaryRendererStates: temporaryStatesChanged
            ? temporaryRendererStates
            : controller.rendererCubit.state.temporaryRendererStates,
      );
      if (allowBake) {
        if (shouldBake) {
          return controller.rendererCubit.bake(
            controller,
            blocState,
            reset: true,
          );
        } else if (!controller.rendererCubit.state.cameraViewport.baked) {
          return controller.rendererCubit.delayedBake(controller, blocState);
        }
      }
    }
  }

  Future<void> refreshToolbar(DocumentBloc bloc) async {
    final toolbar = await state.handler.getToolbar(bloc);
    final temporaryToolbar = await state.temporaryHandler?.getToolbar(bloc);
    setToolbar(toolbar: toolbar, temporaryToolbar: temporaryToolbar);
  }

  Future<void> refreshForegrounds(
    EditorController controller,
    DocumentLoaded blocState,
  ) => foregroundRefreshRunner.schedule(
    () => _refreshForegrounds(controller, blocState),
  );

  Future<void> _refreshForegrounds(
    EditorController controller,
    DocumentLoaded blocState,
  ) async {
    if (controller.isClosed) return;
    final document = blocState.data;
    final page = blocState.page;
    final info = blocState.info;
    final assetService = blocState.assetService;
    final currentArea = blocState.currentArea;

    disposeForegrounds();
    disposeTemporaryForegrounds();

    final temporaryForegrounds = state.temporaryHandler?.createForegrounds(
      controller,
      document,
      page,
      info,
      currentArea,
    );
    if (temporaryForegrounds != null &&
        temporaryForegrounds.isNotEmpty &&
        state.temporaryHandler?.setupForegrounds == true) {
      await Future.wait(
        temporaryForegrounds.map(
          (e) async => await e.setup(
            controller.transformCubit,
            document,
            assetService,
            page,
          ),
        ),
      );
    }

    final foregrounds = state.handler.createForegrounds(
      controller,
      document,
      page,
      info,
      currentArea,
    );
    if (foregrounds.isNotEmpty && state.handler.setupForegrounds) {
      await Future.wait(
        foregrounds.map(
          (e) async => await e.setup(
            controller.transformCubit,
            document,
            assetService,
            page,
          ),
        ),
      );
    }

    const mapEq = MapEquality<String, RendererState>();
    final rendererStates = state.handler.rendererStates;
    final temporaryRendererStates = state.temporaryHandler?.rendererStates;
    final statesChanged = !mapEq.equals(
      controller.rendererCubit.state.rendererStates,
      rendererStates,
    );
    final temporaryStatesChanged = !mapEq.equals(
      controller.rendererCubit.state.temporaryRendererStates,
      temporaryRendererStates,
    );

    setForegrounds(
      foregrounds: foregrounds,
      temporaryForegrounds: temporaryForegrounds,
      cursor: state.handler.cursor ?? MouseCursor.defer,
      temporaryCursor: state.temporaryHandler?.cursor,
    );
    controller.rendererCubit.setRendererStates(
      rendererStates: statesChanged
          ? rendererStates
          : controller.rendererCubit.state.rendererStates,
      temporaryRendererStates: temporaryStatesChanged
          ? temporaryRendererStates
          : controller.rendererCubit.state.temporaryRendererStates,
    );

    if (statesChanged || temporaryStatesChanged) {
      await controller.rendererCubit.bake(controller, blocState, reset: true);
    }
  }

  void updateIndex(EditorController controller, DocumentBloc bloc) {
    final docState = bloc.state;
    if (docState is! DocumentLoadSuccess) return;
    final info = docState.info;
    final index = info.tools.indexOf(state.handler.data);
    if (index < 0) {
      changeTool(controller, bloc, index: state.index ?? 0);
    }
    if (index == state.index) {
      return;
    }
    setIndex(index);
    final selection = state.selection;
    if (selection?.selected.contains(state.handler.data) ?? false) {
      resetSelection();
    }
  }

  Future<void> disposeRuntime(dynamic bloc) async {
    state.handler.dispose(bloc);
    state.temporaryHandler?.dispose(bloc);
    for (final handler in state.toggleableHandlers.values) {
      handler.dispose(bloc);
    }
    for (final renderer in state.getAllForegrounds()) {
      renderer.dispose();
    }
    foregroundRefreshRunner.cancel();
    await foregroundRefreshRunner.disposeAndWait();
  }
}

@freezed
sealed class EditorInputState with _$EditorInputState {
  const factory EditorInputState({
    Offset? lastPosition,
    @Default([]) List<int> pointers,
    int? buttons,
    @Default(false) bool penDetected,
    @Default(false) bool sessionPenOnlyInput,
    @Default(HideState.visible) HideState hideUi,
  }) = _EditorInputState;
}

class EditorInputCubit extends Cubit<EditorInputState> {
  EditorInputCubit(
    this.settingsCubit, [
    super.initial = const EditorInputState(),
  ]);

  final SettingsCubit settingsCubit;

  void replace(EditorInputState state) => emit(state);

  void setPenDetected(bool detected, {bool enableSessionPenOnly = false}) {
    if (state.penDetected == detected &&
        (!enableSessionPenOnly || state.sessionPenOnlyInput)) {
      return;
    }
    emit(
      state.copyWith(
        penDetected: detected,
        sessionPenOnlyInput: enableSessionPenOnly
            ? true
            : state.sessionPenOnlyInput,
      ),
    );
  }

  bool get effectivePenOnlyInput {
    final setting = settingsCubit.state.penOnlyInput;
    if (setting != null) return setting;
    return state.sessionPenOnlyInput;
  }

  bool get moveEnabled =>
      (settingsCubit.state.inputGestures && state.pointers.length > 1) &&
      settingsCubit.state.moveOnGesture;

  void detectPen(bool detected) {
    if (state.penDetected == detected) return;
    setPenDetected(
      detected,
      enableSessionPenOnly:
          detected &&
          settingsCubit.state.penOnlyInput == null &&
          !state.sessionPenOnlyInput,
    );
  }

  void setSessionPenOnlyInput(bool value) {
    if (state.sessionPenOnlyInput != value) {
      emit(state.copyWith(sessionPenOnlyInput: value));
    }
  }

  void updateLastPosition(Offset position) {
    final lastPos = state.lastPosition;
    if (lastPos != null) {
      final dx = (position.dx - lastPos.dx).abs();
      final dy = (position.dy - lastPos.dy).abs();
      if (dx < 1 && dy < 1) return;
    }
    emit(state.copyWith(lastPosition: position));
  }

  void addPointer(int pointer) {
    if (!state.pointers.contains(pointer)) {
      emit(state.copyWith(pointers: [...state.pointers, pointer]));
    }
  }

  void removePointer(int pointer) {
    if (state.pointers.contains(pointer)) {
      emit(
        state.copyWith(
          pointers: state.pointers.where((p) => p != pointer).toList(),
        ),
      );
    }
  }

  void setButtons(int buttons) => emit(state.copyWith(buttons: buttons));

  void removeButtons() => emit(state.copyWith(buttons: null));

  void resetInputState() => emit(state.copyWith(buttons: null, pointers: []));

  void toggleKeyboardHideUI() => emit(
    state.copyWith(
      hideUi: state.hideUi == HideState.visible
          ? HideState.keyboard
          : HideState.visible,
    ),
  );

  void enterTouchHideUI() => emit(state.copyWith(hideUi: HideState.touch));

  void exitHideUI() => emit(state.copyWith(hideUi: HideState.visible));
}

@freezed
sealed class DocumentSaveState with _$DocumentSaveState {
  const DocumentSaveState._();

  const factory DocumentSaveState({
    @Default(false) bool isSaveDelayed,
    @Default(AssetLocation(path: '')) AssetLocation location,
    Embedding? embedding,
    @Default(SaveState.saved) SaveState saved,
    @Default(false) bool isCreating,
  }) = _DocumentSaveState;

  bool get absolute => saved == SaveState.absoluteRead;
}

class DocumentSaveCubit extends Cubit<DocumentSaveState> {
  DocumentSaveCubit(
    this.settingsCubit, [
    super.initial = const DocumentSaveState(),
  ]);

  final SettingsCubit settingsCubit;

  final savingLock = Lock();

  void replace(DocumentSaveState state) => emit(state);

  void setSaveState({
    AssetLocation? location,
    SaveState? saved,
    bool absolute = false,
    bool? isCreating,
    bool keepRead = false,
  }) => emit(
    state.copyWith(
      location: location ?? state.location,
      isCreating: isCreating ?? state.isCreating,
      saved: (absolute || (keepRead && state.absolute))
          ? SaveState.absoluteRead
          : saved ?? state.saved,
    ),
  );

  void setDelayed(bool delayed) => emit(state.copyWith(isSaveDelayed: delayed));

  ExternalStorage? getRemoteStorage() =>
      settingsCubit.getRemote(state.location.remote);

  bool hasAutosave(NetworkingService networkingService) =>
      settingsCubit.state.autosave &&
      (networkingService.isActive ||
          !(state.embedding?.save ?? true) ||
          (!kIsWeb &&
              !state.absolute &&
              (state.location.isEmpty ||
                  (state.location.fileType?.isNote() ?? false)) &&
              (state.location.remote.isEmpty ||
                  (settingsCubit
                          .getRemote(state.location.remote)
                          ?.hasDocumentCached(state.location.path) ??
                      false))));

  Future<AssetLocation> save(
    DocumentBloc bloc,
    NetworkingService networkingService, {
    AssetLocation? location,
    bool force = false,
    bool isAutosave = false,
  }) async {
    final absolute = state.absolute;
    if (location == null &&
        !force &&
        (state.saved == SaveState.saved ||
            state.saved == SaveState.absoluteRead)) {
      return state.location;
    }
    if (networkingService.isClient) {
      return AssetLocation.empty;
    }
    if (state.isSaveDelayed && isAutosave) {
      return state.location;
    }
    final storage = getRemoteStorage();
    final fileSystem = bloc.state.fileSystem.buildDocumentSystem(storage);
    final isDelayed = settingsCubit.state.delayedAutosave;
    if (isDelayed && isAutosave) {
      final seconds = max(0, settingsCubit.state.autosaveDelaySeconds);
      setDelayed(true);
      await Future.delayed(Duration(seconds: seconds));
      if (!state.isSaveDelayed) {
        return state.location;
      }
    }
    return savingLock.synchronized(() async {
      if (location == null &&
          !force &&
          (state.saved == SaveState.saved ||
              state.saved == SaveState.absoluteRead)) {
        return state.location;
      }
      var current = location ?? state.location;
      if (isClosed) {
        return current;
      }
      setSaveState(saved: SaveState.saving, location: current);
      setDelayed(false);
      final blocState = bloc.state;
      final currentData = await blocState.saveData();
      if (isClosed) {
        return current;
      }
      if (currentData == null || state.embedding != null) {
        setSaveState(saved: SaveState.saved);
        return AssetLocation.empty;
      }
      if (absolute || !(current.fileType?.isNote() ?? false)) {
        final file = await compute(_toFile, (currentData, false));
        final document = await fileSystem.createFileWithName(
          name: currentData.name,
          suffix: '.bfly',
          directory: absolute
              ? null
              : current.fileExtension.isEmpty
              ? state.location.path
              : state.location.parent,
          file,
        );
        current = document.location;
      } else {
        final file = await compute(_toFile, (
          currentData,
          current.fileType == AssetFileType.textNote,
        ));
        await fileSystem.updateFile(current.path, file);
      }
      settingsCubit.addRecentHistory(current);
      if (isClosed) {
        return current;
      }
      setSaveState(
        saved: state.saved == SaveState.saving ? SaveState.saved : state.saved,
        location: current,
      );
      return current;
    });
  }
}

@freezed
sealed class EditorViewState with _$EditorViewState {
  const factory EditorViewState({
    @Default(UtilitiesState()) UtilitiesState utilities,
    @Default(ViewOption()) ViewOption viewOption,
    @Default(true) bool areaNavigatorCreate,
    @Default(true) bool areaNavigatorExact,
    @Default(false) bool areaNavigatorAsk,
    @Default(false) bool navigatorEnabled,
    @Default(NavigatorPage.waypoints) NavigatorPage navigatorPage,
    @Default('') String userName,
  }) = _EditorViewState;
}

class EditorViewCubit extends Cubit<EditorViewState> {
  EditorViewCubit({this.editorSessionCubit, EditorViewState? initial})
    : super(initial ?? const EditorViewState());

  final EditorSessionCubit? editorSessionCubit;

  void replace(EditorViewState state) => emit(state);

  void updateUtilities({UtilitiesState? utilities, ViewOption? view}) {
    emit(
      state.copyWith(
        utilities: utilities ?? state.utilities,
        viewOption: view ?? state.viewOption,
      ),
    );
    if (utilities != null) {
      editorSessionCubit?.updateUtilities(utilities);
    }
  }

  void setAreaNavigator({bool? create, bool? exact, bool? ask}) {
    emit(
      state.copyWith(
        areaNavigatorCreate: create ?? state.areaNavigatorCreate,
        areaNavigatorExact: exact ?? state.areaNavigatorExact,
        areaNavigatorAsk: ask ?? state.areaNavigatorAsk,
      ),
    );
    editorSessionCubit?.updateAreaNavigator(
      create: create,
      exact: exact,
      ask: ask,
    );
  }

  void setNavigator({bool? enabled, NavigatorPage? page}) {
    emit(
      state.copyWith(
        navigatorEnabled: enabled ?? state.navigatorEnabled,
        navigatorPage: page ?? state.navigatorPage,
      ),
    );
    editorSessionCubit?.updateNavigator(enabled: enabled, page: page);
  }

  void setUserName(String name) => emit(state.copyWith(userName: name));
}
