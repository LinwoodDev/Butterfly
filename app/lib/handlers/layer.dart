part of 'handler.dart';

class LayerHandler extends Handler {
  @override
  Future<void> onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) async {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final state = bloc.state as DocumentLoadSuccess;
    final painter = state.currentPainter as LayerPainter;
    final hits = await rayCast(
        context, event.localPosition, painter.strokeWidth / transform.size);
    bloc.add(ElementsLayerChanged(
        painter.layer, hits.map((e) => e.element).toList()));
  }
}
