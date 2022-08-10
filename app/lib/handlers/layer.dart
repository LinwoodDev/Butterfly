part of 'handler.dart';

class LayerHandler extends Handler {
  LayerHandler(super.data);

  @override
  Future<void> onPointerMove(
      PointerMoveEvent event, EventContext context) async {
    final transform = context.getCameraTransform();
    final hits = await rayCast(context.buildContext, event.localPosition,
        data.strokeWidth / transform.size);
    context.addDocumentEvent(
        ElementsLayerChanged(data.layer, hits.map((e) => e.element).toList()));
  }
}
