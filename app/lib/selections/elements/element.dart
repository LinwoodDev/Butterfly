part of '../selection.dart';

class ElementSelection<T extends PadElement> extends Selection<Renderer<T>> {
  ElementSelection(super.selected);

  factory ElementSelection.from(Renderer<T> selected) {
    if (selected is Renderer<ImageElement>) {
      return ImageElementSelection([selected as Renderer<ImageElement>])
          as ElementSelection<T>;
    }
    if (selected is Renderer<ImageElement>) {
      return ImageElementSelection([selected as Renderer<ImageElement>])
          as ElementSelection<T>;
    }
    if (selected is Renderer<LabelElement>) {
      return LabelElementSelection([selected]) as ElementSelection<T>;
    }
    if (selected is Renderer<PenElement>) {
      return PenElementSelection([selected as Renderer<PenElement>])
          as ElementSelection<T>;
    }
    if (selected is Renderer<ShapeElement>) {
      return ShapeElementSelection([selected as Renderer<ShapeElement>])
          as ElementSelection<T>;
    }
    if (selected is Renderer<SvgElement>) {
      return SvgElementSelection([selected as Renderer<SvgElement>])
          as ElementSelection<T>;
    }
    return ElementSelection([selected]);
  }

  @override
  List<Widget> buildProperties(BuildContext context) {
    final position =
        selected.fold(
          Offset.zero,
          (p, e) => p + (e.rect?.topLeft ?? Offset.zero),
        ) /
        selected.length.toDouble();
    return [
      ...super.buildProperties(context),
      OffsetListTile(
        value: position,
        title: Text(AppLocalizations.of(context).position),
        onChanged: (value) {
          updateElements(
            context,
            selected
                .map(
                  (e) =>
                      e.transform(position: value, relative: false)?.element ??
                      e.element,
                )
                .whereType<T>()
                .toList(),
          );
        },
      ),
      ExactSlider(
        value: elements.first.rotation,
        defaultValue: 0,
        min: 0,
        max: 360,
        header: Text(AppLocalizations.of(context).rotation),
        onChangeEnd: (value) {
          updateElements(
            context,
            selected
                .map(
                  (e) =>
                      e.transform(rotation: value, relative: false)?.element ??
                      e.element,
                )
                .whereType<T>()
                .toList(),
          );
        },
      ),
    ];
  }

  @override
  void update(BuildContext context, List<Renderer<T>> selected) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final updatedElements = <String, List<PadElement>>{};
    for (var i = 0; i < selected.length; i++) {
      final element = selected[i];
      final oldElement = this.selected[i];
      final id = oldElement.element.id;
      if (element.element != oldElement.element && id != null) {
        updatedElements[id] = [element.element];
      }
    }
    bloc.add(ElementsChanged(updatedElements));
    super.update(context, selected);
  }

  List<T> get elements => selected.map((e) => e.element).toList();

  @override
  bool get showDeleteButton => true;

  Future<void> updateElements(BuildContext context, List<T> elements) async {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return;
    final page = state.page;
    final document = state.data;
    final assetService = state.assetService;
    final renderers = await Future.wait(
      elements.map((e) async {
        final renderer = Renderer.fromInstance(e);
        await renderer.setup(document, assetService, page);
        return renderer;
      }).toList(),
    );
    // ignore: use_build_context_synchronously
    update(context, renderers);
  }

  Rect? get rect => _expandRects(selected.map((e) => e.rect).nonNulls.toList());

  Rect? get expandedRect =>
      _expandRects(selected.map((e) => e.expandedRect).nonNulls.toList());

  Rect? _expandRects(List<Rect> rects) {
    var rect = rects.firstOrNull;
    for (final current in selected.sublist(1)) {
      final currentRect = current.rect;
      if (currentRect != null) {
        rect = rect?.expandToInclude(currentRect);
      }
    }
    return rect;
  }

  @override
  void onDelete(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final ids = selected.map((r) => r.element.id).nonNulls.toList();
    context.read<DocumentBloc>().add(ElementsRemoved(ids));
    bloc.delayedBake();
  }

  @override
  Selection insert(dynamic element) {
    if (element is Renderer<PadElement>) {
      return ElementSelection([...selected, element]);
    }
    return Selection.from(element);
  }

  @override
  Selection? remove(dynamic selected) {
    final selections = List.from(this.selected);
    selections.removeWhere(
      (element) =>
          element == selected ||
          (element is Renderer && element.element == selected),
    );
    final success = selections.length != this.selected.length;
    if (!success) return this;
    if (selections.isEmpty) return null;
    var selection = Selection.from(selections.first);
    for (int i = 1; i < selections.length; i++) {
      selection = selection.insert(selections[i]);
    }
    return selection;
  }

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).element;

  @override
  IconGetter get icon => PhosphorIcons.cube;
}
