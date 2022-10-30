part of '../selection.dart';

class LaserPainterSelection extends PainterSelection<LaserPainter> {
  LaserPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [
      ...super.buildProperties(context),
      ExactSlider(
        header: Text(AppLocalizations.of(context)!.strokeWidth),
        value: selected.first.strokeWidth,
        min: 0,
        max: 70,
        defaultValue: 25,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(strokeWidth: value)).toList(),
        ),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context)!.strokeMultiplier),
        value: selected.first.strokeMultiplier,
        min: 0,
        max: 1,
        defaultValue: .5,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(strokeMultiplier: value)).toList(),
        ),
      ),
      ColorField(
        value: Color(selected.first.color),
        onChanged: (value) => update(
          context,
          selected.map((e) => e.copyWith(color: value.value)).toList(),
        ),
        title: Text(AppLocalizations.of(context)!.color),
      ),
      ExactSlider(
        value: selected.first.duration,
        min: 1,
        max: 20,
        defaultValue: 5,
        header: Text(AppLocalizations.of(context)!.duration),
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(duration: value)).toList(),
        ),
      ),
      const SizedBox(height: 15),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is LaserPainter) {
      return LaserPainterSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.laser;

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.cursorFill : PhosphorIcons.cursorLight;
  @override
  List<String> get help => ['painters', 'laser'];
}
