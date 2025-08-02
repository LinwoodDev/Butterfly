part of '../selection.dart';

class PolygonToolSelection extends ToolSelection<PolygonTool> {
  final _propertySelection = PolygonPropertySelection();

  PolygonToolSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final property = selected.first.property;
    void updateProperty(PolygonProperty property) => update(
      context,
      selected.map((e) => e.copyWith(property: property)).toList(),
    );
    return [
      ...super.buildProperties(context),
      ..._propertySelection.build(context, property, updateProperty),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is PolygonTool) {
      return PolygonToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
