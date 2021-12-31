import 'package:butterfly/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'layer.dart';

class LayersDialog extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  LayersDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
            child: Scaffold(
                appBar: AppBar(
                  title: Text(AppLocalizations.of(context)!.layers),
                  leading: IconButton(
                    icon: const Icon(PhosphorIcons.xLight),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                backgroundColor: Colors.transparent,
                floatingActionButton: FloatingActionButton.extended(
                    icon: const Icon(PhosphorIcons.selectionLight),
                    label:
                        Text(AppLocalizations.of(context)!.selectCustomLayer),
                    onPressed: () {
                      var _nameController = TextEditingController(
                          text: (context.read<DocumentBloc>().state
                                  as DocumentLoadSuccess)
                              .currentLayer);
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title:
                              Text(AppLocalizations.of(ctx)!.selectCustomLayer),
                          content: TextField(
                            controller: _nameController,
                            autofocus: true,
                            decoration: const InputDecoration(filled: true),
                          ),
                          actions: [
                            TextButton(
                              child: Text(AppLocalizations.of(ctx)!.cancel),
                              onPressed: () => Navigator.of(ctx).pop(),
                            ),
                            TextButton(
                              child: Text(AppLocalizations.of(ctx)!.ok),
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                BlocProvider.of<DocumentBloc>(context).add(
                                    CurrentLayerChanged(_nameController.text));
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(PhosphorIcons.magnifyingGlassLight),
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
                          return curr.document.content !=
                                  curr.document.content ||
                              curr.invisbleLayers.length !=
                                  prev.invisbleLayers.length ||
                              curr.currentLayer != prev.currentLayer;
                        }, builder: (context, state) {
                          if (state is! DocumentLoadSuccess) {
                            return Container();
                          }
                          var layers = state.document.content
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
                                  icon: Icon(state.isLayerVisible('')
                                      ? PhosphorIcons.eyeLight
                                      : PhosphorIcons.eyeSlashLight),
                                  onPressed: () {
                                    context
                                        .read<DocumentBloc>()
                                        .add(const LayerVisiblityChanged(''));
                                  },
                                ),
                                title: Text(AppLocalizations.of(context)!
                                    .defaultLayer)),
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
                                          selected: layers[index] ==
                                              state.currentLayer,
                                          leading: IconButton(
                                            icon: Icon(state.isLayerVisible(
                                                    layers[index])
                                                ? PhosphorIcons.eyeLight
                                                : PhosphorIcons.eyeSlashLight),
                                            onPressed: () {
                                              context.read<DocumentBloc>().add(
                                                  LayerVisiblityChanged(
                                                      layers[index]));
                                            },
                                          ),
                                          trailing: LayerDialog(
                                            popupMenu: true,
                                            layer: layers[index],
                                          ),
                                          title: Text(layers[index])),
                                    ))
                          ]);
                        }),
                      ),
                    )),
                  ],
                ))));
  }
}
