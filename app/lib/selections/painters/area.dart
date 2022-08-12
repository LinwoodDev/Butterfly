part of '../selection.dart';

class AreaPainterSelection extends PainterSelection<AreaPainter> {
  AreaPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final painter = selected.first;
    return [
      ...super.buildProperties(context),
      ExactSlider(
          header: Text(AppLocalizations.of(context)!.width),
          value: painter.constrainedWidth,
          min: 0,
          max: 500,
          defaultValue: 0,
          onChanged: (value) => update(
              context,
              selected
                  .map((e) => e.copyWith(constrainedWidth: value))
                  .toList())),
      ExactSlider(
          header: Text(AppLocalizations.of(context)!.height),
          value: painter.constrainedHeight,
          min: 0,
          max: 500,
          defaultValue: 0,
          onChanged: (value) => update(
              context,
              selected
                  .map((e) => e.copyWith(constrainedHeight: value))
                  .toList())),
      ExactSlider(
          header: Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.aspectRatio,
                  textAlign: TextAlign.center,
                ),
              ),
              PopupMenuButton<AspectRatioPreset>(
                itemBuilder: (context) => AspectRatioPreset.values
                    .map((e) => PopupMenuItem(
                          value: e,
                          child: Text(e.getLocalizedName(context)),
                        ))
                    .toList(),
                onSelected: (preset) => update(
                    context,
                    selected
                        .map((e) =>
                            e.copyWith(constrainedAspectRatio: preset.ratio))
                        .toList()),
                tooltip: AppLocalizations.of(context)!.presets,
              )
            ],
          ),
          value: painter.constrainedAspectRatio,
          min: 0,
          max: 10,
          defaultValue: 0,
          onChanged: (value) => update(
              context,
              selected
                  .map((e) => e.copyWith(constrainedAspectRatio: value))
                  .toList())),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is AreaPainter) {
      return AreaPainterSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.area;

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.monitorFill : PhosphorIcons.monitorLight;

  @override
  List<String> get help => ['painters', 'area'];
}
