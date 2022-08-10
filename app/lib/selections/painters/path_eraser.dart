part of '../selection.dart';

class PathEraserPainterSelection extends PainterSelection<PathEraserPainter> {
  PathEraserPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final painter = selected.first;
    return [
      ...super.buildProperties(context),
      ExactSlider(
          header: Text(AppLocalizations.of(context)!.strokeWidth),
          value: painter.strokeWidth,
          min: 0,
          max: 70,
          defaultValue: 5,
          onChanged: (value) => update(context,
              selected.map((e) => e.copyWith(strokeWidth: value)).toList())),
      const SizedBox(height: 10),
      CheckboxListTile(
          value: painter.includeEraser,
          title: Text(AppLocalizations.of(context)!.includeEraser),
          onChanged: (value) => update(
              context,
              selected
                  .map((e) =>
                      e.copyWith(includeEraser: value ?? painter.includeEraser))
                  .toList())),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is PathEraserPainter) {
      return PathEraserPainterSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.pathEraser;

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.pathFill : PhosphorIcons.pathLight;

  @override
  List<String> get help => ['painters', 'path_eraser'];
}
