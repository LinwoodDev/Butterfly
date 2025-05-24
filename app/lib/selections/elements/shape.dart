part of '../selection.dart';

class ShapeElementSelection extends ElementSelection<ShapeElement> {
  ShapeElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    return [
      ...super.buildProperties(context),
      ColorField(
        title: Text(LeapLocalizations.of(context).color),
        value: element.property.color.withValues(a: 255),
        onChanged: (color) => updateElements(
          context,
          elements
              .map(
                (e) => e.copyWith(
                  property: e.property.copyWith(
                    color: color.withValues(a: element.property.color.a),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      ExactSlider(
        value: element.property.color.a.toDouble(),
        header: Text(AppLocalizations.of(context).alpha),
        fractionDigits: 0,
        max: 255,
        min: 0,
        defaultValue: 255,
        onChangeEnd: (value) => updateElements(
          context,
          elements
              .map(
                (e) => e.copyWith(
                  property: e.property.copyWith(
                    color: e.property.color.withValues(a: value.toInt()),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      ShapeView(
        shape: element.property.shape,
        onChanged: (value) => updateElements(
          context,
          elements
              .map(
                (e) => e.copyWith(property: e.property.copyWith(shape: value)),
              )
              .toList(),
        ),
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
  IconGetter get icon => selected.first.element.property.shape.icon;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).shape;
}
