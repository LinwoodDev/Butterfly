part of 'handler.dart';

class LayerHandler extends Handler<LayerPainter> {
  LayerHandler(super.data);

  @override
  Future<void> onPointerMove(
      PointerMoveEvent event, EventContext context) async {
    final transform = context.getCameraTransform();
    final state = context.getState();
    if (state == null) return;
    final hits = await rayCast(
        transform.localToGlobal(event.localPosition),
        context.getDocumentBloc(),
        context.getCameraTransform(),
        data.strokeWidth / transform.size);
    context.addDocumentEvent(ElementsLayerChanged(
        state.currentLayer, hits.map((e) => e.element).toList()));
  }
}
