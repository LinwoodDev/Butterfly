part of 'handler.dart';

class PathEraserHandler extends Handler<PathEraserTool> {
  bool _removeRunning = false;
  Offset? _currentPos;
  PathEraserHandler(super.data);

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      [
        if (_currentPos != null)
          EraserCursor(
              ToolCursorData(EraserInfo.fromPathEraser(data), _currentPos!))
      ];

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refresh();
  }

  @override
  Future<void> onPointerMove(
      PointerMoveEvent event, EventContext context) async {
    _currentPos = event.localPosition;
    context.refresh();
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
