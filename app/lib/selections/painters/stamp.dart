part of '../selection.dart';

class StampPainterSelection extends PainterSelection<StampPainter> {
  StampPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return [];
    final packs = state.document.packs;
    final currentPack =
        packs.firstWhereOrNull((e) => e.name == selected.first.name);
    return [
      ...super.buildProperties(context),
      const SizedBox(height: 16),
      DropdownButtonFormField<ButterflyPack>(
        items: packs
            .map((e) => DropdownMenuItem<ButterflyPack>(child: Text(e.name)))
            .toList(),
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.pack,
          filled: true,
          counterText:
              packs.isEmpty ? AppLocalizations.of(context)!.noPacks : null,
        ),
        onChanged: (e) {
          if (e == null) return;
          update(
              context, selected.map((e) => e.copyWith(pack: e.name)).toList());
        },
      ),
      Column(
          children: currentPack?.components
                  .map((e) => ListTile(title: Text(e.name)))
                  .toList() ??
              []),
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
