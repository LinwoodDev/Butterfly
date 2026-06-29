part of 'handler.dart';

mixin ColoredHandler<T extends Tool> on Handler<T> {
  SRGBColor getColor();
  T setColor(SRGBColor color);
  double? getStrokeWidth() => null;
  T setStrokeWidth(double width) => data;

  bool _startedDrawing = false;

  void changeStartedDrawing(EventContext context) {
    if (_startedDrawing) return;
    _startedDrawing = true;
    context.getEditorController().refreshToolbar(context.getDocumentBloc());
  }

  @override
  PreferredSizeWidget? getToolbar(DocumentBloc bloc) {
    final visiblity = bloc.state.settingsCubit.state.simpleToolbarVisibility;
    if (visiblity == SimpleToolbarVisibility.hide ||
        (_startedDrawing && visiblity == SimpleToolbarVisibility.temporary)) {
      return null;
    }
    return ColorToolbarView(
      color: getColor(),
      onChanged: (value) => changeToolColor(bloc, value),
      onEyeDropper: (context) {
        bloc.editorController.changeTemporaryHandler(
          context,
          EyeDropperTool(),
          bloc: bloc,
          temporaryState: TemporaryState.removeAfterRelease,
        );
      },
      strokeWidth: getStrokeWidth(),
      onStrokeWidthChanged: (value) => changeToolStrokeWidth(bloc, value),
    );
  }

  void changeToolColor(DocumentBloc bloc, SRGBColor value) =>
      changeTool(bloc, setColor(value));

  void changeToolStrokeWidth(DocumentBloc bloc, double value) =>
      changeTool(bloc, setStrokeWidth(value));
}

mixin HandlerWithCursor<T> on Handler<T> {
  Offset? _currentPos;

  Renderer createCursor(Offset position);

  @mustCallSuper
  @override
  List<Renderer> createForegrounds(
    EditorController editorController,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) {
    final renderers = super.createForegrounds(
      editorController,
      document,
      page,
      info,
    );
    if (_currentPos != null) {
      renderers.add(createCursor(_currentPos!));
    }
    return renderers;
  }

  @mustCallSuper
  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refreshForegrounds();
  }

  @mustCallSuper
  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refreshForegrounds();
  }
}

abstract class PastingHandler<T> extends Handler<T> {
  Offset? _firstPos;
  Offset? _secondPos;
  Offset? _hoverPos;
  Future<void>? _prepareFuture;
  bool _aspectRatio = false, _center = false;
  String _currentCollection = '';

  bool _startedDrawing = false;
  bool get startedDrawing => _startedDrawing;

  PastingHandler(super.data);

  @override
  List<Renderer> createForegrounds(
    EditorController editorController,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [
    if (_firstPos != null && _secondPos != null)
      ...getTransformed(editorController).map((e) => Renderer.fromInstance(e)),
    if (_firstPos == null && showHoverPreview && _hoverPos != null)
      ...transformElements(
        Rect.fromPoints(_hoverPos!, _hoverPos!),
        _currentCollection,
        editorController,
      ).map(Renderer.fromInstance),
  ];

  List<PadElement> transformElements(
    Rect rect,
    String collection,
    EditorController cubit,
  );

  @protected
  FutureOr<void> preparePaste(EventContext context) {}

  Future<void> _preparePaste(EventContext context) =>
      _prepareFuture ??= Future.sync(() => preparePaste(context));

  bool get shouldNormalize => true;

  List<PadElement> getTransformed(EditorController cubit) {
    final first = _firstPos;
    final second = _secondPos;
    if (first == null || second == null) return [];
    double top, left, bottom, right;
    if (shouldNormalize) {
      top = min(first.dy, second.dy);
      left = min(first.dx, second.dx);
      bottom = max(first.dy, second.dy);
      right = max(first.dx, second.dx);
    } else {
      top = first.dy;
      left = first.dx;
      bottom = second.dy;
      right = second.dx;
    }
    final horizontalDirection = right >= left ? 1 : -1;
    final verticalDirection = bottom >= top ? 1 : -1;
    var width = (right - left).abs();
    var height = (bottom - top).abs();
    var aspectRatio = constraintedAspectRatio;
    if (_aspectRatio) {
      if (aspectRatio == 0) {
        aspectRatio = 1;
      } else {
        aspectRatio = 0;
      }
    }
    if (constraintedHeight != 0) {
      height = constraintedHeight;
      bottom = top + height * verticalDirection;
    }
    if (constraintedWidth != 0) {
      width = constraintedWidth;
      right = left + width * horizontalDirection;
    }
    if (aspectRatio != 0 &&
        (constraintedHeight == 0 || constraintedWidth == 0)) {
      if (constraintedHeight != 0) {
        height = constraintedHeight;
        width = constraintedAspectRatio * height;
        right = left + width * horizontalDirection;
      } else if (constraintedWidth != 0) {
        width = constraintedWidth;
        height = width / constraintedAspectRatio;
        bottom = top + height * verticalDirection;
      } else {
        final largest = max(width, height);
        width = aspectRatio * largest;
        height = largest / aspectRatio;
        right = left + width * horizontalDirection;
        bottom = top + height * verticalDirection;
      }
    }
    if (_center) {
      top -= height * verticalDirection;
      left -= width * horizontalDirection;
    }
    final rect = Rect.fromLTRB(left, top, right, bottom);
    return transformElements(rect, _currentCollection, cubit);
  }

  Offset _getGlobalPosition(Offset localPosition, EventContext context) {
    final transform = context.getCameraTransform();
    var localPos = localPosition;
    final currentIndex = context.getToolState();
    final viewportSize = context.viewportSize;
    localPos = PointerManipulationHandler.calculatePointerPosition(
      currentIndex,
      localPos,
      viewportSize,
      transform,
    );
    return transform.localToGlobal(localPos);
  }

  void _updateElement(
    Offset localPosition,
    EventContext context, [
    bool first = false,
  ]) {
    _startedDrawing = true;
    final globalPos = _getGlobalPosition(localPosition, context);
    if (!context.getDocumentBloc().isInBounds(globalPos)) return;
    if (first) _firstPos = globalPos;
    if (!first && _firstPos == null) return;
    _secondPos = globalPos;
    _hoverPos = null;
    _aspectRatio = context.isCtrlPressed;
    _center = context.isShiftPressed ^ drawFromCenter;
    _currentCollection = context.getState()?.currentCollection ?? '';

    context.refreshForegrounds();
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    if (!showHoverPreview) return;
    _hoverPos = _getGlobalPosition(event.localPosition, context);
    _currentCollection = context.getState()?.currentCollection ?? '';
    unawaited(_preparePaste(context).then((_) => context.refreshForegrounds()));
    context.refreshForegrounds();
  }

  @override
  @mustCallSuper
  Future<void> onTapUp(TapUpDetails details, EventContext context) async {
    _firstPos = null;
    _secondPos = null;
    await _preparePaste(context);
    _updateElement(details.localPosition, context, true);
    _createElements(context.getDocumentBloc(), context);
  }

  @override
  @mustCallSuper
  bool onScaleStart(ScaleStartDetails details, EventContext context) {
    unawaited(_preparePaste(context).then((_) => context.refreshForegrounds()));
    _updateElement(details.localFocalPoint, context, true);
    return true;
  }

  @override
  @mustCallSuper
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    _updateElement(details.localFocalPoint, context);
  }

  @override
  @mustCallSuper
  void onScaleEnd(ScaleEndDetails details, EventContext context) async {
    await _preparePaste(context);
    _createElements(context.getDocumentBloc(), context);
  }

  void _createElements(DocumentBloc bloc, EventContext context) {
    final elements = getTransformed(bloc.editorController);
    if (elements.isEmpty) return;
    final current = List<PadElement>.from(elements);
    bloc.add(ElementsCreated(current));
    _firstPos = null;
    _secondPos = null;
    context.refresh();
  }

  @override
  @mustCallSuper
  void onScaleStartAbort(ScaleStartDetails details, EventContext context) {
    _firstPos = null;
    _secondPos = null;
    context.refreshForegrounds();
  }

  double get constraintedAspectRatio => 0;
  double get constraintedWidth => 0;
  double get constraintedHeight => 0;
  bool get drawFromCenter => false;
  bool get showHoverPreview => false;

  bool get currentlyPasting => _firstPos != null && _secondPos != null;
}

mixin PointerManipulationHandler<T> on Handler<T> {
  Offset getPointerPosition(
    Offset position,
    Size viewportSize, [
    CameraTransform transform = const CameraTransform(),
  ]) {
    return position;
  }

  static Offset calculatePointerPosition(
    ToolRuntimeState index,
    Offset position,
    Size viewportSize, [
    CameraTransform transform = const CameraTransform(),
  ]) {
    return index.toggleableHandlers.values
        .whereType<PointerManipulationHandler>()
        .fold(
          position,
          (pos, handler) =>
              handler.getPointerPosition(pos, viewportSize, transform),
        );
  }
}
