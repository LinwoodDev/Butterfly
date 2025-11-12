part of '../selection.dart';

class PolygonPropertySelection extends PropertySelection<PolygonProperty> {
  PolygonPropertySelection();

  @override
  List<Widget> build(
    BuildContext context,
    PolygonProperty property,
    ValueChanged<PolygonProperty> onChanged,
  ) => [
    ExactSlider(
      header: Text(AppLocalizations.of(context).strokeWidth),
      value: property.strokeWidth,
      min: 0.1,
      max: 70,
      defaultValue: 5,
      onChangeEnd: (value) =>
          onChanged((property as dynamic).copyWith(strokeWidth: value)),
    ),
    ColorField(
      value: property.color.withValues(a: 255),
      onChanged: (value) => onChanged(
        property.copyWith(color: value.withValues(a: property.color.a)),
      ),
      title: Text(LeapLocalizations.of(context).color),
    ),
    ExactSlider(
      value: property.color.a.toDouble(),
      header: Text(AppLocalizations.of(context).alpha),
      fractionDigits: 0,
      max: 255,
      min: 0,
      defaultValue: 255,
      onChangeEnd: (value) => onChanged(
        property.copyWith(color: property.color.withValues(a: value.toInt())),
      ),
    ),
    ColorField(
      value: property.fill.withValues(a: 255),
      onChanged: (value) => onChanged(
        property.copyWith(fill: value.withValues(a: property.fill.a)),
      ),
      title: Text(AppLocalizations.of(context).fill),
    ),
    ExactSlider(
      value: property.fill.a.toDouble(),
      header: Text(AppLocalizations.of(context).fillAlpha),
      fractionDigits: 0,
      max: 255,
      min: 0,
      defaultValue: 255,
      onChangeEnd: (value) => onChanged(
        property.copyWith(fill: property.fill.withValues(a: value.toInt())),
      ),
    ),
  ];
}
