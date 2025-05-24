part of '../selection.dart';

class ToolSelection<T extends Tool> extends Selection<T> {
  ToolSelection(super.selected);

  factory ToolSelection.from(T selected) =>
      switch (selected) {
            HandTool e => HandSelection([e]),
            LabelTool e => LabelToolSelection([e]),
            PenTool e => PenToolSelection([e]),
            EraserTool e => EraserToolSelection([e]),
            PathEraserTool e => PathEraserToolSelection([e]),
            AreaTool e => AreaToolSelection([e]),
            GridTool e => GridToolSelection([e]),
            LaserTool e => LaserToolSelection([e]),
            RulerTool e => RulerToolSelection([e]),
            ShapeTool e => ShapeToolSelection([e]),
            StampTool e => StampToolSelection([e]),
            TextureTool e => TextureToolSelection([e]),
            BarcodeTool e => BarcodeToolSelection([e]),
            _ => ToolSelection<T>([selected]),
          }
          as ToolSelection<T>;

  @override
  bool isNameEditable(BuildContext context) => true;
  @override
  void setName(BuildContext context, String name) => update(
    context,
    selected.map((e) => e.copyWith(name: name) as T).toList(),
  );

  @override
  String nameFormatter(BuildContext context, [String name = '']) {
    if (name.isNotEmpty) return name;
    final type = selected.first.runtimeType;
    if (selected.every((e) => e.runtimeType == type)) {
      return selected.first.getLocalizedName(context);
    }
    return AppLocalizations.of(context).tool;
  }

  @override
  void update(BuildContext context, List<T> selected) {
    final updatedTools = <int, Tool>{};
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final oldTools = state.info.tools;
    for (var i = 0; i < selected.length; i++) {
      final tool = selected[i];
      final oldTool = this.selected[i];
      final toolIndex = oldTools.indexOf(oldTool);
      if (tool != oldTool && toolIndex >= 0) {
        updatedTools[toolIndex] = tool;
      }
    }
    bloc.add(ToolsChanged(updatedTools));
    super.update(context, selected);
  }

  @override
  bool get showDeleteButton => true;

  @override
  void onDelete(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return;
    final painters = state.info.tools;
    context.read<DocumentBloc>().add(
      ToolsRemoved(selected.map((p) => painters.indexOf(p)).toList()),
    );
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
    var initialName = selected.first.name;
    if (!selected.every((e) => e.name == initialName)) {
      initialName = '';
    }
    return initialName;
  }

  @override
  String getLocalizedCaption(BuildContext context) {
    final type = selected.first.runtimeType;
    if (getLocalizedName(context).isNotEmpty) return nameFormatter(context);
    if (selected.every((e) => e.runtimeType == type)) {
      return selected.first.getLocalizedCaption(context);
    }
    return '';
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
