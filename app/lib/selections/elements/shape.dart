part of '../selection.dart';

class ShapeElementSelection extends ElementSelection<ShapeElement> {
  ShapeElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    return [
      ...super.buildProperties(context),
      ColorField(
        title: Text(AppLocalizations.of(context).color),
        value: Color(element.property.color).withAlpha(255),
        onChanged: (color) => updateElements(
            context,
            elements
                .map((e) => e.copyWith(
                    property: e.property.copyWith(
                        color: convertOldColor(
                            // ignore: deprecated_member_use
                            color.value,
                            element.property.color))))
                .toList()),
      ),
      ExactSlider(
        // ignore: deprecated_member_use
        value: Color(element.property.color).alpha.toDouble(),
        header: Text(AppLocalizations.of(context).alpha),
        fractionDigits: 0,
        max: 255,
        min: 0,
        defaultValue: 255,
        onChangeEnd: (value) => updateElements(
            context,
            elements
                .map((e) => e.copyWith(
                    property: e.property.copyWith(
                        color: convertColor(e.property.color, value.toInt()))))
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
  IconGetter get icon => selected.first.element.property.shape.icon;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).shape;
}
