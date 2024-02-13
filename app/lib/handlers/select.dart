part of 'handler.dart';

const cornerSize = 32.0;
const visibleSize = cornerSize / 2;

class LassoHandSelectionRenderer extends Renderer<List<Offset>> {
  final ColorScheme scheme;
  LassoHandSelectionRenderer(super.element, this.scheme);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    final paint = Paint()
      ..color = scheme.primaryContainer
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 / transform.size
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    final fillPaint = Paint()
      ..color = scheme.primaryContainer.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    final path = Path();
    path.addPolygon(element, true);
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, paint);
  }
}

class HandSelectionRenderer extends Renderer<Rect> {
  final ColorScheme scheme;
  final HandTransformMode? transformMode;
  final HandTransformCorner? transformCorner;
  HandSelectionRenderer(super.element, this.scheme,
      [this.transformMode, this.transformCorner]);

  @override
  void build(Canvas canvas, Size size, NoteData document, DocumentPage page,
      DocumentInfo info, CameraTransform transform,
      [ColorScheme? colorScheme, bool foreground = false]) {
    final paint = Paint()
      ..color = scheme.primaryContainer
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 / transform.size
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    canvas.drawRect(element, paint);
    if (transformMode == null) return;
    final color =
        transformMode == HandTransformMode.scaleProp ? Colors.red : Colors.blue;
    final transformPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 / transform.size
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true;
    final realSize = visibleSize / transform.size;
    if (element.width < 2 * realSize || element.height < 2 * realSize) return;
    final showCenter =
        element.width > 3 * realSize && element.height > 3 * realSize;
    HandTransformCorner.values
        .where((element) => !element.isCenter() || showCenter)
        .forEach((corner) {
      final position = corner.getFromRect(element);
      if (corner == HandTransformCorner.center) {
        canvas.drawCircle(
          position,
          realSize,
          transformPaint
            ..style = corner == transformCorner
                ? PaintingStyle.fill
                : PaintingStyle.stroke,
        );
      } else {
        canvas.drawRect(
          Rect.fromCenter(
            center: position,
            width: realSize,
            height: realSize,
          ),
          transformPaint
            ..style = corner == transformCorner
                ? PaintingStyle.fill
                : PaintingStyle.stroke,
        );
      }
    });
  }
}

enum HandTransformMode { scale, scaleProp }

enum HandTransformCorner {
  // For rotating
  center,

  topLeft,
  topCenter,
  topRight,
  centerLeft,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

extension HandTransformCornerExtension on HandTransformCorner {
  bool isCenter() {
    switch (this) {
      case HandTransformCorner.topCenter:
      case HandTransformCorner.centerLeft:
      case HandTransformCorner.centerRight:
      case HandTransformCorner.bottomCenter:
        return true;
      default:
        return false;
    }
  }

  Offset getFromRect(Rect rect) => switch (this) {
        HandTransformCorner.topLeft => rect.topLeft,
        HandTransformCorner.topCenter => rect.topCenter,
        HandTransformCorner.topRight => rect.topRight,
        HandTransformCorner.centerLeft => rect.centerLeft,
        HandTransformCorner.centerRight => rect.centerRight,
        HandTransformCorner.bottomLeft => rect.bottomLeft,
        HandTransformCorner.bottomCenter => rect.bottomCenter,
        HandTransformCorner.bottomRight => rect.bottomRight,
        HandTransformCorner.center => rect.center,
      };
}

class SelectHandler extends Handler<SelectTool> {
  HandTransformMode _transformMode = HandTransformMode.scale;
  HandTransformCorner? _transformCorner;
  List<Renderer<PadElement>> _selected = [];
  List<Renderer<PadElement>> _transformed = [];
  bool _duplicate = false;
  Offset? _transformStartOffset;
  Offset? _contextMenuOffset;
  Rect? _rectangleFreeSelection;
  List<Offset>? _lassoFreeSelection;
  Offset? _currentMousePosition;
  double _scale = 1.0;

  SelectHandler(super.data);

  void toggleScaleMode(DocumentBloc bloc) {
    _transformMode = _transformMode == HandTransformMode.scaleProp
        ? HandTransformMode.scale
        : HandTransformMode.scaleProp;
    bloc.refresh();
  }

  void transform(DocumentBloc bloc, List<Renderer<PadElement>> next,
      HandTransformCorner? corner,
      [bool duplicate = false]) {
    _submitTransform(bloc);
    _transformed = next;
    _selected = [];
    _transformCorner = corner;
    _transformStartOffset = _currentMousePosition;
    _duplicate = duplicate;
    bloc.refresh();
  }

  @override
  Map<Renderer, RendererState> get rendererStates => Map.fromEntries(
      _transformed.map((e) => MapEntry(e, RendererState.hidden)));

  @override
  void resetInput(DocumentBloc bloc) {
    _resetTransform();
    _submitTransform(bloc);
    _rectangleFreeSelection = null;
    _lassoFreeSelection = null;
    _currentMousePosition = null;
    _transformStartOffset = null;
    _transformed = [];
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
    if (old is Renderer<PadElement> &&
        _transformed.contains(old) &&
        updated is List<Renderer<PadElement>>) {
      _transformed.remove(old);
      _transformed.addAll(updated);
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

  Rect? _getTransformedRect() {
    Rect? rect;
    for (final element in _transformed) {
      final current = element.expandedRect;
      if (current != null) {
        rect = rect?.expandToInclude(current) ?? current;
      }
    }
    return rect;
  }

  List<Renderer<PadElement>>? _getTransformed() {
    final transformRect = _getTransformedRect();
    final corner = _transformCorner;
    final offset = _currentMousePosition;
    final previous = _transformStartOffset ?? offset;
    if (offset == null || transformRect == null || previous == null) {
      return null;
    }
    final delta = offset - previous;
    var scaleX = 1.0;
    var scaleY = 1.0;
    var position = Offset.zero;
    var rotation = 0.0;
    switch (corner) {
      case HandTransformCorner.topLeft:
        position = delta;
        scaleX += -delta.dx / transformRect.size.width;
        scaleY += -delta.dy / transformRect.size.height;
        break;
      case HandTransformCorner.topCenter:
        scaleY += -delta.dy / transformRect.size.height;
        position = Offset(0, delta.dy);
        break;
      case HandTransformCorner.topRight:
        position = Offset(0, delta.dy);
        scaleX += delta.dx / transformRect.size.width;
        scaleY += -delta.dy / transformRect.size.height;
        break;
      case HandTransformCorner.centerLeft:
        position = Offset(delta.dx, 0);
        scaleX += -delta.dx / transformRect.size.width;
        break;
      case HandTransformCorner.centerRight:
        scaleX += delta.dx / transformRect.size.width;
        break;
      case HandTransformCorner.bottomLeft:
        position = Offset(delta.dx, 0);
        scaleX += -delta.dx / transformRect.size.width;
        scaleY += delta.dy / transformRect.size.height;
        break;
      case HandTransformCorner.bottomCenter:
        scaleY += delta.dy / transformRect.size.height;
        break;
      case HandTransformCorner.bottomRight:
        scaleX += delta.dx / transformRect.size.width;
        scaleY += delta.dy / transformRect.size.height;
        break;
      case HandTransformCorner.center:
        rotation = offset.getRotation(transformRect.center) / pi * 180;
        break;
      default:
        position = delta;
    }
    if (_transformMode == HandTransformMode.scaleProp) {
      final scale = max(scaleX, scaleY);
      scaleX = scale;
      scaleY = scale;
    }
    final pivot = transformRect.center;

    return _transformed.map((e) {
      var oldPos = e.expandedRect?.topLeft ?? Offset.zero;
      var diff = oldPos - transformRect.topLeft;
      // Scale and calculate relative position based on transformRect
      var newPos =
          Offset(diff.dx * (scaleX - 1), diff.dy * (scaleY - 1)) + position;
      // Rotate around center
      if (rotation != 0) {
        final center = e.expandedRect?.center ?? Offset.zero;
        newPos += center.rotate(pivot, rotation / 180 * pi) - center;
      }
      return e.transform(
              position: newPos,
              scaleX: scaleX,
              scaleY: scaleY,
              rotation: rotation,
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
      foregrounds.add(HandSelectionRenderer(
          selectionRect, scheme, _transformMode, _transformCorner));
    }
    if (_rectangleFreeSelection != null) {
      foregrounds.add(HandSelectionRenderer(_rectangleFreeSelection!, scheme));
    }
    if (_lassoFreeSelection != null) {
      foregrounds.add(LassoHandSelectionRenderer(_lassoFreeSelection!, scheme));
    }
    return foregrounds;
  }

  bool _submitTransform(DocumentBloc bloc) {
    if (_transformed.isEmpty) return false;
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return false;
    final current = _getTransformed();
    _selected = _transformed;
    _transformCorner = null;
    _transformMode = HandTransformMode.scale;
    _transformed = [];
    bloc.add(_duplicate
        ? ElementsCreated(current!.map((e) => e.element).toList())
        : ElementsChanged(Map.fromEntries(current!.mapIndexed((i, e) =>
            MapEntry(state.page.content.indexOf(_selected[i].element),
                [e.element])))));
    return true;
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) async {
    _onSelectionAdd(context, details.localPosition, false);
    if (_transformed.isNotEmpty) {
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

  HandTransformCorner? _getCornerHit(Offset position) {
    final selectionRect = getSelectionRect();

    if (selectionRect == null) return null;
    final hits = HandTransformCorner.values.where((element) {
      final corner = element.getFromRect(selectionRect);
      return Rect.fromCenter(
              center: corner,
              width: cornerSize / _scale,
              height: cornerSize / _scale)
          .contains(position);
    }).toList();
    if (hits.length == HandTransformCorner.values.length) return null;
    return hits.firstOrNull;
  }

  Future<void> _onSelectionAdd(EventContext context, Offset localPosition,
      [bool forceAdd = false]) async {
    if (_transformed.isNotEmpty) {
      return;
    }
    final transform = context.getCameraTransform();
    final globalPos = transform.localToGlobal(localPosition);
    final selectionRect = getSelectionRect();
    if (selectionRect?.contains(globalPos) ?? false) {
      toggleScaleMode(context.getDocumentBloc());
      return;
    }
    _resetTransform();
    final settings = context.getSettings();
    final radius = settings.selectSensitivity / transform.size;
    final hits = await rayCast(globalPos, context.getDocumentBloc(),
        context.getCameraTransform(), radius);
    if (hits.isEmpty) {
      if (!context.isCtrlPressed) {
        _selected.clear();
        _resetTransform();
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
    _resetTransform();
    context.refresh();
  }

  void _resetTransform() {
    _transformCorner = null;
    _transformMode = HandTransformMode.scale;
    _transformStartOffset = null;
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
    if (_transformed.isNotEmpty) {
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
    final cameraTransform = context.getCameraTransform();
    final globalPos = cameraTransform.localToGlobal(details.localFocalPoint);
    _currentMousePosition = globalPos;
    _scale = cameraTransform.size;
    _transformCorner = _getCornerHit(globalPos);
    if (_transformCorner != null ||
        (getSelectionRect()?.contains(globalPos) ?? false)) {
      transform(context.getDocumentBloc(), _selected, _transformCorner);
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
    final currentIndex = context.getCurrentIndex();
    final globalPos =
        context.getCameraTransform().localToGlobal(details.localFocalPoint);
    if (_rulerRotation != null && _rulerPosition != null) {
      _handleRuler(details, context);
      return;
    }
    _currentMousePosition = globalPos;
    if (_transformed.isNotEmpty) {
      context.refresh();
      return;
    }
    if (currentIndex.buttons != kSecondaryMouseButton && _transformed.isEmpty) {
      if (details.scale == 1.0) {
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
      return;
    }
    context
        .getCurrentIndexCubit()
        .move(-details.focalPointDelta / context.getCameraTransform().size);
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
      return;
    }
    context.refresh();
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    final transform = context.getCameraTransform();
    final globalPos = transform.localToGlobal(event.localPosition);
    _currentMousePosition = globalPos;
    _scale = transform.size;
    _transformCorner = _getCornerHit(globalPos);
    context.refresh();
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    Focus.of(context.buildContext).requestFocus();
  }

  @override
  MouseCursor? get cursor {
    if (_currentMousePosition == null) return null;
    final corner = _getCornerHit(_currentMousePosition!);
    return switch (corner) {
          HandTransformCorner.bottomCenter ||
          HandTransformCorner.topCenter =>
            SystemMouseCursors.resizeUpDown,
          HandTransformCorner.centerLeft ||
          HandTransformCorner.centerRight =>
            SystemMouseCursors.resizeLeftRight,
          HandTransformCorner.topLeft ||
          HandTransformCorner.bottomRight =>
            SystemMouseCursors.resizeUpLeftDownRight,
          HandTransformCorner.topRight ||
          HandTransformCorner.bottomLeft =>
            SystemMouseCursors.resizeUpRightDownLeft,
          HandTransformCorner.center => SystemMouseCursors.grab,
          _ => null,
        } ??
        (getSelectionRect()?.contains(_currentMousePosition!) ?? false
            ? SystemMouseCursors.move
            : null);
  }

  Future<void> copySelection(
      DocumentBloc bloc, ClipboardManager clipboardManager,
      [bool cut = false]) async {
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    if (cut) {
      bloc.add(ElementsRemoved(_selected
          .map((r) => state.page.content.indexOf(r.element))
          .toList()));
    }
    final point = getSelectionRect()?.topLeft;
    if (point == null) return;
    final clipboard = (
      type: AssetFileType.page.name,
      data: Uint8List.fromList(
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
    clipboardManager.setContent(clipboard);
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
        context.read<DocumentBloc>().add(ElementsRemoved(_selected
            .map((r) => state.page.content.indexOf(r.element))
            .toList()));
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
