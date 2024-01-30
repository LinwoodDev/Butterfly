part of 'handler.dart';

class PenHandler extends Handler<PenTool> with ColoredHandler {
  final Map<int, PenElement> elements = {};

  final Map<int, Offset> lastPosition = {};

  PenHandler(super.data);

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      elements.values
          .map((e) {
            if (e.points.length > 1) return PenRenderer(e);
            return null;
          })
          .whereType<Renderer>()
          .toList();

  @override
  void resetInput(DocumentBloc bloc) {
    submitElements(bloc, elements.keys.toList());
    elements.clear();
    lastPosition.clear();
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    addPoint(context.buildContext, event.pointer, event.localPosition,
        _getPressure(event), event.kind,
        refresh: false);
    submitElements(context.getDocumentBloc(), [event.pointer]);
  }

  bool _currentlyBaking = false;

  Future<void> submitElements(DocumentBloc bloc, List<int> indexes) async {
    final elements =
        indexes.map((e) => this.elements.remove(e)).whereNotNull().toList();
    if (elements.isEmpty) return;
    lastPosition.removeWhere((key, value) => indexes.contains(key));
    bloc.add(ElementsCreated(elements));
    if (_currentlyBaking) return;
    _currentlyBaking = true;
    await bloc.bake();
    _currentlyBaking = false;
    bloc.refresh();
  }

  void addPoint(BuildContext context, int pointer, Offset localPos,
      double pressure, PointerDeviceKind kind,
      {bool refresh = true, bool shouldCreate = false}) {
    final bloc = context.read<DocumentBloc>();
    final currentIndexCubit = context.read<CurrentIndexCubit>();
    final viewport = currentIndexCubit.state.cameraViewport;
    final transform = context.read<TransformCubit>().state;
    final globalPos = transform.localToGlobal(localPos);
    if (!isInBounds(bloc, globalPos)) return;
    final state = bloc.state as DocumentLoadSuccess;
    final settings = context.read<SettingsCubit>().state;
    final penOnlyInput = settings.penOnlyInput;
    localPos =
        viewport.utilities.getPointerPosition(localPos, currentIndexCubit);
    if (lastPosition[pointer] == localPos) return;
    lastPosition[pointer] = localPos;
    if (penOnlyInput && kind != PointerDeviceKind.stylus) {
      return;
    }
    double zoom = data.zoomDependent ? transform.size : 1;

    final createNew = !elements.containsKey(pointer);

    if (createNew && !shouldCreate) return;

    final element = elements[pointer] ??
        PenElement(
          zoom: transform.size,
          layer: state.currentLayer,
          property: data.property
              .copyWith(strokeWidth: data.property.strokeWidth / zoom),
        );
    elements[pointer] = element.copyWith(
        points: List<PathPoint>.from(element.points)
          ..add(PathPoint.fromPoint(
              globalPos.toPoint(), (createNew ? 0 : pressure) / zoom)));
    if (refresh) bloc.refresh();
  }

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    final currentIndex = context.getCurrentIndex();
    if (currentIndex.moveEnabled && event.kind != PointerDeviceKind.stylus) {
      elements.clear();
      context.refresh();
      return;
    }
    elements.remove(event.pointer);
    addPoint(context.buildContext, event.pointer, event.localPosition,
        _getPressure(event), event.kind,
        shouldCreate: true);
  }

  double _getPressure(PointerEvent event) =>
      event.kind == PointerDeviceKind.stylus
          ? (event.pressure - event.pressureMin) /
              (event.pressureMax - event.pressureMin)
          : 0.5;

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) => addPoint(
      context.buildContext,
      event.pointer,
      event.localPosition,
      _getPressure(event),
      event.kind);

  @override
  void onScaleStartAbort(ScaleStartDetails details, EventContext context) {
    elements.clear();
    context.refresh();
  }

  @override
  int getColor() => data.property.color;

  @override
  PenTool setColor(int color) => data.copyWith(
      property: data.property
          .copyWith(color: convertOldColor(color, data.property.color)));

  @override
  MouseCursor get cursor => SystemMouseCursors.precise;
}
