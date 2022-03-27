part of 'handler.dart';

class PenHandler extends Handler {
  final PenPainter painter;
  final Map<int, PenElement> elements = {};

  PenHandler(this.painter);

  @override
  List<PadElement> createForegrounds() => elements.values.toList();

  @override
  void onPointerUp(BuildContext context, PointerUpEvent event) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    double zoom = painter.zoomDependent ? transform.size : 1;
    final state = bloc.state as DocumentLoadSuccess;
    elements[event.pointer] = PenElement(layer: state.currentLayer, points: [
      PathPoint.fromOffset(
          transform.localToGlobal(event.localPosition), event.pressure * zoom)
    ]);
  }

  void submitElement(BuildContext context, int index) {
    final bloc = context.read<DocumentBloc>();
    var element = elements.remove(index);
    if (element != null) bloc.add(ElementsCreated([element]));
  }

  void addPoint(BuildContext context, int pointer, Offset localPosition,
      double pressure) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    double zoom = painter.zoomDependent ? transform.size : 1;
    final state = bloc.state as DocumentLoadSuccess;
    final element = elements[pointer] ?? PenElement(layer: state.currentLayer);

    elements[pointer] = element.copyWith(
        points: List<PathPoint>.from(element.points)
          ..add(PathPoint.fromOffset(
              transform.localToGlobal(localPosition), pressure * zoom)));
    bloc.add(const IndexRefreshed());
  }

  @override
  void onPointerDown(BuildContext context, PointerDownEvent event) =>
      addPoint(context, event.pointer, event.localPosition, event.pressure);
}
