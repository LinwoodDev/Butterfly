part of '../selection.dart';

class LayerPainterSelection extends PainterSelection<LayerPainter> {
  LayerPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final painter = selected.first;
    return [
      ...super.buildProperties(context),
      TextFormField(
          decoration: InputDecoration(
              filled: true, labelText: AppLocalizations.of(context)!.layer),
          initialValue: painter.layer,
          onChanged: (value) => update(
              context, selected.map((e) => e.copyWith(layer: value)).toList())),
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
    if (element is LayerPainter) {
      return LayerPainterSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.layer;

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.squaresFourFill : PhosphorIcons.squaresFourLight;

  @override
  List<String> get help => ['painters', 'layer'];
}
