import 'dart:convert';

import 'package:butterfly/actions/settings.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/file_system_remote.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/export.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly/helpers/element_helper.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/services/sync.dart';
import 'package:butterfly/visualizer/asset.dart';
import 'package:butterfly/visualizer/sync.dart';
import 'package:butterfly/widgets/window.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:popover/popover.dart';

import '../api/open_release_notes.dart';
import '../dialogs/file_system/move.dart';
import '../dialogs/file_system/sync.dart';
import '../dialogs/import.dart';

class HomePage extends StatefulWidget {
  final AssetLocation? selectedAsset;

  const HomePage({super.key, this.selectedAsset});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RemoteStorage? _remote;

  @override
  void initState() {
    super.initState();
    _remote = context.read<SettingsCubit>().state.getDefaultRemote();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DocumentFileSystem>.value(
            value: DocumentFileSystem.fromPlatform(remote: _remote)),
        RepositoryProvider<TemplateFileSystem>.value(
            value: TemplateFileSystem.fromPlatform(remote: _remote)),
        RepositoryProvider<PackFileSystem>.value(
            value: PackFileSystem.fromPlatform(remote: _remote)),
        RepositoryProvider<ImportService>(
            create: (context) => ImportService(context)),
      ],
      child: Scaffold(
        appBar: const WindowTitleBar(
          title: Text('Butterfly'),
          onlyShowOnDesktop: true,
        ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 64),
                  const _HeaderHomeView(),
                  const SizedBox(height: 64),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 1000) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: _FilesHomeView(
                              selectedAsset: widget.selectedAsset,
                              remote: _remote,
                              onRemoteChanged: (value) =>
                                  setState(() => _remote = value),
                            )),
                            const SizedBox(width: 32),
                            SizedBox(
                              width: 500,
                              child: _QuickstartHomeView(
                                remote: _remote,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _QuickstartHomeView(
                              remote: _remote,
                            ),
                            const SizedBox(height: 32),
                            _FilesHomeView(
                              selectedAsset: widget.selectedAsset,
                              remote: _remote,
                              onRemoteChanged: (value) =>
                                  setState(() => _remote = value),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderHomeView extends StatelessWidget {
  const _HeaderHomeView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (context, constraints) {
      final actions = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            onPressed: () => openHelp(['intro']),
            icon: const PhosphorIcon(PhosphorIconsLight.bookOpen),
            label: Text(AppLocalizations.of(context).documentation),
          ),
          IconButton(
            onPressed: () => openSettings(context),
            icon: const PhosphorIcon(PhosphorIconsLight.gear),
            tooltip: AppLocalizations.of(context).settings,
          ),
        ],
      );
      final isDesktop = constraints.maxWidth > 1000;
      final settingsCubit = context.read<SettingsCubit>();
      final whatsNew = FutureBuilder<bool>(
        future: settingsCubit.hasNewerVersion(),
        builder: (context, snapshot) {
          final style = FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 20,
            ),
            textStyle: const TextStyle(fontSize: 20),
          );
          void openNew() {
            openReleaseNotes();
            settingsCubit.updateLastVersion();
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (snapshot.data ?? false)
                  ? FilledButton(
                      onPressed: openNew,
                      style: style,
                      child: Text(AppLocalizations.of(context).whatsNew),
                    )
                  : ElevatedButton(
                      onPressed: openNew,
                      style: style,
                      child: Text(AppLocalizations.of(context).whatsNew),
                    ),
              if (snapshot.data ?? false)
                SizedBox(
                  height: 0,
                  child: Stack(
                    children: const [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: PhosphorIcon(PhosphorIconsLight.caretUp),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      );
      final logo = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/logo.png',
            width: 64,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context).welcome,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colorScheme.onInverseSurface,
                      ),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  AppLocalizations.of(context).welcomeContent,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onInverseSurface,
                      ),
                ),
              ],
            ),
          ),
        ],
      );
      final innerCard = isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: logo),
                const SizedBox(width: 32),
                whatsNew,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                logo,
                const SizedBox(height: 32),
                whatsNew,
              ],
            );
      final card = Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colorScheme.inverseSurface,
                colorScheme.primary,
              ],
              stops: const [0, 0.8],
            ),
          ),
          child: innerCard,
        ),
      );
      if (isDesktop) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: card),
            const SizedBox(width: 32),
            actions,
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            card,
            const SizedBox(height: 32),
            actions,
          ],
        );
      }
    });
  }
}

class _FilesHomeView extends StatefulWidget {
  final AssetLocation? selectedAsset;
  final RemoteStorage? remote;
  final ValueChanged<RemoteStorage?>? onRemoteChanged;

  const _FilesHomeView({this.selectedAsset, this.remote, this.onRemoteChanged});

  @override
  State<_FilesHomeView> createState() => _FilesHomeViewState();
}

enum _SortBy { name, created, modified }

class _FilesHomeViewState extends State<_FilesHomeView> {
  final TextEditingController _locationController = TextEditingController();
  late DocumentFileSystem _fileSystem;

  //bool _gridView = false;
  RemoteStorage? _remote;
  _SortBy _sortBy = _SortBy.name;
  String _search = '';
  late final SettingsCubit _settingsCubit;
  late Future<AppDocumentEntity?> _filesFuture;

  @override
  void initState() {
    super.initState();
    _settingsCubit = context.read<SettingsCubit>();
    _remote = _settingsCubit.getRemote();
    _setFilesFuture();
  }

  @override
  void didUpdateWidget(covariant _FilesHomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.remote != widget.remote) {
      _remote = widget.remote;
      _setFilesFuture();
    }
  }

  String getLocalizedNameOfSortBy(_SortBy sortBy) {
    switch (sortBy) {
      case _SortBy.name:
        return AppLocalizations.of(context).name;
      case _SortBy.created:
        return AppLocalizations.of(context).created;
      case _SortBy.modified:
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
      Wrap(
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.spaceBetween,
        runSpacing: 16,
        spacing: 16,
        children: [
          Text(
            AppLocalizations.of(context).files,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.start,
          ),
          Wrap(
            runSpacing: 16,
            spacing: 16,
            children: [
              /*Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Switch view'),
            IconButton(
              onPressed: () => setState(() => _gridView = !_gridView),
              icon: _gridView
                  ? PhosphorIcon(PhosphorIconsLight.list)
                  : PhosphorIcon(PhosphorIconsLight.gridFour),
            ),
          ],
          ),*/
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context).source),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 200,
                    child: BlocBuilder<SettingsCubit, ButterflySettings>(
                        builder: (context, state) {
                      return DropdownButtonFormField<String?>(
                        items: [
                          DropdownMenuItem(
                            value: null,
                            child: Text(AppLocalizations.of(context).local),
                          ),
                          ...state.remotes
                              .map((e) => DropdownMenuItem(
                                    value: e.identifier,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(e.uri.host),
                                        Text(e.username),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ],
                        itemHeight: 50,
                        selectedItemBuilder: (context) => [
                          Text(AppLocalizations.of(context).local),
                          ...state.remotes.map((e) =>
                              Text(e.uri.host, overflow: TextOverflow.ellipsis))
                        ],
                        borderRadius: BorderRadius.circular(16),
                        value: _remote?.identifier,
                        onChanged: (value) => _setRemote(
                            value == null ? null : state.getRemote(value)),
                      );
                    }),
                  ),
                  BlocBuilder<SettingsCubit, ButterflySettings>(
                    buildWhen: (previous, current) =>
                        previous.remotes != current.remotes,
                    builder: (context, state) => state.remotes.isEmpty
                        ? const SizedBox.shrink()
                        : const SyncButton(),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context).sortBy),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 150,
                    child: DropdownButtonFormField<_SortBy>(
                      items: _SortBy.values
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(getLocalizedNameOfSortBy(e)),
                              ))
                          .toList(),
                      borderRadius: BorderRadius.circular(16),
                      value: _sortBy,
                      onChanged: (value) =>
                          setState(() => _sortBy = value ?? _sortBy),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      LayoutBuilder(builder: (context, constraints) {
        final searchBar = TextFormField(
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).search,
            prefixIcon: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
            filled: true,
          ),
          initialValue: _search,
          onChanged: (value) => setState(() => _search = value),
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
                      builder: (context) => NameDialog(),
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
                      builder: (context) => NameDialog(),
                    );
                    if (name?.isEmpty ?? true) return;
                    final templateFileSystem =
                        TemplateFileSystem.fromPlatform(remote: _remote);
                    if (context.mounted) {
                      await templateFileSystem.createDefault(context);
                    }
                    final templates = await templateFileSystem.getTemplates();
                    if (context.mounted) {
                      final asset = await showDialog<DocumentTemplate>(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                    AppLocalizations.of(context).templates),
                                scrollable: true,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: templates
                                      .map((e) => ListTile(
                                            title: Text(e.name),
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
                      var newPath = '$path/$name';
                      if (!newPath.endsWith('.bfly')) {
                        newPath += '.bfly';
                      }
                      await _fileSystem.updateDocument(newPath, asset.document);
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
                    final result = await showDialog<String>(
                        builder: (context) => const ImportDialog(),
                        context: context);
                    if (result == null) return;
                    final model = await importService.importBfly(
                      Uint8List.fromList(result.codeUnits),
                    );
                    model?.maybeMap(
                      document: (value) => router.push(
                          '/native?name=document.bfly&type=note',
                          extra: value),
                      orElse: () {},
                    );
                    _reloadFileSystem();
                  },
                  child: Text(AppLocalizations.of(context).import),
                ),
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
                  contentPadding: const EdgeInsets.only(left: 32),
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
      FutureBuilder<AppDocumentEntity?>(
          future: _filesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final entity = snapshot.data;
            if (!snapshot.hasData || entity is! AppDocumentDirectory) {
              return Container();
            }
            final assets = entity.assets.where((e) {
              if (_search.isNotEmpty) {
                return e.fileName.contains(_search);
              }
              return true;
            }).toList()
              ..sort(_sortAssets);
            return ListView.builder(
              shrinkWrap: true,
              itemCount: assets.length,
              itemBuilder: (context, index) {
                final entity = assets[index];
                final selected =
                    widget.selectedAsset?.isSame(entity.location) ?? false;
                return _FileEntityListTile(
                  entity: entity,
                  selected: selected,
                  onTap: () async {
                    if (entity is AppDocumentDirectory) {
                      setState(() {
                        _locationController.text =
                            entity.pathWithoutLeadingSlash;
                        _setFilesFuture();
                      });
                      return;
                    }
                    final location = entity.location;
                    if (location.remote != '') {
                      await GoRouter.of(context).pushNamed('remote', params: {
                        'remote': location.remote,
                        'path': location.pathWithoutLeadingSlash,
                      });
                      return;
                    }
                    await GoRouter.of(context).pushNamed('local',
                        params: {
                          'path': location.pathWithoutLeadingSlash,
                        },
                        extra: entity);
                    _reloadFileSystem();
                  },
                  onReload: _reloadFileSystem,
                );
              },
            );
          }),
    ]);
  }

  int _sortAssets(AppDocumentEntity a, AppDocumentEntity b) {
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
    final aInfo = aFile.getDocumentInfo();
    final bInfo = bFile.getDocumentInfo();
    if (aInfo == null) {
      return 1;
    }
    if (bInfo == null) {
      return -1;
    }
    switch (_sortBy) {
      case _SortBy.name:
        return aFile.fileName.compareTo(bFile.fileName);
      case _SortBy.created:
        final aCreatedAt = aInfo.createdAt;
        final bCreatedAt = bInfo.createdAt;
        if (aCreatedAt == null) {
          return 1;
        }
        if (bCreatedAt == null) {
          return -1;
        }
        return aCreatedAt.compareTo(bCreatedAt);
      case _SortBy.modified:
        final aModifiedAt = aInfo.updatedAt;
        final bModifiedAt = bInfo.updatedAt;
        if (aModifiedAt == null) {
          return 1;
        }
        if (bModifiedAt == null) {
          return -1;
        }
        return aModifiedAt.compareTo(bModifiedAt);
    }
  }
}

class _FileEntityListTile extends StatelessWidget {
  final AppDocumentEntity entity;
  final bool selected;
  final VoidCallback onTap, onReload;
  final TextEditingController _nameController = TextEditingController();

  _FileEntityListTile(
      {required this.entity,
      this.selected = false,
      required this.onTap,
      required this.onReload});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final settingsCubit = context.read<SettingsCubit>();
    final remote = settingsCubit.getRemote(entity.location.remote);
    final fileSystem = DocumentFileSystem.fromPlatform(remote: remote);
    final syncService = context.read<SyncService>();
    DocumentInfo? info;
    String? modifiedText, createdText;
    PhosphorIconData icon = PhosphorIconsLight.folder;
    try {
      if (entity is AppDocumentFile) {
        final file = entity as AppDocumentFile;
        icon = file.fileType.getIcon();
        info = file.getDocumentInfo();
        final locale = Localizations.localeOf(context).languageCode;
        final dateFormatter = DateFormat.yMd(locale);
        final timeFormatter = DateFormat.Hm(locale);
        modifiedText = info?.updatedAt != null
            ? '${dateFormatter.format(info!.updatedAt!)} ${timeFormatter.format(info.updatedAt!)}'
            : null;
        createdText = info?.createdAt != null
            ? '${dateFormatter.format(info!.createdAt!)} ${timeFormatter.format(info.createdAt!)}'
            : null;
      }
    } catch (_) {}
    var editable = false;
    final draggable = Draggable<String>(
      data: entity.pathWithLeadingSlash,
      feedback: Material(
        elevation: 5,
        child: SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              entity.fileName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: selected
                  ? BorderSide(
                      color: colorScheme.primaryContainer,
                      width: 1,
                    )
                  : BorderSide.none,
            ),
            surfaceTintColor: selected
                ? colorScheme.primaryContainer
                : colorScheme.secondaryContainer,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
                onTap: onTap,
                highlightColor: selected ? colorScheme.primaryContainer : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: StatefulBuilder(builder: (context, setState) {
                    return LayoutBuilder(builder: (context, constraints) {
                      final fileName = Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PhosphorIcon(
                            icon,
                            color: colorScheme.outline,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                              child: editable
                                  ? TextField(
                                      controller: _nameController,
                                      autofocus: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: colorScheme.onBackground,
                                          ),
                                      onSubmitted: (value) async {
                                        await fileSystem.renameAsset(
                                            entity.location.path, value);
                                        setState(() {
                                          editable = false;
                                        });
                                        onReload();
                                      },
                                    )
                                  : Text(entity.fileName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis)),
                        ],
                      );
                      final edit = editable
                          ? Container()
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => setState(() {
                                    editable = true;
                                    _nameController.text = entity.fileName;
                                  }),
                                  icon: const PhosphorIcon(
                                      PhosphorIconsLight.pencil),
                                  tooltip: AppLocalizations.of(context).rename,
                                ),
                              ],
                            );
                      final actions = Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (remote != null)
                            StreamBuilder<List<SyncFile>>(
                              stream: syncService
                                  .getSync(remote.identifier)
                                  ?.filesStream,
                              builder: (context, snapshot) {
                                final currentStatus = snapshot.data
                                    ?.lastWhereOrNull((element) => entity
                                        .location.pathWithLeadingSlash
                                        .startsWith(element
                                            .location.pathWithLeadingSlash))
                                    ?.status;
                                return IconButton(
                                  icon: PhosphorIcon(currentStatus.getIcon(),
                                      color: currentStatus.getColor(
                                          Theme.of(context).colorScheme)),
                                  tooltip:
                                      currentStatus.getLocalizedName(context),
                                  onPressed: () {
                                    syncService
                                        .getSync(remote.identifier)
                                        ?.sync();
                                  },
                                );
                              },
                            ),
                          BlocBuilder<SettingsCubit, ButterflySettings>(
                              builder: (context, state) {
                            final starred = state.isStarred(entity.location);
                            return IconButton(
                              onPressed: () {
                                settingsCubit.toggleStarred(entity.location);
                                onReload();
                              },
                              icon: starred
                                  ? const PhosphorIcon(PhosphorIconsFill.star)
                                  : const PhosphorIcon(PhosphorIconsLight.star),
                              isSelected: starred,
                              tooltip: starred
                                  ? AppLocalizations.of(context).unstar
                                  : AppLocalizations.of(context).star,
                            );
                          }),
                          IconButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => FileSystemAssetMoveDialog(
                                asset: entity,
                                fileSystem: fileSystem,
                              ),
                            ).then((value) => onReload()),
                            tooltip: AppLocalizations.of(context).move,
                            icon: const PhosphorIcon(
                                PhosphorIconsLight.arrowsDownUp),
                          ),
                        ],
                      );
                      final info = Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (modifiedText != null)
                            Tooltip(
                              message: AppLocalizations.of(context).modified,
                              child: Row(
                                children: [
                                  PhosphorIcon(
                                    PhosphorIconsLight.clockCounterClockwise,
                                    size: 12,
                                    color: colorScheme.outline,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    modifiedText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: colorScheme.outline,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          if (createdText != null)
                            Tooltip(
                              message: AppLocalizations.of(context).created,
                              child: Row(
                                children: [
                                  PhosphorIcon(
                                    PhosphorIconsLight.plus,
                                    size: 12,
                                    color: colorScheme.outline,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    createdText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: colorScheme.outline,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                      final isDesktop = constraints.maxWidth > 400;
                      if (isDesktop) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  fileName,
                                  edit,
                                ],
                              ),
                            ),
                            const SizedBox(width: 32),
                            info,
                            const SizedBox(width: 32),
                            actions,
                          ],
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  fileName,
                                  const SizedBox(height: 8),
                                  info,
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            edit,
                            actions,
                          ],
                        );
                      }
                    });
                  }),
                )),
          )),
          const SizedBox(width: 16),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (entity is AppDocumentFile)
                  IconButton(
                    onPressed: () {
                      try {
                        final data =
                            utf8.decode((entity as AppDocumentFile).data);
                        showDialog(
                            context: context,
                            builder: (context) => ExportDialog(data: data));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context).error,
                            ),
                          ),
                        );
                      }
                    },
                    icon:
                        const PhosphorIcon(PhosphorIconsLight.paperPlaneRight),
                    tooltip: AppLocalizations.of(context).export,
                  ),
                Builder(builder: (context) {
                  return IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.trash),
                    highlightColor: colorScheme.error.withOpacity(0.2),
                    tooltip: AppLocalizations.of(context).delete,
                    onPressed: () {
                      showPopover(
                        backgroundColor: colorScheme.inverseSurface,
                        context: context,
                        bodyBuilder: (ctx) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context).areYouSure,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: colorScheme.onInverseSurface,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const PhosphorIcon(
                                        PhosphorIconsLight.x),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      fileSystem
                                          .deleteAsset(entity.location.path);
                                      onReload();
                                    },
                                    child: const PhosphorIcon(
                                        PhosphorIconsLight.check),
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
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
    if (entity is AppDocumentDirectory) {
      return DragTarget<String>(
        builder: (context, candidateData, rejectedData) {
          return draggable;
        },
        onWillAccept: (data) {
          return data != entity.location.path;
        },
        onAccept: (data) async {
          await fileSystem.moveAsset(
              data, '${entity.location.path}/${data.split('/').last}');
          onReload();
        },
      );
    }
    return draggable;
  }
}

class _QuickstartHomeView extends StatelessWidget {
  final RemoteStorage? remote;
  const _QuickstartHomeView({this.remote});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final templateFileSystem = TemplateFileSystem.fromPlatform(remote: remote);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            AppLocalizations.of(context).quickstart,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<DocumentTemplate>>(
              future: templateFileSystem
                  .createDefault(context)
                  .then((value) => templateFileSystem.getTemplates()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                }
                final templates = snapshot.data ?? [];
                return Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 16,
                  spacing: 16,
                  children: templates
                      .map(
                        (e) => FutureBuilder<List<int>>(
                            future: e.document.getThumbnailData(),
                            builder: (context, snapshot) => ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxHeight: 200),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Card(
                                      elevation: 5,
                                      clipBehavior: Clip.hardEdge,
                                      child: InkWell(
                                        onTap: () => GoRouter.of(context)
                                            .pushNamed('new',
                                                queryParams: {
                                                  'path': e.directory
                                                },
                                                extra: e.document),
                                        child: Stack(
                                          children: [
                                            if (snapshot.data?.isNotEmpty ??
                                                false)
                                              Align(
                                                child: Image.memory(
                                                  Uint8List.fromList(
                                                      snapshot.data!),
                                                  fit: BoxFit.cover,
                                                  width: 640,
                                                  alignment: Alignment.center,
                                                ),
                                              ),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                margin: const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: colorScheme
                                                      .primaryContainer
                                                      .withAlpha(200),
                                                ),
                                                child: Text(
                                                  e.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        color: colorScheme
                                                            .onSurface,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                      )
                      .toList(),
                );
              }),
        ]),
      ),
    );
  }
}
