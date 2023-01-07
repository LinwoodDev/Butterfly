part of '../selection.dart';

class LabelPainterSelection extends PainterSelection<LabelPainter> {
  LabelPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [
      ...super.buildProperties(context),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is LabelPainter) {
      return LabelPainterSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.label;

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.textTFill : PhosphorIcons.textTLight;

  @override
  List<String> get help => ['painters', 'label'];
}
