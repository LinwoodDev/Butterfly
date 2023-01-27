part of '../selection.dart';

class HandSelection extends PainterSelection<HandPainter> {
  HandSelection(super.selected);

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context).hand;

  @override
  List<Widget> buildProperties(BuildContext context) {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return [];

    return [];
  }

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.handFill : PhosphorIcons.handLight;

  @override
  List<String> get help => ['painters', 'hand'];
}
