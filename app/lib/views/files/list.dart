import 'dart:typed_data';

import 'package:butterfly/api/file_system/file_system.dart';
import 'package:butterfly/api/file_system/file_system_remote.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/file_system/move.dart';
import 'package:butterfly/services/sync.dart';
import 'package:butterfly/views/files/grid.dart';
import 'package:butterfly/visualizer/sync.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FileEntityListTile extends StatelessWidget {
  final String? modifiedText, createdText;
  final bool selected, editable, collapsed;
  final PhosphorIconData icon;
  final VoidCallback onTap, onDelete, onReload;
  final ValueChanged<bool> onEdit;
  final Uint8List? thumbnail;
  final AppDocumentEntity entity;
  final TextEditingController nameController;

  const FileEntityListTile({
    super.key,
    this.createdText,
    this.modifiedText,
    this.selected = false,
    this.editable = false,
    this.collapsed = false,
    required this.icon,
    required this.onTap,
    required this.onDelete,
    required this.onReload,
    required this.onEdit,
    this.thumbnail,
    required this.entity,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final settingsCubit = context.read<SettingsCubit>();
    final syncService = context.read<SyncService>();
    final remote = settingsCubit.getRemote(entity.location.remote);
    final fileSystem = DocumentFileSystem.fromPlatform(remote: remote);
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: selected
                  ? BorderSide(
                      color: colorScheme.primaryContainer,
                      width: 1,
                    )
                  : BorderSide.none,
            ),
            surfaceTintColor: selected
                ? colorScheme.primaryContainer
                : colorScheme.secondaryContainer,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
                onTap: onTap,
                highlightColor: selected ? colorScheme.primaryContainer : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: LayoutBuilder(builder: (context, constraints) {
                    final leading = PhosphorIcon(
                      icon,
                      color: colorScheme.outline,
                    );
                    final fileName = Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: thumbnail != null
                              ? Image.memory(
                                  thumbnail!,
                                  fit: BoxFit.cover,
                                  cacheHeight: 32,
                                  cacheWidth: 32,
                                  errorBuilder: (context, error, stackTrace) =>
                                      leading,
                                )
                              : leading,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: editable
                              ? ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: constraints.maxWidth,
                                    minWidth: 100,
                                  ),
                                  child: TextField(
                                    controller: nameController,
                                    autofocus: true,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: colorScheme.onBackground,
                                        ),
                                    onSubmitted: (value) async {
                                      await fileSystem.renameAsset(
                                          entity.location.path, value);
                                      onEdit(false);
                                      onReload();
                                    },
                                  ),
                                )
                              : GestureDetector(
                                  child: Text(entity.fileName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                  onDoubleTap: () {
                                    onEdit(true);
                                    nameController.text = entity.fileName;
                                  },
                                ),
                        ),
                      ],
                    );
                    final edit = editable
                        ? Container()
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  onEdit(true);
                                  nameController.text = entity.fileName;
                                },
                                icon: const PhosphorIcon(
                                    PhosphorIconsLight.pencil),
                                tooltip: AppLocalizations.of(context).rename,
                              ),
                            ],
                          );
                    final actions = Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (remote is RemoteStorage)
                          StreamBuilder<List<SyncFile>>(
                            stream: syncService
                                .getSync(remote!.identifier)
                                ?.filesStream,
                            builder: (context, snapshot) {
                              final currentStatus = snapshot.data
                                  ?.lastWhereOrNull((element) => entity
                                      .location.pathWithLeadingSlash
                                      .startsWith(element
                                          .location.pathWithLeadingSlash))
                                  ?.status;
                              return IconButton(
                                icon: PhosphorIcon(currentStatus.getIcon(),
                                    color: currentStatus.getColor(
                                        Theme.of(context).colorScheme)),
                                tooltip:
                                    currentStatus.getLocalizedName(context),
                                onPressed: () {
                                  syncService
                                      .getSync(remote.identifier)
                                      ?.sync();
                                },
                              );
                            },
                          ),
                        BlocBuilder<SettingsCubit, ButterflySettings>(
                            builder: (context, state) {
                          final starred = state.isStarred(entity.location);
                          return IconButton(
                            onPressed: () {
                              settingsCubit.toggleStarred(entity.location);
                            },
                            selectedIcon:
                                const PhosphorIcon(PhosphorIconsFill.star),
                            icon: const PhosphorIcon(PhosphorIconsLight.star),
                            isSelected: starred,
                            tooltip: starred
                                ? AppLocalizations.of(context).unstar
                                : AppLocalizations.of(context).star,
                          );
                        }),
                        IconButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => FileSystemAssetMoveDialog(
                              asset: entity,
                              fileSystem: fileSystem,
                            ),
                          ).then((value) => onReload()),
                          tooltip: AppLocalizations.of(context).move,
                          icon: const PhosphorIcon(
                              PhosphorIconsLight.arrowsDownUp),
                        ),
                      ],
                    );
                    final info = Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (modifiedText != null)
                          Tooltip(
                            message: AppLocalizations.of(context).modified,
                            child: Row(
                              children: [
                                PhosphorIcon(
                                  PhosphorIconsLight.clockCounterClockwise,
                                  size: 12,
                                  color: colorScheme.outline,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  modifiedText!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: colorScheme.outline,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        if (createdText != null)
                          Tooltip(
                            message: AppLocalizations.of(context).created,
                            child: Row(
                              children: [
                                PhosphorIcon(
                                  PhosphorIconsLight.plus,
                                  size: 12,
                                  color: colorScheme.outline,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  createdText!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: colorScheme.outline,
                                      ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                    final actionMenu = FilesActionMenu(
                      remote: remote,
                      syncService: syncService,
                      entity: entity,
                      settingsCubit: settingsCubit,
                      editable: editable,
                      onEdit: onEdit,
                      nameController: nameController,
                      onDelete: onDelete,
                    );
                    final isDesktop = constraints.maxWidth > 400;
                    final isTablet = constraints.maxWidth > 300;
                    if (isDesktop) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                fileName,
                                edit,
                              ],
                            ),
                          ),
                          if (!collapsed) ...[
                            const SizedBox(width: 32),
                            info,
                            const SizedBox(width: 32),
                            actions,
                          ] else if (collapsed)
                            actionMenu,
                        ],
                      );
                    } else if (isTablet) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Row(children: [
                            Flexible(
                              child: Wrap(
                                spacing: 2,
                                children: [
                                  fileName,
                                  if (!collapsed) info,
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            edit,
                          ])),
                          if (!collapsed) actions else actionMenu,
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                fileName,
                                const SizedBox(height: 8),
                                info,
                                const SizedBox(height: 8),
                                if (!collapsed)
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      edit,
                                      actions,
                                    ],
                                  ),
                              ],
                            ),
                          ),
                          if (collapsed) actionMenu,
                        ],
                      );
                    }
                  }),
                )),
          ),
        ),
        if (!collapsed) ...[
          const SizedBox(width: 16),
          SizedBox(
            width: 96,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (entity is AppDocumentFile)
                  IconButton(
                    onPressed: () {
                      try {
                        final data = (entity as AppDocumentFile).data;
                        exportData(context, data);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context).error,
                            ),
                          ),
                        );
                      }
                    },
                    icon:
                        const PhosphorIcon(PhosphorIconsLight.paperPlaneRight),
                    tooltip: AppLocalizations.of(context).export,
                  ),
                IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.trash),
                  highlightColor: colorScheme.error.withOpacity(0.2),
                  tooltip: AppLocalizations.of(context).delete,
                  onPressed: () {
                    onDelete();
                  },
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
