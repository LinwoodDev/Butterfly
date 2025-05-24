part of '../selection.dart';

class EraserToolSelection extends ToolSelection<EraserTool> {
  EraserToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [
      ...super.buildProperties(context),
      ExactSlider(
        header: Text(AppLocalizations.of(context).strokeWidth),
        value: selected.first.strokeWidth,
        min: 0,
        max: 70,
        defaultValue: 5,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(strokeWidth: value)).toList(),
        ),
      ),
      CheckboxListTile(
        value: selected.first.eraseElements,
        title: Text(AppLocalizations.of(context).deleteElements),
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
