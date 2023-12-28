part of '../selection.dart';

class LabelElementSelection extends ElementSelection<PadElement> {
  LabelElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element as LabelElement;
    return [
      ...super.buildProperties(context),
      ExactSlider(
        header: Text(AppLocalizations.of(context).scale),
        min: 0.1,
        max: 15,
        value: element.scale,
        defaultValue: 5,
        onChangeEnd: (value) => updateElements(
            context,
            elements
                .map((e) => e.maybeMap(
                    text: (e) => e.copyWith(scale: value),
                    markdown: (e) => e.copyWith(scale: value),
                    orElse: () => e))
                .toList()),
      ),
      ConstraintView(
        initialConstraint: element.constraint,
        onChanged: (constraint) => updateElements(
            context,
            elements
                .map((e) => e.maybeMap(
                    text: (e) => e.copyWith(constraint: constraint),
                    markdown: (e) => e.copyWith(constraint: constraint),
                    orElse: () => e))
                .toList()),
      ),
    ];
  }

  @override
  Selection insert(element) {
    if (element is Renderer<LabelElement>) {
      return LabelElementSelection(
          [...selected, element as Renderer<PadElement>]);
    }
    return super.insert(element);
  }

  @override
  IconGetter get icon => PhosphorIcons.textT;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).label;
}
