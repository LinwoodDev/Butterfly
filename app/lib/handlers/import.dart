part of 'handler.dart';

class ImportHandler extends Handler<ImportPainter> {
  Offset _position = Offset.zero;
  List<Renderer<PadElement>>? _renderers;

  ImportHandler(super.data);

  @override
  void dispose(DocumentBloc bloc) {
    print('dispose');
    _renderers?.forEach((e) => e.dispose());
  }

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
    context.refresh();
  }

  @override
  Future<void> onPointerDown(
      PointerDownEvent event, EventContext context) async {
    _position = context.getCameraTransform().localToGlobal(event.localPosition);
    final state = context.getState();
    if (state == null) return;
    context.refresh();
  }

  @override
  bool canChange(PointerDownEvent event, EventContext context) => false;

  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) async {
    _renderers = _load(true);
    final state = context.getState();
    if (state == null) return;
    await Future.wait(_renderers!.map((e) async {
      e.setup(state.data, state.page);
    }));
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

  List<Renderer<PadElement>> _load([bool force = false]) {
    if (_renderers != null && !force) return _renderers!;
    _renderers = data.elements
        .map((e) => Renderer.fromInstance(e))
        .whereType<Renderer<PadElement>>()
        .toList();
    return _renderers!;
  }

  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
          NoteData document, DocumentPage page,
          [Area? currentArea]) =>
      _load(true).map((e) => e.transform(position: _position) ?? e).toList();
}
