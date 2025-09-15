part of '../selection.dart';

class LaserToolSelection extends ToolSelection<LaserTool> {
  LaserToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [
      ...super.buildProperties(context),
      ExactSlider(
        header: Text(AppLocalizations.of(context).strokeWidth),
        value: selected.first.strokeWidth,
        min: 0,
        max: 70,
        defaultValue: 5,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(strokeWidth: value)).toList(),
        ),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).thinning),
        value: selected.first.thinning,
        min: 0,
        max: 1,
        defaultValue: .4,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(thinning: value)).toList(),
        ),
      ),
      ColorField(
        value: selected.first.color,
        onChanged: (value) => update(
          context,
          selected.map((e) => e.copyWith(color: value)).toList(),
        ),
        title: Text(LeapLocalizations.of(context).color),
      ),
      ExactSlider(
        value: selected.first.duration,
        min: 0,
        max: 20,
        defaultValue: 5,
        header: Text(AppLocalizations.of(context).duration),
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(duration: value)).toList(),
        ),
      ),
      ExactSlider(
        value: selected.first.hideDuration,
        min: 0.1,
        max: 2,
        defaultValue: 0.5,
        header: Text(AppLocalizations.of(context).hideDuration),
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(hideDuration: value)).toList(),
        ),
      ),
      ListTile(
        title: Text(AppLocalizations.of(context).animation),
        trailing: DropdownMenu<LaserAnimation>(
          dropdownMenuEntries: LaserAnimation.values
              .map(
                (e) => DropdownMenuEntry(
                  value: e,
                  label: switch (e) {
                    LaserAnimation.fade => LeapLocalizations.of(context).color,
                    LaserAnimation.path => AppLocalizations.of(context).path,
                  },
                  leadingIcon: Icon(switch (e) {
                    LaserAnimation.fade => PhosphorIconsLight.palette,
                    LaserAnimation.path => PhosphorIconsLight.path,
                  }),
                ),
              )
              .toList(),
          initialSelection: selected.first.animation,
          onSelected: (value) {
            if (value != null) {
              update(
                context,
                selected.map((e) => e.copyWith(animation: value)).toList(),
              );
            }
          },
        ),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is LaserTool) {
      return LaserToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
