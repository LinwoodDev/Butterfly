part of '../selection.dart';

class PenElementSelection extends ElementSelection<PenElement> {
  final _propertySelection = PenPropertySelection();
  PenElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    return [
      ...super.buildProperties(context),
      ..._propertySelection.build(
          context,
          element.property,
          (property) =>
              elements.map((e) => e.copyWith(property: property)).toList()),
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
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.penFill : PhosphorIcons.penLight;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.pen;
}
