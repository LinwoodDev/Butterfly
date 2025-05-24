part of '../selection.dart';

class AreaToolSelection extends ToolSelection<AreaTool> {
  AreaToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final tool = selected.first;
    return [
      ...super.buildProperties(context),
      CheckboxListTile(
        title: Text(AppLocalizations.of(context).askForName),
        value: tool.askForName,
        onChanged: (value) => update(
          context,
          selected.map((e) => e.copyWith(askForName: value ?? false)).toList(),
        ),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).width),
        value: tool.constrainedWidth,
        min: 0,
        max: 500,
        defaultValue: 0,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(constrainedWidth: value)).toList(),
        ),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).height),
        value: tool.constrainedHeight,
        min: 0,
        max: 500,
        defaultValue: 0,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(constrainedHeight: value)).toList(),
        ),
      ),
      ExactSlider(
        header: Row(
          children: [
            Expanded(child: Text(AppLocalizations.of(context).aspectRatio)),
            MenuAnchor(
              menuChildren: AspectRatioPreset.values
                  .map(
                    (preset) => MenuItemButton(
                      leadingIcon: PhosphorIcon(
                        preset.icon(PhosphorIconsStyle.light),
                      ),
                      onPressed: () => update(
                        context,
                        selected
                            .map(
                              (e) => e.copyWith(
                                constrainedAspectRatio: preset.ratio,
                              ),
                            )
                            .toList(),
                      ),
                      child: Text(preset.getLocalizedName(context)),
                    ),
                  )
                  .toList(),
              builder: defaultMenuButton(
                tooltip: AppLocalizations.of(context).presets,
              ),
            ),
          ],
        ),
        value: tool.constrainedAspectRatio,
        min: 0,
        max: 10,
        defaultValue: 0,
        fractionDigits: 3,
        onChangeEnd: (value) => update(
          context,
          selected
              .map((e) => e.copyWith(constrainedAspectRatio: value))
              .toList(),
        ),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is AreaTool) {
      return AreaToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
