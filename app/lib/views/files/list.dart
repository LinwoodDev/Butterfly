import 'dart:typed_data';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/file_system/move.dart';
import 'package:butterfly/services/sync.dart';
import 'package:butterfly/visualizer/connection.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/widgets/file_name_display.dart';

class FileSyncStatusButton extends StatelessWidget {
  final RemoteStorage remote;
  final AssetLocation location;
  final bool directory;
  final bool menu;
  final SyncService? syncService;
  final SettingsCubit? settingsCubit;

  const FileSyncStatusButton({
    super.key,
    required this.remote,
    required this.location,
    this.directory = false,
    this.menu = false,
    this.syncService,
    this.settingsCubit,
  });

  @override
  Widget build(BuildContext context) {
    final syncService = this.syncService ?? context.read<SyncService>();
    final settingsCubit = this.settingsCubit ?? context.read<SettingsCubit>();
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      bloc: settingsCubit,
      buildWhen: (previous, current) =>
          previous.getRemote(remote.identifier) !=
          current.getRemote(remote.identifier),
      builder: (context, settings) {
        final currentRemote = settings.getRemote(remote.identifier);
        if (currentRemote is! RemoteStorage) return const SizedBox.shrink();
        final cached = currentRemote.isPathPinned(
          location.path,
          variant: SyncFileSystemType.documents.cacheVariant,
        );
        final sync = syncService.getSync(remote.identifier);
        if (sync == null) return const SizedBox.shrink();

        return StreamBuilder<RemoteSyncState>(
          stream: sync.stateStream,
          builder: (context, snapshot) {
            final syncFile = snapshot.data?.visibleFiles.values
                .expand((files) => files)
                .lastWhereOrNull((file) => _matches(file.location.path));
            final status =
                syncFile?.status ??
                (directory && cached && snapshot.hasData
                    ? FileSyncStatus.synced
                    : null);
            final loading = cached && status == null;
            final colorScheme = ColorScheme.of(context);
            final icon = loading
                ? PhosphorIconsLight.arrowClockwise
                : status?.getIcon() ?? PhosphorIconsLight.cloudSlash;
            final color =
                status?.getColor(colorScheme) ??
                colorScheme.onSurfaceVariant.withAlpha(184);
            final label = !cached
                ? AppLocalizations.of(context).notSynced
                : loading
                ? AppLocalizations.of(context).loading
                : status.getLocalizedName(context);
            final tooltip = !cached
                ? label
                : '${AppLocalizations.of(context).caches} · $label';
            final onPressed = sync.status == SyncStatus.syncing
                ? null
                : () => _toggleSync(syncService, settingsCubit, cached);

            if (menu) {
              return MenuItemButton(
                leadingIcon: PhosphorIcon(
                  icon,
                  textDirection: TextDirection.ltr,
                  color: color,
                ),
                onPressed: onPressed,
                child: Text(tooltip),
              );
            }

            final button = IconButton(
              icon: PhosphorIcon(
                icon,
                textDirection: TextDirection.ltr,
                color: color,
              ),
              tooltip: tooltip,
              onPressed: onPressed,
            );
            if (!cached || status?.needsSync != true) return button;
            return Badge(smallSize: 8, child: button);
          },
        );
      },
    );
  }

  Future<void> _toggleSync(
    SyncService syncService,
    SettingsCubit settingsCubit,
    bool cached,
  ) async {
    if (cached) {
      final sync = syncService.getSync(remote.identifier);
      await sync?.documentSystem.remoteSystem?.deleteCachedContent(
        location.path,
      );
      await sync?.refreshFiles();
      await settingsCubit.removeCache(remote.identifier, location.path);
      return;
    }
    await settingsCubit.addCache(remote.identifier, location.path);
    await syncService.syncRemote(remote.identifier);
  }

  bool _matches(String syncPath) {
    final path = location.path;
    if (path == syncPath) return true;
    if (!directory) return false;
    final normalizedPath = path.endsWith('/') ? path : '$path/';
    return syncPath.startsWith(normalizedPath);
  }
}

extension on FileSyncStatus {
  bool get needsSync =>
      this == FileSyncStatus.localLatest ||
      this == FileSyncStatus.remoteLatest ||
      this == FileSyncStatus.conflict;
}

class FileEntityListTile extends StatelessWidget {
  final String? modifiedText, createdText;
  final bool active, editable, collapsed;
  final bool? selected;
  final PhosphorIconData icon;
  final VoidCallback onTap, onDelete, onReload;
  final ValueChanged<bool> onEdit, onSelectedChanged;
  final Uint8List? thumbnail;
  final FileSystemEntity<NoteFile> entity;
  final TextEditingController nameController;
  final Widget actionButton;

  const FileEntityListTile({
    super.key,
    this.createdText,
    this.modifiedText,
    this.selected,
    this.active = false,
    this.editable = false,
    this.collapsed = false,
    required this.icon,
    required this.onTap,
    required this.onDelete,
    required this.onReload,
    required this.onEdit,
    required this.onSelectedChanged,
    this.thumbnail,
    required this.entity,
    required this.nameController,
    required this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final fileSystem = context.read<ButterflyFileSystem>();
    final remote = fileSystem.settingsCubit.getRemote(entity.location.remote);
    final documentSystem = fileSystem.buildDocumentSystem(remote);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= LeapBreakpoints.medium;
        final isTablet = constraints.maxWidth >= LeapBreakpoints.compact;
        return Row(
          children: [
            Expanded(
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  side: active
                      ? BorderSide(
                          color: colorScheme.primaryContainer,
                          width: 1,
                        )
                      : BorderSide.none,
                ),
                surfaceTintColor: active
                    ? colorScheme.primaryContainer
                    : colorScheme.secondaryContainer,
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  onTap: onTap,
                  highlightColor: active ? colorScheme.primaryContainer : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Builder(
                      builder: (context) {
                        final info = [
                          if (modifiedText != null)
                            Tooltip(
                              message: AppLocalizations.of(context).modified,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  PhosphorIcon(
                                    PhosphorIconsLight.clockCounterClockwise,
                                    size: 12,
                                    color: colorScheme.outline,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    modifiedText!,
                                    style: TextTheme.of(context).bodySmall
                                        ?.copyWith(color: colorScheme.outline),
                                  ),
                                ],
                              ),
                            ),
                          if (createdText != null)
                            Tooltip(
                              message: AppLocalizations.of(context).created,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  PhosphorIcon(
                                    PhosphorIconsLight.plus,
                                    size: 12,
                                    color: colorScheme.outline,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    createdText!,
                                    style: TextTheme.of(context).bodySmall
                                        ?.copyWith(color: colorScheme.outline),
                                  ),
                                ],
                              ),
                            ),
                        ];
                        final leading = PhosphorIcon(
                          icon,
                          color: colorScheme.outline,
                        );
                        final fileName = Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 64,
                              child: thumbnail != null
                                  ? AspectRatio(
                                      aspectRatio: kThumbnailRatio,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: Image.memory(
                                          thumbnail!,
                                          fit: BoxFit.cover,
                                          gaplessPlayback: true,
                                          cacheHeight: kThumbnailHeight,
                                          cacheWidth: kThumbnailWidth,
                                        ),
                                      ),
                                    )
                                  : leading,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: editable
                                  ? TextField(
                                      controller: nameController,
                                      autofocus: true,
                                      style: TextTheme.of(context).labelLarge,
                                      onSubmitted: (value) async {
                                        await documentSystem.renameAsset(
                                          entity.location.path,
                                          value,
                                        );
                                        onEdit(false);
                                        onReload();
                                      },
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        filled: true,
                                        constraints: BoxConstraints(
                                          maxWidth: constraints.maxWidth,
                                          minWidth: 100,
                                          maxHeight: 40,
                                        ),
                                        hintText: AppLocalizations.of(
                                          context,
                                        ).enterText,
                                        suffix: IconButton(
                                          onPressed: () async {
                                            if (nameController.text ==
                                                entity.fileName) {
                                              onEdit(false);
                                              return;
                                            }
                                            await documentSystem.renameAsset(
                                              entity.location.path,
                                              nameController.text,
                                            );
                                            onEdit(false);
                                            onReload();
                                          },
                                          icon: const PhosphorIcon(
                                            PhosphorIconsLight.check,
                                            textDirection: TextDirection.ltr,
                                          ),
                                          tooltip: AppLocalizations.of(
                                            context,
                                          ).save,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onDoubleTap: () {
                                        onEdit(true);
                                        nameController.text = entity.fileName;
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Tooltip(
                                            message: entity.fileName,
                                            child: FileNameDisplay(
                                              entity: entity,
                                              style: TextTheme.of(
                                                context,
                                              ).labelLarge,
                                            ),
                                          ),
                                          if (!isDesktop && !collapsed) ...[
                                            const SizedBox(height: 6),
                                            Wrap(spacing: 4, children: info),
                                          ],
                                        ],
                                      ),
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
                                      PhosphorIconsLight.pencil,
                                    ),
                                    tooltip: AppLocalizations.of(
                                      context,
                                    ).rename,
                                  ),
                                ],
                              );
                        final actions = Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (remote is RemoteStorage)
                              FileSyncStatusButton(
                                remote: remote,
                                location: entity.location,
                                directory: entity is FileSystemDirectory,
                              ),
                            BlocBuilder<SettingsCubit, ButterflySettings>(
                              builder: (context, state) {
                                final starred = state.isStarred(
                                  entity.location,
                                );
                                return IconButton(
                                  onPressed: () {
                                    fileSystem.settingsCubit.toggleStarred(
                                      entity.location,
                                    );
                                  },
                                  selectedIcon: const PhosphorIcon(
                                    PhosphorIconsFill.star,
                                  ),
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.star,
                                  ),
                                  isSelected: starred,
                                  tooltip: starred
                                      ? AppLocalizations.of(context).unstar
                                      : AppLocalizations.of(context).star,
                                );
                              },
                            ),
                            IconButton(
                              onPressed: () =>
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        FileSystemAssetMoveDialog(
                                          assets: [entity.location],
                                          fileSystem: documentSystem,
                                        ),
                                  ).then((value) {
                                    if (value != null) onReload();
                                  }),
                              tooltip: AppLocalizations.of(context).move,
                              icon: const PhosphorIcon(
                                PhosphorIconsLight.arrowsDownUp,
                              ),
                            ),
                          ],
                        );
                        final selectionCheckbox = Checkbox(
                          value: selected ?? false,
                          onChanged: (value) =>
                              onSelectedChanged(value ?? false),
                        );
                        if (isDesktop) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              selectionCheckbox,
                              const SizedBox(width: 8),
                              Expanded(
                                child: Row(
                                  children: [
                                    Flexible(child: fileName),
                                    edit,
                                  ],
                                ),
                              ),
                              if (!collapsed) ...[
                                const SizedBox(width: 32),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  spacing: 4,
                                  children: info,
                                ),
                                const SizedBox(width: 32),
                                actions,
                              ] else if (collapsed)
                                actionButton,
                            ],
                          );
                        } else if (isTablet) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              selectionCheckbox,
                              const SizedBox(width: 8),
                              Expanded(
                                child: Row(
                                  children: [
                                    Flexible(child: fileName),
                                    const SizedBox(width: 8),
                                    edit,
                                  ],
                                ),
                              ),
                              if (!collapsed) actions else actionButton,
                            ],
                          );
                        } else {
                          return Row(
                            children: [
                              if (selected != null) ...[
                                selectionCheckbox,
                                const SizedBox(width: 8),
                              ],
                              Expanded(child: fileName),
                              actionButton,
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            if (!collapsed && isTablet) ...[
              const SizedBox(width: 16),
              SizedBox(
                width: 96,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (entity is FileSystemFile<NoteFile>)
                      IconButton(
                        onPressed: () {
                          try {
                            final data = (entity as FileSystemFile<NoteFile>)
                                .data
                                ?.load();
                            if (data == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context).error,
                                  ),
                                ),
                              );
                              return;
                            }
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
                        icon: const PhosphorIcon(
                          PhosphorIconsLight.paperPlaneRight,
                        ),
                        tooltip: AppLocalizations.of(context).export,
                      ),
                    IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.trash),
                      highlightColor: colorScheme.error.withValues(alpha: 0.2),
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
      },
    );
  }
}
