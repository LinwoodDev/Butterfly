part of '../selection.dart';

class LabelPainterSelection extends PainterSelection<LabelPainter> {
  LabelPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return [];
    final packs = state.document.packs;
    final currentPack =
        packs.firstWhereOrNull((e) => e.name == selected.first.styleSheet.pack);
    return [
      ...super.buildProperties(context),
      CheckboxListTile(
          value: selected.first.zoomDependent,
          title: Text(AppLocalizations.of(context).zoomDependent),
          onChanged: (value) => update(
              context,
              selected
                  .map((e) => e.copyWith(
                      zoomDependent: value ?? selected.first.zoomDependent))
                  .toList())),
      const SizedBox(height: 16),
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
                      e.copyWith(styleSheet: PackAssetLocation(pack: pack)))
                  .toList());
        },
      ),
      const SizedBox(height: 8),
      const Divider(),
      const SizedBox(height: 8),
      Column(
          children: currentPack?.styles
                  .asMap()
                  .entries
                  .map((style) => Dismissible(
                      key: ValueKey(style.key),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        final newPack = currentPack.copyWith(
                          styles:
                              List<text.TextStyleSheet>.from(currentPack.styles)
                                ..removeAt(style.key),
                        );
                        bloc.add(DocumentPackUpdated(newPack.name, newPack));
                      },
                      child: ListTile(
                        title: Text(style.value.name),
                        selected:
                            style.value.name == selected.first.styleSheet.name,
                        onTap: () => update(
                            context,
                            selected
                                .map((e) => e.copyWith(
                                        styleSheet: PackAssetLocation(
                                      pack: currentPack.name,
                                      name: style.value.name,
                                    )))
                                .toList()),
                      )))
                  .toList() ??
              []),
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
  IconGetter get icon => PhosphorIcons.textT;

  @override
  List<String> get help => ['painters', 'label'];
}
