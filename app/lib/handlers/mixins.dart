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
    context.getCurrentIndexCubit().refreshToolbar(context.getDocumentBloc());
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
        final state = bloc.state;
        state.currentIndexCubit?.changeTemporaryHandler(
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
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) {
    final renderers = super.createForegrounds(
      currentIndexCubit,
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
    context.refresh();
  }

  @mustCallSuper
  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refresh();
  }
}

abstract class PastingHandler<T> extends Handler<T> {
  Offset? _firstPos;
  Offset? _secondPos;
  bool _aspectRatio = false, _center = false;
  String _currentCollection = '';

  bool _startedDrawing = false;
  bool get startedDrawing => _startedDrawing;

  PastingHandler(super.data);

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [
    if (_firstPos != null && _secondPos != null)
      ...getTransformed(currentIndexCubit).map((e) => Renderer.fromInstance(e)),
  ];

  List<PadElement> transformElements(
    Rect rect,
    String collection,
    CurrentIndexCubit cubit,
  );

  bool get shouldNormalize => true;

  List<PadElement> getTransformed(CurrentIndexCubit cubit) {
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
      bottom = top + height;
    }
    if (constraintedWidth != 0) {
      width = constraintedWidth;
      right = left + width;
    }
    if (aspectRatio != 0 &&
        (constraintedHeight == 0 || constraintedWidth == 0)) {
      if (constraintedHeight != 0) {
        height = constraintedHeight;
        width = constraintedAspectRatio * height;
        right = left + width;
      } else if (constraintedWidth != 0) {
        width = constraintedWidth;
        height = width / constraintedAspectRatio;
        bottom = top + height;
      } else {
        final largest = max(width, height);
        width = aspectRatio * largest;
        height = largest / aspectRatio;
        right = left + width;
        bottom = top + height;
      }
    }
    if (_center) {
      top -= height;
      left -= width;
    }
    final rect = Rect.fromLTRB(left, top, right, bottom);
    return transformElements(rect, _currentCollection, cubit);
  }

  void _updateElement(
    PointerEvent event,
    EventContext context, [
    bool first = false,
  ]) {
    _startedDrawing = true;
    final transform = context.getCameraTransform();
    var localPos = event.localPosition;
    final currentIndex = context.getCurrentIndex();
    final viewportSize = context.viewportSize;
    localPos = PointerManipulationHandler.calculatePointerPosition(
      currentIndex,
      localPos,
      viewportSize,
      transform,
    );
    final globalPos = transform.localToGlobal(localPos);
    if (!context.getDocumentBloc().isInBounds(globalPos)) return;
    if (first) _firstPos = globalPos;
    if (!first && _firstPos == null) return;
    _secondPos = globalPos;
    _aspectRatio = context.isCtrlPressed;
    _center = context.isShiftPressed ^ drawFromCenter;
    _currentCollection = context.getState()?.currentCollection ?? '';

    context.refresh();
  }

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) =>
      _updateElement(event, context, true);
  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) =>
      _updateElement(event, context);

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    final bloc = context.getDocumentBloc();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final elements = getTransformed(state.currentIndexCubit);
    if (elements.isEmpty) return;
    final current = List<PadElement>.from(elements);
    bloc.add(ElementsCreated(current));
    _firstPos = null;
    _secondPos = null;
    context.refresh();
  }

  @override
  void onScaleStartAbort(ScaleStartDetails details, EventContext context) {
    _firstPos = null;
    _secondPos = null;
    context.refresh();
  }

  double get constraintedAspectRatio => 0;
  double get constraintedWidth => 0;
  double get constraintedHeight => 0;
  bool get drawFromCenter => false;

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
    CurrentIndex index,
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
