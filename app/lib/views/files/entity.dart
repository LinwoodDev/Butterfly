import 'dart:async';
import 'dart:typed_data';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/reveal.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/file_system/move.dart';
import 'package:butterfly/services/sync.dart';
import 'package:butterfly/views/files/grid.dart';
import 'package:butterfly/views/files/list.dart';
import 'package:butterfly/visualizer/asset.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:intl/intl.dart' hide TextDirection;
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
  final ValueChanged<FileSystemEntity<NoteFile>?> onChanged;
  final bool isMobile;

  /// Moves the dropped asset into this folder, instead of the default move.
  final Future<void> Function(String source)? onMoveInto;

  /// Called when a dragged asset stays over this folder for a while.
  final VoidCallback? onDragHold;

  /// The "Open" action of the menu; by default [onTap] when [onPreview] is
  /// set.
  final VoidCallback? onOpen;

  /// The entries of the "Create" submenu of a folder, which create in it.
  final List<Widget>? createMenu;

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
    required this.onChanged,
    this.onPreview,
    this.onMoveInto,
    this.onDragHold,
    this.onOpen,
    this.createMenu,
  });

  @override
  State<FileEntityItem> createState() => _FileEntityItemState();
}

String _trimSlashes(String path) {
  var start = 0, end = path.length;
  while (start < end && path[start] == '/') {
    start++;
  }
  while (end > start && path[end - 1] == '/') {
    end--;
  }
  return path.substring(start, end);
}

/// Whether the asset at [source] can be moved into the folder [directory]:
/// not into itself, one of its subfolders or the folder it is already in.
bool canMoveAssetInto(String source, String directory) {
  source = _trimSlashes(source);
  directory = _trimSlashes(directory);
  final index = source.lastIndexOf('/');
  final parent = index < 0 ? '' : source.substring(0, index);
  return source != directory &&
      !directory.startsWith('$source/') &&
      parent != directory;
}

/// Outlines [child] while an asset is dragged over it.
Widget highlightDropTarget(BuildContext context, bool active, Widget child) =>
    DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        border: active
            ? Border.all(color: ColorScheme.of(context).primary, width: 2)
            : null,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: child,
    );

/// How far the mouse moves before a drag starts. Flutter's immediate drag
/// starts after one pixel, which turns a slightly shaky click into a drag.
const double _mouseDragSlop = 6;

class _MouseDragPointerState extends MultiDragPointerState {
  _MouseDragPointerState(
    super.initialPosition,
    super.kind,
    super.gestureSettings,
  );

  @override
  void checkForResolutionAfterMove() {
    if (pendingDelta!.distance > _mouseDragSlop) {
      resolve(GestureDisposition.accepted);
    }
  }

  @override
  void accepted(GestureMultiDragStartCallback starter) =>
      starter(initialPosition);
}

class _MouseDragGestureRecognizer extends MultiDragGestureRecognizer {
  _MouseDragGestureRecognizer()
    : super(
        debugOwner: null,
        supportedDevices: const {PointerDeviceKind.mouse},
      );

  @override
  MultiDragPointerState createNewPointerState(PointerDownEvent event) =>
      _MouseDragPointerState(event.position, event.kind, gestureSettings);

  @override
  String get debugDescription => 'mouse drag';
}

/// Starts dragging as soon as the mouse moves a few pixels. Other input keeps
/// the long press of [LongPressDraggable], so touch scrolling still works.
class _MouseDraggable<T extends Object> extends Draggable<T> {
  const _MouseDraggable({
    required super.child,
    required super.feedback,
    super.data,
    super.maxSimultaneousDrags,
  });

  @override
  MultiDragGestureRecognizer createRecognizer(
    GestureMultiDragStartCallback onStart,
  ) => _MouseDragGestureRecognizer()..onStart = onStart;
}

void deleteEntities({
  required BuildContext context,
  required bool isMobile,
  required DocumentFileSystem documentSystem,
  required Set<String> entities,
  required ValueChanged<Set<String>> onDelete,
}) {
  final paths = entities.toSet();
  final colorScheme = ColorScheme.of(context);
  showPopover(
    backgroundColor: colorScheme.surface,
    context: context,
    direction: isMobile ? PopoverDirection.top : PopoverDirection.right,
    radius: 16,
    width: 180,
    arrowHeight: 15,
    arrowWidth: 20,
    bodyBuilder: (ctx) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: .min,
        mainAxisAlignment: .center,
        children: [
          Text(AppLocalizations.of(context).areYouSure, textAlign: .center),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: .spaceEvenly,
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
                  for (final entity in paths) {
                    await documentSystem.deleteAsset(entity);
                    await settingsCubit.removeRecentHistory(
                      AssetLocation(
                        path: entity,
                        remote: documentSystem.storage?.identifier ?? '',
                      ),
                    );
                  }
                  onDelete(paths);
                },
                child: const PhosphorIcon(
                  PhosphorIconsLight.check,
                  textDirection: .ltr,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _FileEntityItemState extends State<FileEntityItem> {
  final TextEditingController _nameController = .new();
  bool _editable = false;
  bool _renaming = false;
  Timer? _dragHoldTimer;

  @override
  void dispose() {
    _dragHoldTimer?.cancel();
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
        final encrypted = entity.data?.isEncrypted() ?? false;
        final password = readConnectionEncryptionPassword(remote);
        final shouldLoadDisplay =
            context.read<SettingsCubit>().state.showThumbnails ||
            encrypted && password != null;
        final data = shouldLoadDisplay && entity.data != null
            ? displayConnectionNoteFile(remote, entity.data!)
            : null;
        icon = entity.location.fileType.icon();
        if (encrypted && !(data?.isValid ?? false)) {
          icon = PhosphorIconsLight.lock;
        }
        if (data?.isValid ?? false) {
          thumbnail = data!.getThumbnail();
          if (thumbnail?.isEmpty ?? false) thumbnail = null;
          metadata = data.getMetadata();
        }
        final locale = Localizations.localeOf(context).languageCode;
        final dateFormatter = DateFormat.yMd(locale);
        final timeFormatter = DateFormat.Hm(locale);
        final updatedAt = metadata?.updatedAt ?? entity.lastModified;
        modifiedText = updatedAt != null
            ? '${dateFormatter.format(updatedAt)} ${timeFormatter.format(updatedAt)}'
            : null;
        createdText = metadata?.createdAt != null
            ? '${dateFormatter.format(metadata!.createdAt!)} ${timeFormatter.format(metadata.createdAt!)}'
            : null;
      }
    } catch (_) {}
    void onEdit(bool value) {
      if (value) {
        _nameController.text = entity is FileSystemFile<NoteFile>
            ? entity.fileNameWithoutExtension
            : entity.fileName;
      }
      setState(() => _editable = value);
    }

    void onDelete() => deleteEntities(
      context: context,
      isMobile: widget.isMobile,
      documentSystem: documentSystem,
      entities: {widget.entity.location.path},
      onDelete: (_) => widget.onChanged(null),
    );

    Future<void> onRename(String name) async {
      if (_renaming) return;
      _renaming = true;
      final onChanged = widget.onChanged;
      try {
        final renamed = await renameDocumentAsset(
          documentSystem,
          fileSystem.settingsCubit,
          entity,
          name,
        );
        if (renamed == null) return;
        if (mounted) onEdit(false);
        if (!identical(renamed, entity)) onChanged(renamed);
      } finally {
        _renaming = false;
      }
    }

    final feedback = Material(
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
    );
    final draggable = _MouseDraggable<String>(
      data: widget.entity.path,
      feedback: feedback,
      // A mouse drag in the name field selects its text.
      maxSimultaneousDrags: _editable ? 0 : null,
      child: LongPressDraggable<String>(
        data: widget.entity.path,
        feedback: feedback,
        child: ContextFileRegion(
          remote: remote,
          entity: entity,
          settingsCubit: fileSystem.settingsCubit,
          editable: _editable,
          onEdit: onEdit,
          onDelete: onDelete,
          onReload: widget.onReload,
          documentSystem: documentSystem,
          onOpen:
              widget.onOpen ?? (widget.onPreview != null ? widget.onTap : null),
          createMenu: widget.createMenu,
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
                  onEdit: onEdit,
                  onRename: onRename,
                  entity: widget.entity,
                  nameController: _nameController,
                  collapsed: widget.collapsed,
                  editable: _editable,
                  active: widget.active || controller.isOpen,
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
                  onRename: onRename,
                  entity: widget.entity,
                  nameController: _nameController,
                  collapsed: widget.collapsed,
                  editable: _editable,
                  active: widget.active || controller.isOpen,
                  selected: widget.selected,
                  onSelectedChanged: widget.onSelected,
                  thumbnail: thumbnail,
                  actionButton: button,
                ),
        ),
      ),
    );
    if (widget.entity is FileSystemDirectory) {
      return DragTarget<String>(
        builder: (context, candidateData, rejectedData) =>
            highlightDropTarget(context, candidateData.isNotEmpty, draggable),
        onWillAcceptWithDetails: (data) {
          final accepted = canMoveAssetInto(
            data.data,
            widget.entity.location.path,
          );
          final onDragHold = widget.onDragHold;
          if (accepted && onDragHold != null) {
            _dragHoldTimer?.cancel();
            _dragHoldTimer = Timer(
              const Duration(milliseconds: 700),
              onDragHold,
            );
          }
          return accepted;
        },
        onLeave: (_) => _dragHoldTimer?.cancel(),
        onAcceptWithDetails: (data) async {
          _dragHoldTimer?.cancel();
          final onMoveInto = widget.onMoveInto;
          if (onMoveInto != null) {
            await onMoveInto(data.data);
            return;
          }
          try {
            await moveDocumentAssetInto(
              documentSystem,
              fileSystem.settingsCubit,
              data.data,
              widget.entity.location.path,
            );
          } catch (_) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context).error)),
              );
            }
          }
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
  final List<Widget>? createMenu;
  final ContextRegionChildBuilder builder;

  const ContextFileRegion({
    super.key,
    required this.remote,
    required this.entity,
    required this.settingsCubit,
    required this.editable,
    required this.onEdit,
    required this.onDelete,
    required this.documentSystem,
    required this.onReload,
    required this.builder,
    this.onOpen,
    this.onSelect,
    this.createMenu,
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
        if (createMenu != null)
          SubmenuButton(
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.plus),
            menuChildren: createMenu!,
            child: Text(LeapLocalizations.of(context).create),
          ),
        if (canRevealInFileExplorer && remote is! RemoteStorage)
          MenuItemButton(
            onPressed: () async {
              final revealed = await revealInFileExplorer(
                documentSystem.fileSystem,
                entity.location.path,
                directory: entity is FileSystemDirectory,
              );
              if (!revealed && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(AppLocalizations.of(context).error)),
                );
              }
            },
            leadingIcon: const PhosphorIcon(
              PhosphorIconsLight.folderOpen,
              textDirection: .ltr,
            ),
            child: Text(AppLocalizations.of(context).revealInFileExplorer),
          ),
        if (remote is RemoteStorage)
          FileSyncStatusButton(
            remote: remote! as RemoteStorage,
            location: entity.location,
            directory: entity is FileSystemDirectory,
            menu: true,
            syncService: syncService,
            settingsCubit: settingsCubit,
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
            leadingIcon: const PhosphorIcon(
              PhosphorIconsLight.check,
              textDirection: .ltr,
            ),
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
            onPressed: () => onEdit(true),
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.pencil),
            child: Text(AppLocalizations.of(context).rename),
          ),
        if (entity is FileSystemFile<NoteFile>)
          MenuItemButton(
            onPressed: () async {
              try {
                final data = await loadFileSystemNoteData(
                  documentSystem,
                  entity as FileSystemFile<NoteFile>,
                );
                if (!context.mounted) return;
                if (data == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context).error)),
                  );
                  return;
                }
                exportData(context, data);
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
