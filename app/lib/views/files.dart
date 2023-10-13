import 'dart:typed_data';

import 'package:butterfly/main.dart';
import 'package:butterfly/visualizer/asset.dart';
import 'package:butterfly/visualizer/sync.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:popover/popover.dart';

import '../api/file_system/file_system.dart';
import '../api/file_system/file_system_remote.dart';
import '../api/open.dart';
import '../api/save_data.dart';
import '../cubits/settings.dart';
import '../dialogs/file_system/move.dart';
import '../dialogs/file_system/sync.dart';
import '../dialogs/name.dart';
import '../services/import.dart';
import '../services/sync.dart';

part 'files/entity.dart';
part 'files/grid.dart';
part 'files/list.dart';

class FilesView extends StatefulWidget {
  final AssetLocation? selectedAsset;
  final RemoteStorage? remote;
  final ValueChanged<RemoteStorage?>? onRemoteChanged;
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
  State<FilesView> createState() => _FilesViewState();
}

class _FilesViewState extends State<FilesView> {
  final TextEditingController _locationController = TextEditingController();
  late DocumentFileSystem _fileSystem;

  bool _gridView = false;
  SortBy _sortBy = SortBy.name;
  SortOrder _sortOrder = SortOrder.ascending;
  RemoteStorage? _remote;
  String _search = '';
  late final SettingsCubit _settingsCubit;
  Future<AppDocumentEntity?>? _filesFuture;

  @override
  void initState() {
    super.initState();
    _settingsCubit = context.read<SettingsCubit>();
    _sortBy = _settingsCubit.state.sortBy;
    _sortOrder = _settingsCubit.state.sortOrder;
    _remote = widget.remote ?? _settingsCubit.getRemote();
    _setFilesFuture();
  }

  @override
  void didUpdateWidget(covariant FilesView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remote != widget.remote) {
      _remote = widget.remote;
      _setFilesFuture();
    }
  }

  String getLocalizedNameOfSortBy(SortBy sortBy) {
    switch (sortBy) {
      case SortBy.name:
        return AppLocalizations.of(context).name;
      case SortBy.created:
        return AppLocalizations.of(context).created;
      case SortBy.modified:
        return AppLocalizations.of(context).modified;
    }
  }

  void _setFilesFuture() {
    _fileSystem = DocumentFileSystem.fromPlatform(remote: _remote);
    _filesFuture = _fileSystem.getAsset(_locationController.text);
  }

  void _reloadFileSystem() {
    setState(_setFilesFuture);
  }

  void _setRemote(RemoteStorage? remote) {
    _remote = remote;
    _setFilesFuture();
    widget.onRemoteChanged?.call(remote);
  }

  @override
  Widget build(BuildContext context) {
    final index = _locationController.text.lastIndexOf('/');
    final parent = _locationController.text.substring(0, index < 0 ? 0 : index);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      LayoutBuilder(builder: (context, constraints) {
        final isMobile = constraints.maxWidth <= kLargeWidth;
        final text = Text(
          AppLocalizations.of(context).files,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.start,
        );
        final actions = OverflowBar(
          spacing: 16,
          children: [
            if (!widget.collapsed)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context).switchView),
                  const SizedBox(width: 8),
                  IconButton.filledTonal(
                    onPressed: () => setState(() => _gridView = !_gridView),
                    icon: _gridView
                        ? const PhosphorIcon(PhosphorIconsLight.list)
                        : const PhosphorIcon(PhosphorIconsLight.gridFour),
                  ),
                ],
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<SettingsCubit, ButterflySettings>(
                    builder: (context, state) {
                  return DropdownMenu<String?>(
                    label: Text(AppLocalizations.of(context).source),
                    width: 225,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        value: null,
                        label: AppLocalizations.of(context).local,
                      ),
                      ...state.remotes
                          .map((e) => DropdownMenuEntry(
                                value: e.identifier,
                                label: e.uri.host,
                              ))
                          .toList(),
                    ],
                    initialSelection: _remote?.identifier,
                    onSelected: (value) => _setRemote(
                        value == null ? null : state.getRemote(value)),
                  );
                }),
                BlocBuilder<SettingsCubit, ButterflySettings>(
                  buildWhen: (previous, current) =>
                      previous.remotes != current.remotes,
                  builder: (context, state) => state.remotes.isEmpty
                      ? const SizedBox.shrink()
                      : const SyncButton(),
                ),
              ],
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
      const SizedBox(height: 16),
      LayoutBuilder(builder: (context, constraints) {
        final searchBar = SearchBar(
          onChanged: (value) => setState(() => _search = value),
          hintText: AppLocalizations.of(context).search,
          leading: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
        );
        final locationBar = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MenuAnchor(
              menuChildren: [
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.folder),
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
                    _reloadFileSystem();
                  },
                ),
                MenuItemButton(
                  onPressed: () async {
                    final name = await showDialog<String>(
                      context: context,
                      builder: (context) => NameDialog(
                        validator: defaultFileNameValidator(context),
                      ),
                    );
                    if (name?.isEmpty ?? true) return;
                    final templateFileSystem =
                        TemplateFileSystem.fromPlatform(remote: _remote);
                    if (context.mounted) {
                      await templateFileSystem.createDefault(context);
                    }
                    final templates = await templateFileSystem.getTemplates();
                    if (context.mounted) {
                      final asset = await showDialog<NoteData>(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                    AppLocalizations.of(context).templates),
                                scrollable: true,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: templates
                                      .map((e) => ListTile(
                                            title: Text(e.name!),
                                            onTap: () =>
                                                Navigator.of(context).pop(e),
                                          ))
                                      .toList(),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(null),
                                    child: Text(
                                        AppLocalizations.of(context).cancel),
                                  ),
                                ],
                              ));
                      if (asset == null) return;
                      final path = _locationController.text;
                      var newPath =
                          '$path/${_fileSystem.convertNameToFile(name!)}.bfly';
                      await _fileSystem.updateDocument(
                          newPath,
                          asset.createDocument(
                            name: name,
                          ));
                      _reloadFileSystem();
                    }
                  },
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.file),
                  child: Text(AppLocalizations.of(context).newFile),
                ),
                MenuItemButton(
                  leadingIcon:
                      const PhosphorIcon(PhosphorIconsLight.arrowSquareIn),
                  onPressed: () async {
                    final router = GoRouter.of(context);
                    final importService = context.read<ImportService>();
                    final result = await openBfly();
                    if (result == null) return;
                    final model = await importService.importBfly(result);
                    if (model == null) return;
                    const route = '/native?name=document.bfly&type=note';
                    router.go(route, extra: model.save());
                    if (!widget.collapsed) {
                      _reloadFileSystem();
                    }
                  },
                  child: Column(
                    children: [
                      Text(AppLocalizations.of(context).import),
                      Text('.bfly',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                /*MenuItemButton(
                  leadingIcon:
                      const PhosphorIcon(PhosphorIconsLight.shareNetwork),
                  child: Text(AppLocalizations.of(context).connect),
                  onPressed: () {
                    // TODO: Connect
                  },
                ),*/
              ],
              builder: (context, controller, child) =>
                  FloatingActionButton.small(
                heroTag: null,
                onPressed: () =>
                    controller.isOpen ? controller.close() : controller.open(),
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
                          _setFilesFuture();
                        }),
                icon: const PhosphorIcon(PhosphorIconsLight.arrowUp),
                tooltip: AppLocalizations.of(context).goUp,
              ),
              onWillAccept: (data) => true,
              onAccept: (data) async {
                await _fileSystem.moveAsset(
                    data, '$parent/${data.split('/').last}');
                _reloadFileSystem();
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
                onFieldSubmitted: (value) => _reloadFileSystem(),
              ),
            ),
          ],
        );
        final isDesktop = constraints.maxWidth > 600;
        if (isDesktop) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 3, child: locationBar),
              const SizedBox(width: 8),
              SizedBox(width: 150, child: searchBar),
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
        builder: (context, settings) => FutureBuilder<AppDocumentEntity?>(
            future: _filesFuture,
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
              if (_gridView) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: assets.map(
                    (e) {
                      final selected =
                          widget.selectedAsset?.isSame(e.location) ?? false;
                      return _FileEntityItem(
                        entity: e,
                        isMobile: widget.isMobile,
                        selected: selected,
                        collapsed: widget.collapsed,
                        onTap: () => _onFileTap(e),
                        onReload: _reloadFileSystem,
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
                  return _FileEntityItem(
                    entity: entity,
                    selected: selected,
                    collapsed: widget.collapsed,
                    onTap: () => _onFileTap(entity),
                    onReload: _reloadFileSystem,
                    gridView: false,
                    isMobile: widget.isMobile,
                  );
                },
              );
            }),
      ),
    ]);
  }

  Future<void> _onFileTap(AppDocumentEntity entity) async {
    if (entity is! AppDocumentFile) {
      setState(() {
        _locationController.text = entity.pathWithoutLeadingSlash;
        _setFilesFuture();
      });
      return;
    }
    final location = entity.location;
    final data = entity.data;
    if (location.remote != '') {
      GoRouter.of(context).pushReplacementNamed('remote',
          pathParameters: {
            'remote': location.remote,
            'path': location.pathWithoutLeadingSlash,
          },
          queryParameters: {
            'type': location.fileType?.name,
          },
          extra: data);
      return;
    }
    GoRouter.of(context).pushReplacementNamed('local',
        pathParameters: {
          'path': location.pathWithoutLeadingSlash,
        },
        queryParameters: {
          'type': location.fileType?.name,
        },
        extra: data);
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
