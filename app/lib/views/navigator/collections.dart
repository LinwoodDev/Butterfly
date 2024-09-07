import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../dialogs/delete.dart';
import '../../widgets/editable_list_tile.dart';

class CollectionsView extends StatelessWidget {
  const CollectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      buildWhen: (previous, current) =>
          previous is DocumentLoadSuccess &&
          current is DocumentLoadSuccess &&
          (previous.currentCollection != current.currentCollection ||
              previous.invisibleCollections != current.invisibleCollections ||
              previous.page.content != current.page.content),
      builder: (context, state) {
        if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
        final currentCollection = state.currentCollection;
        final collections = (state.page.content.map((e) => e.collection).toSet()
              ..add(currentCollection)
              ..remove(''))
            .toList();
        final defaultVisble = state.isLayerVisible('');
        return Stack(
          children: [
            ListView(children: [
              ListTile(
                  onTap: () {
                    context
                        .read<DocumentBloc>()
                        .add(const CurrentLayerChanged(''));
                  },
                  selected: state.currentCollection.isEmpty,
                  leading: IconButton(
                    icon: PhosphorIcon(defaultVisble
                        ? PhosphorIconsLight.eye
                        : PhosphorIconsLight.eyeSlash),
                    tooltip: defaultVisble
                        ? AppLocalizations.of(context).hide
                        : AppLocalizations.of(context).show,
                    onPressed: () {
                      context
                          .read<DocumentBloc>()
                          .add(const LayerVisibilityChanged(''));
                    },
                  ),
                  trailing: IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.pencil),
                    tooltip: AppLocalizations.of(context).rename,
                    onPressed: () async {
                      final bloc = context.read<DocumentBloc>();
                      final result = await showDialog<String>(
                          builder: (context) => NameDialog(), context: context);
                      if (result == null) return;
                      bloc.add(LayerRenamed(state.currentCollection, result));
                    },
                  ),
                  title: Text(AppLocalizations.of(context).defaultLayer)),
              const Divider(),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: collections.length,
                  itemBuilder: (BuildContext context, int index) {
                    final layer = collections[index];
                    final visible = state.isLayerVisible(layer);
                    return EditableListTile(
                      initialValue: layer,
                      selected: layer == currentCollection,
                      onTap: () => context
                          .read<DocumentBloc>()
                          .add(CurrentLayerChanged(layer)),
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
                              .add(LayerVisibilityChanged(collections[index]));
                        },
                      ),
                      onSaved: (value) => context
                          .read<DocumentBloc>()
                          .add(LayerRenamed(layer, value)),
                      actions: [
                        MenuItemButton(
                          leadingIcon:
                              const PhosphorIcon(PhosphorIconsLight.trash),
                          onPressed: currentCollection == layer
                              ? null
                              : () async {
                                  final result = await showDialog<bool>(
                                      context: context,
                                      builder: (context) =>
                                          const DeleteDialog());
                                  if (result != true) return;
                                  context
                                      .read<DocumentBloc>()
                                      .add(LayerRemoved(layer));
                                },
                          child: Text(AppLocalizations.of(context).delete),
                        )
                      ],
                    );
                  }),
            ]),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.extended(
                    label: Text(AppLocalizations.of(context).selectCustomLayer),
                    icon: const PhosphorIcon(PhosphorIconsLight.selection),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                    onPressed: () async {
                      final bloc = context.read<DocumentBloc>();
                      final state = bloc.state;
                      if (state is! DocumentLoadSuccess) return;
                      final result = await showDialog<String>(
                          builder: (context) => NameDialog(
                                value: state.currentCollection,
                              ),
                          context: context);
                      if (result == null) return;
                      bloc.add(CurrentLayerChanged(result));
                    }),
              ),
            )
          ],
        );
      },
    );
  }
}
