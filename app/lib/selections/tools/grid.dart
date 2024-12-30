part of '../selection.dart';

class GridToolSelection extends ToolSelection<GridTool> {
  GridToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [
      ...super.buildProperties(context),
      const SizedBox(height: 8),
      OffsetPropertyView(
        title: Text(AppLocalizations.of(context).size),
        value: Offset(selected.first.xSize, selected.first.ySize),
        onChanged: (value) => update(
          context,
          selected
              .map((e) => e.copyWith(xSize: value.dx, ySize: value.dy))
              .toList(),
        ),
      ),
      const SizedBox(height: 8),
      ColorField(
        value: selected.first.color,
        onChanged: (value) => update(
          context,
          selected.map((e) => e.copyWith(color: value)).toList(),
        ),
        title: Text(LeapLocalizations.of(context).color),
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
