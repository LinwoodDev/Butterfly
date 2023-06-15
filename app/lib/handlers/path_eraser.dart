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
    final page = context.getPage();
    if (page == null) return;
    final indexes = hits.map((e) => page.content.indexOf(e.element)).toList();
    context.addDocumentEvent(ElementsRemoved(indexes));
    _removeRunning = false;
  }
}
