import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/intent.dart';
import 'package:butterfly/dialogs/collaboration/connect.dart';
import 'package:butterfly/dialogs/file_system/move.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/views/files/entity.dart';
import 'package:butterfly/views/files/recently.dart';
import 'package:butterfly/widgets/connection_button.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
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
    this.collapsed = false,
    this.isMobile = false,
    this.isPage = false,
  });

  @override
  State<FilesView> createState() => FilesViewState();
}

class FilesViewState extends State<FilesView> {
  final TextEditingController _locationController = TextEditingController();
  late final ButterflyFileSystem _fileSystem;
  late Future<List<FileSystemFile<NoteData>>> _templatesFuture;
  late DocumentFileSystem _documentSystem;
  late TemplateFileSystem _templateSystem;
  final GlobalKey<RecentFilesViewState> _recentFilesKey = GlobalKey();

  SortBy _sortBy = SortBy.name;
  SortOrder _sortOrder = SortOrder.ascending;
  ExternalStorage? _remote;
  String _search = '';
  late final SettingsCubit _settingsCubit;
  Stream<FileSystemEntity<NoteFile>?>? _filesStream;
  final Set<String> _selectedFiles = {};

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
    _setFilesStream();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FilesView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remote != widget.remote) {
      _remote = widget.remote;
      _setFilesStream();
    }
  }

  String getLocalizedNameOfSortBy(SortBy sortBy) => switch (sortBy) {
    SortBy.name => LeapLocalizations.of(context).name,
    SortBy.created => AppLocalizations.of(context).created,
    SortBy.modified => AppLocalizations.of(context).modified,
  };

  IconGetter getIconOfSortBy(SortBy sortBy) => switch (sortBy) {
    SortBy.name => PhosphorIcons.file,
    SortBy.created => PhosphorIcons.calendar,
    SortBy.modified => PhosphorIcons.clock,
  };

  void _setFilesStream() {
    _templateSystem = _fileSystem.buildTemplateSystem(_remote);
    _documentSystem = _fileSystem.buildDocumentSystem(_remote);
    _filesStream = ValueConnectableStream(
      _documentSystem.fetchAsset(_locationController.text),
    ).autoConnect();
    _templatesFuture = _templateSystem.initialize().then(
      (_) => _templateSystem.getFiles(),
    );
  }

  void reloadFileSystem() {
    _recentFilesKey.currentState?.reload();
    if (mounted) {
      setState(_setFilesStream);
    }
  }

  Future<void> _createFile(
    NoteData? template, {
    bool isTextBased = false,
  }) async {
    template ??= await DocumentDefaults.createTemplate();
    final name = await showDialog<String>(
      context: context,
      builder: (context) =>
          NameDialog(validator: defaultFileNameValidator(context)),
    );
    if (name == null) return;
    final path = _locationController.text;
    await _documentSystem.createFileWithName(
      directory: path,
      name: name,
      suffix: isTextBased ? '.tbfly' : '.bfly',
      template.createDocument(name: name).toFile(isTextBased: isTextBased),
    );
    reloadFileSystem();
  }

  void _setRemote(ExternalStorage? remote) {
    setState(() => _remote = remote);
    _setFilesStream();
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

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > LeapBreakpoints.medium;
        final isTablet = constraints.maxWidth > LeapBreakpoints.compact;
        return BlocBuilder<SettingsCubit, ButterflySettings>(
          buildWhen: (previous, current) =>
              previous.gridView != current.gridView,
          builder: (context, state) {
            final text = Text(
              AppLocalizations.of(context).files,
              style: TextTheme.of(context).headlineMedium,
              textAlign: TextAlign.start,
            );
            final orderButton = IconButton(
              icon: PhosphorIcon(
                _sortOrder == SortOrder.ascending
                    ? PhosphorIconsLight.sortAscending
                    : PhosphorIconsLight.sortDescending,
              ),
              tooltip: _sortOrder == SortOrder.ascending
                  ? AppLocalizations.of(context).ascending
                  : AppLocalizations.of(context).descending,
              onPressed: () => setState(() {
                _sortOrder = _sortOrder == SortOrder.ascending
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context).switchView),
                    const SizedBox(width: 8),
                    IconButton.filledTonal(
                      onPressed: () =>
                          context.read<SettingsCubit>().toggleGridView(),
                      icon: state.gridView
                          ? const PhosphorIcon(PhosphorIconsLight.list)
                          : const PhosphorIcon(PhosphorIconsLight.gridFour),
                    ),
                  ],
                ),
                BlocBuilder<SettingsCubit, ButterflySettings>(
                  buildWhen: (previous, current) =>
                      previous.connections != current.connections,
                  builder: (context, state) => Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          ? const SyncButton()
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
                          leadingIcon: PhosphorIcon(
                            getIconOfSortBy(e)(PhosphorIconsStyle.light),
                          ),
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
              if (!widget.collapsed)
                IconButton(
                  onPressed: () =>
                      context.read<SettingsCubit>().toggleGridView(),
                  tooltip: AppLocalizations.of(context).switchView,
                  icon: state.gridView
                      ? const PhosphorIcon(PhosphorIconsLight.list)
                      : const PhosphorIcon(PhosphorIconsLight.gridFour),
                ),
              ConnectionButton(
                currentRemote: _remote?.identifier ?? '',
                onChanged: _setRemote,
              ),
              MenuAnchor(
                builder: defaultMenuButton(
                  tooltip: AppLocalizations.of(context).sortBy,
                  icon: PhosphorIcon(
                    getIconOfSortBy(_sortBy)(PhosphorIconsStyle.light),
                  ),
                ),
                menuChildren: SortBy.values
                    .map(
                      (e) => MenuItemButton(
                        leadingIcon: PhosphorIcon(
                          getIconOfSortBy(e)(PhosphorIconsStyle.light),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!widget.isPage) ...[
                  widget.collapsed
                      ? Center(child: mobileActions)
                      : OverflowBar(
                          alignment: MainAxisAlignment.spaceBetween,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        stream: _filesStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                          final assets = entity.assets.where((e) {
                            if (_search.isNotEmpty) {
                              return e.fileName.toLowerCase().contains(
                                _search.toLowerCase(),
                              );
                            }
                            return true;
                          }).toList()..sort(_sortAssets);
                          if (assets.isEmpty) {
                            return Center(
                              child: Text(
                                AppLocalizations.of(context).noElements,
                              ),
                            );
                          }

                          generateOnPreview(FileSystemEntity<NoteFile> e) =>
                              widget.onPreview != null
                              ? () {
                                  if (e is! FileSystemFile<NoteFile>) {
                                    _onFileTap(e);
                                    return;
                                  }
                                  widget.onPreview!(e);
                                }
                              : null;
                          if (state.gridView && !widget.collapsed) {
                            return Center(
                              child: Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: assets.map((e) {
                                  final active =
                                      widget.activeAsset == e.location;
                                  return FileEntityItem(
                                    entity: e,
                                    isMobile: widget.isMobile,
                                    active: active,
                                    collapsed: widget.collapsed,
                                    onTap: () => _onFileTap(e),
                                    onPreview: generateOnPreview(e),
                                    selected: _selectedFiles.isEmpty
                                        ? null
                                        : _selectedFiles.contains(
                                            e.location.path,
                                          ),
                                    onSelected: _updateSelection(
                                      e.location.path,
                                    ),
                                    onReload: reloadFileSystem,
                                    gridView: true,
                                  );
                                }).toList(),
                              ),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: assets.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final e = assets[index];
                              final active = widget.activeAsset == e.location;
                              return FileEntityItem(
                                entity: e,
                                active: active,
                                collapsed: widget.collapsed,
                                onPreview: generateOnPreview(e),
                                selected: _selectedFiles.isEmpty
                                    ? null
                                    : _selectedFiles.contains(e.location.path),
                                onTap: () => _onFileTap(e),
                                onSelected: _updateSelection(e.location.path),
                                onReload: reloadFileSystem,
                                gridView: false,
                                isMobile: widget.isMobile,
                              );
                            },
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
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: content,
                  ),
                ),
              );
            }
            return content;
          },
        );
      },
    );
  }

  SizedBox _buildLocationBar(String parent) {
    return SizedBox(
      height: 64,
      child: _selectedFiles.isEmpty
          ? BlocBuilder<SettingsCubit, ButterflySettings>(
              buildWhen: (previous, current) => previous.flags != current.flags,
              builder: (context, settings) => Row(
                mainAxisSize: MainAxisSize.min,
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
                          await _documentSystem.createDirectory(newPath);
                          reloadFileSystem();
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
                        ),
                        child: Text(AppLocalizations.of(context).newNote),
                      ),
                      FutureBuilder<List<FileSystemFile<NoteData>>>(
                        future: _templatesFuture,
                        builder: (context, snapshot) => SubmenuButton(
                          leadingIcon: const PhosphorIcon(
                            PhosphorIconsLight.file,
                          ),
                          menuChildren:
                              snapshot.data?.map((e) {
                                final data = e.data!;
                                final metadata = data.getMetadata();
                                final thumbnail = data.getThumbnail();
                                return MenuItemButton(
                                  leadingIcon: thumbnail == null
                                      ? null
                                      : Image.memory(
                                          thumbnail,
                                          width: 32,
                                          height: 18,
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
                          ),
                          menuChildren:
                              snapshot.data?.map((e) {
                                final data = e.data!;
                                final metadata = data.getMetadata();
                                final thumbnail = data.getThumbnail();
                                return MenuItemButton(
                                  leadingIcon: thumbnail == null
                                      ? null
                                      : Image.memory(
                                          thumbnail,
                                          width: 32,
                                          height: 18,
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
                          final router = GoRouter.of(context);
                          var (result, fileExtension) = await importFile(
                            context,
                          );
                          if (result == null) return;
                          if (fileExtension == 'bin') {
                            // see https://github.com/LinwoodDev/Butterfly/issues/839
                            fileExtension = null;
                          }
                          setNativeData(result, fileExtension);
                          router.goNamed(
                            'native',
                            queryParameters: {
                              'name': 'document.bfly',
                              'path': AssetLocation(
                                path: _locationController.text,
                                remote: _remote?.identifier ?? '',
                              ).identifier,
                              'type': fileExtension ?? 'note',
                            },
                          );
                          if (!widget.collapsed) {
                            reloadFileSystem();
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
                        IconButton(
                          onPressed: _locationController.text.isEmpty
                              ? null
                              : () => setState(() {
                                  _locationController.text = parent;
                                  _setFilesStream();
                                }),
                          icon: const PhosphorIcon(PhosphorIconsLight.arrowUp),
                          tooltip: AppLocalizations.of(context).goUp,
                        ),
                    onWillAcceptWithDetails: (data) => true,
                    onAcceptWithDetails: (data) async {
                      await _documentSystem.moveAsset(
                        data.data,
                        '$parent/${data.data.split('/').last}',
                      );
                      reloadFileSystem();
                    },
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: TextFormField(
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
                ],
              ),
            )
          : Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            tooltip: AppLocalizations.of(
                              context,
                            ).invertSelection,
                            onPressed: () async {
                              final directory = await _documentSystem.getAsset(
                                _locationController.text,
                                readData: false,
                              );
                              if (directory is! FileSystemDirectory<NoteFile>) {
                                return;
                              }
                              setState(() {
                                final all = _selectedFiles.toSet();
                                _selectedFiles.clear();
                                _selectedFiles.addAll(
                                  directory.assets
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
                              onPressed: () async => deleteEntities(
                                context: context,
                                entities: _selectedFiles,
                                documentSystem: _documentSystem,
                                isMobile: widget.isMobile,
                                onDelete: reloadFileSystem,
                              ),
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

  Future<void> _onFileTap(FileSystemEntity<NoteFile> entity) async {
    if (entity is! FileSystemFile<NoteFile>) {
      setState(() {
        _locationController.text = entity.pathWithoutLeadingSlash;
        _setFilesStream();
      });
      return;
    }
    final location = entity.location;
    await openFile(context, widget.collapsed, location);
    if (!widget.collapsed) {
      reloadFileSystem();
    }
  }

  int _sortAssets(FileSystemEntity<NoteFile> a, FileSystemEntity<NoteFile> b) {
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
      if (a is FileSystemDirectory<NoteFile>) {
        return -1;
      }
      if (b is FileSystemDirectory<NoteFile>) {
        return 1;
      }
      final aFile = a as FileSystemFile<NoteFile>;
      final bFile = b as FileSystemFile<NoteFile>;
      FileMetadata? aInfo, bInfo;
      try {
        aInfo = aFile.data?.load()?.getMetadata();
      } catch (_) {}
      try {
        bInfo = bFile.data?.load()?.getMetadata();
      } catch (_) {}
      if (aInfo == null) {
        if (bInfo == null) {
          return aFile.fileName.compareTo(bFile.fileName);
        }
        return 1;
      }
      if (bInfo == null) {
        return -1;
      }
      switch (_sortBy) {
        case SortBy.name:
          final compared = aFile.fileName.compareTo(bFile.fileName);
          return _sortOrder == SortOrder.ascending ? compared : -compared;
        case SortBy.created:
          final aCreatedAt = aInfo.createdAt;
          final bCreatedAt = bInfo.createdAt;
          if (aCreatedAt == null) {
            return 1;
          }
          if (bCreatedAt == null) {
            return -1;
          }
          final compared = bCreatedAt.compareTo(aCreatedAt);
          return _sortOrder == SortOrder.ascending ? compared : -compared;
        case SortBy.modified:
          final aModifiedAt = aInfo.updatedAt;
          final bModifiedAt = bInfo.updatedAt;
          if (aModifiedAt == null) {
            return 1;
          }
          if (bModifiedAt == null) {
            return -1;
          }
          final compared = bModifiedAt.compareTo(aModifiedAt);
          return _sortOrder == SortOrder.ascending ? compared : -compared;
      }
    } catch (e) {
      return 0;
    }
  }
}
