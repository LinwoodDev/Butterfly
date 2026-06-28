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
      ColorField(
        title: Text(LeapLocalizations.of(context).color),
        value:
            selected.first.color?.withValues(a: 255) ?? SRGBColor.transparent,
        subtitle: selected.first.color == null
            ? Text(AppLocalizations.of(context).notSet)
            : null,
        leading: selected.first.color == null
            ? null
            : IconButton(
                icon: const Icon(PhosphorIconsLight.trash),
                onPressed: () {
                  context.read<DocumentBloc>().add(
                    AreaChanged(
                      selected.first.name,
                      selected.first.copyWith(color: null),
                    ),
                  );
                },
              ),
        onChanged: (value) {
          context.read<DocumentBloc>().add(
            AreaChanged(
              selected.first.name,
              selected.first.copyWith(color: value),
            ),
          );
        },
      ),
      OffsetListTile(
        value: selected.first.position.toOffset(),
        title: Text(AppLocalizations.of(context).position),
        onChanged: (value) {
          context.read<DocumentBloc>().add(
            AreaChanged(
              selected.first.name,
              selected.first.copyWith(position: value.toPoint()),
              true,
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
      CheckboxListTile(
        title: Text(AppLocalizations.of(context).areaAsInitial),
        value: selected.first.isInitial,
        onChanged: (value) {
          context.read<DocumentBloc>().add(
            AreaChanged(
              selected.first.name,
              selected.first.copyWith(isInitial: value ?? false),
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
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return;
    context.read<DocumentBloc>().add(
      AreasRemoved(
        super.selected
            .map((e) => AreaPreset(page: state.pageName, name: e.name))
            .toList(),
      ),
    );
  }
}
