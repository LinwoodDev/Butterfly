part of '../selection.dart';

class PainterSelection<T extends Painter> extends Selection<T> {
  PainterSelection(super.selected);

  factory PainterSelection.from(T selected) {
    return selected.maybeMap(
      hand: (value) => HandSelection([value]),
      label: (value) => LabelPainterSelection([value]),
      pen: (value) => PenPainterSelection([value]),
      eraser: (value) => EraserPainterSelection([value]),
      pathEraser: (value) => PathEraserPainterSelection([value]),
      layer: (value) => LayerPainterSelection([value]),
      area: (value) => AreaPainterSelection([value]),
      laser: (value) => LaserPainterSelection([value]),
      shape: (value) => ShapePainterSelection([value]),
      stamp: (value) => StampPainterSelection([value]),
      orElse: () => PainterSelection<T>([selected]),
    ) as PainterSelection<T>;
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
              filled: true, labelText: AppLocalizations.of(context).name),
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

  @override
  String getLocalizedName(BuildContext context) {
    final type = selected.first.runtimeType;
    if (selected.every((e) => e.runtimeType == type)) {
      return selected.first.getLocalizedName(context);
    }
    return AppLocalizations.of(context).painter;
  }

  @override
  IconData getIcon({bool filled = false}) {
    final type = selected.first.runtimeType;
    if (selected.every((e) => e.runtimeType == type)) {
      return selected.first.getIcon(filled: filled);
    }
    return filled
        ? PhosphorIcons.paintRollerFill
        : PhosphorIcons.paintRollerLight;
  }
}
