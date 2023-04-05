part of '../selection.dart';

class LayerPainterSelection extends PainterSelection<LayerPainter> {
  LayerPainterSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final searchController = TextEditingController();
    var opened = false;
    return [
      ...super.buildProperties(context),
      const SizedBox(height: 8),
      StatefulBuilder(
        builder: (context, setState) => ExpansionPanelList(
          expansionCallback: (index, isExpanded) {
            setState(() {
              opened = !opened;
            });
          },
          children: [
            ExpansionPanel(
              isExpanded: opened,
              headerBuilder: (context, isExpanded) => ListTile(
                  title: Text(AppLocalizations.of(context).layers),
                  trailing: IconButton(
                      icon: PhosphorIcon(PhosphorIcons.light.selection),
                      tooltip: AppLocalizations.of(context).selectCustomLayer,
                      onPressed: () async {
                        final bloc = context.read<DocumentBloc>();
                        final state = bloc.state as DocumentLoadSuccess;
                        final nameController =
                            TextEditingController(text: state.currentLayer);
                        final success = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(
                                    AppLocalizations.of(ctx).selectCustomLayer),
                                content: TextField(
                                  controller: nameController,
                                  autofocus: true,
                                  onSubmitted: (value) =>
                                      Navigator.of(ctx).pop(true),
                                  decoration: InputDecoration(
                                      filled: true,
                                      hintText:
                                          AppLocalizations.of(context).name),
                                ),
                                actions: [
                                  TextButton(
                                    child:
                                        Text(AppLocalizations.of(ctx).cancel),
                                    onPressed: () =>
                                        Navigator.of(ctx).pop(false),
                                  ),
                                  ElevatedButton(
                                    child: Text(AppLocalizations.of(ctx).ok),
                                    onPressed: () {
                                      Navigator.of(ctx).pop(true);
                                    },
                                  ),
                                ],
                              ),
                            ) ??
                            false;
                        if (!success) return;
                        bloc.add(CurrentLayerChanged(nameController.text));
                      })),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon:
                            PhosphorIcon(PhosphorIcons.light.magnifyingGlass),
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      controller: searchController,
                      autofocus: true,
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: ValueListenableBuilder(
                      valueListenable: searchController,
                      builder: (context, value, child) =>
                          BlocBuilder<DocumentBloc, DocumentState>(
                              buildWhen: (previous, current) {
                        var prev = previous as DocumentLoadSuccess;
                        var curr = current as DocumentLoadSuccess;
                        return curr.document.content != curr.document.content ||
                            curr.invisibleLayers.length !=
                                prev.invisibleLayers.length ||
                            curr.currentLayer != prev.currentLayer;
                      }, builder: (context, state) {
                        if (state is! DocumentLoadSuccess) {
                          return Container();
                        }
                        var layers = {
                          ...state.document.content.map((e) => e.layer),
                          state.currentLayer,
                        }
                            .where((element) =>
                                element.contains(searchController.text))
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
                                icon: PhosphorIcon(state.isLayerVisible('')
                                    ? PhosphorIcons.light.eye
                                    : PhosphorIcons.light.eyeSlash),
                                onPressed: () {
                                  context
                                      .read<DocumentBloc>()
                                      .add(const LayerVisibilityChanged(''));
                                },
                              ),
                              title: Text(
                                  AppLocalizations.of(context).defaultLayer)),
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
                                          context.read<DocumentBloc>().add(
                                              CurrentLayerChanged(
                                                  layers[index]));
                                        },
                                        selected:
                                            layers[index] == state.currentLayer,
                                        leading: IconButton(
                                          icon: PhosphorIcon(state
                                                  .isLayerVisible(layers[index])
                                              ? PhosphorIcons.light.eye
                                              : PhosphorIcons.light.eyeSlash),
                                          onPressed: () {
                                            context.read<DocumentBloc>().add(
                                                LayerVisibilityChanged(
                                                    layers[index]));
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
                ],
              ),
            ),
          ],
        ),
      ),
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
      AppLocalizations.of(context).layer;

  @override
  PhosphorIconData getIcon({bool filled = false}) =>
      filled ? PhosphorIcons.fill.squaresFour : PhosphorIcons.light.squaresFour;

  @override
  List<String> get help => ['painters', 'layer'];
}
