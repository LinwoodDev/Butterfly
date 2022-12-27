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
        packs.firstWhereOrNull((e) => e.name == selected.first.pack);
    return [
      ...super.buildProperties(context),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(
        items: packs
            .map((e) =>
                DropdownMenuItem<String>(value: e.name, child: Text(e.name)))
            .toList(),
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.pack,
          filled: true,
          counterText:
              packs.isEmpty ? AppLocalizations.of(context)!.noPacks : null,
          suffixIcon: IconButton(
            icon: const Icon(PhosphorIcons.packageLight),
            tooltip: AppLocalizations.of(context)!.packs,
            onPressed: () {
              Actions.maybeInvoke<PacksIntent>(context, PacksIntent(context));
            },
          ),
        ),
        value: currentPack?.name,
        onChanged: (pack) {
          if (pack == null) return;
          update(context, selected.map((e) => e.copyWith(pack: pack)).toList());
        },
      ),
      const SizedBox(height: 8),
      const Divider(),
      const SizedBox(height: 8),
      Column(
          children: currentPack?.components
                  .asMap()
                  .entries
                  .map((component) => Dismissible(
                      key: ValueKey(component.key),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        final newPack = currentPack.copyWith(
                          components: List<ButterflyComponent>.from(
                              currentPack.components)
                            ..removeAt(component.key),
                        );
                        bloc.add(DocumentPackUpdated(newPack.name, newPack));
                      },
                      child: ListTile(
                        title: Text(component.value.name),
                        selected: component.key == selected.first.component,
                        onTap: () => update(
                            context,
                            selected
                                .map(
                                    (e) => e.copyWith(component: component.key))
                                .toList()),
                      )))
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
