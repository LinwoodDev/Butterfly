part of '../selection.dart';

class HandSelection extends PainterSelection<HandPainter> {
  HandSelection(super.selected);

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.hand;

  @override
  buildProperties(BuildContext context) {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return [];

    return [
      CheckboxListTile(
          value: selected.first.includeEraser,
          title: Text(AppLocalizations.of(context)!.includeEraser),
          onChanged: (value) => update(
              context,
              selected
                  .map((e) =>
                      e.copyWith(includeEraser: value ?? e.includeEraser))
                  .toList())),
    ];
  }

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.handFill : PhosphorIcons.handLight;

  @override
  List<String> get help => ['painters', 'hand'];
}
