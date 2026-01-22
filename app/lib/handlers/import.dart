part of 'handler.dart';

class ImportHandler extends Handler<ImportTool> {
  List<Renderer<PadElement>>? _renderers;
  Offset _offset = Offset.zero;

  ImportHandler(super.data);

  Future<List<Renderer<PadElement>>> _load(
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    if (_renderers != null) return _renderers!;
    final renderers = data.elements
        .map((e) => Renderer.fromInstance(e))
        .whereType<Renderer<PadElement>>()
        .toList();
    _renderers = renderers;
    return renderers;
  }

  @override
  void dispose(DocumentBloc bloc) {
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final assetService = state.assetService;
    for (final element in data.elements.whereType<SourcedElement>()) {
      assetService.invalidate(element.source);
    }
  }

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) {
    _updatePosition(event.localPosition, context);
  }

  @override
  Future<void> onPointerHover(PointerHoverEvent event, EventContext context) =>
      _updatePosition(event.localPosition, context);

  @override
  Future<void> onPointerDown(PointerDownEvent event, EventContext context) =>
      _updatePosition(event.localPosition, context);

  Future<void> _updatePosition(
    Offset localPosition,
    EventContext context,
  ) async {
    final transform = context.getCameraTransform();
    _offset = transform.localToGlobal(localPosition);
    final state = context.getState();
    if (state == null) return;
    await _load(state.data, state.assetService, state.page);
    context.refreshForegrounds();
  }

  @override
  Future<void> onPointerUp(PointerUpEvent event, EventContext context) async {
    final state = context.getState();
    if (state == null) return;
    context.addDocumentEvent(
      AreasCreated(
        data.areas
            .map((e) => e.copyWith(position: e.position + _offset.toPoint()))
            .toList(),
      ),
    );
    context.addDocumentEvent(
      ElementsCreated(
        (await _load(state.data, state.assetService, state.page))
            .map(
              (e) => e
                  .transform(position: _offset, relative: true)
                  ?.element
                  .copyWith(id: createUniqueId()),
            )
            .nonNulls
            .toList(),
        assets: data.assets,
      ),
    );
    await context.refresh();
    await context.delayedBake();
  }

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) =>
      _renderers
          ?.map((e) => e.transform(position: _offset, relative: true) ?? e)
          .toList() ??
      [];

  @override
  bool get setupForegrounds => false;

  @override
  MouseCursor get cursor => SystemMouseCursors.grabbing;
}
