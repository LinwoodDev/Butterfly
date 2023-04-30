part of 'handler.dart';

class ImportHandler extends Handler<ImportPainter> {
  Offset _position = Offset.zero;
  List<Renderer<PadElement>>? _renderers;

  ImportHandler(super.data);

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    _position = context.getCameraTransform().localToGlobal(event.localPosition);
    context.refresh();
  }

  @override
  Future<void> onPointerHover(
      PointerHoverEvent event, EventContext context) async {
    _position = context.getCameraTransform().localToGlobal(event.localPosition);
    final state = context.getState();
    if (state == null) return;
    await _load(state.data, state.page);
    context.refresh();
  }

  @override
  Future<void> onPointerDown(
      PointerDownEvent event, EventContext context) async {
    _position = context.getCameraTransform().localToGlobal(event.localPosition);
    final state = context.getState();
    if (state == null) return;
    await _load(state.data, state.page);
    context.refresh();
  }

  Future<void> _load(NoteData document, DocumentPage page) async {
    if (_renderers != null) return;
    _renderers = await Future.wait(data.elements.map((e) async {
      final renderer = Renderer.fromInstance(e);
      await renderer.setup(document, page);
      return renderer;
    }).toList());
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) => false;

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    context.addDocumentEvent(ElementsCreated.renderers(_renderers
        ?.map((e) => e.transform(position: _position) ?? e)
        .toList()));
    context.addDocumentEvent(AreasCreated(data.areas
        .map((e) => e.copyWith(
              position: e.position + _position.toPoint(),
            ))
        .toList()));
    context
        .getCurrentIndexCubit()
        .resetTemporaryHandler(context.getDocumentBloc());
    context.refresh();
    context.bake();
  }

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page, [Area? currentArea]) =>
      _renderers?.map((e) => e.transform(position: _position) ?? e).toList() ??
      [];
}
