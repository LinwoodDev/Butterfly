import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'layer.dart';

class LayersDialog extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  LayersDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: Column(
              children: [
                Header(
                    title: Text(AppLocalizations.of(context).layers),
                    leading: IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.x),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    actions: [
                      IconButton(
                          icon:
                              const PhosphorIcon(PhosphorIconsLight.selection),
                          tooltip:
                              AppLocalizations.of(context).selectCustomLayer,
                          onPressed: () async {
                            final bloc = context.read<DocumentBloc>();
                            final state = bloc.state as DocumentLoadSuccess;
                            final nameController =
                                TextEditingController(text: state.currentLayer);
                            final success = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text(AppLocalizations.of(ctx)
                                        .selectCustomLayer),
                                    content: TextField(
                                      controller: nameController,
                                      autofocus: true,
                                      onSubmitted: (value) =>
                                          Navigator.of(ctx).pop(true),
                                      decoration: InputDecoration(
                                          filled: true,
                                          hintText: AppLocalizations.of(context)
                                              .name),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text(
                                            AppLocalizations.of(ctx).cancel),
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(false),
                                      ),
                                      ElevatedButton(
                                        child:
                                            Text(AppLocalizations.of(ctx).ok),
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
                          })
                    ]),
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            filled: true,
                            prefixIcon: PhosphorIcon(
                                PhosphorIconsLight.magnifyingGlass),
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          controller: _searchController,
                          autofocus: true,
                        ),
                      ),
                      const Divider(),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: ValueListenableBuilder(
                          valueListenable: _searchController,
                          builder: (context, value, child) =>
                              BlocBuilder<DocumentBloc, DocumentState>(
                                  buildWhen: (previous, current) {
                            var prev = previous as DocumentLoadSuccess;
                            var curr = current as DocumentLoadSuccess;
                            return curr.page.content != curr.page.content ||
                                curr.invisibleLayers.length !=
                                    prev.invisibleLayers.length ||
                                curr.currentLayer != prev.currentLayer;
                          }, builder: (context, state) {
                            if (state is! DocumentLoadSuccess) {
                              return Container();
                            }
                            var layers = state.page.content
                                .map((e) => e.layer)
                                .where((element) =>
                                    element.contains(_searchController.text))
                                .toSet()
                                .toList();
                            layers.remove('');
                            return ListView(children: [
                              ListTile(
                                  onTap: () {
                                    context
                                        .read<DocumentBloc>()
                                        .add(const CurrentLayerChanged(''));
                                  },
                                  selected: state.currentLayer.isEmpty,
                                  leading: IconButton(
                                    icon: PhosphorIcon(state.isLayerVisible('')
                                        ? PhosphorIconsLight.eye
                                        : PhosphorIconsLight.eyeSlash),
                                    onPressed: () {
                                      context.read<DocumentBloc>().add(
                                          const LayerVisibilityChanged(''));
                                    },
                                  ),
                                  title: Text(AppLocalizations.of(context)
                                      .defaultLayer)),
                              const Divider(),
                              ...List.generate(
                                  layers.length,
                                  (index) => Dismissible(
                                        key: ObjectKey(layers[index]),
                                        background:
                                            Container(color: Colors.red),
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
                                            selected: layers[index] ==
                                                state.currentLayer,
                                            leading: IconButton(
                                              icon: PhosphorIcon(
                                                  state.isLayerVisible(
                                                          layers[index])
                                                      ? PhosphorIconsLight.eye
                                                      : PhosphorIconsLight
                                                          .eyeSlash),
                                              onPressed: () {
                                                context
                                                    .read<DocumentBloc>()
                                                    .add(LayerVisibilityChanged(
                                                        layers[index]));
                                              },
                                            ),
                                            trailing: IconTheme.merge(
                                                data:
                                                    Theme.of(context).iconTheme,
                                                child: LayerDialog(
                                                  popupMenu: true,
                                                  layer: layers[index],
                                                )),
                                            title: Text(layers[index])),
                                      ))
                            ]);
                          }),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            )));
  }
}
