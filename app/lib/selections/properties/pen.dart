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
        const SizedBox(height: 4),
        ColorField(
          value: Color(property.color).withAlpha(255),
          onChanged: (value) => onChanged(property.copyWith(
              // ignore: deprecated_member_use
              color: convertOldColor(value.value, property.color))),
          title: Text(AppLocalizations.of(context).color),
        ),
        ExactSlider(
          // ignore: deprecated_member_use
          value: Color(property.color).alpha.toDouble(),
          header: Text(AppLocalizations.of(context).alpha),
          fractionDigits: 0,
          max: 255,
          min: 0,
          defaultValue: 255,
          onChangeEnd: (value) => onChanged(property.copyWith(
              color: convertColor(property.color, value.toInt()))),
        ),
        const SizedBox(height: 4),
        CheckboxListTile(
            value: property.fill,
            title: Text(AppLocalizations.of(context).fill),
            onChanged: (value) =>
                onChanged(property.copyWith(fill: value ?? property.fill))),
      ];
}
