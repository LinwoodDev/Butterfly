part of '../selection.dart';

class AreaPainterSelection extends ToolSelection<AreaTool> {
  AreaPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final tool = selected.first;
    return [
      ...super.buildProperties(context),
      ExactSlider(
          header: Text(AppLocalizations.of(context).width),
          value: tool.constrainedWidth,
          min: 0,
          max: 500,
          defaultValue: 0,
          onChangeEnd: (value) => update(
              context,
              selected
                  .map((e) => e.copyWith(constrainedWidth: value))
                  .toList())),
      ExactSlider(
          header: Text(AppLocalizations.of(context).height),
          value: tool.constrainedHeight,
          min: 0,
          max: 500,
          defaultValue: 0,
          onChangeEnd: (value) => update(
              context,
              selected
                  .map((e) => e.copyWith(constrainedHeight: value))
                  .toList())),
      ExactSlider(
          header: Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context).aspectRatio,
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
                tooltip: AppLocalizations.of(context).presets,
              )
            ],
          ),
          value: tool.constrainedAspectRatio,
          min: 0,
          max: 10,
          defaultValue: 0,
          onChangeEnd: (value) => update(
              context,
              selected
                  .map((e) => e.copyWith(constrainedAspectRatio: value))
                  .toList())),
      CheckboxListTile(
        title: Text(AppLocalizations.of(context).askForName),
        value: tool.askForName,
        onChanged: (value) => update(
            context,
            selected
                .map((e) => e.copyWith(askForName: value ?? false))
                .toList()),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is AreaTool) {
      return AreaPainterSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
