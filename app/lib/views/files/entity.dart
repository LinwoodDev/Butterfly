import 'dart:typed_data';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/file_system/move.dart';
import 'package:butterfly/services/sync.dart';
import 'package:butterfly/views/files/grid.dart';
import 'package:butterfly/views/files/list.dart';
import 'package:butterfly/visualizer/asset.dart';
import 'package:butterfly/visualizer/connection.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:popover/popover.dart';

class FileEntityItem extends StatefulWidget {
  final FileSystemEntity<NoteFile> entity;
  final bool active, collapsed, gridView;
  final bool? selected;
  final VoidCallback onTap, onReload;
  final VoidCallback? onPreview;
  final ValueChanged<bool> onSelected;
  final bool isMobile;

  const FileEntityItem({
    super.key,
    required this.entity,
    this.selected = false,
    this.active = false,
    this.collapsed = false,
    this.gridView = false,
    required this.isMobile,
    required this.onTap,
    required this.onReload,
    required this.onSelected,
    this.onPreview,
  });

  @override
  State<FileEntityItem> createState() => _FileEntityItemState();
}

void deleteEntities({
  required BuildContext context,
  required bool isMobile,
  required DocumentFileSystem documentSystem,
  required Set<String> entities,
  required VoidCallback onDelete,
}) {
  final colorScheme = ColorScheme.of(context);
  showPopover(
    backgroundColor: colorScheme.surface,
    context: context,
    direction: isMobile ? PopoverDirection.top : PopoverDirection.right,
    radius: 16,
    width: 180,
    height: 130,
    arrowHeight: 15,
    arrowWidth: 20,
    bodyBuilder: (ctx) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context).areYouSure,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const PhosphorIcon(PhosphorIconsLight.x),
              ),
              FilledButton(
                onPressed: () async {
                  final settingsCubit = context.read<SettingsCubit>();
                  Navigator.of(ctx).pop();
                  for (final entity in entities) {
                    await documentSystem.deleteAsset(entity);
                    await settingsCubit.removeRecentHistory(
                      AssetLocation(
                        path: entity,
                        remote: documentSystem.storage?.identifier ?? '',
                      ),
                    );
                  }
                  onDelete();
                },
                child: const PhosphorIcon(PhosphorIconsLight.check),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _FileEntityItemState extends State<FileEntityItem> {
  final TextEditingController _nameController = TextEditingController();
  bool _editable = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fileSystem = context.read<ButterflyFileSystem>();
    final remote = fileSystem.settingsCubit.getRemote(
      widget.entity.location.remote,
    );
    final documentSystem = fileSystem.buildDocumentSystem(remote);
    FileMetadata? metadata;
    Uint8List? thumbnail;
    String? modifiedText, createdText;
    PhosphorIconData icon = PhosphorIconsLight.folder;
    final entity = widget.entity;
    try {
      if (entity is FileSystemFile<NoteFile>) {
        final data = entity.data?.load();
        icon = entity.location.fileType.icon(PhosphorIconsStyle.light);
        if (entity.data?.isEncrypted() ?? false) {
          icon = PhosphorIconsLight.lock;
        }
        thumbnail = data?.getThumbnail();
        if (thumbnail?.isEmpty ?? false) thumbnail = null;
        metadata = data?.getMetadata();
        final locale = Localizations.localeOf(context).languageCode;
        final dateFormatter = DateFormat.yMd(locale);
        final timeFormatter = DateFormat.Hm(locale);
        modifiedText = metadata?.updatedAt != null
            ? '${dateFormatter.format(metadata!.updatedAt!)} ${timeFormatter.format(metadata.updatedAt!)}'
            : null;
        createdText = metadata?.createdAt != null
            ? '${dateFormatter.format(metadata!.createdAt!)} ${timeFormatter.format(metadata.createdAt!)}'
            : null;
      }
    } catch (_) {}
    void onEdit(bool value) => setState(() => _editable = value);
    void onDelete() => deleteEntities(
      context: context,
      isMobile: widget.isMobile,
      documentSystem: documentSystem,
      entities: {widget.entity.location.path},
      onDelete: widget.onReload,
    );

    final draggable = LongPressDraggable<String>(
      data: widget.entity.path,
      feedback: Material(
        elevation: 5,
        child: SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.entity.fileName,
              style: TextTheme.of(context).bodyMedium,
            ),
          ),
        ),
      ),
      child: ContextFileRegion(
        remote: remote,
        entity: entity,
        settingsCubit: fileSystem.settingsCubit,
        editable: _editable,
        onEdit: onEdit,
        nameController: _nameController,
        onDelete: onDelete,
        onReload: widget.onReload,
        documentSystem: documentSystem,
        onOpen: widget.onPreview != null ? widget.onTap : null,
        onSelect: widget.selected == null
            ? () => widget.onSelected(true)
            : null,
        builder: (context, button, controller) => widget.gridView
            ? FileEntityGridItem(
                modifiedText: modifiedText,
                createdText: createdText,
                icon: icon,
                onTap: widget.onPreview ?? widget.onTap,
                onDelete: onDelete,
                onReload: widget.onReload,
                onEdit: onEdit,
                entity: widget.entity,
                nameController: _nameController,
                collapsed: widget.collapsed,
                editable: _editable,
                active: widget.active,
                selected: widget.selected,
                onSelectedChanged: widget.onSelected,
                thumbnail: thumbnail,
                actionButton: button,
              )
            : FileEntityListTile(
                modifiedText: modifiedText,
                createdText: createdText,
                icon: icon,
                onTap: widget.onPreview ?? widget.onTap,
                onDelete: onDelete,
                onReload: widget.onReload,
                onEdit: onEdit,
                entity: widget.entity,
                nameController: _nameController,
                collapsed: widget.collapsed,
                editable: _editable,
                active: widget.active,
                selected: widget.selected,
                onSelectedChanged: widget.onSelected,
                thumbnail: thumbnail,
                actionButton: button,
              ),
      ),
    );
    if (widget.entity is FileSystemDirectory) {
      return DragTarget<String>(
        builder: (context, candidateData, rejectedData) {
          return draggable;
        },
        onWillAcceptWithDetails: (data) {
          return data.data != widget.entity.location.path;
        },
        onAcceptWithDetails: (data) async {
          await documentSystem.moveAsset(
            data.data,
            '${widget.entity.location.path}/${data.data.split('/').last}',
          );
          widget.onReload();
        },
      );
    }
    return draggable;
  }
}

class ContextFileRegion extends StatelessWidget {
  final ExternalStorage? remote;
  final DocumentFileSystem documentSystem;
  final FileSystemEntity<NoteFile> entity;
  final SettingsCubit settingsCubit;
  final bool editable;
  final ValueChanged<bool> onEdit;
  final VoidCallback onReload, onDelete;
  final VoidCallback? onSelect;
  final VoidCallback? onOpen;
  final TextEditingController nameController;
  final ContextRegionChildBuilder builder;

  const ContextFileRegion({
    super.key,
    required this.remote,
    required this.entity,
    required this.settingsCubit,
    required this.editable,
    required this.onEdit,
    required this.nameController,
    required this.onDelete,
    required this.documentSystem,
    required this.onReload,
    required this.builder,
    this.onOpen,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final syncService = context.read<SyncService>();
    return ContextRegion(
      tooltip: AppLocalizations.of(context).actions,
      menuChildren: [
        if (onOpen != null)
          MenuItemButton(
            onPressed: onOpen,
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.eye),
            child: Text(AppLocalizations.of(context).open),
          ),
        if (remote is RemoteStorage)
          StreamBuilder<List<SyncFile>>(
            stream: syncService.getSync(remote!.identifier)?.filesStream,
            builder: (context, snapshot) {
              final currentStatus = snapshot.data
                  ?.lastWhereOrNull(
                    (element) =>
                        entity.location.path.startsWith(element.location.path),
                  )
                  ?.status;
              return MenuItemButton(
                leadingIcon: PhosphorIcon(
                  currentStatus.getIcon(),
                  color: currentStatus.getColor(ColorScheme.of(context)),
                ),
                child: Text(currentStatus.getLocalizedName(context)),
                onPressed: () {
                  syncService.getSync(remote!.identifier)?.sync();
                },
              );
            },
          ),
        BlocBuilder<SettingsCubit, ButterflySettings>(
          builder: (context, state) {
            final starred = state.isStarred(entity.location);
            return MenuItemButton(
              onPressed: () {
                settingsCubit.toggleStarred(entity.location);
              },
              leadingIcon: starred
                  ? const PhosphorIcon(PhosphorIconsFill.star)
                  : const PhosphorIcon(PhosphorIconsLight.star),
              child: Text(
                starred
                    ? AppLocalizations.of(context).unstar
                    : AppLocalizations.of(context).star,
              ),
            );
          },
        ),
        if (onSelect != null)
          MenuItemButton(
            onPressed: onSelect,
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.check),
            child: Text(AppLocalizations.of(context).select),
          ),
        MenuItemButton(
          onPressed: () =>
              showDialog(
                context: context,
                builder: (context) => FileSystemAssetMoveDialog(
                  assets: [entity.location],
                  fileSystem: documentSystem,
                ),
              ).then((value) {
                if (value != null) onReload();
              }),
          leadingIcon: const PhosphorIcon(PhosphorIconsLight.arrowsDownUp),
          child: Text(AppLocalizations.of(context).move),
        ),
        if (!editable)
          MenuItemButton(
            onPressed: () {
              if (!hasInvalidFileName(nameController.text)) onEdit(true);
              nameController.text = entity.fileName;
            },
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.pencil),
            child: Text(AppLocalizations.of(context).rename),
          ),
        if (entity is FileSystemFile<NoteFile>)
          MenuItemButton(
            onPressed: () {
              try {
                final data = (entity as FileSystemFile<NoteFile>).data;
                exportData(context, data?.data ?? []);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context).error)),
                );
              }
            },
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.paperPlaneRight),
            child: Text(AppLocalizations.of(context).export),
          ),
        MenuItemButton(
          onPressed: onDelete,
          leadingIcon: const PhosphorIcon(PhosphorIconsLight.trash),
          child: Text(AppLocalizations.of(context).delete),
        ),
      ],
      builder: builder,
    );
  }
}
