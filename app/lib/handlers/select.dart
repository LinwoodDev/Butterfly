part of 'handler.dart';

class SelectHandler extends Handler<SelectTool> {
  final _selectionManager = RectSelectionForegroundManager();
  List<Renderer<PadElement>> _selected = [];
  bool _duplicate = false;
  Offset? _rectangleFreeSelectionStart;
  RectSelectionForegroundRenderer? _rectangleFreeSelection;
  double _rectangleSelectionRotation = 0;
  List<Offset>? _lassoFreeSelection;
  ({Offset position, SelectionTransformCorner? corner})? _pendingTransform;

  SelectHandler(super.data);

  void transform(
    DocumentBloc bloc,
    SelectionTransformCorner? corner, {
    List<Renderer<PadElement>>? next,
    bool duplicate = false,
    Offset? position,
  }) {
    _selected = next ?? _selected;
    _submitTransform(bloc);
    _updateSelectionRect(-bloc.editorController.transformCubit.state.rotation);
    _selectionManager.startTransformWithCorner(corner, position);
    _duplicate = duplicate;
    bloc.refresh();
  }

  @override
  Map<String, RendererState> get rendererStates =>
      _selectionManager.isTransforming && !_duplicate
      ? Map.fromEntries(
          _selected.map((e) => MapEntry(e.id, RendererState.hidden)),
        )
      : {};

  @override
  Future<void> resetInput(DocumentBloc bloc) async {
    _submitTransform(bloc);
    _rectangleFreeSelectionStart = null;
    _rectangleFreeSelection = null;
    _lassoFreeSelection = null;
    _pendingTransform = null;
    _selectionManager.reset();
    await bloc.refresh(allowBake: false);
  }

  @override
  bool onRenderersCreated(DocumentPage page, List<Renderer> renderers) {
    var changed = false;
    _selected = _selected
        .map((e) {
          final renderer = renderers.firstWhereOrNull(
            (element) => element.element == e.element,
          );
          if (renderer is! Renderer<PadElement>) return e;
          changed = true;
          return renderer;
        })
        .nonNulls
        .toList();
    _updateSelectionRect();
    return changed;
  }

  @override
  void onRenderersReloaded(
    DocumentPage page,
    List<Renderer<PadElement>> renderers,
  ) {
    final renderersById = <String, Renderer<PadElement>>{};
    for (final renderer in renderers) {
      final id = renderer.element.id;
      if (id != null) renderersById[id] = renderer;
    }
    _selected = _selected
        .map((renderer) => renderersById[renderer.element.id])
        .nonNulls
        .toList();
    _updateSelectionRect();
  }

  @override
  bool onRendererUpdated(
    DocumentPage page,
    Renderer old,
    List<Renderer> updated,
  ) {
    bool changed = false;
    if (old is Renderer<PadElement> &&
        _selected.any((e) => e.id == old.id) &&
        updated is List<Renderer<PadElement>>) {
      _selected.removeWhere((e) => e.id == old.id);
      _selected.addAll(updated);
      changed = true;
      _updateSelectionRect();
    }
    return changed;
  }

  Rect? getSelectionRect() {
    Rect? rect;
    for (final element in _selected) {
      final current = element.expandedRect;
      if (current != null && !current.isEmpty) {
        rect = rect?.expandToInclude(current) ?? current;
      }
    }
    return rect;
  }

  void _updateSelectionRect([double? rotation]) {
    final angle = rotation ?? _selectionManager.rotation;
    Rect? bounds;
    for (final renderer in _selected) {
      final rect = renderer.rect;
      if (rect == null) continue;
      for (final corner in rect.toPolygon()) {
        final point = renderer
            .transformPoint(corner)
            .rotate(Offset.zero, -angle);
        final pointRect = Rect.fromPoints(point, point);
        bounds = bounds?.expandToInclude(pointRect) ?? pointRect;
      }
    }
    _selectionManager.select(bounds, rotation: angle);
  }

  void _syncSelectionRotation(CameraTransform camera) {
    if (!_selectionManager.isTransforming &&
        _selectionManager.rotation != -camera.rotation) {
      _updateSelectionRect(-camera.rotation);
    }
  }

  bool _isSelectionHit(
    Offset position,
    CameraTransform transform,
    double sensitivity,
  ) =>
      _selectionManager.isValid &&
      _selectionManager.shouldTransform(position, transform.size, sensitivity);

  List<Renderer<PadElement>>? _getTransformed() {
    final selectionRect = _selectionManager.selection;
    final pivot = _selectionManager.pivot;
    final transform = _selectionManager.getTransform();
    if (transform == null) return null;

    final angle = _selectionManager.rotation;
    final transformedPivot = transform.scalePoint(pivot, selectionRect);
    return _selected.map((renderer) {
      final center = (renderer.rect?.center ?? Offset.zero).rotate(
        Offset.zero,
        -angle,
      );
      final target = transform
          .scalePoint(center, selectionRect)
          .rotate(transformedPivot, transform.rotation * pi / 180)
          .rotate(Offset.zero, angle);
      return renderer.transform(
            center: target,
            scaleX: transform.scaleX,
            scaleY: transform.scaleY,
            scaleRotation: angle,
            rotation: transform.rotation,
          ) ??
          renderer;
    }).toList();
  }

  @override
  List<Renderer> createForegrounds(
    EditorController editorController,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) {
    _syncSelectionRotation(editorController.transformCubit.state);
    final foregrounds = <Renderer>[];
    // When transform just started but the pointer hasn't moved yet,
    // _getTransformed() returns null. Show originals as foregrounds
    // since rendererStates already hides them from the main layer.
    foregrounds.addAll(
      _getTransformed() ??
          (_selectionManager.isTransforming && !_duplicate ? _selected : []),
    );
    final selectionRect = getSelectionRect();
    final settings = editorController.settingsCubit.state;
    final scheme = getThemeData(settings.design, false).colorScheme;
    if (selectionRect != null) {
      foregrounds.add(_selectionManager.renderer);
    }
    if (_rectangleFreeSelection != null) {
      foregrounds.add(_rectangleFreeSelection!);
    }
    if (_lassoFreeSelection != null) {
      foregrounds.add(
        LassoSelectionForegroundRenderer(_lassoFreeSelection!, scheme),
      );
    }
    return foregrounds;
  }

  List<Renderer<PadElement>>? _submitTransform(DocumentBloc bloc) {
    if (!_selectionManager.isTransforming) return null;
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return null;
    final current = _getTransformed();
    _selectionManager.deselect();
    if (current == null) return null;
    if (_duplicate) {
      final elements = current
          .map((e) => e.element.copyWith(id: createUniqueId()))
          .toList();
      bloc.add(ElementsCreated(elements));
      return [];
    }

    if (state.settingsCubit.state.bringMovedElementsToFront) {
      bloc.add(
        ElementsArranged(Arrangement.front, current.map((e) => e.id).toList()),
      );
    }
    bloc.add(
      ElementsChanged(
        Map.fromEntries(
          current.mapIndexed((i, e) {
            final id = _selected[i].element.id;
            if (id == null) return null;
            return MapEntry(id, [e.element]);
          }).nonNulls,
        ),
      ),
    );
    return current;
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) async {
    final transform = context.getCameraTransform();
    _syncSelectionRotation(transform);
    final globalPos = transform.localToGlobal(details.localPosition);
    if (_selectionManager.isTransforming) {
      _selectionManager.updateCurrentPosition(globalPos);
      _selected = _submitTransform(context.getDocumentBloc()) ?? _selected;
      return;
    }
    await _onSelectionAdd(context, details.localPosition, false);
  }

  @override
  void onLongPressEnd(LongPressEndDetails details, EventContext context) async {
    final transform = context.getCameraTransform();
    _syncSelectionRotation(transform);
    final globalPos = transform.localToGlobal(details.localPosition);
    final hitSelection = _isSelectionHit(
      globalPos,
      transform,
      context.getSettings().touchSensitivity,
    );
    if (!hitSelection) {
      await _onSelectionAdd(context, details.localPosition, true);
    }
    _onSelectionContext(context, details.localPosition);
  }

  Future<void> _onSelectionAdd(
    EventContext context,
    Offset localPosition, [
    bool forceAdd = false,
  ]) async {
    if (_selectionManager.isTransforming) {
      return;
    }
    final locks = context.getViewState().locks;
    final transform = context.getCameraTransform();
    _syncSelectionRotation(transform);
    final globalPos = transform.localToGlobal(localPosition);
    if (_selectionManager.contains(globalPos)) {
      _selectionManager.toggleTransformMode();
      context.refresh();
      return;
    }
    _selectionManager.resetTransform();
    final settings = context.getSettings();
    final radius = settings.selectSensitivity / transform.size;
    final hits = await context.getDocumentBloc().rayCast(
      globalPos,
      radius,
      useCollection: locks.lockCollection,
      useLayer: locks.lockLayer,
    );
    if (hits.isEmpty) {
      if (!context.isCtrlPressed) {
        _selected.clear();
        _selectionManager.resetTransform();
        context.refresh();
      }
      return;
    }
    final hit = hits.first;
    if (context.isCtrlPressed || forceAdd) {
      if (_selected.contains(hit)) {
        _selected.remove(hit);
      } else {
        _selected.add(hit);
      }
    } else {
      _selected.clear();
      _selected.add(hit);
    }
    _selectionManager.resetTransform();
    context.refresh();
  }

  @override
  void onSecondaryTapUp(TapUpDetails details, EventContext context) async {
    _onSelectionContext(context, details.localPosition);
  }

  @override
  void onContextMenu(Offset localPosition, EventContext context) {
    final selectionRect = getSelectionRect();
    final position = selectionRect == null
        ? localPosition
        : context.getCameraTransform().globalToLocal(selectionRect.center);
    _onSelectionContext(context, position);
  }

  Future<void> _onSelectionContext(
    EventContext context,
    Offset localPosition,
  ) async {
    if (_selectionManager.isTransforming) {
      return;
    }
    final position = context.getCameraTransform().localToGlobal(localPosition);
    final bloc = context.getDocumentBloc();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final locks = context.getViewState().locks;
    final hits = await bloc.rayCast(
      position,
      0.0,
      useCollection: locks.lockCollection,
      useLayer: locks.lockLayer,
    );
    final hit = hits.firstOrNull;
    final rect = hit?.expandedRect;
    final hitSelection = _isSelectionHit(
      position,
      context.getCameraTransform(),
      context.getSettings().touchSensitivity,
    );
    if ((rect != null && !hitSelection) && !context.isCtrlPressed) {
      _selected.clear();
      if (hit != null) _selected.add(hit);
    }
    context.refresh();
    final buildContext = context.buildContext;
    if (buildContext.mounted) {
      final result = await showContextMenu<bool>(
        context: buildContext,
        position: localPosition,
        builder: buildElementsContextMenu(
          bloc,
          state,
          context.getImportService(),
          context.getExportService(),
          context.getClipboardManager(),
          localPosition,
          _selected,
          getSelectionRect(),
        ),
      );
      if (result ?? false) {
        _selected.clear();
      }
    }
    context.refresh();
  }

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    final pendingTransform = _pendingTransform;
    _pendingTransform = null;
    final toolState = context.getToolState();
    final inputState = context.getInputState();
    if (inputState.buttons == kSecondaryMouseButton &&
        toolState.temporaryHandler == null) {
      return false;
    }
    final cameraTransform = context.getCameraTransform();
    _syncSelectionRotation(cameraTransform);
    final globalPos = cameraTransform.localToGlobal(details.localFocalPoint);
    final shouldTransform = _selectionManager.shouldTransform(
      globalPos,
      cameraTransform.size,
      context.getSettings().touchSensitivity,
    );
    if (pendingTransform != null || shouldTransform) {
      transform(
        context.getDocumentBloc(),
        pendingTransform != null
            ? pendingTransform.corner
            : _selectionManager.getCornerHit(
                globalPos,
                cameraTransform.size,
                context.getSettings().touchSensitivity,
              ),
        position: pendingTransform?.position ?? globalPos,
      );
      return true;
    }
    _rectangleSelectionRotation = cameraTransform.rotation;
    _rectangleFreeSelectionStart = data.mode == SelectMode.rectangle
        ? globalPos
        : null;
    context.refresh();
    return true;
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) {
    final cameraTransform = context.getCameraTransform();
    _syncSelectionRotation(cameraTransform);
    final globalPos = cameraTransform.localToGlobal(event.localPosition);
    final selectionRect = getSelectionRect();
    final shouldTransform = _selectionManager.shouldTransform(
      globalPos,
      cameraTransform.size,
      context.getSettings().touchSensitivity,
    );
    if (shouldTransform) {
      _pendingTransform = (
        position: globalPos,
        corner: _selectionManager.getCornerHit(
          globalPos,
          cameraTransform.size,
          context.getSettings().touchSensitivity,
        ),
      );
    } else {
      _pendingTransform = null;
    }
    if (selectionRect != null && _selectionManager.contains(globalPos)) {
      return false;
    }
    if (shouldTransform) {
      return false;
    }
    return true;
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    final globalPos = context.getCameraTransform().localToGlobal(
      details.localFocalPoint,
    );
    if (details.pointerCount > 1) return;
    if (_selectionManager.isTransforming) {
      _selectionManager.updateModifiers(
        proportional: context.isShiftPressed,
        centered: context.isAltPressed,
      );
      _selectionManager.updateCurrentPosition(globalPos);
      context.refreshForegrounds();
      return;
    }
    final start = _rectangleFreeSelectionStart ?? globalPos;
    if (data.mode == SelectMode.rectangle) {
      final angle = _rectangleSelectionRotation;
      final rect = Rect.fromPoints(start, globalPos.rotate(start, angle));
      _rectangleFreeSelection = RectSelectionForegroundRenderer(
        rect.shift(rect.center.rotate(start, -angle) - rect.center),
        rotation: -angle * 180 / pi,
      );
    } else {
      _rectangleFreeSelection = null;
    }
    if (data.mode == SelectMode.lasso) {
      _lassoFreeSelection ??= [];
      _lassoFreeSelection!.add(globalPos);
    } else {
      _lassoFreeSelection = null;
    }
    context.refreshForegrounds();
  }

  @override
  void dispose(DocumentBloc bloc) {
    _submitTransform(bloc);
  }

  @override
  Future<void> onScaleEnd(ScaleEndDetails details, EventContext context) async {
    _pendingTransform = null;
    final locks = context.getViewState().locks;
    final rectangleSelection = _rectangleFreeSelection;
    final lassoSelection = _lassoFreeSelection;
    final transformed = _submitTransform(context.getDocumentBloc());
    if (transformed != null) {
      _selected.clear();
      _selected.addAll(transformed);
      _updateSelectionRect();
      return;
    }
    _lassoFreeSelection = null;
    _rectangleFreeSelectionStart = null;
    _rectangleFreeSelection = null;
    if (!context.isCtrlPressed) {
      _selected.clear();
    }
    if (rectangleSelection != null && !rectangleSelection.rect.isEmpty) {
      final hits = await context.getDocumentBloc().rayCastRect(
        rectangleSelection.rect,
        rotation: rectangleSelection.rotation,
        useCollection: locks.lockCollection,
        useLayer: locks.lockLayer,
        hitElementMode: data.hitElementMode,
      );
      _selected.addAll(hits);
    } else if (lassoSelection != null && lassoSelection.isNotEmpty) {
      final hits = await context.getDocumentBloc().rayCastPolygon(
        lassoSelection,
        useCollection: locks.lockCollection,
        useLayer: locks.lockLayer,
        hitElementMode: data.hitElementMode,
      );
      _selected.addAll(hits);
    } else {
      _updateSelectionRect();
      return;
    }
    _updateSelectionRect();
    context.refresh();
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    final transform = context.getCameraTransform();
    _syncSelectionRotation(transform);
    final globalPos = transform.localToGlobal(event.localPosition);
    _selectionManager
      ..updateCurrentPosition(globalPos)
      ..updateCursor(
        transform.size,
        context.getSettings().touchSensitivity,
        transform.rotation,
      );
    context.refreshForegrounds();
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    Focus.of(context.buildContext).requestFocus();
  }

  @override
  MouseCursor? get cursor => _selectionManager.cursor;

  Future<void> copySelection(
    DocumentBloc bloc,
    ClipboardManager clipboardManager, [
    bool cut = false,
  ]) async {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    if (cut) {
      bloc.add(
        ElementsRemoved(_selected.map((r) => r.element.id).nonNulls.toList()),
      );
    }
    final point = getSelectionRect()?.topLeft;
    if (point == null) return;
    writeClipboardData(
      clipboardManager,
      AssetFileType.page,
      Uint8List.fromList(
        utf8.encode(
          json.encode(
            DocumentPage(
              layers: [
                DocumentLayer(
                  id: createUniqueId(),
                  content: _selected
                      .map(
                        (e) =>
                            (e.transform(position: -point, relative: true) ?? e)
                                .element,
                      )
                      .toList(),
                ),
              ],
            ).toDataJson(state.data),
          ),
        ),
      ),
    );
    _selected.clear();
    bloc.refresh();
  }

  void selectAll(
    DocumentBloc bloc, [
    bool Function(Renderer<PadElement>)? filter,
  ]) {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    _selected.clear();
    _selected.addAll(
      bloc.editorController.rendererCubit.renderers.where(
        (e) => filter?.call(e) ?? true,
      ),
    );
    _updateSelectionRect();
    bloc.refreshForegrounds();
  }

  @override
  Map<Type, Action<Intent>> getActions(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final clipboardManager = context.read<ClipboardManager>();

    return {
      ...super.getActions(context),
      SelectAllTextIntent: CallbackAction<SelectAllTextIntent>(
        onInvoke: (intent) => selectAll(bloc),
      ),
      DeleteCharacterIntent: CallbackAction<DeleteCharacterIntent>(
        onInvoke: (intent) {
          final state = bloc.state;
          if (state is! DocumentLoadSuccess) return null;
          context.read<DocumentBloc>().add(
            ElementsRemoved(
              _selected.map((r) => r.element.id).nonNulls.toList(),
            ),
          );
          _selected.clear();
          bloc.refreshForegrounds();
          return null;
        },
      ),
      CopySelectionTextIntent: CallbackAction<CopySelectionTextIntent>(
        onInvoke: (intent) {
          copySelection(bloc, clipboardManager, intent.collapseSelection);
          return null;
        },
      ),
    };
  }

  void clearSelection(DocumentBloc bloc) {
    _selected.clear();
    _updateSelectionRect();
    bloc.refreshForegrounds();
  }
}
