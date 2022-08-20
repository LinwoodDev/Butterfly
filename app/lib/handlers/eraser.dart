part of 'handler.dart';

class EraserHandler extends Handler<EraserPainter> {
  Map<int, EraserElement> elements = {};
  List<EraserElement> submittedElements = [];
  Map<int, Offset> lastPositions = {};

  EraserHandler(super.data);

  @override
  List<Renderer> createForegrounds(
      CurrentIndexCubit currentIndexCubit, AppDocument document,
      [Area? currentArea]) {
    return [
      ...elements.values
          .map((e) {
            if (e.points.length > 1) return EraserRenderer(e);
            return null;
          })
          .whereType<Renderer>()
          .toList()
        ..addAll(submittedElements.map((e) => EraserRenderer(e))),
      ...lastPositions.values.map((e) => EraserCursor(PainterCursor(data, e)))
    ];
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    addPoint(
        context, event.pointer, event.localPosition, event.pressure, event.kind,
        refresh: false);
    submitElement(context, event.pointer);
  }

  Future<void> submitElement(EventContext context, int index) async {
    var element = elements.remove(index);
    if (element == null) return;
    submittedElements.add(element);
    if (elements.isEmpty) {
      final current = List<PadElement>.from(submittedElements);
      submittedElements.clear();
      context.addDocumentEvent(ElementsCreated(current));
      await context.bake();
    }
    context.refresh();
  }

  void addPoint(EventContext context, int pointer, Offset localPosition,
      double pressure, PointerDeviceKind kind,
      {bool refresh = true, bool forceCreate = false}) {
    final transform = context.getCameraTransform();
    final state = context.getState();
    if (state == null) return;
    final settings = context.getSettings();
    final penOnlyInput = settings.penOnlyInput;
    if (lastPositions[pointer] == localPosition && !forceCreate) return;
    lastPositions[pointer] = localPosition;
    if (penOnlyInput && kind != PointerDeviceKind.stylus) {
      return;
    }

    final createNew = !elements.containsKey(pointer);

    if (createNew && !forceCreate) return;

    final element = elements[pointer] ??
        EraserElement(
          layer: state.currentLayer,
          property:
              data.property.copyWith(strokeWidth: data.property.strokeWidth),
        );
    elements[pointer] = element.copyWith(
        points: List<PathPoint>.from(element.points)
          ..add(PathPoint.fromOffset(transform.localToGlobal(localPosition),
              (createNew ? 0 : pressure))));
    if (refresh) context.refresh();
  }

  @override
  void onTapDown(TapDownDetails details, EventContext context) {}

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    final cubit = context.getCurrentIndex();
    if (cubit.moveEnabled && event.kind != PointerDeviceKind.stylus) {
      elements.clear();
      return;
    }
    addPoint(
        context, event.pointer, event.localPosition, event.pressure, event.kind,
        forceCreate: true);
  }

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    addPoint(context, event.pointer, event.localPosition, event.pressure,
        event.kind);
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    lastPosition[event.pointer] = event.localPosition;
    context.refresh();
  }

  @override
  void onPointerGestureMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {
    lastPositions.remove(event.pointer);
  }
}
