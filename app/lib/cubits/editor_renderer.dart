part of 'editor_runtime.dart';

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
    ...(temporaryRendererStates ?? const <String, RendererState>{}),
  };
}

class _RendererSpatialIndex {
  _RendererSpatialIndex(List<Renderer<PadElement>> renderers) {
    for (var index = 0; index < renderers.length; index++) {
      final bounds = renderers[index].expandedRect;
      if (bounds == null) {
        _unbounded.add(index);
        continue;
      }
      final left = (bounds.left / _cellSize).floor();
      final top = (bounds.top / _cellSize).floor();
      final right = (bounds.right / _cellSize).floor();
      final bottom = (bounds.bottom / _cellSize).floor();
      final cellCount = (right - left + 1) * (bottom - top + 1);
      if (cellCount > _maxCellsPerRenderer) {
        _large.add(index);
        continue;
      }
      for (var x = left; x <= right; x++) {
        for (var y = top; y <= bottom; y++) {
          (_cells[(x, y)] ??= <int>[]).add(index);
        }
      }
    }
  }

  static const double _cellSize = 1024;
  static const int _maxCellsPerRenderer = 64;
  static const int _maxQueryCells = 4096;
  final Map<(int, int), List<int>> _cells = {};
  final List<int> _large = [];
  final List<int> _unbounded = [];

  List<Renderer<PadElement>> query(
    List<Renderer<PadElement>> renderers,
    Rect rect,
  ) {
    final indices = <int>{..._large, ..._unbounded};
    final left = (rect.left / _cellSize).floor();
    final top = (rect.top / _cellSize).floor();
    final right = (rect.right / _cellSize).floor();
    final bottom = (rect.bottom / _cellSize).floor();
    final queryCellCount = (right - left + 1) * (bottom - top + 1);
    if (queryCellCount > _maxQueryCells) {
      return renderers.where((renderer) => renderer.isVisible(rect)).toList();
    }
    for (var x = left; x <= right; x++) {
      for (var y = top; y <= bottom; y++) {
        final cell = _cells[(x, y)];
        if (cell != null) indices.addAll(cell);
      }
    }
    final ordered = indices.toList()..sort();
    return ordered
        .where((index) => renderers[index].isVisible(rect))
        .map((index) => renderers[index])
        .toList(growable: false);
  }
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
  EditorController? _controller;
  StreamSubscription<CameraTransform>? _transformSubscription;
  Timer? _transformDebounceTimer;
  _RendererSpatialIndex? _spatialIndex;
  List<Renderer<PadElement>>? _indexedRenderers;

  void bindController(EditorController controller) {
    _controller = controller;
    _transformSubscription?.cancel();
    _transformSubscription = controller.transformCubit.stream.listen((_) {
      _transformDebounceTimer?.cancel();
      _transformDebounceTimer = Timer(const Duration(milliseconds: 16), () {
        if (!controller.isClosed) {
          updateVisibleElements(controller, controller.activeDocumentBloc);
        }
      });
    });
  }

  @override
  void onChange(Change<RendererRuntimeState> change) {
    super.onChange(change);
    final controller = _controller;
    if (controller == null || controller.isClosed) return;
    final currentViewport = change.currentState.cameraViewport;
    final newViewport = change.nextState.cameraViewport;

    if (!identical(currentViewport, newViewport) &&
        currentViewport != newViewport) {
      controller.toolCubit.state.handler.onViewportUpdated(
        currentViewport,
        newViewport,
      );
      controller.toolCubit.state.temporaryHandler?.onViewportUpdated(
        currentViewport,
        newViewport,
      );
    }

    currentViewport.disposeImages(except: newViewport);
  }

  void cancelDelayedBake() {
    delayedBakeRunner.cancel();
  }

  void replace(RendererRuntimeState state) => emit(state);

  void setViewport(CameraViewport cameraViewport) =>
      emit(state.copyWith(cameraViewport: cameraViewport));

  void setRendererStates({
    Map<String, RendererState>? rendererStates,
    Map<String, RendererState>? temporaryRendererStates,
  }) {
    final nextRendererStates = rendererStates ?? state.rendererStates;
    final nextTemporaryRendererStates =
        temporaryRendererStates ?? state.temporaryRendererStates;
    const equality = MapEquality<String, RendererState>();
    if (equality.equals(state.rendererStates, nextRendererStates) &&
        equality.equals(
          state.temporaryRendererStates,
          nextTemporaryRendererStates,
        )) {
      return;
    }
    emit(
      state.copyWith(
        rendererStates: nextRendererStates,
        temporaryRendererStates: nextTemporaryRendererStates,
      ),
    );
  }

  List<Renderer<PadElement>> get renderers =>
      List<Renderer<PadElement>>.from(state.cameraViewport.bakedElements)
        ..addAll(state.cameraViewport.unbakedElements);

  void _invalidateSpatialIndex() {
    _spatialIndex = null;
    _indexedRenderers = null;
  }

  List<Renderer<PadElement>> visibleRenderers(Rect rect) {
    var all = _indexedRenderers;
    if (all == null) {
      all = renderers;
      _indexedRenderers = all;
      _spatialIndex = _RendererSpatialIndex(all);
    }
    return _spatialIndex!.query(all, rect);
  }

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

  bool rendererStateChangesAffectBaked(
    Map<String, RendererState> current,
    Map<String, RendererState> next,
  ) {
    final changedIds = {
      ...current.keys,
      ...next.keys,
    }.where((id) => current[id] != next[id]);
    if (changedIds.isEmpty) return false;
    final bakedIds = state.cameraViewport.bakedElements
        .map((renderer) => renderer.id)
        .toSet();
    return changedIds.any(bakedIds.contains);
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

    final rect = getViewportRect(controller.transformCubit);
    final currentVisible = state.cameraViewport.visibleElements;
    final currentVisibleUnbaked = state.cameraViewport.visibleUnbakedElements;

    final visible = visibleRenderers(rect);
    final unbakedSet = unbaked.toSet();
    final visibleUnbaked = visible.where(unbakedSet.contains).toList();

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
    final measuredViewportSize = viewportSize ?? cameraViewport.viewportSize;
    var size = measuredViewportSize ?? cameraViewport.toSize();
    final ratio = pixelRatio ?? cameraViewport.pixelRatio;
    if (size.height <= 0 || size.width <= 0) {
      return;
    }
    if (measuredViewportSize == null) {
      size /= resolution.multiplier;
    }
    var transform = transformCubit.state;
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
    final renderers = rendererCubit.renderers;
    List<Renderer<PadElement>> visibleElements;
    final oldVisible = cameraViewport.visibleElements;
    talker.verbose(
      'Baking viewport (reset: $reset, viewChanged: $viewChanged, '
      'rendererStatesChanged: $rendererStatesChanged)',
    );

    if (reset) {
      visibleElements = rendererCubit.visibleRenderers(rect);
    } else {
      final oldVisibleSet = oldVisible.toSet();
      visibleElements = List.from(oldVisible)
        ..addAll(
          cameraViewport.unbakedElements.where(
            (renderer) =>
                !oldVisibleSet.contains(renderer) && renderer.isVisible(rect),
          ),
        );
    }

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

    final List<Renderer<PadElement>> newlyUnbaked;
    if (reset) {
      final bakedElementsSet = cameraViewport.bakedElements
          .map((e) => e.element)
          .toSet();
      final unbakedElementsSet = cameraViewport.unbakedElements
          .map((e) => e.element)
          .toSet();
      final visibleElementsSet = visibleElements.toSet();
      newlyUnbaked = renderers
          .where(
            (element) =>
                !bakedElementsSet.contains(element.element) &&
                !unbakedElementsSet.contains(element.element) &&
                !visibleElementsSet.contains(element),
          )
          .toList();
    } else {
      newlyUnbaked = const [];
    }

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
      viewportSize: measuredViewportSize,
      pixelRatio: ratio,
      resolution: resolution,
      scale: transform.size,
      x: renderTransform.position.dx,
      y: renderTransform.position.dy,
      image: newImage,
      bakedElements: renderers,
      unbakedElements: newlyUnbaked,
      visibleElements: visibleElements,
      visibleUnbakedElements: const [],
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
    if (unbakedElements != null) rendererCubit._invalidateSpatialIndex();
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
    rendererCubit._invalidateSpatialIndex();
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
    rendererCubit._invalidateSpatialIndex();
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
    rendererCubit._invalidateSpatialIndex();
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
    await _transformSubscription?.cancel();
    _transformSubscription = null;
    _transformDebounceTimer?.cancel();
    _transformDebounceTimer = null;
    _controller = null;
    delayedBakeRunner.cancel();
    await delayedBakeRunner.disposeAndWait();
    initializedElements.clear();
    _invalidateSpatialIndex();
    state.cameraViewport.disposeImages();
    for (final renderer in renderers) {
      renderer.dispose();
    }
  }

  @override
  Future<void> close() async {
    await _transformSubscription?.cancel();
    _transformSubscription = null;
    _transformDebounceTimer?.cancel();
    _transformDebounceTimer = null;
    _controller = null;
    return super.close();
  }
}
