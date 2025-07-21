part of '../selection.dart';

class PenElementSelection extends ElementSelection<PenElement> {
  final _propertySelection = PenPropertySelection();

  PenElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    void updateProperty(PenProperty property) => updateElements(
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
    if (element is Renderer<PenElement>) {
      return PenElementSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconGetter get icon => PhosphorIcons.pen;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).pen;
}
