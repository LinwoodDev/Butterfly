import 'package:butterfly/bloc/document_bloc.dart';
import '../../widgets/multi_select.dart';
import '../../widgets/reorderable_list_item.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../dialogs/delete.dart';
import '../../dialogs/pages.dart' as pages_dialog;
import '../../widgets/editable_list_tile.dart';

typedef PageEntity = ({String path, String name, bool isFile});

String _normalizePagePath(String path) =>
    path.split('/').where((e) => e.isNotEmpty).join('/');

String _normalizeRelativePagePath(String location, String name) {
  final segments = [
    ..._normalizePagePath(location).split('/').where((e) => e.isNotEmpty),
  ];
  for (final segment in name.split('/')) {
    if (segment.isEmpty || segment == '.') continue;
    if (segment == '..') {
      if (segments.isNotEmpty) segments.removeLast();
      continue;
    }
    segments.add(segment);
  }
  return segments.join('/');
}

@visibleForTesting
List<PageEntity> buildPageEntitiesForLocation(
  List<(String, String)> pages,
  String location,
) {
  final normalizedLocation = _normalizePagePath(location);
  final query = normalizedLocation.isEmpty ? '' : '$normalizedLocation/';
  final queried = pages
      .where((element) => element.$1.startsWith(query))
      .map(
        (e) => (
          path: e.$2,
          name: query.isEmpty ? e.$1 : e.$1.substring(query.length),
          isFile: true,
        ),
      )
      .toList();
  final files = queried.where((element) => !element.name.contains('/'));
  final folders = queried
      .where((element) => element.name.contains('/'))
      .map((e) => e.name.split('/').first)
      .map((e) {
        final path = normalizedLocation.isEmpty ? e : '$normalizedLocation/$e';
        return (path: path, name: e, isFile: false);
      })
      .toSet();
  return [...folders, ...files];
}

@visibleForTesting
String resolvePageRename(String location, String name) {
  final normalizedName = name.startsWith('/')
      ? _normalizePagePath(name)
      : _normalizeRelativePagePath(location, name);
  if (normalizedName.isEmpty) return '';
  return normalizedName;
}

class PagesView extends StatefulWidget {
  const PagesView({super.key});

  @override
  State<PagesView> createState() => _PagesViewState();
}

class _PagesViewState extends State<PagesView> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _rangeController = TextEditingController();
  final FocusNode _rangeFocusNode = FocusNode();
  final MultiSelectController<String> _selectionController =
      MultiSelectController<String>();
  String? _rangeError;
  bool _updatingRangeText = false;
  bool _showInternalPageNumbers = false;

  @override
  void dispose() {
    _locationController.dispose();
    _rangeController.dispose();
    _rangeFocusNode.dispose();
    _selectionController.dispose();
    super.dispose();
  }

  void _setRangeText(String text) {
    if (_rangeController.text == text) return;
    _updatingRangeText = true;
    _rangeController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    _updatingRangeText = false;
  }

  void _toggleInternalPageNumbers() {
    setState(() {
      _showInternalPageNumbers = !_showInternalPageNumbers;
      if (!_showInternalPageNumbers) {
        _rangeError = null;
        _setRangeText('');
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _rangeError = null;
      _selectionController.clear();
      _setRangeText('');
    });
  }

  void _selectPageIndexes(
    Iterable<int> indexes,
    List<PageEntity> selectablePages,
  ) {
    _selectionController.clear();
    _selectionController.selectAll(
      indexes.map((index) => selectablePages[index].path),
    );
  }

  void _toggleAllPages(List<PageEntity> selectablePages) {
    final everythingSelected =
        _selectionController.selectedIds.length == selectablePages.length;
    setState(() {
      _rangeError = null;
      _selectionController.clear();
      if (!everythingSelected) {
        _selectionController.selectAll(
          selectablePages.map((entity) => entity.path),
        );
      }
    });
  }

  void _syncRangeTextFromSelection(
    MultiSelectController<String> controller,
    List<PageEntity> selectablePages,
  ) {
    if (_rangeError != null || _rangeFocusNode.hasFocus) return;
    final selectedIndexes = selectablePages
        .asMap()
        .entries
        .where((entry) => controller.selectedIds.contains(entry.value.path))
        .map((entry) => entry.key);
    _setRangeText(pages_dialog.formatPageSelection(selectedIndexes));
  }

  void _applyRangeSelection(
    String value,
    List<PageEntity> selectablePages, {
    bool normalizeText = false,
  }) {
    if (_updatingRangeText) return;
    final selectedIndexes = pages_dialog.parsePageSelection(
      value,
      selectablePages.length,
    );
    setState(() {
      if (selectedIndexes == null) {
        _rangeError = AppLocalizations.of(context).error;
        return;
      }
      _rangeError = null;
      _selectPageIndexes(selectedIndexes, selectablePages);
      if (normalizeText) {
        _setRangeText(pages_dialog.formatPageSelection(selectedIndexes));
      }
    });
  }

  Future<void> _deleteSelectedPages(BuildContext context) async {
    if (_selectionController.selectedIds.isEmpty) return;
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const DeleteDialog(),
    );
    if (result != true) return;
    if (!context.mounted) return;
    final bloc = context.read<DocumentBloc>();
    for (final id in _selectionController.selectedIds) {
      bloc.add(PageRemoved(id));
    }
    _clearSelection();
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
        void addPage([int? index]) => context.read<DocumentBloc>().add(
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

        return Column(
          children: [
            const SizedBox(height: 8),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).location,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(PhosphorIconsLight.listNumbers),
                      selectedIcon: const Icon(PhosphorIconsFill.listNumbers),
                      isSelected: _showInternalPageNumbers,
                      tooltip: AppLocalizations.of(context).pages,
                      onPressed: _toggleInternalPageNumbers,
                    ),
                    IconButton(
                      icon: const Icon(PhosphorIconsLight.arrowUp),
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
                  ],
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: _locationController,
                builder: (context, value, child) {
                  final all = buildPageEntitiesForLocation(pages, value.text);
                  return Material(
                    type: MaterialType.transparency,
                    child: MultiSelectRegion<String>(
                      controller: _selectionController,
                      builder: (context, controller, child) =>
                          ReorderableListView.builder(
                            buildDefaultDragHandles: false,
                            itemCount: all.length,
                            onReorderItem: (oldIndex, newIndex) {
                              if (oldIndex < 0 ||
                                  oldIndex >= all.length ||
                                  newIndex < 0 ||
                                  newIndex >= all.length ||
                                  !all[oldIndex].isFile) {
                                return;
                              }
                              final anchorIndex = newIndex > oldIndex
                                  ? newIndex + 1
                                  : newIndex;
                              int? pageIndex;
                              if (anchorIndex < all.length) {
                                final anchor = all[anchorIndex];
                                if (!anchor.isFile) return;
                                pageIndex = state.data.getPageIndex(
                                  anchor.path,
                                );
                              } else {
                                pageIndex =
                                    state.data
                                        .getPages(true)
                                        .map(state.data.getPageIndex)
                                        .nonNulls
                                        .fold(
                                          -1,
                                          (maximum, index) =>
                                              index > maximum ? index : maximum,
                                        ) +
                                    1;
                              }
                              if (pageIndex == null) return;
                              context.read<DocumentBloc>().add(
                                PageReordered(all[oldIndex].path, pageIndex),
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              final entity = all[index];
                              return _PageEntityListTile(
                                entity: entity,
                                selected: entity.path == currentName,
                                showInternalPageNumber:
                                    _showInternalPageNumbers,
                                locationController: _locationController,
                                controller: controller,
                                data: state.data,
                                index: index,
                                onSelectionChanged: () {
                                  setState(() => _rangeError = null);
                                },
                                key: ValueKey(entity.path),
                              );
                            },
                          ),
                    ),
                  );
                },
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _locationController,
              builder: (context, value, child) {
                final selectablePages = buildPageEntitiesForLocation(
                  pages,
                  value.text,
                ).where((entity) => entity.isFile).toList();
                return ListenableBuilder(
                  listenable: _selectionController,
                  builder: (context, child) {
                    if (_selectionController.selectionMode) {
                      if (_showInternalPageNumbers) {
                        _syncRangeTextFromSelection(
                          _selectionController,
                          selectablePages,
                        );
                      }
                      return _PagesSelectionBar(
                        controller: _selectionController,
                        showRangeField: _showInternalPageNumbers,
                        rangeController: _rangeController,
                        rangeFocusNode: _rangeFocusNode,
                        rangeError: _rangeError,
                        selectablePages: selectablePages,
                        onRangeChanged: (value) =>
                            _applyRangeSelection(value, selectablePages),
                        onRangeSubmitted: (value) => _applyRangeSelection(
                          value,
                          selectablePages,
                          normalizeText: true,
                        ),
                        onClear: _clearSelection,
                        onSelectAllChanged: () =>
                            _toggleAllPages(selectablePages),
                        onDelete: _selectionController.selectedIds.isEmpty
                            ? null
                            : () => _deleteSelectedPages(context),
                      );
                    }
                    return _PagesCreateBar(index: index, onAddPage: addPage);
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class _PagesSelectionBar extends StatelessWidget {
  const _PagesSelectionBar({
    required this.controller,
    required this.showRangeField,
    required this.rangeController,
    required this.rangeFocusNode,
    required this.rangeError,
    required this.selectablePages,
    required this.onRangeChanged,
    required this.onRangeSubmitted,
    required this.onClear,
    required this.onSelectAllChanged,
    required this.onDelete,
  });

  final MultiSelectController<String> controller;
  final bool showRangeField;
  final TextEditingController rangeController;
  final FocusNode rangeFocusNode;
  final String? rangeError;
  final List<PageEntity> selectablePages;
  final ValueChanged<String> onRangeChanged;
  final ValueChanged<String> onRangeSubmitted;
  final VoidCallback onClear;
  final VoidCallback onSelectAllChanged;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final everythingSelected =
        controller.selectedIds.length == selectablePages.length;
    return Card.filled(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.x),
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  onPressed: onClear,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    loc.countPages(controller.selectedIds.length),
                    style: TextTheme.of(context).titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton.filledTonal(
                  icon: PhosphorIcon(
                    everythingSelected
                        ? PhosphorIconsLight.selectionSlash
                        : PhosphorIconsLight.selectionAll,
                  ),
                  tooltip: everythingSelected ? loc.deselect : loc.selectAll,
                  onPressed: onSelectAllChanged,
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  icon: const PhosphorIcon(PhosphorIconsLight.trash),
                  tooltip: loc.delete,
                  onPressed: onDelete,
                ),
              ],
            ),
            if (showRangeField) ...[
              const SizedBox(height: 6),
              TextField(
                controller: rangeController,
                focusNode: rangeFocusNode,
                decoration: InputDecoration(
                  prefixIcon: const PhosphorIcon(
                    PhosphorIconsLight.listNumbers,
                  ),
                  labelText: loc.pages,
                  hintText: '1-3, 5',
                  errorText: rangeError,
                  filled: true,
                  isDense: true,
                ),
                onChanged: onRangeChanged,
                onSubmitted: onRangeSubmitted,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PagesCreateBar extends StatelessWidget {
  const _PagesCreateBar({required this.index, required this.onAddPage});

  final int? index;
  final void Function([int? index]) onAddPage;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Card.filled(
      child: SizedBox(
        height: 64,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  spacing: 8,
                  children: [
                    const PhosphorIcon(PhosphorIconsLight.plus),
                    Text(
                      LeapLocalizations.of(context).create,
                      style: TextTheme.of(context).titleMedium,
                    ),
                  ],
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
                          icon: const PhosphorIcon(PhosphorIconsLight.arrowUp),
                          tooltip: loc.insertBefore,
                          onPressed: () => onAddPage(index),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          icon: const PhosphorIcon(
                            PhosphorIconsLight.arrowDown,
                          ),
                          tooltip: loc.insertAfter,
                          onPressed: () => onAddPage((index ?? -1) + 1),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          icon: const PhosphorIcon(
                            PhosphorIconsLight.arrowLineUp,
                          ),
                          tooltip: loc.insertFirst,
                          onPressed: () => onAddPage(0),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filledTonal(
                          icon: const PhosphorIcon(
                            PhosphorIconsLight.arrowLineDown,
                          ),
                          tooltip: loc.insertLast,
                          onPressed: () => onAddPage(),
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
    );
  }
}

class _PageEntityListTile extends StatelessWidget {
  const _PageEntityListTile({
    required this.entity,
    required this.selected,
    required this.showInternalPageNumber,
    required this.locationController,
    required this.controller,
    required this.data,
    required this.index,
    required this.onSelectionChanged,
    super.key,
  });

  final PageEntity entity;
  final bool selected;
  final bool showInternalPageNumber;
  final NoteData data;
  final int index;
  final TextEditingController locationController;
  final MultiSelectController<String> controller;
  final VoidCallback onSelectionChanged;

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
        showEditIcon: !isSelectionMode,
        leading: isSelectionMode && editable
            ? Checkbox(
                value: isSelected,
                onChanged: (value) {
                  controller.toggle(entity.path);
                  onSelectionChanged();
                },
              )
            : Icon(
                editable
                    ? PhosphorIconsLight.file
                    : PhosphorIconsLight.folderSimple,
                textDirection: TextDirection.ltr,
              ),
        textFormatter: (v) =>
            v.isEmpty ? AppLocalizations.of(context).untitled : v,
        subtitle: showInternalPageNumber && editable
            ? Text(
                AppLocalizations.of(
                  context,
                ).pageIndex((data.getPageIndex(entity.path) ?? index) + 1),
              )
            : null,
        onTap: () {
          if (isSelectionMode && editable) {
            controller.toggle(entity.path);
            onSelectionChanged();
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
            onSelectionChanged();
          }
        },
        onSaved: editable && !isSelectionMode
            ? (value) => context.read<DocumentBloc>().add(
                PageRenamed(
                  entity.path,
                  resolvePageRename(locationController.text, value),
                ),
              )
            : null,
        actions: editable && !isSelectionMode
            ? [
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.check),
                  onPressed: () {
                    controller.enableSelectionMode();
                    controller.select(entity.path);
                    onSelectionChanged();
                  },
                  child: Text(AppLocalizations.of(context).select),
                ),
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.copy),
                  onPressed: () {
                    final page = data.getPage(entity.path);
                    if (page == null) return;
                    context.read<DocumentBloc>().add(
                      PagesAdded([
                        PageAddedDetails(
                          page: page,
                          name: entity.name,
                          index: (data.getPageIndex(entity.path) ?? index) + 1,
                        ),
                      ]),
                    );
                  },
                  child: Text(AppLocalizations.of(context).duplicate),
                ),
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
