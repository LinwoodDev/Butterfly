part of '../selection.dart';

class LayerToolSelection extends ToolSelection<LayerTool> {
  LayerToolSelection(super.selected);

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
                  title: Text(AppLocalizations.of(context).collections),
                  trailing: IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.selection),
                      tooltip: AppLocalizations.of(context).selectCustomLayer,
                      onPressed: () async {
                        final bloc = context.read<DocumentBloc>();
                        final state = bloc.state as DocumentLoadSuccess;
                        final nameController = TextEditingController(
                            text: state.currentCollection);
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
                      decoration: const InputDecoration(
                        filled: true,
                        prefixIcon:
                            PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
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
                        return curr.page.content != curr.page.content ||
                            curr.invisibleCollections.length !=
                                prev.invisibleCollections.length ||
                            curr.currentCollection != prev.currentCollection;
                      }, builder: (context, state) {
                        if (state is! DocumentLoadSuccess) {
                          return Container();
                        }
                        var collections = {
                          ...state.page.content.map((e) => e.collection),
                          state.currentCollection,
                        }
                            .where((element) =>
                                element.contains(searchController.text))
                            .toSet()
                            .toList();
                        collections.remove('');
                        return Column(children: [
                          ListTile(
                              onTap: () {
                                context
                                    .read<DocumentBloc>()
                                    .add(const CurrentLayerChanged(''));
                              },
                              selected: state.currentCollection.isEmpty,
                              leading: IconButton(
                                icon: PhosphorIcon(state.isLayerVisible('')
                                    ? PhosphorIconsLight.eye
                                    : PhosphorIconsLight.eyeSlash),
                                tooltip:
                                    AppLocalizations.of(context).visibility,
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
                            collections.length,
                            (index) {
                              final visible =
                                  state.isLayerVisible(collections[index]);
                              return Dismissible(
                                key: ObjectKey(collections[index]),
                                background: Container(color: Colors.red),
                                onDismissed: (direction) {
                                  context
                                      .read<DocumentBloc>()
                                      .add(LayerRemoved(collections[index]));
                                },
                                child: ListTile(
                                    onTap: () {
                                      context.read<DocumentBloc>().add(
                                          CurrentLayerChanged(
                                              collections[index]));
                                    },
                                    selected: collections[index] ==
                                        state.currentCollection,
                                    leading: IconButton(
                                      icon: PhosphorIcon(visible
                                          ? PhosphorIconsLight.eye
                                          : PhosphorIconsLight.eyeSlash),
                                      tooltip: visible
                                          ? AppLocalizations.of(context).hide
                                          : AppLocalizations.of(context).show,
                                      onPressed: () {
                                        context.read<DocumentBloc>().add(
                                            LayerVisibilityChanged(
                                                collections[index]));
                                      },
                                    ),
                                    trailing: IconTheme.merge(
                                        data: Theme.of(context).iconTheme,
                                        child: CollectionDialog(
                                          popupMenu: true,
                                          collection: collections[index],
                                        )),
                                    title: Text(collections[index])),
                              );
                            },
                          )
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
    if (element is LayerTool) {
      return LayerToolSelection([...selected, element]);
    }
    return super.insert(element);
  }
}
