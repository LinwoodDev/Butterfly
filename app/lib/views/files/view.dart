import 'dart:typed_data';

import 'package:butterfly/main.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/views/files/entity.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/file_system/file_system.dart';
import '../../api/open.dart';
import '../../cubits/settings.dart';
import '../../dialogs/file_system/sync.dart';
import '../../dialogs/name.dart';
import '../../services/import.dart';

class FilesView extends StatefulWidget {
  final AssetLocation? selectedAsset;
  final ExternalStorage? remote;
  final ValueChanged<ExternalStorage?>? onRemoteChanged;
  final bool collapsed;
  final bool isMobile;

  const FilesView({
    super.key,
    this.selectedAsset,
    this.remote,
    this.onRemoteChanged,
    this.collapsed = false,
    this.isMobile = false,
  });

  @override
  State<FilesView> createState() => FilesViewState();
}

class FilesViewState extends State<FilesView> {
  final TextEditingController _locationController = TextEditingController();
  late DocumentFileSystem _fileSystem;
  late TemplateFileSystem _templateSystem;

  SortBy _sortBy = SortBy.name;
  SortOrder _sortOrder = SortOrder.ascending;
  ExternalStorage? _remote;
  String _search = '';
  late final SettingsCubit _settingsCubit;
  Stream<AppDocumentEntity?>? _filesStream;

  @override
  void initState() {
    super.initState();
    _settingsCubit = context.read<SettingsCubit>();
    _sortBy = _settingsCubit.state.sortBy;
    _sortOrder = _settingsCubit.state.sortOrder;
    _remote = widget.remote ?? _settingsCubit.getRemote();
    _setFilesStream();
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
        SortBy.name => AppLocalizations.of(context).name,
        SortBy.created => AppLocalizations.of(context).created,
        SortBy.modified => AppLocalizations.of(context).modified,
      };

  void _setFilesStream() {
    _templateSystem = TemplateFileSystem.fromPlatform(remote: _remote);
    _fileSystem = DocumentFileSystem.fromPlatform(remote: _remote);
    _filesStream = _fileSystem.fetchAsset(_locationController.text);
  }

  void reloadFileSystem() {
    setState(_setFilesStream);
  }

  Future<void> _createFile(NoteData? template) async {
    template ??= await DocumentDefaults.createTemplate();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => NameDialog(
        validator: defaultFileNameValidator(context),
      ),
    );
    if (name == null) return;
    final path = _locationController.text;
    final newPath = '$path/${_fileSystem.convertNameToFile(name)}.bfly';
    await _fileSystem.updateDocument(
        newPath,
        template.createDocument(
          name: name,
        ));
    reloadFileSystem();
  }

  void _setRemote(ExternalStorage? remote) {
    _remote = remote;
    _setFilesStream();
    widget.onRemoteChanged?.call(remote);
  }

  @override
  Widget build(BuildContext context) {
    final index = _locationController.text.lastIndexOf('/');
    final parent = _locationController.text.substring(0, index < 0 ? 0 : index);
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      buildWhen: (previous, current) => previous.gridView != current.gridView,
      builder: (context, state) =>
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        LayoutBuilder(builder: (context, constraints) {
          final isMobile = constraints.maxWidth <= kMobileWidth;
          final text = Text(
            AppLocalizations.of(context).files,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.start,
          );
          final actions = OverflowBar(
            spacing: 8,
            overflowSpacing: 8,
            overflowAlignment: widget.collapsed
                ? OverflowBarAlignment.start
                : OverflowBarAlignment.end,
            alignment: MainAxisAlignment.end,
            children: [
              if (!widget.collapsed)
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
                        ...state.connections.map((e) => DropdownMenuEntry(
                              value: e.identifier,
                              label: e.label,
                            )),
                      ],
                      initialSelection: _remote?.identifier,
                      onSelected: (value) => _setRemote(
                          value == null ? null : state.getRemote(value)),
                    ),
                    state.connections.any((e) => e is RemoteStorage)
                        ? const SyncButton()
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              DropdownMenu<SortBy>(
                leadingIcon: IconButton(
                  icon: PhosphorIcon(_sortOrder == SortOrder.ascending
                      ? PhosphorIconsLight.sortAscending
                      : PhosphorIconsLight.sortDescending),
                  tooltip: _sortOrder == SortOrder.ascending
                      ? AppLocalizations.of(context).ascending
                      : AppLocalizations.of(context).descending,
                  onPressed: () => setState(() {
                    _sortOrder = _sortOrder == SortOrder.ascending
                        ? SortOrder.descending
                        : SortOrder.ascending;
                    _settingsCubit.changeSortOrder(_sortOrder);
                  }),
                ),
                label: Text(AppLocalizations.of(context).sortBy),
                width: 225,
                dropdownMenuEntries: SortBy.values
                    .map((e) => DropdownMenuEntry(
                          value: e,
                          label: getLocalizedNameOfSortBy(e),
                        ))
                    .toList(),
                initialSelection: _sortBy,
                onSelected: (value) => setState(() {
                  _sortBy = value ?? _sortBy;
                  _settingsCubit.changeSortBy(_sortBy);
                }),
              ),
            ],
          );
          if (widget.collapsed) {
            return actions;
          }
          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                text,
                const SizedBox(height: 16),
                actions,
              ],
            );
          }
          return Row(
            children: [
              text,
              const SizedBox(width: 8),
              Expanded(child: actions),
            ],
          );
        }),
        const SizedBox(height: 8),
        _RecentFilesView(
          replace: widget.collapsed,
        ),
        const SizedBox(height: 16),
        LayoutBuilder(builder: (context, constraints) {
          final searchBar = Row(children: [
            IconButton(
              onPressed: reloadFileSystem,
              tooltip: AppLocalizations.of(context).refresh,
              icon: const PhosphorIcon(PhosphorIconsLight.arrowClockwise),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SearchBar(
                onChanged: (value) => setState(() => _search = value),
                hintText: AppLocalizations.of(context).search,
                leading: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
              ),
            ),
          ]);
          final locationBar = BlocBuilder<SettingsCubit, ButterflySettings>(
            buildWhen: (previous, current) => previous.flags != current.flags,
            builder: (context, settings) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MenuAnchor(
                  menuChildren: [
                    MenuItemButton(
                      leadingIcon:
                          const PhosphorIcon(PhosphorIconsLight.folder),
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
                        await _fileSystem.createDirectory(newPath);
                        reloadFileSystem();
                      },
                    ),
                    MenuItemButton(
                      onPressed: () async => _createFile(
                        await _templateSystem.getDefaultTemplate(
                          _templateSystem.remote?.defaultTemplate ??
                              _settingsCubit.state.defaultTemplate,
                        ),
                      ),
                      leadingIcon:
                          const PhosphorIcon(PhosphorIconsLight.filePlus),
                      child: Text(AppLocalizations.of(context).newFile),
                    ),
                    FutureBuilder<List<NoteData>>(
                      future: _templateSystem
                          .createDefault(context)
                          .then((_) => _templateSystem.getTemplates()),
                      builder: (context, snapshot) => SubmenuButton(
                        leadingIcon:
                            const PhosphorIcon(PhosphorIconsLight.file),
                        menuChildren: snapshot.data?.map((e) {
                              final metadata = e.getMetadata();
                              final thumbnail = e.getThumbnail();
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
                                onPressed: () => _createFile(e),
                              );
                            }).toList() ??
                            [],
                        child: Text(AppLocalizations.of(context).templates),
                      ),
                    ),
                    MenuItemButton(
                      leadingIcon:
                          const PhosphorIcon(PhosphorIconsLight.arrowSquareIn),
                      onPressed: () async {
                        final router = GoRouter.of(context);
                        final importService = context.read<ImportService>();
                        final (result, extension) = await importFile(context);
                        if (result == null) return;
                        final model = await importService.import(
                            AssetFileTypeHelper.fromFileExtension(extension) ??
                                AssetFileType.note,
                            result,
                            DocumentDefaults.createDocument(),
                            advanced: false);
                        if (model == null) return;
                        const route = '/native?name=document.bfly&type=note';
                        router.go(route, extra: model.save());
                        if (!widget.collapsed) {
                          reloadFileSystem();
                        }
                      },
                      child: Text(AppLocalizations.of(context).import),
                    ),
                    if (settings.flags.contains('collaboration'))
                      MenuItemButton(
                        leadingIcon:
                            const PhosphorIcon(PhosphorIconsLight.shareNetwork),
                        child: Text(AppLocalizations.of(context).connect),
                        onPressed: () async {
                          final url = await showDialog<String>(
                            builder: (context) => NameDialog(
                              title: AppLocalizations.of(context).enterUrl,
                              hint: AppLocalizations.of(context).url,
                              button: AppLocalizations.of(context).connect,
                            ),
                            context: context,
                          );
                          if (url == null) return;
                          GoRouter.of(context)
                              .pushNamed('connect', queryParameters: {
                            'url': url,
                          });
                        },
                      ),
                  ],
                  builder: (context, controller, child) =>
                      FloatingActionButton.small(
                    heroTag: null,
                    onPressed: controller.toggle,
                    tooltip: AppLocalizations.of(context).create,
                    child: const PhosphorIcon(PhosphorIconsLight.plus),
                  ),
                ),
                DragTarget<String>(
                  builder: (context, candidateData, rejectedData) => IconButton(
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
                    await _fileSystem.moveAsset(
                        data.data, '$parent/${data.data.split('/').last}');
                    reloadFileSystem();
                  },
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).location,
                      prefixIcon: const PhosphorIcon(PhosphorIconsLight.folder),
                      filled: true,
                    ),
                    controller: _locationController,
                    onFieldSubmitted: (value) => reloadFileSystem(),
                  ),
                ),
              ],
            ),
          );
          final isDesktop = constraints.maxWidth > 600;
          if (isDesktop) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: locationBar),
                const SizedBox(width: 8),
                SizedBox(width: 250, child: searchBar),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchBar,
                const SizedBox(height: 16),
                locationBar,
              ],
            );
          }
        }),
        const SizedBox(height: 16),
        BlocBuilder<SettingsCubit, ButterflySettings>(
          buildWhen: (previous, current) => previous.starred != current.starred,
          builder: (context, settings) => StreamBuilder<AppDocumentEntity?>(
              stream: _filesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final entity = snapshot.data;
                if (entity is! AppDocumentDirectory) {
                  return Container();
                }
                final assets = entity.assets.where((e) {
                  if (_search.isNotEmpty) {
                    return e.fileName
                        .toLowerCase()
                        .contains(_search.toLowerCase());
                  }
                  return true;
                }).toList()
                  ..sort(_sortAssets);
                if (assets.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(context).noElements),
                  );
                }
                if (state.gridView && !widget.collapsed) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: assets.map(
                      (e) {
                        final selected =
                            widget.selectedAsset?.isSame(e.location) ?? false;
                        return FileEntityItem(
                          entity: e,
                          isMobile: widget.isMobile,
                          selected: selected,
                          collapsed: widget.collapsed,
                          onTap: () => _onFileTap(e),
                          onReload: reloadFileSystem,
                          gridView: true,
                        );
                      },
                    ).toList(),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: assets.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final entity = assets[index];
                    final selected =
                        widget.selectedAsset?.isSame(entity.location) ?? false;
                    return FileEntityItem(
                      entity: entity,
                      selected: selected,
                      collapsed: widget.collapsed,
                      onTap: () => _onFileTap(entity),
                      onReload: reloadFileSystem,
                      gridView: false,
                      isMobile: widget.isMobile,
                    );
                  },
                );
              }),
        ),
      ]),
    );
  }

  Future<void> _onFileTap(AppDocumentEntity entity) async {
    if (entity is! AppDocumentFile) {
      setState(() {
        _locationController.text = entity.pathWithoutLeadingSlash;
        _setFilesStream();
      });
      return;
    }
    final location = entity.location;
    final data = entity.data;
    await openFile(context, widget.collapsed, location, data);
    if (!widget.collapsed) {
      reloadFileSystem();
    }
  }

  int _sortAssets(AppDocumentEntity a, AppDocumentEntity b) {
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
      if (a is AppDocumentDirectory) {
        return -1;
      }
      if (b is AppDocumentDirectory) {
        return 1;
      }
      final aFile = a as AppDocumentFile;
      final bFile = b as AppDocumentFile;
      FileMetadata? aInfo, bInfo;
      try {
        aInfo = aFile.metadata;
      } catch (_) {}
      try {
        bInfo = bFile.metadata;
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

class _RecentFilesView extends StatefulWidget {
  final bool replace;
  const _RecentFilesView({
    required this.replace,
  });

  @override
  State<_RecentFilesView> createState() => _RecentFilesViewState();
}

class _RecentFilesViewState extends State<_RecentFilesView> {
  late Stream<List<AppDocumentEntity>> _stream;
  final ScrollController _recentScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _setStream(context.read<SettingsCubit>().state);
  }

  @override
  void dispose() {
    _recentScrollController.dispose();
    super.dispose();
  }

  void _setStream(ButterflySettings settings) => _stream =
      DocumentFileSystem.fetchAssetsGlobalSync(settings.history, settings);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, ButterflySettings>(
      listener: (_, state) => setState(() {
        _setStream(state);
      }),
      child: StreamBuilder<List<AppDocumentEntity>>(
          stream: _stream,
          builder: (context, snapshot) {
            final files = snapshot.data ?? [];
            if (files.isEmpty) {
              return Container();
            }
            return SizedBox(
              height: 150,
              child: Scrollbar(
                controller: _recentScrollController,
                child: ListView.builder(
                  controller: _recentScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final entity = files[index];
                    FileMetadata? metadata;
                    Uint8List? thumbnail;
                    List<int>? data;
                    if (entity is AppDocumentFile) {
                      metadata = entity.metadata;
                      thumbnail = entity.thumbnail;
                      data = entity.data;
                    }
                    return AssetCard(
                      metadata: metadata,
                      thumbnail: thumbnail,
                      name: entity.location.identifier,
                      onTap: () => openFile(
                          context, widget.replace, entity.location, data),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}

class AssetCard extends StatelessWidget {
  const AssetCard({
    super.key,
    required this.metadata,
    required this.thumbnail,
    required this.onTap,
    this.name,
  });
  final String? name;
  final FileMetadata? metadata;
  final Uint8List? thumbnail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurface,
        );
    return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Card(
            elevation: 5,
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                if (thumbnail?.isNotEmpty ?? false)
                  Align(
                    child: Image.memory(
                      thumbnail!,
                      fit: BoxFit.cover,
                      width: 640,
                      alignment: Alignment.center,
                    ),
                  ),
                if ((metadata?.name.isNotEmpty ?? false) ||
                    (name?.isNotEmpty ?? false))
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Tooltip(
                      message: name ?? metadata!.name,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colorScheme.primaryContainer.withAlpha(200),
                        ),
                        child: Text(
                          (metadata?.name.isNotEmpty ?? false)
                              ? metadata!.name
                              : name!,
                          style: textStyle,
                        ),
                      ),
                    ),
                  ),
                Positioned.fill(
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: onTap,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
