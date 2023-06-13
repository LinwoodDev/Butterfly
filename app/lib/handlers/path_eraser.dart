part of 'handler.dart';

class PathEraserHandler extends Handler<PathEraserPainter> {
  bool _removeRunning = false;
  PathEraserHandler(super.data);

  @override
  Future<void> onPointerMove(
      PointerMoveEvent event, EventContext context) async {
    if (_removeRunning) return;
    final transform = context.getCameraTransform();
    _removeRunning = true;
    final hits = await rayCast(
      transform.localToGlobal(event.localPosition),
      context.getDocumentBloc(),
      context.getCameraTransform(),
      data.strokeWidth / transform.size,
    );
    context
        .addDocumentEvent(ElementsRemoved(hits.map((e) => e.element).toList()));
    _removeRunning = false;
  }
}
