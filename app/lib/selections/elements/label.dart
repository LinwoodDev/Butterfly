part of '../selection.dart';

class LabelElementSelection extends ElementSelection<LabelElement> {
  LabelElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    return [
      ...super.buildProperties(context),
      TextFormField(
        initialValue: element.text,
        autofocus: true,
        keyboardType: TextInputType.multiline,
        minLines: 3,
        maxLines: 5,
        decoration: const InputDecoration(filled: true),
        onFieldSubmitted: (value) => updateElements(
            context, elements.map((e) => e.copyWith(text: value)).toList()),
      ),
      LabelPropertyView(
        initialValue: element.property,
        onChanged: (value) => updateElements(
            context, elements.map((e) => e.copyWith(property: value)).toList()),
      ),
      ConstraintView(
        initialConstraint: element.constraint,
        onChanged: (constraint) => updateElements(context,
            elements.map((e) => e.copyWith(constraint: constraint)).toList()),
      ),
    ];
  }

  @override
  Selection insert(element) {
    if (element is Renderer<LabelElement>) {
      return LabelElementSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.textTFill : PhosphorIcons.textTLight;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.label;
}
