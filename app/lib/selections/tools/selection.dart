part of '../selection.dart';

class SelectToolSelection extends ToolSelection<SelectTool> {
  SelectToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return [
      ...super.buildProperties(context),
      ListTile(
        title: Text(loc.select),
        trailing: DropdownMenu<SelectMode>(
          initialSelection: selected.first.selectMode,
          dropdownMenuEntries: SelectMode.values
              .map(
                (e) => DropdownMenuEntry(
                  label: e.getLocalizedName(context),
                  leadingIcon: Icon(e.icon(PhosphorIconsStyle.light)),
                  value: e,
                ),
              )
              .toList(),
          onSelected: (value) {
            if (value != null) {
              update(
                context,
                selected.map((e) => e.copyWith(selectMode: value)).toList(),
              );
            }
          },
        ),
      ),
    ];
  }
}
