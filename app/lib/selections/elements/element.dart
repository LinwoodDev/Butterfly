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
      return LabelElementSelection([selected as Renderer<LabelElement>])
          as ElementSelection<T>;
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
    return [];
  }

  @override
  void update(BuildContext context, List<Renderer<T>> selected) {
    final updatedElements =
        Map<T, T>.fromIterables(elements, selected.map((e) => e.element));
    context.read<DocumentBloc>().add(ElementsChanged(updatedElements));
    super.update(context, selected);
  }

  List<T> get elements => selected.map((e) => e.element).toList();

  @override
  bool get showDeleteButton => true;

  Future<void> updateElements(BuildContext context, List<T> elements) async {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return;
    final document = state.document;
    final renderers = await Future.wait(elements.map((e) async {
      final renderer = Renderer.fromInstance(e);
      await renderer.setup(document);
      return renderer;
    }).toList());
    // ignore: use_build_context_synchronously
    update(context, renderers);
  }

  @override
  List<Rect> get rects =>
      selected.map((e) => e.rect).whereType<Rect>().toList();

  @override
  void onDelete(BuildContext context) {
    context
        .read<DocumentBloc>()
        .add(ElementsRemoved(selected.map((e) => e.element).toList()));
  }

  @override
  Selection insert(dynamic element) {
    if (element is Renderer<PadElement>) {
      return ElementSelection<PadElement>.from(element) as Selection<T>;
    }
    return Selection.from(element);
  }

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.element;

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.cubeFill : PhosphorIcons.cubeLight;
}
