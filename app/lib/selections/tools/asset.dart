part of '../selection.dart';

class AssetToolSelection extends ToolSelection<AssetTool> {
  AssetToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [
      ...super.buildProperties(context),
      ListTile(
        title: Text(AppLocalizations.of(context).type),
        trailing: DropdownMenu<ImportType>(
          initialSelection: selected.first.importType,
          dropdownMenuEntries: ImportType.values
              .map(
                (type) => DropdownMenuEntry(
                  value: type,
                  label: type.getLocalizedName(context),
                  leadingIcon: PhosphorIcon(
                    type.icon(PhosphorIconsStyle.light),
                  ),
                ),
              )
              .toList(),
          onSelected: (type) {
            if (type == null) return;
            update(
              context,
              selected.map((tool) => tool.copyWith(importType: type)).toList(),
            );
          },
        ),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is AssetTool) {
      return AssetToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
