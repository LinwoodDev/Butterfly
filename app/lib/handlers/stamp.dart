part of 'handler.dart';

class StampHandler extends PastingHandler<StampTool> {
  Rect rect = Rect.zero;
  List<Renderer<PadElement>>? _elements;
  StampHandler(super.data);

  @override
  Future<void> preparePaste(EventContext context) async {
    final state = context.getState();
    if (state == null) return;
    await _loadComponent(
      context.getEditorController().transformCubit,
      state.data,
      state.assetService,
      state.page,
    );
  }

  ButterflyComponent? getComponent() => data.component?.item;

  Future<void> _loadComponent(
    TransformCubit transformCubit,
    NoteData document,
    AssetService assetService,
    DocumentPage page,
  ) async {
    final component = getComponent();
    if (component == null) return;
    final elements = _elements = await Future.wait(
      component.elements.map(Renderer.fromInstance).map((e) async {
        await e.setup(transformCubit, document, assetService, page);
        return e;
      }),
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
  bool get showHoverPreview => true;

  @override
  List<PadElement> transformElements(
    Rect rect,
    String collection,
    EditorController cubit,
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
