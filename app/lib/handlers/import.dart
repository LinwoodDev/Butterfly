part of 'handler.dart';

class ImportHandler extends Handler<ImportPainter> {
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
    await Future.wait(
        renderers.map((e) async => e.setup(document, assetService, page)));
    _renderers = renderers;
    return renderers;
  }

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    _offset += event.localDelta;
    context.refresh();
  }

  @override
  Future<void> onPointerHover(
      PointerHoverEvent event, EventContext context) async {
    _offset += event.localDelta;
    final state = context.getState();
    if (state == null) return;
    await _load(state.data, state.assetService, state.page);
    context.refresh();
  }

  @override
  Future<void> onPointerDown(
      PointerDownEvent event, EventContext context) async {
    _offset += event.localDelta;
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
    context.addDocumentEvent(ElementsCreated((await _load(
      state.data,
      state.assetService,
      state.page,
    ))
        .map((e) => e.transform(position: _offset, relative: true)?.element)
        .whereNotNull()
        .toList()));
    context.addDocumentEvent(AreasCreated(data.areas
        .map((e) => e.copyWith(
              position: e.position + _offset.toPoint(),
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
          NoteData document, DocumentPage page, DocumentInfo info,
          [Area? currentArea]) =>
      _renderers
          ?.map((e) => e.transform(position: _offset, relative: true))
          .whereNotNull()
          .toList() ??
      [];
}
