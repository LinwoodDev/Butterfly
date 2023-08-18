part of '../selection.dart';

class ToolSelection<T extends Tool> extends Selection<T> {
  ToolSelection(super.selected);

  factory ToolSelection.from(T selected) => selected.maybeMap(
      hand: (value) => HandSelection([value]),
      label: (value) => LabelToolSelection([value]),
      pen: (value) => PenToolSelection([value]),
      eraser: (value) => EraserToolSelection([value]),
      pathEraser: (value) => PathEraserToolSelection([value]),
      layer: (value) => LayerToolSelection([value]),
      area: (value) => AreaToolSelection([value]),
      laser: (value) => LaserToolSelection([value]),
      shape: (value) => ShapeToolSelection([value]),
      stamp: (value) => StampToolSelection([value]),
      orElse: () => ToolSelection<T>([selected]),
    ) as ToolSelection<T>;

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
    context.read<DocumentBloc>().add(ToolsChanged(updatedElements));
    super.update(context, selected);
  }

  @override
  bool get showDeleteButton => true;

  @override
  void onDelete(BuildContext context) {
    context.read<DocumentBloc>().add(ToolsRemoved(selected));
  }

  @override
  Selection insert(element) {
    if (element is Tool) {
      return ToolSelection([...selected, element]);
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
  IconGetter get icon {
    final type = selected.first.runtimeType;
    if (selected.every((e) => e.runtimeType == type)) {
      return selected.first.icon;
    }
    return PhosphorIcons.paintRoller;
  }

  @override
  List<String> get help {
    final type = selected.first.runtimeType;
    if (selected.any((e) => e.runtimeType != type)) {
      return const [];
    }
    return selected.first.help;
  }
}
