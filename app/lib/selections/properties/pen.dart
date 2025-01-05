part of '../selection.dart';

class PenPropertySelection extends PropertySelection<PenProperty>
    with PathPropertySelection<PenProperty> {
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
          value: property.color.withValues(a: 255),
          onChanged: (value) => onChanged(
              property.copyWith(color: value.withValues(a: property.color.a))),
          title: Text(LeapLocalizations.of(context).color),
        ),
        ExactSlider(
          value: property.color.a.toDouble(),
          header: Text(AppLocalizations.of(context).alpha),
          fractionDigits: 0,
          max: 255,
          min: 0,
          defaultValue: 255,
          onChangeEnd: (value) => onChanged(property.copyWith(
              color: property.color.withValues(a: value.toInt()))),
        ),
        CheckboxListTile(
            value: property.fill,
            title: Text(AppLocalizations.of(context).fill),
            onChanged: (value) =>
                onChanged(property.copyWith(fill: value ?? property.fill))),
      ];
}
