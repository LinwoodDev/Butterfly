part of 'handler.dart';

const cornerSize = 32.0;
const visibleSize = cornerSize / 2;

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
      ..color = scheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4 / transform.size
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..colorFilter =
          ColorFilter.mode(Colors.grey.withOpacity(0.5), BlendMode.srcATop);
    canvas.drawRect(element, paint);
    if (transformMode == null) return;
    final color = transformMode == HandTransformMode.scaleProp
        ? scheme.secondary
        : scheme.error;
    final transformPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2 / transform.size
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..colorFilter =
          ColorFilter.mode(Colors.grey.withOpacity(0.5), BlendMode.srcATop);
    final realSize = visibleSize / transform.size;
    if (element.width < 2 * realSize || element.height < 2 * realSize) return;
    final showCenter =
        element.width > 3 * realSize && element.height > 3 * realSize;
    HandTransformCorner.values
        .where((element) => !element.isCenter() || showCenter)
        .forEach((corner) {
      final position = corner.getFromRect(element);
      if (corner == HandTransformCorner.center) {
        if (corner == transformCorner) {
          canvas.drawCircle(
            position,
            realSize,
            paint..style = PaintingStyle.fill,
          );
        } else {
          canvas.drawCircle(
            position,
            realSize,
            transformPaint..style = PaintingStyle.stroke,
          );
        }
      } else {
        if (corner == transformCorner) {
          canvas.drawRect(
            Rect.fromCenter(
              center: position,
              width: realSize,
              height: realSize,
            ),
            paint..style = PaintingStyle.fill,
          );
        } else {
          canvas.drawRect(
            Rect.fromCenter(
              center: position,
              width: realSize,
              height: realSize,
            ),
            transformPaint..style = PaintingStyle.stroke,
          );
        }
      }
    });
  }
}

enum HandTransformMode { scale, scaleProp }

enum HandTransformCorner {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight,

  // For rotating
  center
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

  Offset getFromRect(Rect rect) {
    switch (this) {
      case HandTransformCorner.topLeft:
        return rect.topLeft;
      case HandTransformCorner.topCenter:
        return rect.topCenter;
      case HandTransformCorner.topRight:
        return rect.topRight;
      case HandTransformCorner.centerLeft:
        return rect.centerLeft;
      case HandTransformCorner.centerRight:
        return rect.centerRight;
      case HandTransformCorner.bottomLeft:
        return rect.bottomLeft;
      case HandTransformCorner.bottomCenter:
        return rect.bottomCenter;
      case HandTransformCorner.bottomRight:
        return rect.bottomRight;
      case HandTransformCorner.center:
        return rect.center;
    }
  }
}

class HandHandler extends Handler<HandPainter> {
  HandTransformMode _transformMode = HandTransformMode.scale;
  HandTransformCorner? _transformCorner;
  List<Renderer<PadElement>> _selected = [];
  List<Renderer<PadElement>> _transformed = [];
  Offset? _transformStartOffset;
  Offset _contextMenuOffset = Offset.zero;
  Rect? _freeSelection;
  Offset? _currentMousePosition;

  HandHandler(super.data);

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
    if (!duplicate) {
      bloc.add(ElementsRemoved(next.map((e) => e.element).toList()));
    }
    bloc.refresh();
  }

  @override
  void resetInput(DocumentBloc bloc) {
    _resetTransform();
    _submitTransform(bloc);
    _selected.clear();
    _freeSelection = null;
    _currentMousePosition = null;
    _transformStartOffset = null;
    _transformed = [];
    bloc.refresh();
  }

  @override
  Future<bool> onRendererUpdated(
      DocumentPage page, Renderer old, Renderer updated) async {
    if (old is Renderer<PadElement> &&
        _selected.contains(old) &&
        updated is Renderer<PadElement>) {
      _selected.remove(old);
      _selected.add(updated);
    } else {
      return false;
    }
    return true;
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
        position = Offset(0, delta.dy);
        scaleY += -delta.dy / transformRect.size.height;
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
    scaleX = scaleX.clamp(0.1, 10.0);
    scaleY = scaleY.clamp(0.1, 10.0);
    if (_transformMode == HandTransformMode.scaleProp) {
      final scale = max(scaleX, scaleY);
      scaleX = scale;
      scaleY = scale;
    }
    return _transformed.map((e) {
      var offset = e.rect?.topLeft ?? Offset.zero;
      offset -= transformRect.topLeft;
      offset = offset.scale(scaleX - 1, scaleY - 1);
      offset += position;
      return e.transform(
              position: offset,
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
    if (_freeSelection != null) {
      foregrounds.add(HandSelectionRenderer(_freeSelection!, scheme));
    }
    return foregrounds;
  }

  bool _submitTransform(DocumentBloc bloc) {
    if (_transformed.isEmpty) return false;
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return false;
    final current = _getTransformed();
    _transformed = [];
    _selected.clear();
    _transformCorner = null;
    _transformMode = HandTransformMode.scale;
    bloc.add(ElementsCreated(current?.map((e) => e.element).toList()));
    bloc.refresh();
    return true;
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) async {
    _onSelectionAdd(context, details.localPosition, false);
  }

  @override
  void onLongPressEnd(LongPressEndDetails details, EventContext context) {
    _onSelectionAdd(context, details.localPosition, true);
  }

  HandTransformCorner? _getCornerHit(Offset position) {
    final selectionRect = getSelectionRect();

    if (selectionRect == null) return null;
    return HandTransformCorner.values.firstWhereOrNull((element) {
      final corner = element.getFromRect(selectionRect);
      return Rect.fromCenter(
              center: corner, width: cornerSize, height: cornerSize)
          .contains(position);
    });
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
    _contextMenuOffset = details.localPosition;
  }

  @override
  void onDoubleTap(EventContext context) {
    _onSelectionContext(context, _contextMenuOffset);
  }

  Future<void> _onSelectionContext(
      EventContext context, Offset localPosition) async {
    if (_transformed.isNotEmpty) {
      return;
    }
    final position = context.getCameraTransform().localToGlobal(localPosition);
    final hits = await rayCast(
        position, context.getDocumentBloc(), context.getCameraTransform(), 0.0);
    final hit = hits.firstOrNull;
    final rect = hit?.expandedRect;
    if ((rect != null && !(getSelectionRect()?.contains(position) ?? false)) &&
        !context.isCtrlPressed) {
      _selected.clear();
      if (hit != null) _selected.add(hit);
    }
    context.refresh();
    final buildContext = context.buildContext;
    if (_selected.isEmpty && buildContext.mounted) {
      return;
    }
    if (buildContext.mounted) {
      final result = await showContextMenu<bool>(
        context: buildContext,
        position: localPosition,
        builder: (ctx) => MultiBlocProvider(
          providers: context.getProviders(),
          child: RepositoryProvider.value(
            value: context.getImportService(),
            child: Actions(
              actions: context.getActions(),
              child:
                  ElementsDialog(position: localPosition, renderers: _selected),
            ),
          ),
        ),
      );
      if (result ?? false) {
        _selected.clear();
      }
    }
    context.refresh();
  }

  double? _rulerRotation;

  @override
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    final viewport = context.getCameraViewport();
    if (viewport.tool.hitRuler(details.localFocalPoint, viewport.toSize())) {
      _rulerRotation = 0;
      return true;
    }
    final globalPos =
        context.getCameraTransform().localToGlobal(details.localFocalPoint);
    _currentMousePosition = globalPos;
    final corner = _getCornerHit(globalPos);
    if (corner != null || (getSelectionRect()?.contains(globalPos) ?? false)) {
      transform(context.getDocumentBloc(), _selected, corner);
      return true;
    }
    context.refresh();
    return false;
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) =>
      event.kind == PointerDeviceKind.mouse &&
      event.buttons != kSecondaryMouseButton;

  void _handleRuler(ScaleUpdateDetails details, EventContext context) {
    final state = context.getState();
    if (state == null) return;
    var toolState = context.getCameraViewport().tool.element;
    final currentRotation = details.rotation * 180 / pi * details.scale;
    final delta = currentRotation - _rulerRotation!;
    var angle = toolState.rulerAngle + delta;
    while (angle < 0) {
      angle += 360;
    }
    angle %= 360;
    toolState = toolState.copyWith(
      rulerPosition: toolState.rulerPosition +
          Point(
            details.focalPointDelta.dx,
            details.focalPointDelta.dy,
          ),
      rulerAngle: angle,
    );
    _rulerRotation = currentRotation;
    context
        .getCurrentIndexCubit()
        .updateTool(state.data, state.page, state.assetService, toolState);
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    final currentIndex = context.getCurrentIndex();
    final globalPos =
        context.getCameraTransform().localToGlobal(details.localFocalPoint);
    if (_rulerRotation != null) {
      _handleRuler(details, context);
      return;
    }
    _currentMousePosition = globalPos;
    if (_transformed.isNotEmpty) {
      context.refresh();
      return;
    }
    if (currentIndex.buttons != kSecondaryMouseButton &&
        details.pointerCount == 1 &&
        _transformed.isEmpty) {
      if (details.scale == 1.0) {
        final topLeft = _freeSelection?.topLeft ?? globalPos;
        _freeSelection =
            Rect.fromLTRB(topLeft.dx, topLeft.dy, globalPos.dx, globalPos.dy);
        context.refresh();
      }
      return;
    }
    context
        .getTransformCubit()
        .move(details.focalPointDelta / context.getCameraTransform().size);
  }

  @override
  void onScaleEnd(ScaleEndDetails details, EventContext context) async {
    final freeSelection = _freeSelection?.normalized();
    if (_rulerRotation != null) {
      _rulerRotation = null;
      return;
    }
    if (_submitTransform(context.getDocumentBloc())) return;
    if (freeSelection != null && !freeSelection.isEmpty) {
      _freeSelection = null;
      if (!context.isCtrlPressed) {
        _selected.clear();
      }
      final hits = await rayCastRect(freeSelection, context.getDocumentBloc(),
          context.getCameraTransform());
      _selected.addAll(hits);
      context.refresh();
    }
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    final globalPos =
        context.getCameraTransform().localToGlobal(event.localPosition);
    _currentMousePosition = globalPos;
    _transformCorner = _getCornerHit(globalPos);
    context.refresh();
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    if (_transformed.isNotEmpty) {
      _submitTransform(context.getDocumentBloc());
    }
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
}
