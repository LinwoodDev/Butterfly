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
    var isInitial = selected.first.isInitial;
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AreaSizePicker(
          width: selected.first.width,
          height: selected.first.height,
          onChanged: (value) {
            context.read<DocumentBloc>().add(
              AreaChanged(
                selected.first.name,
                selected.first.copyWith(
                  width: value.width,
                  height: value.height,
                ),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 16),
      StatefulBuilder(
        builder: (context, setState) {
          return CheckboxListTile(
            title: Text(AppLocalizations.of(context).areaAsInitial),
            value: isInitial,
            onChanged: (value) {
              context.read<DocumentBloc>().add(
                AreaChanged(
                  selected.first.name,
                  selected.first.copyWith(isInitial: value ?? false),
                ),
              );
              setState(() {
                isInitial = value ?? false;
              });
            },
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
