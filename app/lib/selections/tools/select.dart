part of '../selection.dart';

class SelectToolSelection extends ToolSelection<SelectTool> {
  SelectToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final tool = selected.first;
    final currentMode = tool.hitElementMode;
    final loc = AppLocalizations.of(context);
    return [
      ...super.buildProperties(context),
      ListTile(
        title: Text(loc.mode),
        trailing: DropdownMenu<SelectMode>(
          initialSelection: selected.first.mode,
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
                selected.map((e) => e.copyWith(mode: value)).toList(),
              );
            }
          },
        ),
      ),
      ExpansionTile(
        leading: const PhosphorIcon(PhosphorIconsLight.selectionAll),
        title: Text(AppLocalizations.of(context).selectElements),
        subtitle: Text(currentMode.getLocalizedName(context, isEraser: false)),
        shape: const Border(),
        children: [
          RadioGroup<HitElementMode>(
            groupValue: currentMode,
            onChanged: (HitElementMode? value) {
              if (value != null) {
                update(
                  context,
                  selected
                      .map((e) => e.copyWith(hitElementMode: value))
                      .toList(),
                );
              }
            },
            child: Column(
              children: HitElementMode.selectorValues().map((mode) {
                return RadioListTile<HitElementMode>(
                  title: Text(mode.getLocalizedName(context, isEraser: false)),
                  value: mode,
                  activeColor: Theme.of(context).colorScheme.primary,
                  contentPadding: const EdgeInsets.only(
                    left: 56.0,
                    right: 16.0,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is SelectTool) {
      return SelectToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
