part of '../selection.dart';

class PainterSelection<T extends Painter> extends Selection<T> {
  PainterSelection(super.selected);

  factory PainterSelection.from(T selected) {
    if (selected is PenPainter) {
      return PenPainterSelection([selected]) as PainterSelection<T>;
    }
    return PainterSelection([selected]);
  }

  @override
  List<Widget> buildProperties(BuildContext context) {
    var initialName = selected.first.name;
    if (!selected.every((e) => e.name == initialName)) {
      initialName = '';
    }
    return [
      TextFormField(
          decoration: InputDecoration(
              filled: true, labelText: AppLocalizations.of(context)!.name),
          initialValue: initialName,
          onChanged: (value) => update(context,
              selected.map((e) => e.copyWith(name: value) as T).toList())),
    ];
  }

  @override
  void update(BuildContext context, List<T> selected) {
    final updatedElements = Map<T, T>.fromIterables(this.selected, selected);
    context.read<DocumentBloc>().add(PaintersChanged(updatedElements));
    super.update(context, selected);
  }

  @override
  bool get showDeleteButton => true;

  @override
  void onDelete(BuildContext context) {
    context.read<DocumentBloc>().add(PaintersRemoved(selected));
  }

  @override
  Selection insert(element) {
    if (element is Painter) {
      return PainterSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
