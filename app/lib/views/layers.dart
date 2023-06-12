import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../dialogs/delete.dart';

class LayersView extends StatelessWidget {
  const LayersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      buildWhen: (previous, current) =>
          previous is DocumentLoadSuccess &&
          current is DocumentLoadSuccess &&
          (previous.currentLayer != current.currentLayer ||
              previous.invisibleLayers != current.invisibleLayers),
      builder: (context, state) {
        if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
        final currentLayer = state.currentLayer;
        return StreamBuilder<NoteData>(
            stream: state.data.onChange,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox.shrink();
              var layers = (state.page.content.map((e) => e.layer).toSet()
                    ..add(currentLayer)
                    ..remove(''))
                  .toList();
              return Stack(
                children: [
                  ListView(children: [
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
                            context
                                .read<DocumentBloc>()
                                .add(const LayerVisibilityChanged(''));
                          },
                        ),
                        title: Text(AppLocalizations.of(context).defaultLayer)),
                    const Divider(),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: layers.length,
                        itemBuilder: (BuildContext context, int index) {
                          final layer = layers[index];
                          return ListTile(
                            title: Text(layer),
                            selected: layer == currentLayer,
                            onTap: () => context
                                .read<DocumentBloc>()
                                .add(CurrentLayerChanged(layer)),
                            leading: IconButton(
                              icon: PhosphorIcon(state.isLayerVisible(layer)
                                  ? PhosphorIconsLight.eye
                                  : PhosphorIconsLight.eyeSlash),
                              onPressed: () {
                                context
                                    .read<DocumentBloc>()
                                    .add(LayerVisibilityChanged(layers[index]));
                              },
                            ),
                            trailing: MenuAnchor(
                              builder: defaultMenuButton(),
                              menuChildren: [
                                MenuItemButton(
                                  leadingIcon: const PhosphorIcon(
                                      PhosphorIconsLight.trash),
                                  onPressed: currentLayer == layer
                                      ? null
                                      : () async {
                                          final result = await showDialog<bool>(
                                              context: context,
                                              builder: (context) =>
                                                  const DeleteDialog());
                                          if (result != true) return;
                                          snapshot.data?.removePage(layer);
                                        },
                                  child:
                                      Text(AppLocalizations.of(context).delete),
                                )
                              ],
                            ),
                          );
                        }),
                  ]),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton.extended(
                          label: Text(
                              AppLocalizations.of(context).selectCustomLayer),
                          icon:
                              const PhosphorIcon(PhosphorIconsLight.selection),
                          onPressed: () async {
                            final bloc = context.read<DocumentBloc>();
                            final state = bloc.state;
                            if (state is! DocumentLoadSuccess) return;
                            final result = await showDialog<String>(
                                builder: (context) => NameDialog(
                                      value: state.currentLayer,
                                    ),
                                context: context);
                            if (result == null) return;
                            bloc.add(CurrentLayerChanged(result));
                          }),
                    ),
                  )
                ],
              );
            });
      },
    );
  }
}
