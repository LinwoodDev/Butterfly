part of 'handler.dart';

class PenHandler extends Handler<PenPainter> {
  Map<int, PenElement> elements = {};
  List<PenElement> submittedElements = [];
  Map<int, Offset> lastPosition = {};

  PenHandler(super.data);

  @override
  List<Renderer> createForegrounds(AppDocument document, [Area? currentArea]) {
    return elements.values
        .map((e) {
          if (e.points.length > 1) return PenRenderer(e);
          return null;
        })
        .whereType<Renderer>()
        .toList()
      ..addAll(submittedElements.map((e) => PenRenderer(e)));
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
    var element = elements.remove(index);
    if (element == null) return;
    lastPosition.remove(index);
    submittedElements.add(element);
    if (elements.isEmpty) {
      final current = List<PadElement>.from(submittedElements);
      bloc.add(ElementsCreated(current));
      await bloc.bake();
      bloc.refresh();
      submittedElements.clear();
    }
  }

  void addPoint(BuildContext context, int pointer, Offset localPosition,
      double pressure, PointerDeviceKind kind,
      {bool refresh = true, bool shouldCreate = false}) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final settings = context.read<SettingsCubit>().state;
    final penOnlyInput = settings.penOnlyInput;
    if (lastPosition[pointer] == localPosition) return;
    lastPosition[pointer] = localPosition;
    if (penOnlyInput && kind != PointerDeviceKind.stylus) {
      return;
    }
    double zoom = data.zoomDependent ? transform.size : 1;

    final createNew = !elements.containsKey(pointer);

    if (createNew && !shouldCreate) return;

    final element = elements[pointer] ??
        PenElement(
          layer: state.currentLayer,
          property: data.property
              .copyWith(strokeWidth: data.property.strokeWidth / zoom),
        );
    elements[pointer] = element.copyWith(
        points: List<PathPoint>.from(element.points)
          ..add(PathPoint.fromOffset(transform.localToGlobal(localPosition),
              (createNew ? 0 : pressure) / zoom)));
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
      context.read<DocumentBloc>().refresh();
      return;
    }
    elements.remove(event.pointer);
    addPoint(
        context, event.pointer, event.localPosition, event.pressure, event.kind,
        shouldCreate: true);
  }

  @override
  void onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {
    addPoint(context, event.pointer, event.localPosition, event.pressure,
        event.kind);
  }

  @override
  int? getColor(DocumentBloc bloc) => data.property.color;

  @override
  PenPainter? setColor(DocumentBloc bloc, int color) =>
      data.copyWith(property: data.property.copyWith(color: color));
}
