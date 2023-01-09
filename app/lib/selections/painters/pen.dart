part of '../selection.dart';

class PenPainterSelection extends PainterSelection<PenPainter> {
  final _propertySelection = PenPropertySelection();
  PenPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final property = selected.first.property;
    void updateProperty(PenProperty property) => update(
        context, selected.map((e) => e.copyWith(property: property)).toList());
    return [
      ...super.buildProperties(context),
      CheckboxListTile(
          value: selected.first.zoomDependent,
          title: Text(AppLocalizations.of(context).zoomDependent),
          onChanged: (value) => update(
              context,
              selected
                  .map((e) => e.copyWith(
                      zoomDependent: value ?? selected.first.zoomDependent))
                  .toList())),
      const SizedBox(height: 15),
      ..._propertySelection.build(context, property, updateProperty),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is PenPainter) {
      return PenPainterSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).pen;

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.penFill : PhosphorIcons.penLight;
  @override
  List<String> get help => ['painters', 'pen'];
}
