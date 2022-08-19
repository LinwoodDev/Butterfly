part of 'handler.dart';

class EraserHandler extends Handler<EraserPainter> {
  Map<int, EraserElement> elements = {};
  List<EraserElement> submittedElements = [];
  Map<int, Offset> lastPositions = {};

  EraserHandler(super.data);

  @override
  List<Renderer> createForegrounds(AppDocument document, [Area? currentArea]) {
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
  void onPointerUp(
      Size viewportSize, BuildContext context, PointerUpEvent event) {
    addPoint(
        context, event.pointer, event.localPosition, event.pressure, event.kind,
        refresh: false);
    submitElement(viewportSize, context, event.pointer);
  }

  Future<void> submitElement(
      Size viewportSize, BuildContext context, int index) async {
    final bloc = context.read<DocumentBloc>();
    lastPositions.remove(index);
    var element = elements.remove(index);
    if (element == null) return;
    submittedElements.add(element);
    if (elements.isEmpty) {
      final current = List<PadElement>.from(submittedElements);
      submittedElements.clear();
      bloc.add(ElementsCreated(current));
      await bloc.bake();
    }
    bloc.refresh();
  }

  void addPoint(BuildContext context, int pointer, Offset localPosition,
      double pressure, PointerDeviceKind kind,
      {bool refresh = true, bool forceCreate = false}) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final settings = context.read<SettingsCubit>().state;
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
    if (refresh) bloc.refresh();
  }

  @override
  void onTapDown(
      Size viewportSize, BuildContext context, TapDownDetails details) {}

  @override
  void onPointerDown(
      Size viewportSize, BuildContext context, PointerDownEvent event) {
    final cubit = context.read<CurrentIndexCubit>();
    if (cubit.state.moveEnabled && event.kind != PointerDeviceKind.stylus) {
      elements.clear();
      return;
    }
    addPoint(
        context, event.pointer, event.localPosition, event.pressure, event.kind,
        forceCreate: true);
  }

  @override
  void onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {
    addPoint(context, event.pointer, event.localPosition, event.pressure,
        event.kind);
  }

  @override
  void onPointerHover(
      Size viewportSize, BuildContext context, PointerHoverEvent event) {
    lastPositions[event.pointer] = event.localPosition;
    context.read<DocumentBloc>().refresh();
  }

  @override
  void onPointerGestureMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {
    lastPositions.remove(event.pointer);
  }
}
