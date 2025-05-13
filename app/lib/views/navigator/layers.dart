import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
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
              buildDefaultDragHandles: false,
              itemBuilder: (BuildContext context, int index) {
                final layer = layers[index];
                final id = layer.id ?? '';
                final visible = state.isLayerVisible(id);
                final contentPadding =
                    ListTileTheme.of(context).contentPadding ?? EdgeInsets.zero;
                return Stack(
                  key: ValueKey(id),
                  children: [
                    EditableListTile(
                      initialValue: layer.name,
                      selected: id == state.currentLayer,
                      onTap: () => context.read<DocumentBloc>().add(
                            CurrentLayerChanged(id),
                          ),
                      subtitle: Text(AppLocalizations.of(
                        context,
                      ).countElements(layer.content.length)),
                      leading: IconButton(
                        icon: PhosphorIcon(
                          visible
                              ? PhosphorIconsLight.eye
                              : PhosphorIconsLight.eyeSlash,
                        ),
                        tooltip: visible
                            ? AppLocalizations.of(context).hide
                            : AppLocalizations.of(context).show,
                        onPressed: () {
                          context.read<DocumentBloc>().add(
                                LayerVisibilityChanged(id, !visible),
                              );
                        },
                      ),
                      textFormatter: (e) =>
                          e.isEmpty ? AppLocalizations.of(context).layer : e,
                      onSaved: (value) => context.read<DocumentBloc>().add(
                            LayerChanged(id, name: value),
                          ),
                      actions: [
                        if (layers.length > 1)
                          SubmenuButton(
                            leadingIcon: const PhosphorIcon(
                              PhosphorIconsLight.stack,
                            ),
                            menuChildren: [
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.arrowUp,
                                ),
                                onPressed: index <= 0
                                    ? null
                                    : () => context.read<DocumentBloc>().add(
                                          LayersMerged(
                                            [
                                              layers[index - 1].id,
                                              id,
                                            ].nonNulls.toList(),
                                          ),
                                        ),
                                child: Text(AppLocalizations.of(context).up),
                              ),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.arrowDown,
                                ),
                                onPressed: index >= layers.length - 1
                                    ? null
                                    : () => context.read<DocumentBloc>().add(
                                          LayersMerged(
                                            [
                                              id,
                                              layers[index + 1].id,
                                            ].nonNulls.toList(),
                                          ),
                                        ),
                                child: Text(AppLocalizations.of(context).down),
                              ),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.dotsNine,
                                ),
                                onPressed: () {
                                  final bloc = context.read<DocumentBloc>();
                                  showDialog(
                                    context: context,
                                    builder: (context) => BlocProvider.value(
                                      value: bloc,
                                      child: _LayerMergeDialog(main: id),
                                    ),
                                  );
                                },
                                child: Text(AppLocalizations.of(context).other),
                              ),
                            ],
                            child: Text(AppLocalizations.of(context).merge),
                          ),
                        MenuItemButton(
                          leadingIcon: const PhosphorIcon(
                            PhosphorIconsLight.copySimple,
                          ),
                          onPressed: () => context.read<DocumentBloc>().add(
                                LayersMerged([id], true),
                              ),
                          child: Text(AppLocalizations.of(context).duplicate),
                        ),
                        MenuItemButton(
                          leadingIcon:
                              const PhosphorIcon(PhosphorIconsLight.trash),
                          onPressed: currentLayer == layer
                              ? null
                              : () async {
                                  final result = await showDialog<bool>(
                                    context: context,
                                    builder: (context) => const DeleteDialog(),
                                  );
                                  if (result != true) return;
                                  context.read<DocumentBloc>().add(
                                        LayerRemoved(id),
                                      );
                                },
                          child: Text(AppLocalizations.of(context).delete),
                        ),
                      ],
                      contentPadding: contentPadding.add(
                        const EdgeInsets.only(
                          right: 32,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 4,
                      child: ReorderableDragStartListener(
                        index: index,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.grab,
                          child: const Icon(
                            PhosphorIconsLight.dotsSix,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              onReorder: (int oldIndex, int newIndex) {
                final layer = layers[oldIndex];
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                newIndex = layers.length - 1 - newIndex;
                context.read<DocumentBloc>().add(
                      LayerOrderChanged(layer.id ?? '', newIndex),
                    );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.extended(
                  label: Text(LeapLocalizations.of(context).create),
                  icon: const PhosphorIcon(PhosphorIconsLight.plus),
                  backgroundColor: ColorScheme.of(context).secondary,
                  foregroundColor: ColorScheme.of(context).onSecondary,
                  onPressed: () async {
                    final bloc = context.read<DocumentBloc>();
                    final state = bloc.state;
                    if (state is! DocumentLoadSuccess) return;
                    final id = createUniqueId();
                    bloc
                      ..add(LayerCreated(id: id))
                      ..add(CurrentLayerChanged(id));
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LayerMergeDialog extends StatefulWidget {
  final String? main;

  const _LayerMergeDialog({this.main});

  @override
  State<_LayerMergeDialog> createState() => _LayerMergeDialogState();
}

class _LayerMergeDialogState extends State<_LayerMergeDialog> {
  final List<String> _selected = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).merge),
      content: BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) {
          if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
          final layers = state.page.layers;
          final mainLayer =
              widget.main == null ? null : state.page.getLayer(widget.main!);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (mainLayer != null) ...[
                ListTile(
                  title: Text(
                    mainLayer.name.isEmpty
                        ? AppLocalizations.of(context).layer
                        : mainLayer.name,
                  ),
                  subtitle: Text(
                    AppLocalizations.of(
                      context,
                    ).countElements(mainLayer.content.length),
                  ),
                ),
                const Divider(),
              ],
              ...layers.where((e) => e.id != widget.main).map(
                    (e) => CheckboxListTile(
                      value: _selected.contains(e.id),
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _selected.add(e.id ?? '');
                          } else {
                            _selected.remove(e.id);
                          }
                        });
                      },
                      title: Text(
                        e.name.isEmpty
                            ? AppLocalizations.of(context).layer
                            : e.name,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(
                          context,
                        ).countElements(e.content.length),
                      ),
                    ),
                  ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<DocumentBloc>().add(
                  LayersMerged([
                    if (widget.main != null) widget.main!,
                    ..._selected,
                  ]),
                );
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context).merge),
        ),
      ],
    );
  }
}
