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
    final position = selected.length > 1 ? null : selected.first.rect?.topLeft;
    return [
      ...super.buildProperties(context),
      OffsetPropertyView(
        value: position,
        title: Text(AppLocalizations.of(context)!.position),
        onChanged: (value) {
          updateElements(
              context,
              selected
                  .map((e) => e.move(value, selected.length > 1))
                  .whereType<T>()
                  .toList());
        },
      )
    ];
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

class OffsetPropertyView extends StatelessWidget {
  final Widget title;
  final Offset? value;
  final Function(Offset) onChanged;

  const OffsetPropertyView(
      {super.key, required this.title, this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrained) {
      final isRow = constrained.maxWidth > 100;
      final title = DefaultTextStyle(
          style: Theme.of(context).textTheme.subtitle1 ?? const TextStyle(),
          child: this.title);
      final controls = Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Expanded(
          child: TextFormField(
            initialValue: value?.dx.toString(),
            decoration: const InputDecoration(
              labelText: 'X',
              alignLabelWithHint: true,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onFieldSubmitted: (value) {
              if (value.isEmpty) return;
              final dx = double.tryParse(value);
              if (dx == null) return;
              onChanged(Offset(dx, this.value?.dy ?? 0));
            },
          ),
        ),
        Expanded(
          child: TextFormField(
            initialValue: value?.dy.toString(),
            decoration: const InputDecoration(
              labelText: 'Y',
              alignLabelWithHint: true,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onFieldSubmitted: (value) {
              if (value.isEmpty) return;
              final dy = double.tryParse(value);
              if (dy == null) return;
              onChanged(Offset(this.value?.dx ?? 0, dy));
            },
          ),
        ),
      ]);
      if (isRow) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(flex: 1, child: title),
              const SizedBox(width: 8),
              Expanded(flex: 2, child: controls),
            ],
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          title,
          const SizedBox(height: 8),
          controls,
        ],
      );
    });
  }
}
