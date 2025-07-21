import 'package:butterfly/bloc/document_bloc.dart';
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
          previous.pageName != current.pageName,
      builder: (context, state) {
        if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
        final currentName = state.pageName;
        final pages = state.data.getPages();
        final index = state.data.getPageIndex(state.pageName);
        void addPage([int? index]) =>
            context.read<DocumentBloc>().add(PageAdded(index));

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
                      .where((element) => element.startsWith(query))
                      .map(
                        (e) => (
                          path: e,
                          name: e.substring(query.length),
                          isFile: true,
                        ),
                      )
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
                    child: ReorderableListView.builder(
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
                        final next = all[newIndex.clamp(0, all.length - 1)];
                        var nextIndex = state.data.getPageIndex(next.name);
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
                          data: state.data,
                          key: ValueKey(entity.path),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const PhosphorIcon(PhosphorIconsLight.plus),
                      const SizedBox(width: 8),
                      Text(LeapLocalizations.of(context).create),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton.filledTonal(
                        icon: const PhosphorIcon(PhosphorIconsLight.arrowUp),
                        tooltip: AppLocalizations.of(context).insertBefore,
                        onPressed: () => addPage(index),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filledTonal(
                        icon: const PhosphorIcon(PhosphorIconsLight.arrowDown),
                        tooltip: AppLocalizations.of(context).insertAfter,
                        onPressed: () => addPage((index ?? -1) + 1),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filledTonal(
                        icon: const PhosphorIcon(
                          PhosphorIconsLight.arrowLineUp,
                        ),
                        tooltip: AppLocalizations.of(context).insertFirst,
                        onPressed: () => addPage(0),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filledTonal(
                        icon: const PhosphorIcon(
                          PhosphorIconsLight.arrowLineDown,
                        ),
                        tooltip: AppLocalizations.of(context).insertLast,
                        onPressed: () => addPage(),
                      ),
                    ],
                  ),
                ],
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
    required this.data,
    super.key,
  });

  final _PageEntity entity;
  final bool selected;
  final NoteData data;
  final TextEditingController locationController;

  @override
  Widget build(BuildContext context) {
    final editable = entity.isFile;
    return EditableListTile(
      initialValue: entity.name,
      selected: selected,
      leading: Icon(
        entity.isFile
            ? PhosphorIconsLight.file
            : PhosphorIconsLight.folderSimple,
      ),
      onTap: () {
        if (entity.isFile) {
          context.read<DocumentBloc>().add(PageChanged(entity.path));
        } else {
          locationController.text = entity.path;
        }
      },
      onSaved: editable
          ? (value) => context.read<DocumentBloc>().add(
              PageRenamed(entity.path, value),
            )
          : null,
      actions: editable
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
                        context.read<DocumentBloc>().add(
                          PageRemoved(entity.path),
                        );
                      },
                child: Text(AppLocalizations.of(context).delete),
              ),
            ]
          : null,
    );
  }
}
