part of '../selection.dart';

class SvgElementSelection extends ElementSelection<SvgElement> {
  SvgElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    return [
      ...super.buildProperties(context),
      ConstraintsView(
        enableScaled: true,
        initialConstraints: element.constraints,
        onChanged: (constraints) => updateElements(
          context,
          elements.map((e) => e.copyWith(constraints: constraints)).toList(),
        ),
      ),
    ];
  }

  @override
  Selection insert(element) {
    if (element is Renderer<SvgElement>) {
      return SvgElementSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconGetter get icon => PhosphorIcons.fileSvg;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).svg;
}
