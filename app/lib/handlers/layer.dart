part of 'handler.dart';

class LayerHandler extends Handler<LayerTool> {
  LayerHandler(super.data);

  @override
  Future<void> onPointerMove(
      PointerMoveEvent event, EventContext context) async {
    final transform = context.getCameraTransform();
    final state = context.getState();
    if (state == null) return;
    final hits = await context.getDocumentBloc().rayCast(
          transform.localToGlobal(event.localPosition),
          data.strokeWidth / transform.size,
          useLayer: true,
        );
    context.addDocumentEvent(ElementsLayerChanged(state.currentCollection,
        hits.map((r) => r.element.id).whereNotNull().toList()));
  }
}
