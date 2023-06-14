part of '../selection.dart';

class StampPainterSelection extends PainterSelection<StampPainter> {
  StampPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return [];
    final packs = state.data.getPacks();
    final packName = selected.first.component.pack;
    final currentPack = state.data.getPack(packName);
    return [
      ...super.buildProperties(context),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(
        items: packs
            .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
            .toList(),
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).pack,
          filled: true,
          counterText:
              packs.isEmpty ? AppLocalizations.of(context).noPacks : null,
          suffixIcon: IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.package),
            tooltip: AppLocalizations.of(context).packs,
            onPressed: () {
              Actions.maybeInvoke<PacksIntent>(context, PacksIntent(context));
            },
          ),
        ),
        value: currentPack?.name,
        onChanged: (pack) {
          if (pack == null) return;
          update(
              context,
              selected
                  .map((e) =>
                      e.copyWith(component: PackAssetLocation(pack: pack)))
                  .toList());
        },
      ),
      const SizedBox(height: 8),
      const Divider(),
      const SizedBox(height: 8),
      Column(
          children: currentPack
                  ?.getComponents()
                  .map((component) => Dismissible(
                      key: ValueKey(component),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        currentPack.removeComponent(component);
                        bloc.add(PackUpdated(packName, currentPack));
                      },
                      child: ListTile(
                        title: Text(component),
                        selected: component == selected.first.component.name,
                        onTap: () => update(
                            context,
                            selected
                                .map((e) => e.copyWith(
                                        component: PackAssetLocation(
                                      pack: packName,
                                      name: component,
                                    )))
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
}
