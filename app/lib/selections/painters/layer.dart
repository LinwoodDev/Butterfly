part of '../selection.dart';

class LayerPainterSelection extends PainterSelection<LayerPainter> {
  LayerPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final painter = selected.first;
    final searchController = TextEditingController();
    return [
      ...super.buildProperties(context),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: const InputDecoration(
            filled: true,
            prefixIcon: Icon(PhosphorIcons.magnifyingGlassLight),
          ),
          textAlignVertical: TextAlignVertical.center,
          controller: searchController,
          autofocus: true,
        ),
      ),
      const Divider(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ValueListenableBuilder(
          valueListenable: searchController,
          builder: (context, value, child) =>
              BlocBuilder<DocumentBloc, DocumentState>(
                  buildWhen: (previous, current) {
            var prev = previous as DocumentLoadSuccess;
            var curr = current as DocumentLoadSuccess;
            return curr.document.content != curr.document.content ||
                curr.invisibleLayers.length != prev.invisibleLayers.length ||
                curr.currentLayer != prev.currentLayer;
          }, builder: (context, state) {
            if (state is! DocumentLoadSuccess) {
              return Container();
            }
            var layers = state.document.content
                .map((e) => e.layer)
                .where((element) => element.contains(searchController.text))
                .toSet()
                .toList();
            layers.remove('');
            return Column(children: [
              ListTile(
                  onTap: () {
                    context
                        .read<DocumentBloc>()
                        .add(const CurrentLayerChanged(''));
                  },
                  selected: state.currentLayer.isEmpty,
                  leading: IconButton(
                    icon: Icon(state.isLayerVisible('')
                        ? PhosphorIcons.eyeLight
                        : PhosphorIcons.eyeSlashLight),
                    onPressed: () {
                      context
                          .read<DocumentBloc>()
                          .add(const LayerVisibilityChanged(''));
                    },
                  ),
                  title: Text(AppLocalizations.of(context)!.defaultLayer)),
              const Divider(),
              ...List.generate(
                  layers.length,
                  (index) => Dismissible(
                        key: ObjectKey(layers[index]),
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          context
                              .read<DocumentBloc>()
                              .add(LayerRemoved(layers[index]));
                        },
                        child: ListTile(
                            onTap: () {
                              context
                                  .read<DocumentBloc>()
                                  .add(CurrentLayerChanged(layers[index]));
                            },
                            selected: layers[index] == state.currentLayer,
                            leading: IconButton(
                              icon: Icon(state.isLayerVisible(layers[index])
                                  ? PhosphorIcons.eyeLight
                                  : PhosphorIcons.eyeSlashLight),
                              onPressed: () {
                                context
                                    .read<DocumentBloc>()
                                    .add(LayerVisibilityChanged(layers[index]));
                              },
                            ),
                            trailing: IconTheme.merge(
                                data: Theme.of(context).iconTheme,
                                child: LayerDialog(
                                  popupMenu: true,
                                  layer: layers[index],
                                )),
                            title: Text(layers[index])),
                      ))
            ]);
          }),
        ),
      ),
      const SizedBox(height: 16),
      TextFormField(
          decoration: InputDecoration(
              filled: true, labelText: AppLocalizations.of(context)!.layer),
          initialValue: painter.layer,
          onChanged: (value) => update(
              context, selected.map((e) => e.copyWith(layer: value)).toList())),
      const SizedBox(height: 10),
      CheckboxListTile(
          value: painter.includeEraser,
          title: Text(AppLocalizations.of(context)!.includeEraser),
          onChanged: (value) => update(
              context,
              selected
                  .map((e) =>
                      e.copyWith(includeEraser: value ?? painter.includeEraser))
                  .toList())),
    ];
  }

  @override
  Selection insert(dynamic element) {
    if (element is LayerPainter) {
      return LayerPainterSelection([...selected, element]);
    }
    return super.insert(element);
  }

  @override
  String getLocalizedName(BuildContext context) =>
      AppLocalizations.of(context)!.layer;

  @override
  IconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.squaresFourFill : PhosphorIcons.squaresFourLight;

  @override
  List<String> get help => ['painters', 'layer'];
}
