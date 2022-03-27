part of 'handler.dart';

class PenHandler extends Handler {
  final PenPainter painter;
  final Map<int, PadElement> elements;

  PenHandler(this.painter, DocumentBloc bloc) : super(bloc);

  @override
  List<PadElement> createForeground() => elements.values.toList();

  @override
  void onPointerUp(BuildContext context, PointerUpEvent details) {
    final transform = context.read<TransformCubit>().state;
    double zoom = painter.zoomDependent ? transform.size : 1;
    context.read<EditingCubit>().put(
        pointer,
        painter.buildElement(transform.localToGlobal(localPosition), pressure,
            zoom, state.currentLayer));
  }

  @override
  void onPointerDown(BuildContext context, PointerDownEvent details) {
    final transform = context.read<TransformCubit>().state;
    double zoom = painter.zoomDependent ? transform.size : 1;
    final state = bloc.state as DocumentLoadSuccess;
    elements[details.pointer] = PenElement(layer: state.currentLayer, points: [
      PathPoint.fromOffset(transform.localToGlobal(details.localPosition),
          details.pressure * zoom)
    ]);
  }
}
