part of '../selection.dart';

class PathEraserPainterSelection extends ToolSelection<PathEraserTool> {
  PathEraserPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final tool = selected.first;
    return [
      ...super.buildProperties(context),
      ExactSlider(
          header: Text(AppLocalizations.of(context).strokeWidth),
          value: tool.strokeWidth,
          min: 0,
          max: 70,
          defaultValue: 5,
          onChangeEnd: (value) => update(context,
              selected.map((e) => e.copyWith(strokeWidth: value)).toList())),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is PathEraserTool) {
      return PathEraserPainterSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
