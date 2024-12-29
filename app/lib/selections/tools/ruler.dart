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
