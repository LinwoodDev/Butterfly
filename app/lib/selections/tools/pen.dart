part of '../selection.dart';

class PenToolSelection extends ToolSelection<PenTool> {
  final _propertySelection = PenPropertySelection();

  PenToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {

    final property = selected.first.property;
    void updateProperty(PenProperty property) => update(
        context, selected.map((e) => e.copyWith(property: property)).toList());
    return [
      ...super.buildProperties(context),
      CheckboxListTile(
          value: selected.first.zoomDependent,
          title: Text(AppLocalizations.of(context).zoomDependent),
          onChanged: (value) => update(
              context,
              selected
                  .map((e) => e.copyWith(
                      zoomDependent: value ?? selected.first.zoomDependent))
                  .toList())),
      const SizedBox(height: 16),
      CheckboxListTile(
          value: selected.first.straightLineEnabled,
          title: Text(AppLocalizations.of(context).straightLineEnabled),
          onChanged: (value) => update(
                context,
                selected
                    .map((e) => e.copyWith(
                        straightLineEnabled:
                            value ?? selected.first.straightLineEnabled))
                    .toList())),
      const SizedBox(height: 16),
      Visibility(
        visible: selected.first.straightLineEnabled,
        maintainState: true,
        child: ExactSlider(
            header: Text(AppLocalizations.of(context).straightLineEnabled),
            value: selected.first.straightLineTime,
            min: 0,
            max: 1,
            defaultValue: selected.first.straightLineTime,
            onChanged: (value) => update(
                context,
                selected
                    .map((e) => e.copyWith(straightLineTime: value))
                    .toList())),
      ),
      const SizedBox(height: 16),
      ..._propertySelection.build(context, property, updateProperty),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is PenTool) {
      return PenToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
