import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/l10n/leap_localizations.dart';

import 'tree.dart';

enum MoveMode { duplicate, move }

class FileSystemAssetMoveDialog extends StatefulWidget {
  final MoveMode? moveMode;
  final List<AssetLocation> assets;
  final DocumentFileSystem fileSystem;
  const FileSystemAssetMoveDialog({
    super.key,
    this.moveMode,
    required this.assets,
    required this.fileSystem,
  });

  @override
  State<FileSystemAssetMoveDialog> createState() =>
      _FileSystemAssetMoveDialogState();
}

class _FileSystemAssetMoveDialogState extends State<FileSystemAssetMoveDialog> {
  final TextEditingController _nameController = TextEditingController();
  late String selectedPath;
  late String selectedRemote;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.assets.first.fileNameWithoutExtension;
    selectedPath = widget.assets.first.parent;
    selectedRemote = widget.assets.first.remote;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  bool isSingleFile() => widget.assets.length == 1;

  DocumentFileSystem _buildDocumentSystem(String remote) {
    final fileSystem = context.read<ButterflyFileSystem>();
    final storage = context.read<SettingsCubit>().getRemote(remote);
    return fileSystem.buildDocumentSystem(storage);
  }

  Future<String> _copyAsset(
    DocumentFileSystem sourceFileSystem,
    DocumentFileSystem destinationFileSystem,
    FileSystemEntity<NoteFile> asset,
    String newPath,
  ) async {
    if (asset is FileSystemFile<NoteFile>) {
      var data = asset.data;
      if (data == null) {
        final source = await sourceFileSystem.getAsset(asset.path);
        if (source is FileSystemFile<NoteFile>) {
          data = source.data;
        }
      }
      if (data != null) {
        await destinationFileSystem.updateFile(newPath, data);
      }
    } else if (asset is FileSystemDirectory<NoteFile>) {
      await destinationFileSystem.createDirectory(newPath);
      for (final child in asset.assets) {
        await _copyAsset(
          sourceFileSystem,
          destinationFileSystem,
          child,
          '$newPath/${child.fileName}',
        );
      }
    }
    return newPath;
  }

  Future<void> _move(bool duplicate) async {
    final navigator = Navigator.of(context);
    final newLocations = <AssetLocation>[];
    final settingsCubit = context.read<SettingsCubit>();
    final destinationFileSystem = _buildDocumentSystem(selectedRemote);
    for (final asset in widget.assets) {
      var newPath = selectedPath;
      if (selectedPath != '/') {
        newPath += '/';
      }
      newPath += isSingleFile()
          ? _nameController.text
          : asset.fileNameWithoutExtension;
      newPath += '.${asset.fileExtension}';
      final sourceFileSystem = asset.remote == selectedRemote
          ? widget.fileSystem
          : _buildDocumentSystem(asset.remote);
      if (duplicate) {
        if (asset.remote == selectedRemote) {
          await sourceFileSystem.duplicateAsset(asset.path, newPath);
        } else {
          final source = await sourceFileSystem.getAsset(
            asset.path,
            listLevel: allListLevel,
          );
          if (source != null) {
            await _copyAsset(
              sourceFileSystem,
              destinationFileSystem,
              source,
              newPath,
            );
          }
        }
      } else {
        final source = await sourceFileSystem.getAsset(
          asset.path,
          listLevel: allListLevel,
        );
        if (source == null) continue;
        if (asset.remote == selectedRemote) {
          await sourceFileSystem.moveAsset(asset.path, newPath);
        } else {
          await _copyAsset(
            sourceFileSystem,
            destinationFileSystem,
            source,
            newPath,
          );
          await sourceFileSystem.deleteAsset(asset.path);
        }
        await settingsCubit.moveAssetReferences(
          asset,
          AssetLocation(path: newPath, remote: selectedRemote),
          directory: source is FileSystemDirectory,
        );
      }
      newLocations.add(AssetLocation(path: newPath, remote: selectedRemote));
    }
    navigator.pop(newLocations);
  }

  @override
  Widget build(BuildContext context) {
    String title = switch (widget.moveMode) {
      MoveMode.duplicate => AppLocalizations.of(context).duplicate,
      MoveMode.move => AppLocalizations.of(context).move,
      _ => AppLocalizations.of(context).changeDocumentPath,
    };
    final settings = context.watch<SettingsCubit>().state;
    final destinationFileSystem = _buildDocumentSystem(selectedRemote);
    return AlertDialog(
      actions: [
        TextButton(
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        if (widget.moveMode != null)
          ElevatedButton(
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
            onPressed: () => _move(widget.moveMode == MoveMode.duplicate),
          ),
        if (widget.moveMode == null) ...[
          ElevatedButton(
            onPressed: () => _move(true),
            child: Text(AppLocalizations.of(context).duplicate),
          ),
          ElevatedButton(
            onPressed: () => _move(false),
            child: Text(AppLocalizations.of(context).move),
          ),
        ],
      ],
      title: Text(title),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (settings.connections.isNotEmpty)
            DropdownMenu<String>(
              label: Text(AppLocalizations.of(context).source),
              width: 300,
              dropdownMenuEntries: [
                DropdownMenuEntry(
                  value: '',
                  label: AppLocalizations.of(context).local,
                ),
                ...settings.connections.map(
                  (e) => DropdownMenuEntry(value: e.identifier, label: e.label),
                ),
              ],
              initialSelection: selectedRemote,
              onSelected: (value) => setState(() {
                selectedRemote = value ?? '';
              }),
            ),
          const SizedBox(height: 16),
          FileSystemDirectoryTreeView(
            key: ValueKey(selectedRemote),
            fileSystem: destinationFileSystem,
            path: '/',
            onPathSelected: (path) => selectedPath = path,
            initialExpanded: true,
          ),
          if (isSingleFile()) ...[
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                filled: true,
                hintText: LeapLocalizations.of(context).name,
              ),
              autofocus: true,
              controller: _nameController,
            ),
          ],
        ],
      ),
    );
  }
}
