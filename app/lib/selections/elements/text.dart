part of '../selection.dart';

class TextElementSelection extends ElementSelection<TextElement> {
  TextElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    return [
      ...super.buildProperties(context),
      ConstraintView(
        initialConstraint: element.constraint,
        onChanged: (constraint) => updateElements(context,
            elements.map((e) => e.copyWith(constraint: constraint)).toList()),
      ),
    ];
  }

  @override
  Selection insert(element) {
    if (element is Renderer<TextElement>) {
      return TextElementSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.textTFill : PhosphorIcons.textTLight;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).label;
}
