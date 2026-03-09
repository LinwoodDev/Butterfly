part of 'handler.dart';

class StampHandler extends PastingHandler<StampTool> {
  ButterflyComponent? _component;
  Offset? _position;
  Rect rect = Rect.zero;
  List<Renderer<PadElement>>? _elements;
  StampHandler(super.data);

  @override
  List<Renderer> createForegrounds(
    CurrentIndexCubit currentIndexCubit,
    NoteData document,
    DocumentPage page,
    DocumentInfo info, [
    Area? currentArea,
  ]) => [
    ...super.createForegrounds(
      currentIndexCubit,
      document,
      page,
      info,
      currentArea,
    ),
    if (!currentlyPasting && _position != null)
      ...transformElements(
        Rect.fromPoints(_position!, _position!),
        '',
        currentIndexCubit,
      ).map(Renderer.fromInstance),
  ];

  void _update(PointerEvent event, EventContext context) {
    final state = context.getState();
    if (state != null) {
      _loadComponent(
        state.transformCubit,
        state.data,
        state.assetService,
        state.page,
      );
    }
    _position = context.getCameraTransform().localToGlobal(event.localPosition);
    context.refreshForegrounds();
  }

  @override
  void onPointerHover(PointerHoverEvent event, EventContext context) =>
      _update(event, context);

  @override
  void onPointerDown(PointerDownEvent event, EventContext context) {
    _update(event, context);
    super.onPointerDown(event, context);
  }

  @override
  void onPointerUp(PointerUpEvent event, EventContext context) {
    super.onPointerUp(event, context);
    if (event.kind != PointerDeviceKind.mouse) {
      _position = null;
      context.refreshForegrounds();
    }
  }

  ButterflyComponent? getComponent() => data.component?.item;

  Future<void> _loadComponent(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page, [
    bool force = false,
  ]) async {
    _position = null;
    _component = getComponent();
    if ((!force && _elements != null) || _component == null) return;
    final elements = _elements = await Future.wait(
      _component?.elements.map(Renderer.fromInstance).map((e) async {
            await e.setup(transformCubit, document, assetService, page);
            return e;
          }) ??
          [],
    );
    rect =
        elements
            .map((e) => e.expandedRect ?? e.rect)
            .nonNulls
            .fold<Rect?>(
              null,
              (value, element) => value?.expandToInclude(element) ?? element,
            ) ??
        Rect.zero;
  }

  @override
  PreferredSizeWidget getToolbar(DocumentBloc bloc) => ComponentsToolbarView(
    component: data.component,
    onChanged: (value) {
      final state = bloc.state;
      if (state is! DocumentLoaded) return;
      bloc.add(ToolsChanged([data.copyWith(component: value)]));
    },
  );
  @override
  MouseCursor get cursor => SystemMouseCursors.click;

  @override
  List<PadElement> transformElements(
    Rect rect,
    String collection,
    CurrentIndexCubit cubit,
  ) {
    final elements = _elements;
    if (elements == null || elements.isEmpty) return [];

    final sourceRect = this.rect;
    var scaleX = 1.0, scaleY = 1.0;
    if (!rect.isEmpty && !sourceRect.isEmpty) {
      scaleX = rect.width / sourceRect.width;
      scaleY = rect.height / sourceRect.height;
    }

    Offset applyScaleAndTranslate(Offset original) {
      final relative = original - sourceRect.topLeft;
      return Offset(relative.dx * scaleX, relative.dy * scaleY) + rect.topLeft;
    }

    return elements
        .map((renderer) {
          final elementExpandedRect =
              renderer.expandedRect ?? renderer.rect ?? Rect.zero;
          final originalTopLeft = elementExpandedRect.topLeft;
          final translatedTopLeft = applyScaleAndTranslate(originalTopLeft);
          final delta = translatedTopLeft - originalTopLeft;

          return renderer
                  .transform(
                    position: delta,
                    scaleX: scaleX,
                    scaleY: scaleY,
                    relative: true,
                  )
                  ?.element ??
              renderer.element;
        })
        .map((element) => element.copyWith(id: createUniqueId()))
        .toList();
  }
}
