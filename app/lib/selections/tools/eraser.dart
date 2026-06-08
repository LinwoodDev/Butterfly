part of '../selection.dart';

class EraserToolSelection extends ToolSelection<EraserTool> {
  EraserToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final tool = selected.first;
    final currentMode = tool.hitElementMode;
    return [
      ...super.buildProperties(context),
      ExactSlider(
        header: Text(AppLocalizations.of(context).strokeWidth),
        value: tool.strokeWidth,
        min: 0,
        max: 70,
        defaultValue: 5,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(strokeWidth: value)).toList(),
        ),
      ),
      ExpansionTile(
        leading: const PhosphorIcon(PhosphorIconsLight.shapes),
        title: Text(AppLocalizations.of(context).eraseShapes),
        subtitle: Text(currentMode.getLocalizedName(context, isEraser: true)),
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
              children: HitElementMode.eraserValues().map((mode) {
                return RadioListTile<HitElementMode>(
                  title: Text(mode.getLocalizedName(context, isEraser: true)),
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
      CheckboxListTile(
        value: tool.eraseElements,
        title: Text(AppLocalizations.of(context).eraseAllElements),
        secondary: const PhosphorIcon(PhosphorIconsLight.image),
        onChanged: (value) => update(
          context,
          selected
              .map((e) => e.copyWith(eraseElements: value ?? false))
              .toList(),
        ),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is EraserTool) {
      return EraserToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
