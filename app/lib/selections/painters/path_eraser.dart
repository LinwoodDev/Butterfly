part of '../selection.dart';

class PathEraserPainterSelection extends PainterSelection<PathEraserPainter> {
  PathEraserPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final painter = selected.first;
    return [
      ...super.buildProperties(context),
      ExactSlider(
          header: Text(AppLocalizations.of(context).strokeWidth),
          value: painter.strokeWidth,
          min: 0,
          max: 70,
          defaultValue: 5,
          onChangeEnd: (value) => update(context,
              selected.map((e) => e.copyWith(strokeWidth: value)).toList())),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is PathEraserPainter) {
      return PathEraserPainterSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
