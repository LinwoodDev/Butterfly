part of '../selection.dart';

class PenPainterSelection extends PainterSelection<PenPainter> {
  PenPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final property = selected.first.property;
    void updateProperty(PenProperty property) => update(
        context, selected.map((e) => e.copyWith(property: property)).toList());
    return [
      ...super.buildProperties(context),
      ExactSlider(
          header: Text(AppLocalizations.of(context)!.strokeWidth),
          value: property.strokeWidth,
          min: 0,
          max: 70,
          defaultValue: 5,
          onChanged: (value) =>
              updateProperty(property.copyWith(strokeWidth: value))),
      ExactSlider(
          header: Text(AppLocalizations.of(context)!.strokeMultiplier),
          value: property.strokeMultiplier,
          min: 0,
          max: 70,
          defaultValue: 5,
          onChanged: (value) =>
              updateProperty(property.copyWith(strokeMultiplier: value))),
      const SizedBox(height: 50),
      ColorField(
        value: Color(property.color),
        onChanged: (value) =>
            updateProperty(property.copyWith(color: value.value)),
        title: Text(AppLocalizations.of(context)!.color),
      ),
      const SizedBox(height: 15),
      CheckboxListTile(
          value: selected.first.zoomDependent,
          title: Text(AppLocalizations.of(context)!.zoomDependent),
          onChanged: (value) => update(
              context,
              selected
                  .map((e) => e.copyWith(
                      zoomDependent: value ?? selected.first.zoomDependent))
                  .toList())),
      CheckboxListTile(
          value: property.fill,
          title: Text(AppLocalizations.of(context)!.fill),
          onChanged: (value) =>
              updateProperty(property.copyWith(fill: value ?? property.fill)))
    ];
  }

  @override
  Selection? insert(dynamic element) {
    if (element is Painter && element is! PenPainter) {
      return PainterSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
