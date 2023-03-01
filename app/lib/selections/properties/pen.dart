part of '../selection.dart';

class PenPropertySelection extends PathPropertySelection<PenProperty> {
  PenPropertySelection();

  @override
  List<Widget> build(
    BuildContext context,
    PenProperty property,
    ValueChanged<PenProperty> onChanged,
  ) =>
      [
        ...super.build(context, property, onChanged),
        ColorField(
          value: Color(property.color),
          onChanged: (value) =>
              onChanged(property.copyWith(color: value.value)),
          title: Text(AppLocalizations.of(context).color),
        ),
        ExactSlider(
          value: Color(property.color).alpha.toDouble(),
          header: Text(AppLocalizations.of(context).alpha),
          fractionDigits: 0,
          max: 255,
          min: 0,
          defaultValue: 255,
          onChangeEnd: (value) => onChanged(property.copyWith(
              color: convertColor(property.color, value.toInt()))),
        ),
        CheckboxListTile(
            value: property.fill,
            title: Text(AppLocalizations.of(context).fill),
            onChanged: (value) =>
                onChanged(property.copyWith(fill: value ?? property.fill))),
      ];
}
