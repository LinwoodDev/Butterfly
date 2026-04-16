import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/pdf_new_page.dart';
import 'package:butterfly/helpers/pdf_direct.dart';
import '../../widgets/multi_select.dart';
import '../../widgets/reorderable_list_item.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../dialogs/delete.dart';
import '../../widgets/editable_list_tile.dart';

typedef _PageEntity = ({String path, String name, bool isFile});

class PagesView extends StatefulWidget {
  const PagesView({super.key});

  @override
  State<PagesView> createState() => _PagesViewState();
}

class _PagesViewState extends State<PagesView> {
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
      buildWhen: (previous, current) =>
          previous.data != current.data ||
          previous.pageName != current.pageName ||
          previous.currentArea != current.currentArea,
      builder: (context, state) {
        if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
        final currentName = state.pageName;
        final pages = state.data.getPagesWithNames();
        final index = state.data.getPageIndex(state.pageName);
        final currentArea = state.currentArea;
        Future<void> addPage([int? index]) async {
          if (state.isDirectPdfSession) {
            final details = await showDialog<PageAddedDetails>(
              context: context,
              builder: (context) => PdfNewPageDialog(
                insertIndex: index,
                nextPageNumber: state.data.getPages().length + 1,
              ),
            );
            if (details == null || !context.mounted) return;
            context.read<DocumentBloc>().add(PagesAdded([details]));
            return;
          }
          context.read<DocumentBloc>().add(
            PagesAdded([
              PageAddedDetails(
                index: index,
                name: AppLocalizations.of(
                  context,
                ).pageIndex(state.data.getPages().length + 1),
                initialArea: currentArea != null
                    ? InitialAreaDetails(
                        width: currentArea.width,
                        height: currentArea.height,
                        name: AppLocalizations.of(context).areaIndex(1),
                      )
                    : null,
              ),
            ]),
          );
        }

        return Column(
          children: [
            const SizedBox(height: 8),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).location,
                suffixIcon: IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.arrowUp),
                  tooltip: AppLocalizations.of(context).goUp,
                  onPressed: () {
                    final paths = _locationController.text.split('/');
                    if (paths.length <= 1) {
                      _locationController.text = '';
                      return;
                    }
                    paths.removeLast();
                    _locationController.text = paths.join('/');
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _locationController,
                builder: (context, value, child) {
                  final query = value.text.isEmpty ? '' : '${value.text}/';
                  final queried = pages
                      .where((element) => element.$1.startsWith(query))
                      .map((e) => (path: e.$2, name: e.$1, isFile: true))
                      .toList();
                  final files = queried.where(
                    (element) => !element.name.contains('/'),
                  );
                  final folders = queried
                      .where((element) => element.name.contains('/'))
                      .map((e) => e.name.split('/').first)
                      .map((e) {
                        var path = value.text;
                        if (path.isNotEmpty) path += '/';
                        path += e;
                        return (path: path, name: e, isFile: false);
                      })
                      .toSet();
                  final all = [...folders, ...files];
                  return Material(
                    type: MaterialType.transparency,
                    child: MultiSelectRegion<String>(
                      toolbarBuilder: (context, controller) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        child: OverflowBar(
                          spacing: 8,
                          children: [
                            ActionChip(
                              label: Text(AppLocalizations.of(context).delete),
                              avatar: const PhosphorIcon(
                                PhosphorIconsLight.trash,
                              ),
                              onPressed: () async {
                                if (controller.selectedIds.isEmpty) return;
                                final result = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => const DeleteDialog(),
                                );
                                if (result != true) return;
                                if (!context.mounted) return;
                                final bloc = context.read<DocumentBloc>();
                                // Remember that for page deletion it accepts an array.
                                // If the event exists in the future, it might be used.
                                for (final id in controller.selectedIds) {
                                  bloc.add(PageRemoved(id));
                                }
                                controller.clear();
                              },
                            ),
                          ],
                        ),
                      ),
                      builder: (context, controller, child) =>
                          ReorderableListView.builder(
                            buildDefaultDragHandles: false,
                            itemCount: all.length,
                            onReorder: (oldIndex, newIndex) {
                              if (oldIndex < 0 ||
                                  newIndex < 0 ||
                                  oldIndex >= all.length) {
                                return;
                              }
                              final current = all[oldIndex];
                              final name = current.path;
                              final isFile = current.isFile;
                              if (!isFile) return;
                              final next =
                                  all[newIndex.clamp(0, all.length - 1)];
                              var nextIndex = state.data.getPageIndex(
                                next.path,
                              );
                              if (newIndex >= all.length && nextIndex != null) {
                                nextIndex++;
                              }
                              if (!next.isFile || nextIndex == null) return;
                              context.read<DocumentBloc>().add(
                                PageReordered(name, nextIndex),
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              final entity = all[index];
                              return _PageEntityListTile(
                                entity: entity,
                                selected: entity.path == currentName,
                                locationController: _locationController,
                                controller: controller,
                                data: state.data,
                                index: index,
                                key: ValueKey(entity.path),
                              );
                            },
                          ),
                    ),
                  );
                },
              ),
            ),
            Card.filled(
              child: SizedBox(
                height: 64,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FilledButton.icon(
                          onPressed: () => addPage((index ?? -1) + 1),
                          icon: const PhosphorIcon(PhosphorIconsLight.plus),
                          label: Text(
                            state.isDirectPdfSession
                                ? AppLocalizations.of(context).newPage
                                : LeapLocalizations.of(context).create,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                IconButton.filledTonal(
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.arrowUp,
                                  ),
                                  tooltip: AppLocalizations.of(
                                    context,
                                  ).insertBefore,
                                  onPressed: () => addPage(index),
                                ),
                                const SizedBox(width: 8),
                                IconButton.filledTonal(
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.arrowDown,
                                  ),
                                  tooltip: AppLocalizations.of(
                                    context,
                                  ).insertAfter,
                                  onPressed: () => addPage((index ?? -1) + 1),
                                ),
                                const SizedBox(width: 8),
                                IconButton.filledTonal(
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.arrowLineUp,
                                  ),
                                  tooltip: AppLocalizations.of(
                                    context,
                                  ).insertFirst,
                                  onPressed: () => addPage(0),
                                ),
                                const SizedBox(width: 8),
                                IconButton.filledTonal(
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.arrowLineDown,
                                  ),
                                  tooltip: AppLocalizations.of(
                                    context,
                                  ).insertLast,
                                  onPressed: () => addPage(),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PageEntityListTile extends StatelessWidget {
  const _PageEntityListTile({
    required this.entity,
    required this.selected,
    required this.locationController,
    required this.controller,
    required this.data,
    required this.index,
    super.key,
  });

  final _PageEntity entity;
  final bool selected;
  final NoteData data;
  final int index;
  final TextEditingController locationController;
  final MultiSelectController<String> controller;

  @override
  Widget build(BuildContext context) {
    final editable = entity.isFile;
    final isSelectionMode = controller.selectionMode;
    final isSelected = isSelectionMode
        ? controller.selectedIds.contains(entity.path)
        : selected;
    return ReorderableListItem(
      index: index,
      enabled: editable && !isSelectionMode,
      key: ValueKey(entity.path),
      child: EditableListTile(
        initialValue: entity.name,
        selected: isSelected,
        leading: isSelectionMode && editable
            ? Checkbox(
                value: isSelected,
                onChanged: (value) => controller.toggle(entity.path),
              )
            : Icon(
                editable
                    ? PhosphorIconsLight.file
                    : PhosphorIconsLight.folderSimple,
                textDirection: TextDirection.ltr,
              ),
        textFormatter: (v) =>
            v.isEmpty ? AppLocalizations.of(context).untitled : v,
        onTap: () {
          if (isSelectionMode && editable) {
            controller.toggle(entity.path);
            return;
          }
          if (editable) {
            context.read<DocumentBloc>().add(PageChanged(entity.path));
          } else {
            locationController.text = entity.path;
          }
        },
        onLongPress: () {
          if (!isSelectionMode && editable) {
            controller.enableSelectionMode();
            controller.select(entity.path);
          }
        },
        onSaved: editable
            ? (value) => context.read<DocumentBloc>().add(
                PageRenamed(entity.path, value),
              )
            : null,
        actions: editable && !isSelectionMode
            ? [
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.trash),
                  onPressed: selected
                      ? null
                      : () async {
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (context) => const DeleteDialog(),
                          );
                          if (result != true) {
                            return;
                          }
                          if (!context.mounted) return;
                          context.read<DocumentBloc>().add(
                            PageRemoved(entity.path),
                          );
                        },
                  child: Text(AppLocalizations.of(context).delete),
                ),
              ]
            : null,
      ),
    );
  }
}
