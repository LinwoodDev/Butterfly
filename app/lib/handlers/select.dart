part of 'handler.dart';

class SelectHandler extends Handler<SelectTool> {
  final _selectionManager = RectSelectionForegroundManager();
  List<Renderer<PadElement>> _selected = [];
  bool _duplicate = false;
  Offset? _contextMenuOffset;
  Rect? _rectangleFreeSelection;
  List<Offset>? _lassoFreeSelection;

  SelectHandler(super.data);

  void transform(DocumentBloc bloc, SelectionTransformCorner? corner,
      {List<Renderer<PadElement>>? next,
      bool duplicate = false,
      Offset? position}) {
    _selected = next ?? _selected;
    _submitTransform(bloc);
    _updateSelectionRect();
    _selectionManager.startTransformWithCorner(
        corner, position ?? _selectionManager.selection.center);
    _duplicate = duplicate;
    bloc.refresh();
  }

  @override
  Map<Renderer, RendererState> get rendererStates => _selectionManager
          .isTransforming
      ? Map.fromEntries(_selected.map((e) => MapEntry(e, RendererState.hidden)))
      : {};

  @override
  void resetInput(DocumentBloc bloc) {
    _submitTransform(bloc);
    _rectangleFreeSelection = null;
    _lassoFreeSelection = null;
    _selectionManager.resetTransform();
    bloc.refresh();
  }

  @override
  bool onRenderersCreated(DocumentPage page, List<Renderer> renderers) {
    var changed = false;
    _selected = _selected
        .map((e) {
          final renderer = renderers
              .firstWhereOrNull((element) => element.element == e.element);
          if (renderer is! Renderer<PadElement>) return e;
          changed = true;
          return renderer;
        })
        .whereNotNull()
        .toList();
    return changed;
  }

  @override
  bool onRendererUpdated(
      DocumentPage page, Renderer old, List<Renderer> updated) {
    bool changed = false;
    if (old is Renderer<PadElement> &&
        _selected.contains(old) &&
        updated is List<Renderer<PadElement>>) {
      _selected.remove(old);
      _selected.addAll(updated);
      changed = true;
    }
    return changed;
  }

  Rect? getSelectionRect() {
    Rect? rect;
    for (final element in _selected) {
      final current = element.expandedRect;
      if (current != null) {
        rect = rect?.expandToInclude(current) ?? current;
      }
    }
    return rect;
  }

  void _updateSelectionRect() => _selectionManager.select(getSelectionRect());

  List<Renderer<PadElement>>? _getTransformed() {
    final rect = _selectionManager.selection;
    final pivot = _selectionManager.pivot;
    final transform = _selectionManager.getTransform();
    if (transform == null) return null;
    return _selected.map((e) {
      var oldPos = e.expandedRect?.topLeft ?? Offset.zero;
      var diff = oldPos - rect.topLeft;
      // Scale and calculate relative position based on transformRect
      var newPos = Offset(diff.dx * (transform.scaleX - 1),
              diff.dy * (transform.scaleY - 1)) +
          transform.position;
      // Rotate around center
      if (transform.rotation != 0) {
        final center = e.expandedRect?.center ?? Offset.zero;
        newPos += center.rotate(pivot, transform.rotation / 180 * pi) - center;
      }
      return e.transform(
              position: newPos,
              scaleX: transform.scaleX,
              scaleY: transform.scaleY,
              rotation: transform.rotation,
              relative: true) ??
          e;
    }).toList();
  }

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
      NoteData document, DocumentPage page, DocumentInfo info,
      [Area? currentArea]) {
    final foregrounds = <Renderer>[];
    foregrounds.addAll(_getTransformed() ?? []);
    final selectionRect = getSelectionRect();
    final scheme = currentIndexCubit.getTheme(false).colorScheme;
    if (selectionRect != null) {
      foregrounds.add(_selectionManager.renderer);
    }
    if (_rectangleFreeSelection != null) {
      foregrounds
          .add(RectSelectionForegroundRenderer(_rectangleFreeSelection!));
    }
    if (_lassoFreeSelection != null) {
      foregrounds
          .add(LassoSelectionForegroundRenderer(_lassoFreeSelection!, scheme));
    }
    return foregrounds;
  }

  bool _submitTransform(DocumentBloc bloc) {
    if (!_selectionManager.isTransforming) return false;
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return false;
    final current = _getTransformed();
    _selectionManager.deselect();
    bloc.add(_duplicate
        ? ElementsCreated(current!.map((e) => e.element).toList())
        : ElementsChanged(Map.fromEntries(current!.mapIndexed((i, e) {
            final id = _selected[i].element.id;
            if (id == null) return null;
            return MapEntry(id, [e.element]);
          }).whereNotNull())));
    return true;
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) async {
    _onSelectionAdd(context, details.localPosition, false);
    if (_selectionManager.isTransforming) {
      _submitTransform(context.getDocumentBloc());
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

  Future<void> _onSelectionAdd(EventContext context, Offset localPosition,
      [bool forceAdd = false]) async {
    if (_selectionManager.isTransforming) {
      return;
    }
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
    final hits = await rayCast(globalPos, context.getDocumentBloc(),
        context.getCameraTransform(), radius);
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
    _contextMenuOffset =
        details.kind != PointerDeviceKind.mouse ? details.localPosition : null;
  }

  @override
  void onDoubleTap(EventContext context) {
    if (_contextMenuOffset == null) return;
    _onSelectionContext(context, _contextMenuOffset!);
  }

  Future<void> _onSelectionContext(
      EventContext context, Offset localPosition) async {
    if (_selectionManager.isTransforming) {
      return;
    }
    final position = context.getCameraTransform().localToGlobal(localPosition);
    final bloc = context.getDocumentBloc();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final hits =
        await rayCast(position, bloc, context.getCameraTransform(), 0.0);
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
          context.getSettingsCubit(),
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

  double? _rulerRotation;
  Offset? _rulerPosition;

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    final viewport = context.getCameraViewport();
    if (viewport.utilities
        .hitRuler(details.localFocalPoint, viewport.toSize())) {
      _rulerRotation = 0;
      _rulerPosition = details.localFocalPoint;
      return true;
    }
    final currentIndex = context.getCurrentIndex();
    if (currentIndex.buttons == kSecondaryMouseButton) {
      return false;
    }
    final cameraTransform = context.getCameraTransform();
    final globalPos = cameraTransform.localToGlobal(details.localFocalPoint);
    final shouldTransform =
        _selectionManager.shouldTransform(globalPos, cameraTransform.size);
    if (shouldTransform) {
      transform(context.getDocumentBloc(),
          _selectionManager.getCornerHit(globalPos, cameraTransform.size),
          position: globalPos);
      return true;
    }
    context.refresh();
    return true;
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) =>
      event.kind == PointerDeviceKind.mouse &&
      event.buttons != kSecondaryMouseButton;

  void _handleRuler(ScaleUpdateDetails details, EventContext context) {
    final state = context.getState();
    if (state == null) return;
    final viewport = context.getCameraViewport();
    var utilitiesState = viewport.utilities.element;
    final currentRotation = details.rotation * 180 / pi * details.scale;
    final delta = currentRotation - _rulerRotation!;
    var angle = utilitiesState.rulerAngle + delta;
    while (angle < 0) {
      angle += 360;
    }
    angle %= 360;
    final currentPos = details.localFocalPoint;
    utilitiesState = utilitiesState.copyWith(
      rulerPosition: utilitiesState.rulerPosition +
          Point(
            currentPos.dx - _rulerPosition!.dx,
            currentPos.dy - _rulerPosition!.dy,
          ),
      rulerAngle: angle,
    );
    _rulerRotation = currentRotation;
    _rulerPosition = currentPos;
    context.getCurrentIndexCubit().updateUtilities(utilities: utilitiesState);
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    if (details.pointerCount > 1) return;
    final globalPos =
        context.getCameraTransform().localToGlobal(details.localFocalPoint);
    if (_rulerRotation != null && _rulerPosition != null) {
      _handleRuler(details, context);
      return;
    }
    if (_selectionManager.isTransforming) {
      _selectionManager.updateCurrentPosition(globalPos);
      context.refresh();
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
    context.refresh();
  }

  @override
  void dispose(DocumentBloc bloc) => _submitTransform(bloc);

  @override
  void onScaleEnd(ScaleEndDetails details, EventContext context) async {
    final rectangleSelection = _rectangleFreeSelection?.normalized();
    final lassoSelection = _lassoFreeSelection;
    if (_rulerRotation != null) {
      _rulerRotation = null;
      return;
    }
    if (_submitTransform(context.getDocumentBloc())) return;
    _lassoFreeSelection = null;
    _rectangleFreeSelection = null;
    if (!context.isCtrlPressed) {
      _selected.clear();
    }
    if (rectangleSelection != null && !rectangleSelection.isEmpty) {
      final hits = await rayCastRect(rectangleSelection,
          context.getDocumentBloc(), context.getCameraTransform());
      _selected.addAll(hits);
    } else if (lassoSelection != null && lassoSelection.isNotEmpty) {
      final hits = await rayCastPolygon(lassoSelection,
          context.getDocumentBloc(), context.getCameraTransform());
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
      ..updateCursor(transform.size);
    context.refresh();
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    Focus.of(context.buildContext).requestFocus();
  }

  @override
  MouseCursor? get cursor => _selectionManager.cursor;

  Future<void> copySelection(
      DocumentBloc bloc, ClipboardManager clipboardManager,
      [bool cut = false]) async {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    if (cut) {
      bloc.add(ElementsRemoved(
          _selected.map((r) => r.element.id).whereNotNull().toList()));
    }
    final point = getSelectionRect()?.topLeft;
    if (point == null) return;
    writeClipboardData(
      clipboardManager,
      AssetFileType.page,
      Uint8List.fromList(
        utf8.encode(
          json.encode(await DocumentPage(
                  content: _selected
                      .map((e) => (e.transform(
                                position: -point,
                                relative: true,
                              ) ??
                              e)
                          .element)
                      .toList())
              .toDataJson(state.data)),
        ),
      ),
    );
    _selected.clear();
    bloc.refresh();
  }

  void selectAll(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    _selected.clear();
    _selected.addAll(state.renderers);
    bloc.refresh();
  }

  @override
  Map<Type, Action<Intent>> getActions(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final clipboardManager = context.read<ClipboardManager>();

    return {
      ...super.getActions(context),
      SelectAllTextIntent: CallbackAction<SelectAllTextIntent>(
          onInvoke: (intent) => selectAll(bloc)),
      DeleteCharacterIntent:
          CallbackAction<DeleteCharacterIntent>(onInvoke: (intent) {
        final state = bloc.state;
        if (state is! DocumentLoadSuccess) return null;
        context.read<DocumentBloc>().add(ElementsRemoved(
            _selected.map((r) => r.element.id).whereNotNull().toList()));
        _selected.clear();
        bloc.refresh();
        return null;
      }),
      CopySelectionTextIntent:
          CallbackAction<CopySelectionTextIntent>(onInvoke: (intent) {
        copySelection(bloc, clipboardManager, intent.collapseSelection);
        return null;
      }),
    };
  }
}
