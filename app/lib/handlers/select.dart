part of 'handler.dart';

class SelectHandler extends Handler<SelectTool> {
  final _selectionManager = RectSelectionForegroundManager();
  List<Renderer<PadElement>> _selected = [];
  bool _duplicate = false;
  Offset? _contextMenuOffset;
  Rect? _rectangleFreeSelection;
  List<Offset>? _lassoFreeSelection;

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
    _updateSelectionRect();
    _selectionManager.startTransformWithCorner(
      corner,
      position ?? _selectionManager.selection.center,
    );
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
    _rectangleFreeSelection = null;
    _lassoFreeSelection = null;
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

  void _updateSelectionRect() => _selectionManager.select(getSelectionRect());

  List<Renderer<PadElement>>? _getTransformed() {
    final selectionRect = _selectionManager.selection;
    final pivot = _selectionManager.pivot;
    final transform = _selectionManager.getTransform();
    if (transform == null) return null;

    final scaleX = transform.scaleX;
    final scaleY = transform.scaleY;
    final rotation = transform.rotation;
    final rotationRad = rotation * pi / 180;

    final Offset selectionTopLeft = selectionRect.topLeft;
    final Offset movedSelectionTopLeft = selectionTopLeft + transform.position;

    Offset applyScaleAndTranslate(Offset original) {
      final relative = original - selectionTopLeft;
      return Offset(relative.dx * scaleX, relative.dy * scaleY) +
          movedSelectionTopLeft;
    }

    final Offset transformedPivot = applyScaleAndTranslate(pivot);

    return _selected.map((renderer) {
      final elementRect = renderer.rect ?? renderer.expandedRect ?? Rect.zero;

      final originalTopLeft = elementRect.topLeft;
      final translatedTopLeft = applyScaleAndTranslate(originalTopLeft);
      var delta = translatedTopLeft - originalTopLeft;

      if (rotation != 0) {
        final originalCenter = elementRect.center;
        final transformedCenter = applyScaleAndTranslate(originalCenter);
        final rotatedCenter = transformedCenter.rotate(
          transformedPivot,
          rotationRad,
        );
        delta += rotatedCenter - transformedCenter;
      }

      return renderer.transform(
            position: delta,
            scaleX: scaleX,
            scaleY: scaleY,
            rotation: rotation,
            rotatePosition: false,
            relative: true,
          ) ??
          renderer;
    }).toList();
  }

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) {
    final foregrounds = <Renderer>[];
    foregrounds.addAll(_getTransformed() ?? []);
    final selectionRect = getSelectionRect();
    final scheme = currentIndexCubit.getTheme(false).colorScheme;
    if (selectionRect != null) {
      foregrounds.add(_selectionManager.renderer);
    }
    if (_rectangleFreeSelection != null) {
      foregrounds.add(
        RectSelectionForegroundRenderer(_rectangleFreeSelection!),
      );
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
    final globalPos = transform.localToGlobal(details.localPosition);
    if (_selectionManager.isTransforming) {
      _selectionManager.updateCurrentPosition(globalPos);
      _selected = _submitTransform(context.getDocumentBloc()) ?? _selected;
      return;
    }
    final noSelection = _selected.isEmpty;
    await _onSelectionAdd(context, details.localPosition, false);
    final selectionRect = getSelectionRect();
    if (noSelection &&
        (selectionRect == null || !selectionRect.contains(globalPos))) {
      _onSelectionContext(context, details.localPosition);
    }
  }

  bool _startLongPress = false;

  @override
  void onLongPressDown(LongPressDownDetails details, EventContext context) {
    _startLongPress = details.kind != PointerDeviceKind.mouse;
  }

  @override
  void onLongPressEnd(LongPressEndDetails details, EventContext context) {
    if (!_startLongPress) return;
    _onSelectionAdd(context, details.localPosition, true);
  }

  Future<void> _onSelectionAdd(
    EventContext context,
    Offset localPosition, [
    bool forceAdd = false,
  ]) async {
    if (_selectionManager.isTransforming) {
      return;
    }
    final utilities = context.getCurrentIndex().utilities;
    final transform = context.getCameraTransform();
    final globalPos = transform.localToGlobal(localPosition);
    final selectionRect = getSelectionRect();
    if (selectionRect?.contains(globalPos) ?? false) {
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
      useCollection: utilities.lockCollection,
      useLayer: utilities.lockLayer,
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
  void onDoubleTapDown(TapDownDetails details, EventContext context) {
    _contextMenuOffset = details.localPosition;
  }

  @override
  void onDoubleTap(EventContext context) {
    if (_contextMenuOffset == null) return;
    _onSelectionContext(context, _contextMenuOffset!);
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
    final hits = await bloc.rayCast(position, 0.0, useCollection: true);
    final hit = hits.firstOrNull;
    final rect = hit?.expandedRect;
    final selectionRect = getSelectionRect();
    if ((rect != null && !(selectionRect?.contains(position) ?? false)) &&
        !context.isCtrlPressed) {
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
          selectionRect,
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
    final currentIndex = context.getCurrentIndex();
    _ruler = RulerHandler.getFirstRuler(
      context.getCurrentIndex(),
      details.localFocalPoint,
      context.viewportSize,
    );
    _rulerRotationStart = details.localFocalPoint;
    _lastRulerRotation = _ruler?.rotation ?? 0;
    if (_ruler != null) return true;
    if (currentIndex.buttons == kSecondaryMouseButton &&
        currentIndex.temporaryHandler == null) {
      return false;
    }
    final cameraTransform = context.getCameraTransform();
    final globalPos = cameraTransform.localToGlobal(details.localFocalPoint);
    final shouldTransform = _selectionManager.shouldTransform(
      globalPos,
      cameraTransform.size,
      context.getSettings().touchSensitivity,
    );
    if (shouldTransform) {
      transform(
        context.getDocumentBloc(),
        _selectionManager.getCornerHit(
          globalPos,
          cameraTransform.size,
          context.getSettings().touchSensitivity,
        ),
        position: globalPos,
      );
      return true;
    }
    context.refresh();
    return true;
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) {
    final cameraTransform = context.getCameraTransform();
    final globalPos = cameraTransform.localToGlobal(event.localPosition);
    final selectionRect = getSelectionRect();
    final shouldTransform = _selectionManager.shouldTransform(
      globalPos,
      cameraTransform.size,
      context.getSettings().touchSensitivity,
    );
    if (selectionRect != null && selectionRect.contains(globalPos)) {
      return false;
    }
    if (shouldTransform) {
      return false;
    }
    return true;
  }

  RulerHandler? _ruler;
  Offset? _rulerRotationStart;
  double _lastRulerRotation = 0;

  bool _handleRuler(ScaleUpdateDetails details, EventContext context) {
    final state = context.getState();
    if (state == null) return false;
    final ruler = _ruler;
    if (ruler == null) return false;
    final rightClick =
        (context.getCurrentIndex().buttons ?? 0) & kSecondaryMouseButton != 0;
    var angle = details.rotation * 180 / pi;
    var currentPos = Offset.zero;
    if (details.rotation == 0 && rightClick) {
      final rulerCenter = ruler.getRect(context.viewportSize).center;
      var start = _rulerRotationStart ?? rulerCenter;
      final startDelta = (start - rulerCenter).direction;
      final currentDelta = (details.localFocalPoint - rulerCenter).direction;
      angle =
          (currentDelta - startDelta) * 180 / pi -
          ruler.rotation +
          _lastRulerRotation;
    } else {
      currentPos = details.focalPointDelta;
    }
    while (angle < 0) {
      angle += 360;
    }
    angle %= 360;
    ruler.transform(context, position: currentPos, rotation: angle);
    return true;
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    final globalPos = context.getCameraTransform().localToGlobal(
      details.localFocalPoint,
    );
    if (_handleRuler(details, context)) {
      return;
    }
    if (details.pointerCount > 1) return;
    if (_selectionManager.isTransforming) {
      _selectionManager.updateCurrentPosition(globalPos);
      context.refreshForegrounds();
      return;
    }
    final topLeft = _rectangleFreeSelection?.topLeft ?? globalPos;
    _rectangleFreeSelection = data.mode == SelectMode.rectangle
        ? Rect.fromLTRB(topLeft.dx, topLeft.dy, globalPos.dx, globalPos.dy)
        : null;
    if (data.mode == SelectMode.lasso) {
      _lassoFreeSelection ??= [];
      _lassoFreeSelection!.add(globalPos);
    } else {
      _lassoFreeSelection = null;
    }
    context.refreshForegrounds();
  }

  @override
  void dispose(DocumentBloc bloc) => _submitTransform(bloc);

  @override
  void onScaleEnd(ScaleEndDetails details, EventContext context) async {
    final utilities = context.getCurrentIndex().utilities;
    final rectangleSelection = _rectangleFreeSelection?.normalized();
    final lassoSelection = _lassoFreeSelection;
    if (_ruler != null) {
      return;
    }
    final transformed = _submitTransform(context.getDocumentBloc());
    if (transformed != null) {
      _selected.clear();
      _selected.addAll(transformed);
      _updateSelectionRect();
      return;
    }
    _lassoFreeSelection = null;
    _rectangleFreeSelection = null;
    if (!context.isCtrlPressed) {
      _selected.clear();
    }
    if (rectangleSelection != null && !rectangleSelection.isEmpty) {
      final hits = await context.getDocumentBloc().rayCastRect(
        rectangleSelection,
        useCollection: utilities.lockCollection,
        useLayer: utilities.lockLayer,
      );
      _selected.addAll(hits);
    } else if (lassoSelection != null && lassoSelection.isNotEmpty) {
      final hits = await context.getDocumentBloc().rayCastPolygon(
        lassoSelection,
        useCollection: utilities.lockCollection,
        useLayer: utilities.lockLayer,
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
    final globalPos = transform.localToGlobal(event.localPosition);
    _selectionManager
      ..updateCurrentPosition(globalPos)
      ..updateCursor(transform.size, context.getSettings().touchSensitivity);
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
    _selected.addAll(state.renderers.where((e) => filter?.call(e) ?? true));
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
}
