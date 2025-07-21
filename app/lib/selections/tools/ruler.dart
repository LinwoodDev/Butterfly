part of '../selection.dart';

class RulerToolSelection extends ToolSelection<RulerTool> {
  RulerToolSelection(super.selected);

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
                onPressed: () => update(
                  context,
                  selected.map((e) => e.copyWith(color: null)).toList(),
                ),
              ),
        onChanged: (value) => update(
          context,
          selected.map((e) => e.copyWith(color: value)).toList(),
        ),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).size),
        value: selected.first.size.toDouble(),
        min: 1,
        max: 500,
        defaultValue: 100,
        fractionDigits: 0,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(size: value.toInt())).toList(),
        ),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is RulerTool) {
      return RulerToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
