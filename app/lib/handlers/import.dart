part of 'handler.dart';

class ImportHandler extends Handler<ImportTool> {
  List<Renderer<PadElement>>? _renderers;
  Offset _offset = Offset.zero;

  ImportHandler(super.data);

  Future<List<Renderer<PadElement>>> _load(
      NoteData document, AssetService assetService, DocumentPage page) async {
    if (_renderers != null) return _renderers!;
    final renderers = data.elements
        .map((e) => Renderer.fromInstance(e))
        .whereType<Renderer<PadElement>>()
        .toList();
    _renderers = renderers;
    return renderers;
  }

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    _offset = event.localPosition;
    context.refresh();
  }

  @override
  Future<void> onPointerHover(PointerHoverEvent event, EventContext context) =>
      _updatePosition(event.localPosition, context);

  @override
  Future<void> onPointerDown(PointerDownEvent event, EventContext context) =>
      _updatePosition(event.localPosition, context);

  Future<void> _updatePosition(
      Offset localPosition, EventContext context) async {
    final transform = context.getCameraTransform();
    _offset = transform.localToGlobal(localPosition);
    final state = context.getState();
    if (state == null) return;
    await _load(state.data, state.assetService, state.page);
    context.refresh();
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) => false;

  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) async {
    final state = context.getState();
    if (state == null) return;
    context.addDocumentEvent(AreasCreated(data.areas
        .map((e) => e.copyWith(
              position: e.position + _offset.toPoint(),
            ))
        .toList()));
    context.addDocumentEvent(ElementsCreated((await _load(
      state.data,
      state.assetService,
      state.page,
    ))
        .map((e) => e.transform(position: _offset, relative: true)?.element)
        .whereNotNull()
        .toList()));
    context
        .getCurrentIndexCubit()
        .resetTemporaryHandler(context.getDocumentBloc());
    context.refresh();
    context.bake();
  }

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      _renderers
          ?.take(3)
          .map((e) => e.transform(position: _offset, relative: true) ?? e)
          .toList() ??
      [];

  @override
  MouseCursor get cursor => SystemMouseCursors.grabbing;
}
