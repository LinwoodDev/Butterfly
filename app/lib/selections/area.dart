part of 'selection.dart';

class AreaSelection extends Selection<Area> {
  AreaSelection(super.selected);

  @override
  PhosphorIconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.fill.monitor : PhosphorIcons.light.monitor;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).area;

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [...super.buildProperties(context)];
  }

  @override
  bool get showDeleteButton => true;

  @override
  void onDelete(BuildContext context) {
    context
        .read<DocumentBloc>()
        .add(AreasRemoved(super.selected.map((e) => e.name).toList()));
  }
}
