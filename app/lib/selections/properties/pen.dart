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
      defaultValue: .5,
      onChangeEnd: (value) =>
          onChanged((property as dynamic).copyWith(streamline: value)),
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
