import 'dart:convert';

import 'package:butterfly/actions/settings.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/export.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly/helpers/element_helper.dart';
import 'package:butterfly/views/window.dart';
import 'package:butterfly/visualizer/asset.dart';
import 'package:butterfly/visualizer/string.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:popover/popover.dart';
import 'package:window_manager/window_manager.dart';

import '../api/open_release_notes.dart';
import '../dialogs/file_system/move.dart';

class HomePage extends StatelessWidget {
  final String? selectedAsset;

  const HomePage({super.key, this.selectedAsset});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (!kIsWeb && isWindow)
          ? PreferredSize(
              preferredSize: Size.fromHeight(
                  Theme.of(context).appBarTheme.toolbarHeight ?? 56),
              child: DragToMoveArea(
                child: AppBar(actions: const [
                  WindowButtons(),
                ]),
              ),
            )
          : null,
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
                              child:
                                  _FilesHomeView(selectedAsset: selectedAsset)),
                          const SizedBox(width: 32),
                          const SizedBox(
                              width: 500, child: _QuickstartHomeView()),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          const _QuickstartHomeView(),
                          const SizedBox(height: 32),
                          _FilesHomeView(selectedAsset: selectedAsset),
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
            icon: const Icon(PhosphorIcons.bookOpenLight),
            label: Text(AppLocalizations.of(context).documentation),
          ),
          IconButton(
            onPressed: () => openSettings(context),
            icon: const Icon(PhosphorIcons.gearLight),
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
                        child: Icon(PhosphorIcons.caretUpLight),
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
                  'Hey, this is Linwood Butterfly',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colorScheme.onInverseSurface,
                      ),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  'A free and open-source drawing space!',
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
  final String? selectedAsset;
  const _FilesHomeView({this.selectedAsset});

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

  String getLocalizedNameOfSortBy(_SortBy sortBy) {
    return sortBy.name.toDisplayString();
  }

  void _setFilesFuture() {
    _fileSystem = DocumentFileSystem.fromPlatform(remote: _remote);
    _filesFuture = _fileSystem.getAsset(_locationController.text);
  }

  void _reloadFileSystem() {
    setState(_setFilesFuture);
  }

  @override
  Widget build(BuildContext context) {
    final index = _locationController.text.lastIndexOf('/');
    final parent = _locationController.text.substring(0, index < 0 ? 0 : index);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(
        children: [
          Text(
            AppLocalizations.of(context).files,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.start,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
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
                    ? const Icon(PhosphorIcons.listLight)
                    : const Icon(PhosphorIcons.gridFourLight),
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
                        return DropdownButtonFormField<RemoteStorage?>(
                          items: [
                            DropdownMenuItem(
                              value: null,
                              child: Text(AppLocalizations.of(context).local),
                            ),
                            ...state.remotes
                                .map((e) => DropdownMenuItem(
                                      value: e,
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
                            ...state.remotes.map((e) => Text(e.uri.host,
                                overflow: TextOverflow.ellipsis))
                          ],
                          borderRadius: BorderRadius.circular(16),
                          value: _remote,
                          onChanged: (value) => setState(() {
                            _remote = value;
                            _setFilesFuture();
                          }),
                        );
                      }),
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
          ),
        ],
      ),
      const SizedBox(height: 16),
      LayoutBuilder(builder: (context, constraints) {
        final searchBar = TextFormField(
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context).search,
            prefixIcon: const Icon(PhosphorIcons.magnifyingGlassLight),
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
                  leadingIcon: const Icon(PhosphorIcons.folderLight),
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
                  leadingIcon: const Icon(PhosphorIcons.fileLight),
                  child: Text(AppLocalizations.of(context).newFile),
                ),
              ],
              builder: (context, controller, child) =>
                  FloatingActionButton.small(
                onPressed: () =>
                    controller.isOpen ? controller.close() : controller.open(),
                tooltip: AppLocalizations.of(context).create,
                child: const Icon(PhosphorIcons.plusLight),
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
                icon: const Icon(PhosphorIcons.arrowUpLight),
                tooltip: AppLocalizations.of(context).goUp,
              ),
              onWillAccept: (data) => true,
              onAccept: (data) {
                _fileSystem.moveAsset(data, '$parent/${data.split('/').last}');
                _reloadFileSystem();
              },
            ),
            const SizedBox(width: 8),
            Flexible(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).location,
                  prefixIcon: const Icon(PhosphorIcons.folderLight),
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
                    widget.selectedAsset == entity.pathWithLeadingSlash;
                return _FileEntityListTile(
                  entity: entity,
                  selected: selected,
                  onTap: () {
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
                      final uri = Uri(pathSegments: [
                        '',
                        'remote',
                        Uri.encodeComponent(location.remote),
                        ...location.pathWithoutLeadingSlash
                            .split('/')
                            .map((e) => Uri.encodeComponent(e)),
                      ]).toString();

                      GoRouter.of(context).push(uri);
                      return;
                    }
                    GoRouter.of(context).push(Uri(
                      pathSegments: [
                        '',
                        'local',
                        ...location.pathWithoutLeadingSlash
                            .split('/')
                            .map((e) => Uri.encodeComponent(e)),
                      ],
                    ).toString());
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
    DocumentInfo? info;
    String? modifiedText;
    IconData icon = PhosphorIcons.folderLight;
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
            : '';
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
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
                                      onSubmitted: (value) {
                                        fileSystem.renameAsset(
                                            entity.location.path,
                                            '${entity.parent}/$value');
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
                                  icon: const Icon(PhosphorIcons.pencilLight),
                                  tooltip: AppLocalizations.of(context).rename,
                                ),
                              ],
                            );
                      final actions = Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocBuilder<SettingsCubit, ButterflySettings>(
                              builder: (context, state) {
                            final starred = state.isStarred(entity.location);
                            return IconButton(
                              onPressed: () {
                                settingsCubit.toggleStarred(entity.location);
                                onReload();
                              },
                              icon: starred
                                  ? const Icon(PhosphorIcons.starFill)
                                  : const Icon(PhosphorIcons.starLight),
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
                            icon: const Icon(PhosphorIcons.arrowsDownUpLight),
                          ),
                        ],
                      );
                      final modified = Text(
                        modifiedText ?? '',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.outline,
                            ),
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
                            modified,
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
                                  modified,
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
                    onPressed: () => showDialog(
                        context: context,
                        builder: (context) => ExportDialog(
                            data:
                                utf8.decode((entity as AppDocumentFile).data))),
                    icon: const Icon(PhosphorIcons.paperPlaneRightLight),
                    tooltip: AppLocalizations.of(context).export,
                  ),
                Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(PhosphorIcons.trashLight),
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
                                    child: const Icon(PhosphorIcons.xLight),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      fileSystem
                                          .deleteAsset(entity.location.path);
                                      onReload();
                                    },
                                    child: const Icon(PhosphorIcons.checkLight),
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
        onAccept: (data) {
          fileSystem.moveAsset(
              data, '${entity.location.path}/${data.split('/').last}');
          onReload();
        },
      );
    }
    return draggable;
  }
}

class _QuickstartHomeView extends StatelessWidget {
  const _QuickstartHomeView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final templateFileSystem = context.read<TemplateFileSystem>();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            'Quickstart',
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
