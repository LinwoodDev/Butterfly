part of 'handler.dart';

class PenHandler extends Handler {
  final Map<int, PenElement> elements = {};

  PenHandler();

  @override
  List<PadElement> createForegrounds() => elements.values.toList();

  @override
  void onPointerUp(
      Size viewportSize, BuildContext context, PointerUpEvent event) {
    addPoint(context, event.pointer, event.localPosition, event.pressure);
    submitElement(context, event.pointer);
  }

  void submitElement(BuildContext context, int index) {
    final bloc = context.read<DocumentBloc>();
    var element = elements.remove(index);
    if (element != null) bloc.add(ElementsCreated([element]));
    bloc.add(const IndexRefreshed());
  }

  void addPoint(BuildContext context, int pointer, Offset localPosition,
      double pressure) {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final painter = state.currentPainter as PenPainter;
    double zoom = painter.zoomDependent ? transform.size : 1;

    final element = elements[pointer] ??
        PenElement(layer: state.currentLayer, property: painter.property);

    elements[pointer] = element.copyWith(
        points: List<PathPoint>.from(element.points)
          ..add(PathPoint.fromOffset(
              transform.localToGlobal(localPosition),
              (element.property.strokeWidth +
                      element.property.strokeMultiplier * pressure) *
                  zoom)));
    bloc.add(const IndexRefreshed());
  }

  @override
  void onPointerDown(
          Size viewportSize, BuildContext context, PointerDownEvent event) =>
      addPoint(context, event.pointer, event.localPosition, event.pressure);

  @override
  void onPointerMove(
          Size viewportSize, BuildContext context, PointerMoveEvent event) =>
      addPoint(context, event.pointer, event.localPosition, event.pressure);
}
