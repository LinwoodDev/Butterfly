part of '../selection.dart';

mixin PathPropertySelection<T extends PathProperty> on PropertySelection<T> {
  @override
  List<Widget> build(
    BuildContext context,
    T property,
    ValueChanged<T> onChanged,
  ) => [
    ExactSlider(
      header: Text(AppLocalizations.of(context).strokeWidth),
      value: property.strokeWidth,
      min: 0.1,
      max: 70,
      defaultValue: 5,
      onChangeEnd: (value) =>
          onChanged((property as dynamic).copyWith(strokeWidth: value) as T),
    ),
    ExactSlider(
      header: Text(AppLocalizations.of(context).thinning),
      value: property.thinning,
      min: 0,
      max: 1,
      defaultValue: .4,
      onChangeEnd: (value) =>
          onChanged((property as dynamic).copyWith(thinning: value) as T),
    ),
    ExactSlider(
      header: Text(AppLocalizations.of(context).smoothing),
      value: property.smoothing,
      min: 0,
      max: 1,
      defaultValue: .5,
      onChangeEnd: (value) =>
          onChanged((property as dynamic).copyWith(smoothing: value) as T),
    ),
    ExactSlider(
      header: Text(AppLocalizations.of(context).streamline),
      value: property.streamline,
      min: .1,
      max: 1,
      defaultValue: .5,
      onChangeEnd: (value) =>
          onChanged((property as dynamic).copyWith(streamline: value) as T),
    ),
  ];
}
