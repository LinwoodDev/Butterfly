part of '../selection.dart';

class SpacerToolSelection extends ToolSelection<SpacerTool> {
  SpacerToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return [
      ...super.buildProperties(context),
      ListTile(
        title: Text(loc.direction),
        trailing: DropdownMenu<Axis2D>(
          initialSelection: selected.first.axis,
          dropdownMenuEntries: Axis2D.values
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
                selected.map((e) => e.copyWith(axis: value)).toList(),
              );
            }
          },
        ),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is SpacerTool) {
      return SpacerToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
