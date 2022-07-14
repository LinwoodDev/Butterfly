part of 'handler.dart';

class LayerHandler extends Handler {
  LayerHandler(super.data);

  @override
  Future<void> onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) async {
    final bloc = context.read<DocumentBloc>();
    final transform = context.read<TransformCubit>().state;
    final painter = cubit.fetchPainter<LayerPainter>(bloc);
    if (painter == null) return;
    final hits = await rayCast(
        context, event.localPosition, painter.strokeWidth / transform.size);
    bloc.add(ElementsLayerChanged(
        painter.layer, hits.map((e) => e.element).toList()));
  }
}
