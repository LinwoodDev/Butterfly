part of 'selection.dart';

class AreaSelection extends Selection<Area> {
  AreaSelection(super.selected);

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.monitorFill : PhosphorIcons.monitor;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.area;

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
