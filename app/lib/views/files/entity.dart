part of '../files.dart';

class _FileEntityItem extends StatefulWidget {
  final AppDocumentEntity entity;
  final bool selected, collapsed, gridView;
  final VoidCallback onTap, onReload;

  const _FileEntityItem({
    required this.entity,
    this.selected = false,
    this.collapsed = false,
    this.gridView = false,
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
        icon = file.fileType.getIcon();
        final data = file.load();
        thumbnail = data.getThumbnail();
        if (thumbnail?.isEmpty ?? false) thumbnail = null;
        metadata = data.getMetadata();
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
        backgroundColor: colorScheme.inverseSurface,
        context: context,
        bodyBuilder: (ctx) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context).areYouSure,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onInverseSurface,
                    ),
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
        direction: PopoverDirection.bottom,
        width: 200,
        height: 130,
        arrowHeight: 15,
        arrowWidth: 20,
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
