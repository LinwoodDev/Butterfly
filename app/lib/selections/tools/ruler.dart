part of '../selection.dart';

class RulerToolSelection extends ToolSelection<RulerTool> {
  RulerToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final tool = selected.first;
    return [
      ...super.buildProperties(context),
      ColorField(
        title: Text(AppLocalizations.of(context).background),
        value: tool.color?.withValues(a: 255) ?? SRGBColor.transparent,
        subtitle: tool.color == null
            ? Text(AppLocalizations.of(context).notSet)
            : null,
        leading: tool.color == null
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
      ColorField(
        title: Text(AppLocalizations.of(context).foreground),
        value: tool.foreground?.withValues(a: 255) ?? SRGBColor.transparent,
        subtitle: tool.foreground == null
            ? Text(AppLocalizations.of(context).notSet)
            : null,
        leading: tool.foreground == null
            ? null
            : IconButton(
                icon: const Icon(PhosphorIconsLight.trash),
                onPressed: () => update(
                  context,
                  selected.map((e) => e.copyWith(foreground: null)).toList(),
                ),
              ),
        onChanged: (value) => update(
          context,
          selected.map((e) => e.copyWith(foreground: value)).toList(),
        ),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).size),
        value: tool.size.toDouble(),
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
