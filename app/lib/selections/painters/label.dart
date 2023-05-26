part of '../selection.dart';

class LabelPainterSelection extends PainterSelection<LabelPainter> {
  LabelPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return [];
    final packs = state.data.getPacks();
    final packName = selected.first.styleSheet.pack;
    final currentPack = state.data.getPack(packName);
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
      ColorField(
        value: Color(selected.first.foreground),
        onChanged: (value) => update(context,
            selected.map((e) => e.copyWith(foreground: value.value)).toList()),
        title: Text(AppLocalizations.of(context).foreground),
      ),
      ExactSlider(
        header: Text(AppLocalizations.of(context).alpha),
        value: Color(selected.first.foreground).alpha.toDouble(),
        defaultValue: 255,
        min: 0,
        max: 255,
        fractionDigits: 0,
        onChangeEnd: (value) => update(
            context,
            selected
                .map((e) => e.copyWith(
                    foreground:
                        Color(e.foreground).withAlpha(value.toInt()).value))
                .toList()),
      ),
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
                      e.copyWith(styleSheet: PackAssetLocation(pack: pack)))
                  .toList());
        },
      ),
      const SizedBox(height: 8),
      const Divider(),
      const SizedBox(height: 8),
      Column(
          children: currentPack
                  ?.getStyles()
                  .map((style) => Dismissible(
                      key: ValueKey(style),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        // Implement remove style
                        bloc.add(DocumentPackUpdated(packName, currentPack));
                      },
                      child: ListTile(
                        title: Text(style),
                        selected: style == selected.first.styleSheet.name,
                        onTap: () => update(
                            context,
                            selected
                                .map((e) => e.copyWith(
                                        styleSheet: PackAssetLocation(
                                      pack: packName,
                                      name: style,
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
}
