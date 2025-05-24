part of 'selection.dart';

class AreaSelection extends Selection<Area> {
  AreaSelection(super.selected);

  @override
  IconGetter get icon => PhosphorIcons.monitor;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).area;

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [
      ...super.buildProperties(context),
      OffsetListTile(
        value: selected.first.position.toOffset(),
        title: Text(AppLocalizations.of(context).position),
        onChanged: (value) {
          context.read<DocumentBloc>().add(
            AreaChanged(
              selected.first.name,
              selected.first.copyWith(position: value.toPoint()),
            ),
          );
        },
      ),
      const SizedBox(height: 8),
      OffsetListTile(
        value: Offset(selected.first.width, selected.first.height),
        title: Text(AppLocalizations.of(context).size),
        onChanged: (value) {
          context.read<DocumentBloc>().add(
            AreaChanged(
              selected.first.name,
              selected.first.copyWith(width: value.dx, height: value.dy),
            ),
          );
        },
      ),
    ];
  }

  @override
  bool get showDeleteButton => true;

  @override
  void onDelete(BuildContext context) {
    context.read<DocumentBloc>().add(
      AreasRemoved(super.selected.map((e) => e.name).toList()),
    );
  }
}
