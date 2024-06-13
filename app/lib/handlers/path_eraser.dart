part of 'handler.dart';

class PathEraserHandler extends Handler<PathEraserTool> {
  bool _currentlyErasing = false;
  Offset? _currentPos, _lastErased;
  final Set<String> _erased = {};
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
  Map<String, RendererState> get rendererStates =>
      Map.fromEntries(_erased.map((e) => MapEntry(e, RendererState.hidden)));

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    _currentPos = event.localPosition;
    context.refresh();
  }

  @override
  void resetInput(DocumentBloc bloc) {
    _currentPos = null;
  }

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    super.onPointerDown(event, context);
    _erased.clear();
  }

  @override
  Future<void> onPointerMove(
      PointerMoveEvent event, EventContext context) async {
    _currentPos = event.localPosition;
    final transform = context.getCameraTransform();
    final currentIndex = context.getCurrentIndex();
    final state = context.getState();
    final globalPos = transform.localToGlobal(event.localPosition);
    final size = data.strokeWidth;
    final shouldErase =
        _lastErased == null || (globalPos - _lastErased!).distance > size;
    context.refresh();
    if (_currentlyErasing || !shouldErase) return;
    _currentlyErasing = true;
    _lastErased = globalPos;
    Iterable<Renderer<PadElement>> ray =
        await rayCast(globalPos, context.getDocumentBloc(), transform, size);
    final page = context.getPage();
    if (page == null) return;
    if (!data.eraseElements) ray = ray.where((e) => e.element.isStroke());
    if (currentIndex.utilitiesState.lockLayer) ray = ray.where((e) => e.element.layer == state?.currentLayer);
    var ids = ray.map((e) => e.element.id).whereNotNull();
    _erased.addAll(ids);
    _currentlyErasing = false;
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    if (_erased.isNotEmpty) {
      context.getDocumentBloc().add(ElementsRemoved(_erased.toList()));
    }
  }

  @override
  PreferredSizeWidget? getToolbar(DocumentBloc bloc) => EraserToolbarView(
        eraseElements: data.eraseElements,
        onToggleEraseElements: () =>
            changeTool(bloc, data.copyWith(eraseElements: !data.eraseElements)),
      );
}
