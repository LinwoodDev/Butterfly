part of '../selection.dart';

class SelectToolSelection extends ToolSelection<SelectTool> {
  SelectToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final tool = selected.first;
    final currentMode = tool.hitElementMode;
    final loc = AppLocalizations.of(context);
    final anchor = tool.anchorX == null || tool.anchorY == null
        ? null
        : Offset(tool.anchorX!, tool.anchorY!);
    void setAnchor(Offset? a) {
      update(
        context,
        selected
            .map((e) => e.copyWith(anchorX: a?.dx, anchorY: a?.dy))
            .toList(),
      );
      context.read<DocumentBloc>().refreshForegrounds();
    }

    return [
      ...super.buildProperties(context),
      ListTile(
        title: Text(loc.mode),
        trailing: DropdownMenu<SelectMode>(
          initialSelection: tool.mode,
          dropdownMenuEntries: SelectMode.values
              .map(
                (e) => DropdownMenuEntry(
                  label: e.getLocalizedName(context),
                  leadingIcon: Icon(e.icon()),
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(child: Text('Scale anchor')),
                AnchorPicker(value: anchor, onChanged: setAnchor),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 20, child: Text('X')),
                Expanded(
                  child: Slider(
                    value: anchor?.dx ?? 0.5,
                    onChanged: (v) => setAnchor(Offset(v, anchor?.dy ?? 0.5)),
                  ),
                ),
                SizedBox(
                  width: 48,
                  child: Text('${((anchor?.dx ?? 0.5) * 100).round()}%'),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 20, child: Text('Y')),
                Expanded(
                  child: Slider(
                    value: anchor?.dy ?? 0.5,
                    onChanged: (v) => setAnchor(Offset(anchor?.dx ?? 0.5, v)),
                  ),
                ),
                SizedBox(
                  width: 48,
                  child: Text('${((anchor?.dy ?? 0.5) * 100).round()}%'),
                ),
              ],
            ),
            if (anchor != null)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => setAnchor(null),
                  child: const Text('Clear'),
                ),
              ),
          ],
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
