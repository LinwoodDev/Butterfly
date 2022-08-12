part of 'handler.dart';

class PathEraserHandler extends Handler<PathEraserPainter> {
  PathEraserHandler(super.data);

  @override
  Future<void> onPointerMove(
      PointerMoveEvent event, EventContext context) async {
    final transform = context.getCameraTransform();
    final hits = await rayCast(context.buildContext, event.localPosition,
        data.strokeWidth / transform.size, data.includeEraser);
    context
        .addDocumentEvent(ElementsRemoved(hits.map((e) => e.element).toList()));
  }
}
