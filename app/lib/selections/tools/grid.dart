part of '../selection.dart';

class GridToolSelection extends ToolSelection<GridTool> {
  GridToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [
      ...super.buildProperties(context),
      OffsetListTile(
        title: Text(AppLocalizations.of(context).size),
        value: Offset(selected.first.xSize, selected.first.ySize),
        onChanged: (value) => update(
          context,
          selected
              .map((e) => e.copyWith(xSize: value.dx, ySize: value.dy))
              .toList(),
        ),
      ),
      OffsetListTile(
        title: Text(AppLocalizations.of(context).offset),
        value: Offset(selected.first.xOffset, selected.first.yOffset),
        onChanged: (value) => update(
          context,
          selected
              .map((e) => e.copyWith(xOffset: value.dx, yOffset: value.dy))
              .toList(),
        ),
      ),
      ColorField(
        title: Text(AppLocalizations.of(context).fill),
        leading: const PhosphorIcon(PhosphorIconsLight.paintBucket),
        value: selected.first.color.withValues(a: 255),
        defaultColor: SRGBColor.transparent,
        onChanged: (color) => update(
          context,
          selected
              .map((e) => e.copyWith(color: color.withValues(a: e.color.a)))
              .toList(),
        ),
      ),
      ExactSlider(
        value: selected.first.color.a.toDouble(),
        header: Text(AppLocalizations.of(context).alpha),
        fractionDigits: 0,
        max: 255,
        min: 0,
        defaultValue: 255,
        onChangeEnd: (value) => update(
          context,
          selected
              .map(
                (e) => e.copyWith(color: e.color.withValues(a: value.toInt())),
              )
              .toList(),
        ),
      ),
      ExactSlider(
        value: selected.first.stroke,
        onChangeEnd: (value) => update(
          context,
          selected.map((e) => e.copyWith(stroke: value)).toList(),
        ),
        header: Text(AppLocalizations.of(context).strokeWidth),
        min: 0,
        max: 50,
      ),
      CheckboxListTile(
        value: selected.first.positionDependent,
        title: Text(AppLocalizations.of(context).positionDependent),
        onChanged: (value) => update(
          context,
          selected
              .map(
                (e) => e.copyWith(
                  positionDependent: value ?? selected.first.positionDependent,
                ),
              )
              .toList(),
        ),
      ),
      CheckboxListTile(
        value: selected.first.zoomDependent,
        title: Text(AppLocalizations.of(context).zoomDependent),
        onChanged: (value) => update(
          context,
          selected
              .map(
                (e) => e.copyWith(
                  zoomDependent: value ?? selected.first.zoomDependent,
                ),
              )
              .toList(),
        ),
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is GridTool) {
      return GridToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
