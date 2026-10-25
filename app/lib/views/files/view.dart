import 'dart:async';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/intent.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/dialogs/collaboration/connect.dart';
import 'package:butterfly/dialogs/file_system/move.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/services/document_state.dart';
import 'package:butterfly/views/files/entity.dart';
import 'package:butterfly/views/files/recent.dart';
import 'package:butterfly/views/files/tree.dart';
import 'package:butterfly/widgets/connection_button.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:rxdart/rxdart.dart';

import '../../api/open.dart';
import '../../cubits/settings.dart';
import '../../dialogs/file_system/sync.dart';

class FilesView extends StatefulWidget {
  final AssetLocation? activeAsset;
  final ExternalStorage? remote;
  final ValueChanged<ExternalStorage?>? onRemoteChanged;
  final ValueChanged<FileSystemFile<NoteFile>>? onPreview;
  final void Function(FileSystemEntity<NoteFile>)? onTap;
  final bool collapsed;
  final bool isMobile, isPage;
  final String? initialPath;

  const FilesView({
    super.key,
    this.initialPath,
    this.activeAsset,
    this.remote,
    this.onRemoteChanged,
    this.onPreview,
    this.onTap,
    this.collapsed = false,
    this.isMobile = false,
    this.isPage = false,
  });

  @override
  State<FilesView> createState() => FilesViewState();
}

class FilesViewState extends State<FilesView> {
  final TextEditingController _locationController = .new();
  late final ButterflyFileSystem _fileSystem;
  late Future<List<FileSystemFile<NoteData>>> _templatesFuture;
  late DocumentFileSystem _documentSystem;
  late TemplateFileSystem _templateSystem;
  final GlobalKey<RecentFilesViewState> _recentFilesKey = GlobalKey();

  SortBy _sortBy = .name;
  SortOrder _sortOrder = .ascending;
  ExternalStorage? _remote;
  String _search = '';
  late final SettingsCubit _settingsCubit;
  BehaviorSubject<FileSystemEntity<NoteFile>?>? _filesStream;
  StreamSubscription<FileSystemEntity<NoteFile>?>? _filesSubscription;
  final Set<String> _selectedFiles = {};
  final FileTreeController _tree = FileTreeController();

  @override
  void initState() {
    super.initState();
    _fileSystem = context.read<ButterflyFileSystem>();
    _settingsCubit = context.read<SettingsCubit>();
    _sortBy = _settingsCubit.state.sortBy;
    _sortOrder = _settingsCubit.state.sortOrder;
    _remote = widget.remote ?? _settingsCubit.getRemote();
    final initialPath = widget.initialPath;
    if (initialPath != null) {
      _locationController.text = initialPath;
    }
    _tree
      ..readData = _readData
      ..onRead = _retainTreeSelection
      ..addListener(_onTreeChanged);
    _setFilesStream();
  }

  @override
  void dispose() {
    _filesSubscription?.cancel();
    _filesStream?.close();
    _locationController.dispose();
    _tree.dispose();
    super.dispose();
  }

  bool _readData() =>
      widget.onPreview != null || _settingsCubit.state.showThumbnails;

  void _onTreeChanged() => setState(() {});

  @override
  void didUpdateWidget(covariant FilesView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remote != widget.remote) {
      final storageChanged = _remote?.identifier != widget.remote?.identifier;
      _remote = widget.remote;
      if (storageChanged) {
        _locationController.clear();
        _selectedFiles.clear();
      }
      _setFilesStream();
    }
  }

  String getLocalizedNameOfSortBy(SortBy sortBy) => switch (sortBy) {
    .name => LeapLocalizations.of(context).name,
    .created => AppLocalizations.of(context).created,
    .modified => AppLocalizations.of(context).modified,
  };

  PhosphorIconData getIconOfSortBy(SortBy sortBy) => switch (sortBy) {
    .name => PhosphorIconsLight.file,
    .created => PhosphorIconsLight.calendar,
    .modified => PhosphorIconsLight.clock,
  };

  String getLocalizedNameOfFilesLayout(FilesLayout layout) => switch (layout) {
    .list => AppLocalizations.of(context).listLayout,
    .grid => AppLocalizations.of(context).gridLayout,
    .tree => AppLocalizations.of(context).treeLayout,
  };

  PhosphorIconData getIconOfFilesLayout(FilesLayout layout) => switch (layout) {
    .list => PhosphorIconsLight.list,
    .grid => PhosphorIconsLight.gridFour,
    .tree => PhosphorIconsLight.treeView,
  };

  // The collapsed view has no room for the grid.
  List<FilesLayout> get _availableLayouts => widget.collapsed
      ? const [FilesLayout.list, FilesLayout.tree]
      : FilesLayout.values;

  FilesLayout get _layout {
    final layout = _settingsCubit.state.filesLayout;
    return _availableLayouts.contains(layout) ? layout : FilesLayout.list;
  }

  // Selected entries of a folder that was read again must still be in it.
  void _retainTreeSelection(
    String path,
    FileSystemDirectory<NoteFile>? directory,
  ) {
    final existing = {...?directory?.assets.map(_tree.pathOf)};
    _selectedFiles.removeWhere((selected) {
      final normalized = _documentSystem.normalizePath(selected);
      if (!normalized.startsWith('$path/')) return false;
      final child = normalized.substring(path.length + 1).split('/').first;
      return !existing.contains('$path/$child');
    });
  }

  void _toggleTreeDirectory(FileSystemEntity<NoteFile> directory) {
    setState(() {
      if (_tree.toggle(directory)) return;
      // The entries of a collapsed folder are hidden: deselect them, so that
      // the selection actions never touch entries nobody sees.
      final path = _tree.pathOf(directory);
      _selectedFiles.removeWhere(
        (selected) =>
            _documentSystem.normalizePath(selected).startsWith('$path/'),
      );
    });
  }

  List<FileTreeRow> _getTreeRows(
    List<FileSystemEntity<NoteFile>> assets,
    Map<NoteFile, FileMetadata?> metadata,
  ) => _tree.rows(
    assets,
    search: _search,
    compare: (a, b) => _sortAssets(a, b, metadata),
  );

  void _setFilesStream({FileSystemEntity<NoteFile>? initialData}) {
    _filesSubscription?.cancel();
    _filesStream?.close();
    if (initialData == null) _selectedFiles.clear();
    _templateSystem = _fileSystem.buildTemplateSystem();
    _documentSystem = _fileSystem.buildDocumentSystem(_remote);
    _tree.reset(_documentSystem);
    final files = initialData == null
        ? BehaviorSubject<FileSystemEntity<NoteFile>?>()
        : BehaviorSubject<FileSystemEntity<NoteFile>?>.seeded(initialData);
    _filesStream = files;
    FileSystemEntity<NoteFile>? latest = initialData;
    _filesSubscription = _documentSystem
        .fetchAsset(_locationController.text, readData: _readData())
        .listen(
          (asset) => latest = asset,
          onError: files.addError,
          cancelOnError: true,
          onDone: () {
            // fetchAsset emits partial directories before the complete listing.
            if (files.isClosed) return;
            final entity = latest;
            if (_selectedFiles.isNotEmpty) {
              setState(
                () => _selectedFiles.retainAll([
                  if (entity is FileSystemDirectory<NoteFile>)
                    ...entity.assets.map((asset) => asset.path),
                  for (final directory in _tree.directories)
                    ...directory.assets.map((asset) => asset.path),
                ]),
              );
            }
            files.add(entity);
          },
        );
    _templatesFuture = _templateSystem.initialize().then(
      (_) => _templateSystem.getFiles(),
    );
  }

  void reloadFileSystem() {
    if (!mounted) return;
    _recentFilesKey.currentState?.reload();
    final current = _filesStream?.valueOrNull;
    final sameDirectory =
        current != null &&
        current.remote == (_remote?.identifier ?? '') &&
        _documentSystem.normalizePath(current.path) ==
            _documentSystem.normalizePath(_locationController.text);
    setState(
      () => _setFilesStream(initialData: sameDirectory ? current : null),
    );
  }

  // Updates the loaded folders and the selection, which can both contain
  // entries outside the current folder.
  void _updateTreeAsset(
    AssetLocation original,
    FileSystemEntity<NoteFile>? replacement,
  ) {
    if (original.remote != (_remote?.identifier ?? '')) return;
    setState(() {
      _tree.update(original, replacement);
      _moveSelectedPaths(
        _documentSystem.normalizePath(original.path),
        replacement?.path,
      );
    });
  }

  // Selected entries follow a renamed folder and leave a deleted one.
  void _moveSelectedPaths(String path, String? newPath) {
    final moved = _selectedFiles
        .map(_documentSystem.normalizePath)
        .where((key) => key == path || key.startsWith('$path/'))
        .toList();
    _selectedFiles.removeWhere(
      (selected) => moved.contains(_documentSystem.normalizePath(selected)),
    );
    if (newPath == null) return;
    _selectedFiles.addAll(
      moved.map((key) => '$newPath${key.substring(path.length)}'),
    );
  }

  Future<void> _moveAssetInto(String source, String directory) async {
    if (!canMoveAssetInto(source, directory)) return;
    final documentSystem = _documentSystem;
    final FileSystemEntity<NoteFile>? moved;
    try {
      moved = await moveDocumentAssetInto(
        documentSystem,
        _settingsCubit,
        source,
        directory,
      );
    } catch (error) {
      debugPrint('Could not move $source into $directory: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context).error)),
        );
      }
      return;
    }
    if (!mounted || documentSystem != _documentSystem) return;
    if (moved != null) {
      final path = documentSystem.normalizePath(source);
      final newPath = moved.path;
      final directory = moved is FileSystemDirectory<NoteFile>;
      setState(() {
        _tree.move(
          path,
          directory ? documentSystem.normalizePath(newPath) : null,
        );
        _moveSelectedPaths(path, newPath);
      });
    }
    reloadFileSystem();
  }

  void _updateAsset(
    AssetLocation original,
    FileSystemEntity<NoteFile>? replacement,
  ) {
    if (!mounted) return;
    _updateTreeAsset(original, replacement);
    final directory = _filesStream?.valueOrNull;
    if (directory is! FileSystemDirectory<NoteFile> ||
        directory.remote != original.remote ||
        _documentSystem.normalizePath(directory.path) !=
            _documentSystem.normalizePath(original.parent)) {
      return;
    }
    // A pending refresh must not overwrite a successful file change.
    _filesSubscription?.cancel();
    _filesSubscription = null;
    final assets = directory.assets
        .where((asset) => asset.location != original)
        .toList();
    if (replacement != null) assets.add(replacement);
    _filesStream!.add(directory.withAssets(assets));
  }

  Future<void> _createFile(
    NoteData? template, {
    bool isTextBased = false,
  }) async {
    template ??= await DocumentDefaults.createTemplate();
    if (!mounted) return;
    final name = await showDialog<String>(
      context: context,
      builder: (context) =>
          NameDialog(validator: defaultFileNameValidator(context)),
    );
    if (name == null) return;
    final path = _locationController.text;
    final remote = _remote;
    final file = await _documentSystem.createFileWithName(
      directory: path,
      name: name,
      suffix: isTextBased ? '.tbfly' : '.bfly',
      template.createDocument(name: name).toFile(isTextBased: isTextBased),
    );
    final pathKey = documentStatePathKeyOrNull(file.location);
    if (pathKey != null) {
      try {
        await DocumentStateService(
          _fileSystem.buildDocumentStateSystem(remote),
          settingsProvider: () => _settingsCubit.state.documentStatePersistence,
        ).save(
          const PersistedDocumentState(autoThumbnail: true)
              .touch(pathKey: pathKey),
          pathKey: pathKey,
          persistentChanged: true,
        );
      } catch (error) {
        debugPrint('Could not save automatic thumbnail setting: $error');
      }
    }
    _updateAsset(file.location, file);
  }

  void _setRemote(ExternalStorage? remote) {
    final storageChanged = _remote?.identifier != remote?.identifier;
    if (!storageChanged) {
      _remote = remote;
      reloadFileSystem();
      widget.onRemoteChanged?.call(remote);
      return;
    }
    setState(() {
      _remote = remote;
      _locationController.clear();
      _selectedFiles.clear();
      _setFilesStream();
    });
    widget.onRemoteChanged?.call(remote);
  }

  void Function(bool) _updateSelection(String path) => (bool value) {
    setState(() {
      if (value) {
        _selectedFiles.add(path);
      } else {
        _selectedFiles.remove(path);
      }
    });
  };

  @override
  Widget build(BuildContext context) {
    final index = _locationController.text.lastIndexOf('/');
    final parent = _locationController.text.substring(0, index < 0 ? 0 : index);

    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, ButterflySettings>(
          listenWhen: (previous, current) =>
              previous.showThumbnails != current.showThumbnails,
          listener: (_, _) => reloadFileSystem(),
        ),
        // Only the tree shows entries of other folders: the other layouts
        // keep the selected entries of the current folder.
        BlocListener<SettingsCubit, ButterflySettings>(
          listenWhen: (previous, current) =>
              previous.filesLayout != current.filesLayout,
          listener: (_, _) {
            final directory = _filesStream?.valueOrNull;
            if (_layout == .tree || _selectedFiles.isEmpty) return;
            setState(
              () => _selectedFiles.retainAll([
                if (directory is FileSystemDirectory<NoteFile>)
                  ...directory.assets.map((asset) => asset.path),
              ]),
            );
          },
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > LeapBreakpoints.medium;
          final isTablet = constraints.maxWidth > LeapBreakpoints.compact;
          return BlocBuilder<SettingsCubit, ButterflySettings>(
            buildWhen: (previous, current) =>
                previous.filesLayout != current.filesLayout,
            builder: (context, state) {
              final layout = _layout;
              final text = Text(
                AppLocalizations.of(context).files,
                style: TextTheme.of(context).headlineMedium,
                textAlign: .start,
              );
              final orderButton = IconButton(
                icon: PhosphorIcon(
                  _sortOrder == .ascending
                      ? PhosphorIconsLight.sortAscending
                      : PhosphorIconsLight.sortDescending,
                ),
                tooltip: _sortOrder == .ascending
                    ? AppLocalizations.of(context).ascending
                    : AppLocalizations.of(context).descending,
                onPressed: () => setState(() {
                  _sortOrder = _sortOrder == .ascending
                      ? SortOrder.descending
                      : SortOrder.ascending;
                  _settingsCubit.changeSortOrder(_sortOrder);
                }),
              );
              final desktopActions = OverflowBar(
                spacing: 8,
                overflowSpacing: 8,
                children: [
                  Row(
                    mainAxisSize: .min,
                    children: [
                      Text(AppLocalizations.of(context).switchView),
                      const SizedBox(width: 8),
                      SegmentedButton<FilesLayout>(
                        showSelectedIcon: false,
                        segments: _availableLayouts
                            .map(
                              (e) => ButtonSegment(
                                value: e,
                                icon: PhosphorIcon(getIconOfFilesLayout(e)),
                                tooltip: getLocalizedNameOfFilesLayout(e),
                              ),
                            )
                            .toList(),
                        selected: {layout},
                        onSelectionChanged: (value) =>
                            _settingsCubit.changeFilesLayout(value.first),
                      ),
                    ],
                  ),
                  BlocBuilder<SettingsCubit, ButterflySettings>(
                    buildWhen: (previous, current) =>
                        previous.connections != current.connections,
                    builder: (context, state) => Row(
                      mainAxisSize: .min,
                      crossAxisAlignment: .center,
                      children: [
                        DropdownMenu<String?>(
                          label: Text(AppLocalizations.of(context).source),
                          width: 225,
                          dropdownMenuEntries: [
                            DropdownMenuEntry(
                              value: null,
                              label: AppLocalizations.of(context).local,
                            ),
                            ...state.connections.map(
                              (e) => DropdownMenuEntry(
                                value: e.identifier,
                                label: e.label,
                              ),
                            ),
                          ],
                          initialSelection: _remote?.identifier,
                          onSelected: (value) => _setRemote(
                            value == null ? null : state.getRemote(value),
                          ),
                        ),
                        const SizedBox(width: 2),
                        state.connections.any((e) => e is RemoteStorage)
                            ? SyncButton(selectedRemote: _remote?.identifier)
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  DropdownMenu<SortBy>(
                    leadingIcon: orderButton,
                    label: Text(AppLocalizations.of(context).sortBy),
                    width: 225,
                    dropdownMenuEntries: SortBy.values
                        .map(
                          (e) => DropdownMenuEntry(
                            value: e,
                            label: getLocalizedNameOfSortBy(e),
                            leadingIcon: PhosphorIcon(getIconOfSortBy(e)),
                          ),
                        )
                        .toList(),
                    initialSelection: _sortBy,
                    onSelected: (value) => setState(() {
                      _sortBy = value ?? _sortBy;
                      _settingsCubit.changeSortBy(_sortBy);
                    }),
                  ),
                ],
              );
              final primary = ColorScheme.of(context).primary;
              final actionsChildren = [
                MenuAnchor(
                  builder: defaultMenuButton(
                    tooltip: AppLocalizations.of(context).switchView,
                    icon: PhosphorIcon(getIconOfFilesLayout(layout)),
                  ),
                  menuChildren: _availableLayouts
                      .map(
                        (e) => MenuItemButton(
                          leadingIcon: PhosphorIcon(
                            getIconOfFilesLayout(e),
                            color: e == layout ? primary : null,
                          ),
                          child: Text(
                            getLocalizedNameOfFilesLayout(e),
                            style: e == layout
                                ? TextStyle(color: primary)
                                : null,
                          ),
                          onPressed: () => _settingsCubit.changeFilesLayout(e),
                        ),
                      )
                      .toList(),
                ),
                ConnectionButton(
                  currentRemote: _remote?.identifier ?? '',
                  onChanged: _setRemote,
                ),
                MenuAnchor(
                  builder: defaultMenuButton(
                    tooltip: AppLocalizations.of(context).sortBy,
                    icon: PhosphorIcon(getIconOfSortBy(_sortBy)),
                  ),
                  menuChildren: SortBy.values
                      .map(
                        (e) => MenuItemButton(
                          leadingIcon: PhosphorIcon(
                            getIconOfSortBy(e),
                            color: e == _sortBy ? primary : null,
                          ),
                          child: Text(
                            getLocalizedNameOfSortBy(e),
                            style: e == _sortBy
                                ? TextStyle(color: primary)
                                : null,
                          ),
                          onPressed: () => setState(() {
                            _sortBy = e;
                            _settingsCubit.changeSortBy(_sortBy);
                          }),
                        ),
                      )
                      .toList(),
                ),
                orderButton,
                if (state.connections.any((e) => e is RemoteStorage))
                  SyncButton(selectedRemote: _remote?.identifier),
              ];
              final mobileActions = OverflowBar(
                spacing: 4,
                overflowSpacing: 4,
                children: actionsChildren,
              );
              final searchBar = Row(
                children: [
                  Expanded(
                    child: SearchBar(
                      onChanged: (value) => setState(() => _search = value),
                      hintText: AppLocalizations.of(context).search,
                      leading: const PhosphorIcon(
                        PhosphorIconsLight.magnifyingGlass,
                      ),
                    ),
                  ),
                ],
              );
              final locationBar = _buildLocationBar(parent);
              final content = Column(
                crossAxisAlignment: .stretch,
                children: [
                  if (!widget.isPage) ...[
                    widget.collapsed
                        ? Center(child: mobileActions)
                        : OverflowBar(
                            alignment: .spaceBetween,
                            children: [
                              text,
                              isDesktop ? desktopActions : mobileActions,
                            ],
                          ),
                    if (!widget.collapsed) ...[
                      const SizedBox(height: 8),
                      RecentFilesView(
                        key: _recentFilesKey,
                        replace: widget.collapsed,
                        onFileTap: widget.onPreview == null
                            ? _onFileTap
                            : (e) {
                                if (e is FileSystemFile<NoteFile>) {
                                  widget.onPreview!(e);
                                  return;
                                }
                                _onFileTap(e);
                              },
                      ),
                    ],
                  ],
                  const SizedBox(height: 16),
                  isTablet
                      ? Row(
                          crossAxisAlignment: .center,
                          spacing: 8,
                          children: [
                            Expanded(child: locationBar),
                            if (isDesktop)
                              IconButton(
                                onPressed: reloadFileSystem,
                                tooltip: AppLocalizations.of(context).refresh,
                                icon: const PhosphorIcon(
                                  PhosphorIconsLight.arrowClockwise,
                                ),
                              ),
                            SizedBox(width: 250, child: searchBar),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: .stretch,
                          children: [
                            searchBar,
                            const SizedBox(height: 16),
                            locationBar,
                          ],
                        ),
                  const SizedBox(height: 8),
                  BlocBuilder<SettingsCubit, ButterflySettings>(
                    buildWhen: (previous, current) =>
                        previous.starred != current.starred,
                    builder: (context, settings) =>
                        StreamBuilder<FileSystemEntity<NoteFile>?>(
                          stream: _filesStream?.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting &&
                                !(_filesStream?.hasValue ?? false)) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (!snapshot.hasData) {
                              return Center(
                                child: Text(
                                  AppLocalizations.of(context).noElements,
                                ),
                              );
                            }
                            final entity = snapshot.data;
                            if (entity is! FileSystemDirectory<NoteFile>) {
                              return Container();
                            }
                            final metadata = <NoteFile, FileMetadata?>{};
                            Widget buildItem(FileSystemEntity<NoteFile> asset) {
                              // In the tree, folders expand instead of opening.
                              final onTap =
                                  layout == .tree &&
                                      asset is FileSystemDirectory<NoteFile>
                                  ? () => _toggleTreeDirectory(asset)
                                  : () => _onFileTap(asset);
                              return FileEntityItem(
                                key: ValueKey(asset.location),
                                entity: asset,
                                active: widget.activeAsset == asset.location,
                                collapsed: widget.collapsed,
                                gridView: layout == .grid,
                                isMobile: widget.isMobile,
                                selected: _selectedFiles.isEmpty
                                    ? null
                                    : _selectedFiles.contains(asset.path),
                                onTap: onTap,
                                onPreview: widget.onPreview == null
                                    ? null
                                    : () {
                                        if (asset is FileSystemFile<NoteFile>) {
                                          widget.onPreview!(asset);
                                        } else {
                                          onTap();
                                        }
                                      },
                                onSelected: _updateSelection(asset.path),
                                onChanged: (updated) =>
                                    _updateAsset(asset.location, updated),
                                onReload: reloadFileSystem,
                                onMoveInto: (source) =>
                                    _moveAssetInto(source, asset.path),
                                // The tree opens a folder from its menu.
                                onOpen:
                                    layout == .tree &&
                                        asset is FileSystemDirectory<NoteFile>
                                    ? () => _onFileTap(asset)
                                    : null,
                                // Dragging over a closed folder opens it.
                                onDragHold:
                                    layout == .tree &&
                                        asset is FileSystemDirectory<NoteFile>
                                    ? () {
                                        if (mounted &&
                                            !_tree.isExpanded(asset)) {
                                          _toggleTreeDirectory(asset);
                                        }
                                      }
                                    : null,
                              );
                            }

                            if (layout == .tree) {
                              final rows = _getTreeRows(
                                entity.assets,
                                metadata,
                              );
                              if (rows.isEmpty) {
                                return Center(
                                  child: Text(
                                    AppLocalizations.of(context).noElements,
                                  ),
                                );
                              }
                              return FileTreeView(
                                controller: _tree,
                                rows: rows,
                                collapsed: widget.collapsed,
                                buildItem: buildItem,
                                onToggle: _toggleTreeDirectory,
                                onMoveInto: _moveAssetInto,
                              );
                            }

                            final assets = entity.assets.where((e) {
                              if (_search.isNotEmpty) {
                                return e.fileName.toLowerCase().contains(
                                  _search.toLowerCase(),
                                );
                              }
                              return true;
                            }).toList();
                            assets.sort((a, b) => _sortAssets(a, b, metadata));
                            if (assets.isEmpty) {
                              return Center(
                                child: Text(
                                  AppLocalizations.of(context).noElements,
                                ),
                              );
                            }
                            if (layout == .grid) {
                              return Center(
                                child: Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  crossAxisAlignment: .start,
                                  children: assets.map(buildItem).toList(),
                                ),
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: assets.length,
                              findChildIndexCallback: (key) {
                                final index = assets.indexWhere(
                                  (asset) => ValueKey(asset.location) == key,
                                );
                                return index < 0 ? null : index;
                              },
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) =>
                                  buildItem(assets[index]),
                            );
                          },
                        ),
                  ),
                  const SizedBox(height: 32),
                ],
              );
              if (widget.isPage) {
                return Scaffold(
                  appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
                    title: Text(AppLocalizations.of(context).files),
                    actions: actionsChildren,
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: .symmetric(horizontal: 8),
                      child: content,
                    ),
                  ),
                );
              }
              return content;
            },
          );
        },
      ),
    );
  }

  SizedBox _buildLocationBar(String parent) {
    return SizedBox(
      height: 64,
      child: _selectedFiles.isEmpty
          ? BlocBuilder<SettingsCubit, ButterflySettings>(
              buildWhen: (previous, current) => previous.flags != current.flags,
              builder: (context, settings) => Row(
                mainAxisSize: .min,
                children: [
                  MenuAnchor(
                    menuChildren: [
                      MenuItemButton(
                        leadingIcon: const PhosphorIcon(
                          PhosphorIconsLight.folder,
                        ),
                        child: Text(AppLocalizations.of(context).newFolder),
                        onPressed: () async {
                          final name = await showDialog<String>(
                            context: context,
                            builder: (context) => NameDialog(
                              validator: defaultFileNameValidator(context),
                            ),
                          );
                          if (name == null) return;
                          final path = _locationController.text;
                          final newPath = '$path/$name';
                          final directory = await _documentSystem
                              .createDirectory(newPath);
                          _updateAsset(directory.location, directory);
                        },
                      ),
                      MenuItemButton(
                        onPressed: () async => _createFile(
                          await _templateSystem.getDefaultFile(
                            _templateSystem.storage?.defaults['template'] ??
                                _settingsCubit.state.defaultTemplate,
                          ),
                        ),
                        leadingIcon: const PhosphorIcon(
                          PhosphorIconsLight.filePlus,
                          textDirection: .ltr,
                        ),
                        child: Text(AppLocalizations.of(context).newNote),
                      ),
                      FutureBuilder<List<FileSystemFile<NoteData>>>(
                        future: _templatesFuture,
                        builder: (context, snapshot) => SubmenuButton(
                          leadingIcon: const PhosphorIcon(
                            PhosphorIconsLight.file,
                            textDirection: .ltr,
                          ),
                          menuChildren:
                              snapshot.data?.map((e) {
                                final data = e.data!;
                                final metadata = data.getMetadata();
                                final thumbnail =
                                    context
                                        .read<SettingsCubit>()
                                        .state
                                        .showThumbnails
                                    ? data.getThumbnail()
                                    : null;
                                return MenuItemButton(
                                  leadingIcon: thumbnail == null
                                      ? null
                                      : Image.memory(
                                          thumbnail,
                                          width: 32,
                                          height: 18,
                                          gaplessPlayback: true,
                                          cacheWidth: 32,
                                          cacheHeight: 18,
                                        ),
                                  child: Text(metadata?.name ?? ''),
                                  onPressed: () => _createFile(data),
                                );
                              }).toList() ??
                              [],
                          child: Text(AppLocalizations.of(context).templates),
                        ),
                      ),
                      FutureBuilder<List<FileSystemFile<NoteData>>>(
                        future: _templatesFuture,
                        builder: (context, snapshot) => SubmenuButton(
                          leadingIcon: const PhosphorIcon(
                            PhosphorIconsLight.fileTxt,
                            textDirection: .ltr,
                          ),
                          menuChildren:
                              snapshot.data?.map((e) {
                                final data = e.data!;
                                final metadata = data.getMetadata();
                                final thumbnail =
                                    context
                                        .read<SettingsCubit>()
                                        .state
                                        .showThumbnails
                                    ? data.getThumbnail()
                                    : null;
                                return MenuItemButton(
                                  leadingIcon: thumbnail == null
                                      ? null
                                      : Image.memory(
                                          thumbnail,
                                          width: 32,
                                          height: 18,
                                          gaplessPlayback: true,
                                          cacheWidth: 32,
                                          cacheHeight: 18,
                                        ),
                                  child: Text(metadata?.name ?? ''),
                                  onPressed: () =>
                                      _createFile(data, isTextBased: true),
                                );
                              }).toList() ??
                              [],
                          child: Text(
                            AppLocalizations.of(context).createRawNote,
                          ),
                        ),
                      ),
                      MenuItemButton(
                        leadingIcon: const PhosphorIcon(
                          PhosphorIconsLight.arrowSquareIn,
                        ),
                        onPressed: () async {
                          final files = await importFiles(context);
                          if (files.isEmpty) return;

                          final defaultTemplate =
                              _settingsCubit.state.defaultTemplate;
                          final templateFile = await _templateSystem
                              .getDefaultFile(defaultTemplate);

                          for (final file in files) {
                            var result = file.$1;
                            var fileExtension = file.$2;
                            final nameWithoutExtension = file.$3;

                            if (fileExtension == 'bin') {
                              // see https://github.com/LinwoodDev/Butterfly/issues/839
                              fileExtension = '';
                            }

                            final importService = ImportService(
                              context,
                              storage: _remote,
                              path: _locationController.text,
                              useDefaultStorage: false,
                            );
                            final importResult = await importService.load(
                              data: result,
                              type: fileExtension,
                              document:
                                  templateFile?.createDocument(
                                    name: nameWithoutExtension,
                                  ) ??
                                  DocumentDefaults.createDocument(
                                    name: nameWithoutExtension,
                                  ),
                              preserveEncrypted: true,
                            );
                            if (importResult == null) {
                              continue;
                            }
                            final noteFile = await importResult.exportFile();
                            setNativeData(result, fileExtension);

                            var docName = noteFile.display()?.name;
                            if (docName == null || docName.trim().isEmpty) {
                              docName = nameWithoutExtension;
                            }
                            if (docName.trim().isEmpty) {
                              docName = null;
                            } else {
                              docName = sanitizeExportFileName(docName);
                            }

                            final newFile = await _documentSystem
                                .createFileWithName(
                                  directory: _locationController.text,
                                  name: docName,
                                  suffix: '.bfly',
                                  noteFile,
                                );

                            if (files.length == 1 && context.mounted) {
                              _onFileTap(newFile);
                            }
                          }
                        },
                        child: Text(AppLocalizations.of(context).import),
                      ),
                      if (settings.hasFlag('collaboration'))
                        MenuItemButton(
                          leadingIcon: const PhosphorIcon(
                            PhosphorIconsLight.shareNetwork,
                          ),
                          child: Text(AppLocalizations.of(context).connect),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => ConnectCollaborationDialog(),
                          ),
                        ),
                    ],
                    builder: (context, controller, child) =>
                        FloatingActionButton.small(
                          heroTag: null,
                          onPressed: controller.toggle,
                          tooltip: LeapLocalizations.of(context).create,
                          child: const PhosphorIcon(PhosphorIconsLight.plus),
                        ),
                  ),
                  DragTarget<String>(
                    builder: (context, candidateData, rejectedData) =>
                        highlightDropTarget(
                          context,
                          candidateData.isNotEmpty,
                          IconButton(
                            onPressed: _locationController.text.isEmpty
                                ? null
                                : () => setState(() {
                                    _locationController.text = parent;
                                    _setFilesStream();
                                  }),
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.arrowUp,
                            ),
                            tooltip: AppLocalizations.of(context).goUp,
                          ),
                        ),
                    onWillAcceptWithDetails: (data) =>
                        _locationController.text.isNotEmpty &&
                        canMoveAssetInto(data.data, parent),
                    onAcceptWithDetails: (data) =>
                        _moveAssetInto(data.data, parent),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    // Dropping on the location moves into the folder shown,
                    // the top level of the tree.
                    child: DragTarget<String>(
                      builder: (context, candidateData, rejectedData) =>
                          highlightDropTarget(
                            context,
                            candidateData.isNotEmpty,
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context).location,
                                prefixIcon: const PhosphorIcon(
                                  PhosphorIconsLight.folder,
                                ),
                                filled: true,
                                contentPadding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom: 6,
                                ),
                              ),
                              textAlignVertical: TextAlignVertical.center,
                              controller: _locationController,
                              onFieldSubmitted: (value) => reloadFileSystem(),
                            ),
                          ),
                      onWillAcceptWithDetails: (details) {
                        final directory = _filesStream?.valueOrNull;
                        return directory is FileSystemDirectory<NoteFile> &&
                            canMoveAssetInto(details.data, directory.path);
                      },
                      onAcceptWithDetails: (details) {
                        final directory = _filesStream?.valueOrNull;
                        if (directory is! FileSystemDirectory<NoteFile>) {
                          return;
                        }
                        _moveAssetInto(details.data, directory.path);
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.selectionSlash,
                            ),
                            tooltip: AppLocalizations.of(context).deselect,
                            onPressed: () =>
                                setState(() => _selectedFiles.clear()),
                          ),
                          IconButton(
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.selectionInverse,
                            ),
                            tooltip: AppLocalizations.of(context)
                                .invertSelection,
                            onPressed: () {
                              final directory = _filesStream?.valueOrNull;
                              if (directory is! FileSystemDirectory<NoteFile>) {
                                return;
                              }
                              final assets = _layout == .tree
                                  ? _getTreeRows(
                                      directory.assets,
                                      {},
                                    ).map((row) => row.entity).nonNulls
                                  : directory.assets;
                              setState(() {
                                final all = _selectedFiles.toSet();
                                _selectedFiles.clear();
                                _selectedFiles.addAll(
                                  assets
                                      .map((e) => e.path)
                                      .toSet()
                                      .difference(all),
                                );
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.paperPlaneRight,
                            ),
                            tooltip: AppLocalizations.of(context).export,
                            onPressed: _exportSelectedFiles,
                          ),
                          IconButton(
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.arrowsDownUp,
                            ),
                            tooltip: AppLocalizations.of(context).move,
                            onPressed: () =>
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      FileSystemAssetMoveDialog(
                                        assets: _selectedFiles
                                            .map(
                                              (e) => AssetLocation(
                                                path: e,
                                                remote:
                                                    _remote?.identifier ?? '',
                                              ),
                                            )
                                            .toList(),
                                        fileSystem: _documentSystem,
                                      ),
                                ).then((value) {
                                  if (value == null) return;
                                  reloadFileSystem();
                                }),
                          ),
                          Builder(
                            builder: (context) => IconButton(
                              icon: const PhosphorIcon(
                                PhosphorIconsLight.trash,
                              ),
                              tooltip: AppLocalizations.of(context).delete,
                              onPressed: () => _deleteSelectedFiles(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _deleteSelectedFiles(BuildContext context) {
    final documentSystem = _documentSystem;
    deleteEntities(
      context: context,
      entities: _selectedFiles,
      documentSystem: documentSystem,
      isMobile: widget.isMobile,
      onDelete: (paths) {
        for (final path in paths) {
          _updateAsset(
            AssetLocation(
              path: path,
              remote: documentSystem.storage?.identifier ?? '',
            ),
            null,
          );
        }
      },
    );
  }

  Future<void> _exportSelectedFiles() async {
    try {
      final bytes = await createSelectionArchive();
      if (bytes == null || !mounted) return;
      await exportZip(context, bytes);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).error)),
      );
    }
  }

  /// Zips the selected entries with their paths relative to the current
  /// folder, so that nested entries of the tree with equal names are kept.
  @visibleForTesting
  Future<Uint8List?> createSelectionArchive() async {
    final selected = _selectedFiles.toList()..sort();
    if (selected.isEmpty) return null;
    final root = _documentSystem.normalizePath(_locationController.text);
    final output = OutputMemoryStream();
    final encoder = ZipEncoder()..startEncode(output);
    final archivePaths = <String>{};
    for (final path in selected) {
      final entity = await _documentSystem.getAsset(path, listLevel: 0);
      if (entity == null) continue;
      final normalized = _documentSystem.normalizePath(entity.path);
      await _addEntityToArchive(
        encoder,
        archivePaths,
        entity,
        universalPathContext.isWithin(root, normalized)
            ? universalPathContext.relative(normalized, from: root)
            : entity.fileName,
      );
    }
    if (archivePaths.isEmpty) return null;
    encoder.endEncode();
    return output.getBytes();
  }

  Future<void> _addEntityToArchive(
    ZipEncoder encoder,
    Set<String> archivePaths,
    FileSystemEntity<NoteFile> entity,
    String archivePath,
  ) async {
    final normalizedPath = archivePath.replaceAll('\\', '/');
    if (normalizedPath.isEmpty) return;
    if (entity is FileSystemFile<NoteFile>) {
      final file = entity.hasData
          ? entity
          : await _documentSystem.getAsset(entity.path, listLevel: 0);
      if (file is! FileSystemFile<NoteFile>) return;
      final data = file.data?.data;
      if (data == null || !archivePaths.add(normalizedPath)) return;
      encoder.add(ArchiveFile.bytes(normalizedPath, data));
      return;
    }

    if (entity is FileSystemDirectory<NoteFile>) {
      final directory = await _documentSystem.getAsset(
        entity.path,
        listLevel: noListLevel,
        readData: false,
      );
      if (directory is! FileSystemDirectory<NoteFile>) return;
      final directoryPath = normalizedPath.endsWith('/')
          ? normalizedPath
          : '$normalizedPath/';
      if (archivePaths.add(directoryPath)) {
        encoder.add(ArchiveFile.directory(directoryPath));
      }
      for (final child in directory.assets) {
        await _addEntityToArchive(
          encoder,
          archivePaths,
          child,
          '$directoryPath${child.fileName}',
        );
      }
    }
  }

  Future<void> _onFileTap(FileSystemEntity<NoteFile> entity) async {
    if (entity is! FileSystemFile<NoteFile>) {
      setState(() {
        _locationController.text = entity.pathWithoutLeadingSlash;
        _setFilesStream();
      });
      return;
    }
    final location = entity.location;
    if (widget.onTap != null) {
      widget.onTap!(entity);
      return;
    }
    await openFile(context, widget.collapsed, location);
    if (!widget.collapsed) {
      reloadFileSystem();
    }
  }

  int _sortAssets(
    FileSystemEntity<NoteFile> a,
    FileSystemEntity<NoteFile> b,
    Map<NoteFile, FileMetadata?> metadataCache,
  ) {
    try {
      final settings = _settingsCubit.state;
      // Test if starred
      final aStarred = settings.isStarred(a.location);
      final bStarred = settings.isStarred(b.location);
      if (aStarred && !bStarred) {
        return -1;
      }
      if (bStarred && !aStarred) {
        return 1;
      }
      final aDirectory = a is FileSystemDirectory<NoteFile>;
      final bDirectory = b is FileSystemDirectory<NoteFile>;
      // Folders have no dates: they are sorted by name like files are.
      if (aDirectory && bDirectory) {
        final compared = a.fileName.compareTo(b.fileName);
        return _sortOrder == .ascending ? compared : -compared;
      }
      if (aDirectory) {
        return -1;
      }
      if (bDirectory) {
        return 1;
      }
      final aFile = a as FileSystemFile<NoteFile>;
      final bFile = b as FileSystemFile<NoteFile>;
      FileMetadata? metadata(FileSystemFile<NoteFile> file) {
        final data = file.data;
        if (data == null) return null;
        return metadataCache.putIfAbsent(
          data,
          () => displayConnectionNoteFile(_remote, data)?.getMetadata(),
        );
      }

      switch (_sortBy) {
        case .name:
          final compared = aFile.fileName.compareTo(bFile.fileName);
          return _sortOrder == .ascending ? compared : -compared;
        case .created:
          final aCreatedAt = metadata(aFile)?.createdAt ?? aFile.creationTime;
          final bCreatedAt = metadata(bFile)?.createdAt ?? bFile.creationTime;
          if (aCreatedAt == null && bCreatedAt == null) {
            return aFile.fileName.compareTo(bFile.fileName);
          }
          if (aCreatedAt == null) {
            return 1;
          }
          if (bCreatedAt == null) {
            return -1;
          }
          final compared = bCreatedAt.compareTo(aCreatedAt);
          return _sortOrder == .ascending ? compared : -compared;
        case .modified:
          final aModifiedAt = metadata(aFile)?.updatedAt ?? aFile.lastModified;
          final bModifiedAt = metadata(bFile)?.updatedAt ?? bFile.lastModified;
          if (aModifiedAt == null && bModifiedAt == null) {
            return aFile.fileName.compareTo(bFile.fileName);
          }
          if (aModifiedAt == null) {
            return 1;
          }
          if (bModifiedAt == null) {
            return -1;
          }
          final compared = bModifiedAt.compareTo(aModifiedAt);
          return _sortOrder == .ascending ? compared : -compared;
      }
    } catch (e) {
      return 0;
    }
  }
}
