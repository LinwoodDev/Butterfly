part of '../selection.dart';

class PolygonElementSelection extends ElementSelection<PolygonElement> {
  final _propertySelection = PolygonPropertySelection();

  PolygonElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    void updateProperty(PolygonProperty property) => updateElements(
      context,
      elements.map((e) => e.copyWith(property: property)).toList(),
    );
    return [
      ...super.buildProperties(context),
      ..._propertySelection.build(context, element.property, updateProperty),
    ];
  }

  @override
  Selection insert(element) {
    if (element is Renderer<PolygonElement>) {
      return PolygonElementSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconGetter get icon => PhosphorIcons.polygon;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).polygon;
}
