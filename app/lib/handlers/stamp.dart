part of 'handler.dart';

class StampHandler extends Handler<StampPainter> {
  ButterflyComponent? _component;
  Offset _position = Offset.zero;
  Offset _center = Offset.zero;
  List<Renderer<PadElement>> _elements = [];
  StampHandler(super.data);

  @override
  @override
  List<Renderer> createForegrounds(
      CurrentIndexCubit currentIndexCubit, AppDocument document,
      [Area? currentArea]) {
    final currentPos = currentIndexCubit.state.cameraViewport.toOffset();
    return _elements
        .map((e) =>
            e.transform(
                position: -currentPos - _center + _position, relative: true) ??
            e)
        .toList();
  }

  ButterflyComponent? getComponent(AppDocument document) {
    final pack = document.getPack(data.pack);
    if (pack == null) return null;
    final componentId = data.component;
    if (componentId >= pack.components.length || componentId < 0) return null;

    final component = pack.components[componentId];
    if (component.elements.isEmpty) return null;

    return component;
  }

  Future<void> _loadComponent(AppDocument document) async {
    _position = Offset.zero;
    _component = getComponent(document);
    if (_component == null) return;
    _elements = await Future.wait(_component!.elements.map((e) async {
      final element = Renderer.fromInstance(e);
      element.setup(document);
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

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) {
    final state = context.getState();
    if (state == null) return;
    _loadComponent(state.document);
    _position = event.localPosition;
    context.refresh();
  }

  void _stamp(EventContext context) {
    final state = context.getState();
    if (state == null) return;
    final bloc = context.getDocumentBloc();
    final currentPos = context.getCurrentIndex().cameraViewport.toOffset();
    final elements = _elements
        .map((e) =>
            e.transform(
                position: -currentPos - _center + _position, relative: true) ??
            e)
        .toList();
    bloc.add(ElementsCreated.renderers(elements));
    bloc.refresh();
    bloc.bake();
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    _stamp(context);
  }
}
