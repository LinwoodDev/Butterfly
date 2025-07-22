part of '../selection.dart';

class StampToolSelection extends ToolSelection<StampTool> {
  StampToolSelection(super.selected);

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
      DropdownMenu<String>(
        expandedInsets: const EdgeInsets.all(4),
        dropdownMenuEntries: packs
            .map((e) => DropdownMenuEntry<String>(value: e, label: e))
            .toList(),
        label: Text(AppLocalizations.of(context).pack),
        helperText: packs.isEmpty ? AppLocalizations.of(context).noPacks : null,
        trailingIcon: IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.package),
          tooltip: AppLocalizations.of(context).packs,
          onPressed: () {
            Actions.maybeInvoke<PacksIntent>(context, PacksIntent(context));
          },
        ),
        initialSelection: currentPack?.name,
        onSelected: (pack) {
          if (pack == null) return;
          update(
            context,
            selected
                .map((e) => e.copyWith(component: PackAssetLocation(pack)))
                .toList(),
          );
        },
      ),
      const SizedBox(height: 8),
      const Divider(),
      const SizedBox(height: 8),
      Column(
        children:
            currentPack
                ?.getComponents()
                .map(
                  (component) => Dismissible(
                    key: ValueKey(component),
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      bloc.add(
                        PackUpdated(
                          packName,
                          currentPack.removeComponent(component),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(component),
                      selected: component == selected.first.component.name,
                      onTap: () => update(
                        context,
                        selected
                            .map(
                              (e) => e.copyWith(
                                component: PackAssetLocation(
                                  packName,
                                  component,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                )
                .toList() ??
            [],
      ),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is StampTool) {
      return StampToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
