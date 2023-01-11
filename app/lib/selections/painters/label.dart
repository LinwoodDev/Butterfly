part of '../selection.dart';

class LabelPainterSelection extends PainterSelection<LabelPainter> {
  LabelPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return [];
    final packs = state.document.packs;
    final currentPack = selected.first.pack;
    return [
      ...super.buildProperties(context),
      DropdownButtonFormField<String>(
        items: packs
            .map((e) =>
                DropdownMenuItem<String>(value: e.name, child: Text(e.name)))
            .toList(),
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).pack,
          filled: true,
          counterText:
              packs.isEmpty ? AppLocalizations.of(context).noPacks : null,
        ),
        value: currentPack,
        onChanged: (pack) {
          if (pack == null) return;
          update(context, selected.map((e) => e.copyWith(pack: pack)).toList());
        },
      ),
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
      AppLocalizations.of(context).label;

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.textTFill : PhosphorIcons.textTLight;

  @override
  List<String> get help => ['painters', 'label'];
}
