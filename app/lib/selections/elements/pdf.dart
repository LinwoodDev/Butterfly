part of '../selection.dart';

class PdfElementSelection extends ElementSelection<PdfElement> {
  PdfElementSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final element = selected.first.element;
    return [
      ...super.buildProperties(context),
      CheckboxListTile(
        value: element.invert,
        onChanged: (value) => updateElements(
          context,
          elements.map((e) => e.copyWith(invert: value ?? false)).toList(),
        ),
        title: Text(AppLocalizations.of(context).invert),
      ),
      ColorField(
        title: Text(AppLocalizations.of(context).background),
        value: element.background.withValues(a: 255),
        onChanged: (color) => updateElements(
          context,
          elements
              .map(
                (e) => e.copyWith(
                  background: color.withValues(a: element.background.a),
                ),
              )
              .toList(),
        ),
      ),
      ExactSlider(
        value: element.background.a.toDouble(),
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
                  background: e.background.withValues(a: value.toInt()),
                ),
              )
              .toList(),
        ),
      ),
    ];
  }

  @override
  Selection insert(element) {
    if (element is Renderer<PdfElement>) {
      return PdfElementSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  IconGetter get icon => PhosphorIcons.filePdf;

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).pdf;
}
