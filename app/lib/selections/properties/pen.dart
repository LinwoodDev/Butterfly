part of '../selection.dart';

class PenPropertySelection extends PropertySelection<PenProperty> {
  PenPropertySelection();

  @override
  List<Widget> build(
    BuildContext context,
    PenProperty property,
    ValueChanged<PenProperty> onChanged,
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
    ExactSlider(
      header: Text(AppLocalizations.of(context).thinning),
      value: property.thinning,
      min: 0,
      max: 1,
      defaultValue: .4,
      onChangeEnd: (value) =>
          onChanged((property as dynamic).copyWith(thinning: value)),
    ),
    ExactSlider(
      header: Text(AppLocalizations.of(context).smoothing),
      value: property.smoothing,
      min: 0,
      max: 1,
      defaultValue: .5,
      onChangeEnd: (value) =>
          onChanged((property as dynamic).copyWith(smoothing: value)),
    ),
    ExactSlider(
      header: Text(AppLocalizations.of(context).streamline),
      value: property.streamline,
      min: .1,
      max: 1,
      defaultValue: 0.3,
      onChangeEnd: (value) =>
          onChanged((property as dynamic).copyWith(streamline: value)),
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
