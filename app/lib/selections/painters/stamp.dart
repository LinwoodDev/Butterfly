part of '../selection.dart';

class StampPainterSelection extends PainterSelection<StampPainter> {
  StampPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [
      ...super.buildProperties(context),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is StampPainter) {
      return StampPainterSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.stamp;

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.stampFill : PhosphorIcons.stampLight;
  @override
  List<String> get help => ['painters', 'stamp'];
}
