part of '../selection.dart';

class ShapeElementSelection extends ElementSelection<ShapeElement> {
  ShapeElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    return [
      ...super.buildProperties(context),
      ColorField(
        title: Text(AppLocalizations.of(context)!.color),
        value: Color(element.property.color),
        onChanged: (color) => updateElements(
            context,
            elements
                .map((e) => e.copyWith(
                    property: e.property.copyWith(color: color.value)))
                .toList()),
      ),
      ShapeView(
        shape: element.property.shape,
        onChanged: (value) => updateElements(
            context,
            elements
                .map((e) =>
                    e.copyWith(property: e.property.copyWith(shape: value)))
                .toList()),
      ),
    ];
  }

  @override
  Selection insert(element) {
    if (element is Renderer<ShapeElement>) {
      return ShapeElementSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconData getIcon({bool filled = false}) =>
      selected.first.element.property.shape.getIcon(filled: filled);

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.shape;
}
