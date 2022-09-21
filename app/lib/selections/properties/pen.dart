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
        ExactSlider(
          value: property.smoothing,
          min: 0,
          max: 1,
          fractionDigits: 2,
          onChanged: (value) => onChanged(property.copyWith(smoothing: value)),
          header: Text(AppLocalizations.of(context)!.smoothing),
        ),
        ExactSlider(
          value: property.streamline,
          min: 0,
          max: 1,
          fractionDigits: 2,
          onChanged: (value) => onChanged(property.copyWith(streamline: value)),
          header: Text(AppLocalizations.of(context)!.streamline),
        ),
        ExactSlider(
          value: property.taperStart,
          min: 0,
          max: 1,
          fractionDigits: 2,
          onChanged: (value) => onChanged(property.copyWith(taperStart: value)),
          header: Text(AppLocalizations.of(context)!.taperStart),
        ),
        ExactSlider(
          value: property.taperEnd,
          min: 0,
          max: 1,
          fractionDigits: 2,
          onChanged: (value) => onChanged(property.copyWith(taperEnd: value)),
          header: Text(AppLocalizations.of(context)!.taperEnd),
        ),
        const SizedBox(height: 50),
        ColorField(
          value: Color(property.color),
          onChanged: (value) =>
              onChanged(property.copyWith(color: value.value)),
          title: Text(AppLocalizations.of(context)!.color),
        ),
        CheckboxListTile(
            value: property.fill,
            title: Text(AppLocalizations.of(context)!.fill),
            onChanged: (value) =>
                onChanged(property.copyWith(fill: value ?? property.fill))),
      ];
}
