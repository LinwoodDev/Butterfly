part of 'handler.dart';

class HandSelectionRenderer extends Renderer<Rect> {
  final Color color;
  HandSelectionRenderer(super.element, this.color);

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [bool foreground = false]) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..colorFilter =
          ColorFilter.mode(Colors.grey.withOpacity(0.5), BlendMode.srcATop);
    canvas.drawRect(element, paint);
  }
}

class HandHandler extends Handler<HandProperty> {
  List<Renderer<PadElement>> movingElements = [];
  List<Renderer<PadElement>> selected = [];
  Offset? currentMovePosition;

  HandHandler(super.data);

  @override
  Future<bool> onRendererUpdated(
      AppDocument appDocument, Renderer old, Renderer updated) async {
    if (movingElements.contains(old.element) &&
        updated is Renderer<PadElement>) {
      movingElements.remove(old.element);
      movingElements.add(updated);
    } else if (old is Renderer<PadElement> &&
        selected.contains(old) &&
        updated is Renderer<PadElement>) {
      selected.remove(old);
      selected.add(updated);
    } else {
      return false;
    }
    return true;
  }

  Rect? getSelectionRect() {
    Rect? rect;
    for (final element in selected) {
      final current = element.rect;
      if (current != null) {
        rect = rect?.expandToInclude(current) ?? current;
      }
    }
    return rect;
  }

  @override
  List<Renderer> createForegrounds(
      CurrentIndexCubit currentIndexCubit, AppDocument document,
      [Area? currentArea]) {
    final foregrounds = <Renderer>[];
    final color = ThemeManager.getThemeByName(
            currentIndexCubit.state.settingsCubit.state.design)
        .primaryColor;
    if (movingElements.isNotEmpty) {
      final currentElements = movingElements
          .map((e) => currentMovePosition == null
              ? e.element
              : e.move(currentMovePosition!, true))
          .toList();
      final renderers =
          currentElements.map((e) => Renderer.fromInstance(e)).toList();
      foregrounds.addAll(renderers);
    }
    final selectionRect = getSelectionRect();
    if (selectionRect != null) {
      foregrounds.add(HandSelectionRenderer(selectionRect, color));
    }
    return foregrounds;
  }

  void move(BuildContext context, List<Renderer<PadElement>> next,
      [bool duplicate = false]) {
    submitMove(context);
    movingElements = next;
    selected = [];
    currentMovePosition = null;
    if (!duplicate) {
      final bloc = context.read<DocumentBloc>();
      bloc.add(ElementsRemoved(next.map((e) => e.element).toList()));
      bloc.refresh();
    }
  }

  void submitMove(BuildContext context) {
    if (movingElements.isEmpty) return;
    final current = movingElements
        .map((e) =>
            e.move(currentMovePosition ?? Offset.zero, true) ?? e.element)
        .toList();
    currentMovePosition = null;
    movingElements = [];
    final bloc = context.read<DocumentBloc>();
    bloc.add(ElementsCreated(current));
    bloc.refresh();
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) async {
    _onSelectionAdd(context, details.globalPosition, false);
  }

  @override
  void onLongPressDown(
      LongPressDownDetails details, EventContext eventContext) {
    _onSelectionAdd(eventContext, details.globalPosition, true);
  }

  Future<void> _onSelectionAdd(EventContext context, Offset localPosition,
      [bool forceAdd = false]) async {
    if (movingElements.isNotEmpty) {
      return;
    }
    final transform = context.getCameraTransform();
    final settings = context.getSettings();
    final radius = settings.selectSensitivity / transform.size;
    final hits = await rayCast(context.buildContext, localPosition, radius);
    if (hits.isEmpty) {
      if (!context.isCtrlPressed) {
        selected.clear();
        context.refresh();
      }
      return;
    }
    final hit = hits.first;
    if (context.isCtrlPressed) {
      if (selected.contains(hit)) {
        selected.remove(hit);
      } else {
        selected.add(hit);
      }
    } else {
      selected.clear();
      selected.add(hit);
    }
    context.refresh();
  }

  @override
  void onSecondaryTapUp(TapUpDetails details, EventContext context) async {
    _onSelectionContext(context, details.localPosition);
  }

  @override
  void onDoubleTapDown(TapDownDetails details, EventContext eventContext) {
    _onSelectionContext(eventContext, details.localPosition);
  }

  Future<void> _onSelectionContext(
      EventContext context, Offset localPosition) async {
    if (movingElements.isNotEmpty) {
      return;
    }
    final providers = context.getProviders();
    final hits = await rayCast(context.buildContext, localPosition, 0.0);
    final hit = hits.firstOrNull;
    final rect = hit?.rect;
    if ((hit == null ||
            rect == null ||
            !(getSelectionRect()?.overlaps(rect) ?? false)) &&
        !context.isCtrlPressed) {
      selected.clear();
      if (hit != null) selected.add(hit);
    }
    context.refresh();
    if (selected.isEmpty) {
      await showContextMenu(
        context: context.buildContext,
        position: localPosition,
        builder: (ctx, close) => MultiBlocProvider(
          providers: providers,
          child: Actions(
            actions: context.getActions(),
            child: RepositoryProvider.value(
              value: context.getImportService(),
              child: BackgroundContextMenu(
                close: close,
                position: localPosition,
              ),
            ),
          ),
        ),
      );
      return;
    }
    await showContextMenu(
        context: context.buildContext,
        position: localPosition,
        builder: (ctx, close) => MultiBlocProvider(
            providers: context.getProviders(),
            child: RepositoryProvider.value(
              value: context.getImportService(),
              child: Actions(
                actions: context.getActions(),
                child: ElementsDialog(
                    close: close, position: localPosition, renderers: selected),
              ),
            )));
    selected.clear();
    context.refresh();
  }

  @override
  void onScaleStart(ScaleStartDetails details, EventContext context) {
    if (movingElements.isNotEmpty) {
      currentMovePosition =
          context.getCameraTransform().localToGlobal(details.localFocalPoint) -
              (movingElements.first.rect?.center ?? Offset.zero) *
                  context.getCameraTransform().size;
    }
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails details, EventContext context) {
    if (movingElements.isNotEmpty) {
      var current = currentMovePosition ?? Offset.zero;
      current += details.focalPointDelta / context.getCameraTransform().size;
      currentMovePosition = current;
      context.refresh();
      return;
    }
    context
        .getTransformCubit()
        .move(details.focalPointDelta / context.getCameraTransform().size);
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    if (movingElements.isNotEmpty) {
      currentMovePosition =
          context.getCameraTransform().localToGlobal(event.localPosition) -
              (movingElements.first.rect?.center ?? Offset.zero);
      context.refresh();
    }
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    if (movingElements.isNotEmpty) {
      submitMove(context.buildContext);
    }
  }
}
