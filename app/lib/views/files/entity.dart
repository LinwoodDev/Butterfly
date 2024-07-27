import 'dart:typed_data';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/files/grid.dart';
import 'package:butterfly/views/files/list.dart';
import 'package:butterfly/visualizer/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:popover/popover.dart';

class FileEntityItem extends StatefulWidget {
  final FileSystemEntity<NoteData> entity;
  final bool active, collapsed, gridView;
  final bool? selected;
  final VoidCallback onTap, onReload;
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
  });

  @override
  State<FileEntityItem> createState() => _FileEntityItemState();
}

void deleteEntities({
  required BuildContext context,
  required bool isMobile,
  required DocumentFileSystem documentSystem,
  required List<String> entities,
  required VoidCallback onDelete,
}) {
  final colorScheme = Theme.of(context).colorScheme;
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
                    await settingsCubit.removeRecentHistory(AssetLocation(
                        path: entity,
                        remote: documentSystem.storage?.identifier ?? ''));
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
  Widget build(BuildContext context) {
    final fileSystem = context.read<ButterflyFileSystem>();
    final remote =
        fileSystem.settingsCubit.getRemote(widget.entity.location.remote);
    final documentSystem = fileSystem.buildDocumentSystem(remote);
    FileMetadata? metadata;
    Uint8List? thumbnail;
    String? modifiedText, createdText;
    PhosphorIconData icon = PhosphorIconsLight.folder;
    final entity = widget.entity;
    try {
      if (entity is FileSystemFile<NoteData>) {
        icon = entity.location.fileType.icon(PhosphorIconsStyle.light);
        thumbnail = entity.data?.getThumbnail();
        if (thumbnail?.isEmpty ?? false) thumbnail = null;
        metadata = entity.data?.getMetadata();
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
          entities: [widget.entity.location.path],
          onDelete: widget.onReload,
        );

    final draggable = LongPressDraggable<String>(
      data: widget.entity.pathWithLeadingSlash,
      feedback: Material(
        elevation: 5,
        child: SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.entity.fileName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
      child: widget.gridView
          ? FileEntityGridItem(
              modifiedText: modifiedText,
              createdText: createdText,
              icon: icon,
              onTap: widget.onTap,
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
            )
          : FileEntityListTile(
              modifiedText: modifiedText,
              createdText: createdText,
              icon: icon,
              onTap: widget.onTap,
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
          await documentSystem.moveAsset(data.data,
              '${widget.entity.location.path}/${data.data.split('/').last}');
          widget.onReload();
        },
      );
    }
    return draggable;
  }
}
