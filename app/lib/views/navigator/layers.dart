import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../dialogs/delete.dart';
import '../../widgets/editable_list_tile.dart';

class LayersView extends StatelessWidget {
  const LayersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      buildWhen: (previous, current) =>
          previous is DocumentLoadSuccess &&
          current is DocumentLoadSuccess &&
          (previous.currentLayer != current.currentLayer ||
              previous.invisibleLayers != current.invisibleLayers ||
              previous.page.content != current.page.content),
      builder: (context, state) {
        if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
        final currentIndex = state.currentLayer;
        final layers = state.page.layers.reversed.toList();
        final currentLayer = state.page.getLayer(currentIndex);
        return Stack(
          children: [
            ReorderableListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: layers.length,
              itemBuilder: (BuildContext context, int index) {
                final layer = layers[index];
                final id = layer.id ?? '';
                final visible = state.isLayerVisible(id);
                return EditableListTile(
                  initialValue: layer.name,
                  selected: id == state.currentLayer,
                  onTap: () =>
                      context.read<DocumentBloc>().add(CurrentLayerChanged(id)),
                  leading: IconButton(
                    icon: PhosphorIcon(visible
                        ? PhosphorIconsLight.eye
                        : PhosphorIconsLight.eyeSlash),
                    tooltip: visible
                        ? AppLocalizations.of(context).hide
                        : AppLocalizations.of(context).show,
                    onPressed: () {
                      context
                          .read<DocumentBloc>()
                          .add(LayerVisibilityChanged(id, !visible));
                    },
                  ),
                  textFormatter: (e) =>
                      e.isEmpty ? AppLocalizations.of(context).layer : e,
                  onSaved: (value) => context
                      .read<DocumentBloc>()
                      .add(LayerChanged(id, name: value)),
                  key: ValueKey(id),
                  actions: [
                    MenuItemButton(
                      leadingIcon: const PhosphorIcon(PhosphorIconsLight.trash),
                      onPressed: currentLayer == layer
                          ? null
                          : () async {
                              final result = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => const DeleteDialog());
                              if (result != true) return;
                              context
                                  .read<DocumentBloc>()
                                  .add(LayerRemoved(id));
                            },
                      child: Text(AppLocalizations.of(context).delete),
                    )
                  ],
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                final layer = layers[oldIndex];
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                context
                    .read<DocumentBloc>()
                    .add(LayerOrderChanged(layer.id ?? '', newIndex));
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.extended(
                    label: Text(AppLocalizations.of(context).create),
                    icon: const PhosphorIcon(PhosphorIconsLight.plus),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                    onPressed: () async {
                      final bloc = context.read<DocumentBloc>();
                      final state = bloc.state;
                      if (state is! DocumentLoadSuccess) return;
                      final result = await showDialog<String>(
                          builder: (context) => NameDialog(), context: context);
                      if (result == null) return;
                      bloc.add(LayerCreated(result));
                    }),
              ),
            )
          ],
        );
      },
    );
  }
}
