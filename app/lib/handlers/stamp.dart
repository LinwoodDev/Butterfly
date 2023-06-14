part of 'handler.dart';

class StampHandler extends Handler<StampPainter> {
  ButterflyComponent? _component;
  Offset _position = Offset.zero;
  Offset _center = Offset.zero;
  List<Renderer<PadElement>> _elements = [];
  StampHandler(super.data);

  @override
  @override
  List<Renderer> createForegrounds(CurrentIndexCubit currentIndexCubit,
      NoteData document, DocumentPage page, DocumentInfo info,
      [Area? currentArea]) {
    final currentPos = currentIndexCubit.state.cameraViewport.toOffset();
    return _elements
        .map((e) =>
            e.transform(
                position: -currentPos - _center + _position, relative: true) ??
            e)
        .toList();
  }

  ButterflyComponent? getComponent(NoteData document) =>
      document.getPack(data.component.pack)?.getComponent(data.component.name);

  Future<void> _loadComponent(
      NoteData document, AssetService assetService, DocumentPage page) async {
    _position = Offset.zero;
    _component = getComponent(document);
    if (_component == null) return;
    _elements = await Future.wait(_component!.elements.map((e) async {
      final element = Renderer.fromInstance(e);
      element.setup(document, assetService, page);
      return element;
    })).then((value) => value.toList());
    Rect? rect;
    for (final e in _elements) {
      final r = e.rect;
      if (r == null) continue;
      if (rect == null) {
        rect = r;
      } else {
        rect = rect.expandToInclude(r);
      }
    }
    if (rect != null) {
      _center = rect.center;
    }
  }

  void _moveComponent(EventContext context, Offset offset) {
    final transform = context.getCameraTransform();
    final state = context.getState();
    if (state == null) return;
    final global = transform.localToGlobal(offset);
    final grid = context
        .getCurrentIndexCubit()
        .getGridPosition(global, state.page, state.info);
    final local = transform.globalToLocal(grid);
    _loadComponent(state.data, state.assetService, state.page);
    _position = local;
    context.refresh();
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) =>
      _moveComponent(context, event.localPosition);

  @override
  void onPointerMove(PointerMoveEvent event, EventContext context) =>
      _moveComponent(context, event.localPosition);

  void _stamp(EventContext context) {
    final state = context.getState();
    if (state == null) return;
    final bloc = context.getDocumentBloc();
    final currentPos = context.getCurrentIndex().cameraViewport.toOffset();
    final elements = _elements
        .map((e) =>
            e
                .transform(
                    position: -currentPos - _center + _position, relative: true)
                ?.element ??
            e.element)
        .toList();
    bloc.add(ElementsCreated(elements));
    bloc.refresh();
    bloc.bake();
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    _stamp(context);
  }
}
