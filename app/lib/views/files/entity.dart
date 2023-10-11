part of '../files.dart';

class _FileEntityItem extends StatefulWidget {
  final AppDocumentEntity entity;
  final bool selected, collapsed, gridView;
  final VoidCallback onTap, onReload;
  final bool isMobile;

  const _FileEntityItem({
    required this.entity,
    this.selected = false,
    this.collapsed = false,
    this.gridView = false,
    required this.isMobile,
    required this.onTap,
    required this.onReload,
  });

  @override
  State<_FileEntityItem> createState() => _FileEntityItemState();
}

class _FileEntityItemState extends State<_FileEntityItem> {
  final TextEditingController _nameController = TextEditingController();
  bool _editable = false;

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    final remote = settingsCubit.getRemote(widget.entity.location.remote);
    final fileSystem = DocumentFileSystem.fromPlatform(remote: remote);
    FileMetadata? metadata;
    Uint8List? thumbnail;
    String? modifiedText, createdText;
    PhosphorIconData icon = PhosphorIconsLight.folder;
    try {
      if (widget.entity is AppDocumentFile) {
        final file = widget.entity as AppDocumentFile;
        icon = file.fileType.icon(PhosphorIconsStyle.light);
        thumbnail = file.thumbnail;
        if (thumbnail?.isEmpty ?? false) thumbnail = null;
        metadata = file.metadata;
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
    void onDelete() {
      final colorScheme = Theme.of(context).colorScheme;
      showPopover(
        backgroundColor: colorScheme.surface,
        context: context,
        direction:
            widget.isMobile ? PopoverDirection.top : PopoverDirection.right,
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
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      fileSystem.deleteAsset(widget.entity.location.path);
                      widget.onReload();
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
          ? _FileEntityGridItem(
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
              selected: widget.selected,
              thumbnail: thumbnail,
            )
          : _FileEntityListTile(
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
              selected: widget.selected,
              thumbnail: thumbnail,
            ),
    );
    if (widget.entity is AppDocumentDirectory) {
      return DragTarget<String>(
        builder: (context, candidateData, rejectedData) {
          return draggable;
        },
        onWillAccept: (data) {
          return data != widget.entity.location.path;
        },
        onAccept: (data) async {
          await fileSystem.moveAsset(
              data, '${widget.entity.location.path}/${data.split('/').last}');
          widget.onReload();
        },
      );
    }
    return draggable;
  }
}
