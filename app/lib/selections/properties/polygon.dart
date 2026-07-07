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
    TexturePaintField(
      value: property.paint,
      title: Text(LeapLocalizations.of(context).color),
      onChanged: (paint) => onChanged(property.copyWith(paint: paint)),
    ),
    TexturePaintField(
      value: property.fillPaint,
      title: Text(AppLocalizations.of(context).fill),
      onChanged: (paint) => onChanged(property.copyWith(fillPaint: paint)),
    ),
  ];
}
