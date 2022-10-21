part of 'selection.dart';

class ToolSelection extends Selection<ToolState> {
  ToolSelection(super.selected);

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.wrenchFill : PhosphorIcons.wrenchLight;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.tools;

  @override
  List<Widget> buildProperties(BuildContext context) {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return [];
    final toolOption = state.document.tool;
    return [
      ...super.buildProperties(context),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(AppLocalizations.of(context)!.grid,
            style: Theme.of(context).textTheme.headline6),
      ),
      const SizedBox(height: 8),
      CheckboxListTile(
        title: Text(AppLocalizations.of(context)!.showGrid),
        value: toolOption.showGrid,
        onChanged: (value) =>
            context.read<DocumentBloc>().add(ToolChanged.option(
                  toolOption.copyWith(showGrid: value ?? false),
                )),
      ),
      const SizedBox(height: 8),
      OffsetPropertyView(
        value: Offset(toolOption.gridXSize, toolOption.gridYSize),
        title: Text(AppLocalizations.of(context)!.size),
        clearValue: selected.length > 1,
        onChanged: (value) =>
            context.read<DocumentBloc>().add(ToolChanged.option(
                  toolOption.copyWith(gridXSize: value.dx, gridYSize: value.dy),
                )),
      ),
      const SizedBox(height: 8),
      ColorField(
        title: Text(AppLocalizations.of(context)!.color),
        value: Color(toolOption.gridColor),
        onChanged: (value) =>
            context.read<DocumentBloc>().add(ToolChanged.option(
                  toolOption.copyWith(gridColor: value.value),
                )),
      ),
      const SizedBox(height: 32),
      CheckboxListTile(
        title: Text(AppLocalizations.of(context)!.ruler),
        value: selected.first.rulerEnabled,
        onChanged: (value) => updateState(
            context, selected.first.copyWith(rulerEnabled: value ?? false)),
      ),
      const SizedBox(height: 8),
      OffsetPropertyView(
        title: Text(AppLocalizations.of(context)!.position),
        onChanged: (value) =>
            updateState(context, selected.first.copyWith(rulerPosition: value)),
        value: selected.first.rulerPosition,
      ),
      const SizedBox(height: 8),
      ExactSlider(
        header: Text(AppLocalizations.of(context)!.angle),
        value: selected.first.rulerAngle,
        defaultValue: 0,
        min: 0,
        max: 360,
        onChangeEnd: (value) =>
            updateState(context, selected.first.copyWith(rulerAngle: value)),
      ),
    ];
  }

  void updateState(BuildContext context, ToolState selected) {
    update(context, [selected]);

    context.read<DocumentBloc>().add(ToolChanged.state(selected));
  }
}
