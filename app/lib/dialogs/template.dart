import 'package:archive/archive.dart';
import 'package:butterfly/actions/new.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly/widgets/connection_button.dart';
import 'package:butterfly/widgets/option_button.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../bloc/document_bloc.dart';
import '../widgets/editable_list_tile.dart';
import 'delete.dart';

Future<void> _overrideTools(
  TemplateFileSystem templateSystem,
  DocumentBloc bloc,
  List<FileSystemFile<NoteData>> templates,
) async {
  final state = bloc.state;
  if (state is! DocumentLoaded) return;
  final tools = state.info.tools;
  for (final template in templates) {
    var data = template.data!;
    final info = data.getInfo();
    if (info == null) continue;
    data = data.setInfo(info.copyWith(tools: tools));
    await templateSystem.updateFile(template.path, data);
  }
}

class TemplateDialog extends StatefulWidget {
  final DocumentBloc? bloc;
  const TemplateDialog({super.key, this.bloc});

  @override
  State<TemplateDialog> createState() => _TemplateDialogState();
}

class _TemplateDialogState extends State<TemplateDialog> {
  late TemplateFileSystem _templateSystem;
  late final ButterflyFileSystem _fileSystem;
  Future<List<FileSystemFile<NoteData>>>? _userTemplatesFuture;
  Future<List<NoteData>>? _coreTemplatesFuture;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _selectedTemplates = [];
  NoteData? _clickedTemplate;
  PatternBackground _selectedBackground = PatternBackground.light;

  @override
  void initState() {
    super.initState();
    _fileSystem = context.read<ButterflyFileSystem>();
    _templateSystem = _fileSystem.buildDefaultTemplateSystem();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final brightness = Theme.of(context).brightness;
      setState(() {
        _selectedBackground = brightness == Brightness.light
            ? PatternBackground.light
            : PatternBackground.dark;
      });
      load();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void load() {
    setState(() {
      _userTemplatesFuture = _templateSystem.initialize().then((value) async {
        return (await _templateSystem.getFiles()).toList();
      });
      if (context.mounted) {
        _coreTemplatesFuture = DocumentDefaults.getCoreTemplates(
          context,
          background: _selectedBackground,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.widthOf(context);
    final isMobile = width < LeapBreakpoints.medium;
    final detailsTemplate = _clickedTemplate;
    final bloc = widget.bloc;
    return ResponsiveAlertDialog(
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.expanded,
        maxHeight: 800,
      ),
      title: Text(AppLocalizations.of(context).templates),
      leading: IconButton.outlined(
        icon: const PhosphorIcon(PhosphorIconsLight.x),
        onPressed: () => Navigator.of(context).pop(),
        tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      ),
      headerActions: [
        ConnectionButton(
          currentRemote: _templateSystem.storage?.identifier ?? '',
          onChanged: (value) {
            _templateSystem = _fileSystem.buildTemplateSystem(value);
            load();
          },
        ),
        MenuAnchor(
          menuChildren: [
            MenuItemButton(
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.archive),
              child: Text(AppLocalizations.of(context).packagedFile),
              onPressed: () async {
                await _exportTemplates();
              },
            ),
            MenuItemButton(
              leadingIcon: const PhosphorIcon(
                PhosphorIconsLight.file,
                textDirection: TextDirection.ltr,
              ),
              child: Text(AppLocalizations.of(context).rawFile),
              onPressed: () async {
                await _exportTemplates(isTextBased: true);
              },
            ),
          ],
          builder: defaultMenuButton(
            icon: const PhosphorIcon(PhosphorIconsLight.export),
            tooltip: AppLocalizations.of(context).export,
          ),
        ),
        if (bloc != null)
          IconButton(
            icon: Icon(PhosphorIconsLight.plus),
            onPressed: () => _showCreateDialog(bloc),
            tooltip: LeapLocalizations.of(context).create,
          ),
      ],
      content: Row(
        children: [
          Expanded(
            flex: 2,
            child: FutureBuilder<List<dynamic>>(
              future: Future.wait([
                _userTemplatesFuture ??
                    Future.value(<FileSystemFile<NoteData>>[]),
                _coreTemplatesFuture ?? Future.value(<NoteData>[]),
              ]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final userTemplates =
                    snapshot.data![0] as List<FileSystemFile<NoteData>>;
                final coreTemplates = snapshot.data![1] as List<NoteData>;
                return BlocBuilder<SettingsCubit, ButterflySettings>(
                  buildWhen: (previous, current) =>
                      previous.favoriteTemplates != current.favoriteTemplates,
                  builder: (context, state) {
                    return _buildBody(
                      context,
                      userTemplates,
                      coreTemplates,
                      isMobile,
                      state.favoriteTemplates,
                    );
                  },
                );
              },
            ),
          ),
          if (!isMobile)
            Expanded(
              child: detailsTemplate == null
                  ? Card(
                      child: Center(
                        child: Text(AppLocalizations.of(context).noElements),
                      ),
                    )
                  : _TemplateDetailsView(
                      template: detailsTemplate,
                      onOpen: () {
                        openNewDocument(
                          context,
                          widget.bloc != null,
                          detailsTemplate,
                          _templateSystem.storage?.identifier,
                        );
                      },
                    ),
            ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    MapEntry<String?, List<FileSystemFile<NoteData>>> entry,
    int index,
    bool isMobile,
    List<FavoriteLocation> favoriteTemplates,
  ) {
    final template = entry.value[index];
    final isCore = entry.key == null;
    final location = FavoriteLocation(
      remote: isCore ? null : template.remote,
      path: template.pathWithoutLeadingSlash,
    );
    final starred = favoriteTemplates.contains(location);

    if (isMobile) {
      return _TemplateItem(
        file: template,
        fileSystem: _templateSystem,
        bloc: widget.bloc,
        key: ValueKey(template.path),
        selected: _selectedTemplates.contains(template.path),
        isCore: isCore,
        starred: starred,
        location: location,
        onSelected: () {
          setState(() {
            _selectedTemplates.add(template.path);
          });
        },
        onUnselected: () {
          setState(() {
            _selectedTemplates.remove(template.path);
          });
        },
        onChanged: () {
          load();
        },
        onTap: () {
          showLeapBottomSheet(
            context: context,
            titleBuilder: (context) => Text(template.data!.name ?? ''),
            leadingBuilder: (context) {
              final thumbnail = template.data!.getThumbnail();
              const fallback = PhosphorIcon(
                PhosphorIconsLight.file,
                textDirection: TextDirection.ltr,
                size: 48,
              );
              return thumbnail != null
                  ? AspectRatio(
                      aspectRatio: kThumbnailRatio,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          thumbnail,
                          fit: BoxFit.cover,
                          cacheHeight: kThumbnailWidth,
                          cacheWidth: kThumbnailHeight,
                        ),
                      ),
                    )
                  : fallback;
            },
            leadingWidth: 128,
            childrenBuilder: (context) => [
              const SizedBox(height: 8),
              _TemplateDetailsView(
                template: template.data!,
                scrollable: false,
                onOpen: () {
                  Navigator.of(context).pop();
                  openNewDocument(
                    context,
                    widget.bloc != null,
                    template.data!,
                    _templateSystem.storage?.identifier,
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      return _TemplateCard(
        file: template,
        fileSystem: _templateSystem,
        bloc: widget.bloc,
        key: ValueKey(template.path),
        selected: _selectedTemplates.contains(template.path),
        isActive: _clickedTemplate == template.data,
        isCore: entry.key == '',
        starred: starred,
        location: location,
        onSelected: () {
          setState(() {
            _selectedTemplates.add(template.path);
          });
        },
        onUnselected: () {
          setState(() {
            _selectedTemplates.remove(template.path);
          });
        },
        onChanged: () {
          load();
        },
        onTap: () {
          setState(() {
            _clickedTemplate = template.data;
          });
        },
      );
    }
  }

  Widget _buildBody(
    BuildContext context,
    List<FileSystemFile<NoteData>> userTemplates,
    List<NoteData> coreTemplates,
    bool isMobile,
    List<FavoriteLocation> favoriteTemplates,
  ) {
    final filteredUserTemplates = userTemplates
        .where(
          (element) =>
              element.data!.name?.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ) ??
              true,
        )
        .toList();
    final filteredCoreTemplates = coreTemplates
        .where(
          (element) =>
              element.name?.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              ) ??
              true,
        )
        .toList();
    final everythingSelected =
        _selectedTemplates.length == filteredUserTemplates.length;
    final groupedTemplates = filteredUserTemplates
        .groupListsBy<String?>((element) {
          final parent = element.parent;
          if (parent == '/' || parent == '.') return '/';
          return parent;
        })
        .entries
        .toList();
    groupedTemplates.sort((a, b) {
      final aKey = a.key;
      final bKey = b.key;
      if (aKey == null) return -1;
      if (bKey == null) return 1;
      return aKey.compareTo(bKey);
    });
    if (filteredCoreTemplates.isNotEmpty) {
      groupedTemplates.add(
        MapEntry(
          null,
          filteredCoreTemplates
              .map(
                (e) =>
                    FileSystemFile(AssetLocation.local(e.name ?? ''), data: e),
              )
              .toList(),
        ),
      );
    }
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        CustomScrollView(
          slivers: [
            const SliverPadding(padding: EdgeInsets.only(top: 64)),
            for (final entry in groupedTemplates) ...[
              if (entry.key == null || entry.key != '/')
                SliverToBoxAdapter(child: _buildHeader(context, entry.key)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: isMobile
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _buildItem(
                            context,
                            entry,
                            index,
                            isMobile,
                            favoriteTemplates,
                          ),
                          childCount: entry.value.length,
                        ),
                      )
                    : SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 1.1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _buildItem(
                            context,
                            entry,
                            index,
                            isMobile,
                            favoriteTemplates,
                          ),
                          childCount: entry.value.length,
                        ),
                      ),
              ),
            ],
            const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SearchBar(
            leading: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
            constraints: const BoxConstraints(maxWidth: 500, minHeight: 50),
            controller: _searchController,
            hintText: AppLocalizations.of(context).search,
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                child: _selectedTemplates.isEmpty
                    ? SizedBox()
                    : Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const PhosphorIcon(
                                      PhosphorIconsLight.selectionInverse,
                                    ),
                                    tooltip: AppLocalizations.of(
                                      context,
                                    ).invertSelection,
                                    onPressed: () {
                                      setState(() {
                                        final inverted = filteredUserTemplates
                                            .map((e) => e.path)
                                            .toSet()
                                            .difference(
                                              _selectedTemplates.toSet(),
                                            );
                                        _selectedTemplates.clear();
                                        _selectedTemplates.addAll(inverted);
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: PhosphorIcon(
                                      everythingSelected
                                          ? PhosphorIconsLight.selectionSlash
                                          : PhosphorIconsLight.selectionAll,
                                    ),
                                    tooltip: everythingSelected
                                        ? AppLocalizations.of(context).deselect
                                        : AppLocalizations.of(
                                            context,
                                          ).selectAll,
                                    onPressed: () {
                                      setState(() {
                                        _selectedTemplates.clear();
                                        if (!everythingSelected) {
                                          _selectedTemplates.addAll(
                                            filteredUserTemplates.map(
                                              (e) => e.path,
                                            ),
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  if (widget.bloc != null)
                                    IconButton(
                                      icon: const PhosphorIcon(
                                        PhosphorIconsLight.wrench,
                                      ),
                                      tooltip: AppLocalizations.of(
                                        context,
                                      ).overrideTools,
                                      onPressed: () =>
                                          _overrideTools(
                                            _templateSystem,
                                            widget.bloc!,
                                            filteredUserTemplates
                                                .where(
                                                  (element) =>
                                                      _selectedTemplates
                                                          .contains(
                                                            element.path,
                                                          ),
                                                )
                                                .toList(),
                                          ).then(
                                            (value) => setState(
                                              () => _selectedTemplates.clear(),
                                            ),
                                          ),
                                    ),
                                  MenuAnchor(
                                    menuChildren: [
                                      MenuItemButton(
                                        leadingIcon: const PhosphorIcon(
                                          PhosphorIconsLight.archive,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          ).packagedFile,
                                        ),
                                        onPressed: () async {
                                          await _exportTemplates(
                                            useSelected: true,
                                          );
                                        },
                                      ),
                                      MenuItemButton(
                                        leadingIcon: const PhosphorIcon(
                                          PhosphorIconsLight.file,
                                          textDirection: TextDirection.ltr,
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context).rawFile,
                                        ),
                                        onPressed: () async {
                                          await _exportTemplates(
                                            useSelected: true,
                                            isTextBased: true,
                                          );
                                        },
                                      ),
                                    ],
                                    builder: defaultMenuButton(
                                      icon: const PhosphorIcon(
                                        PhosphorIconsLight.export,
                                      ),
                                      tooltip: AppLocalizations.of(
                                        context,
                                      ).export,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const PhosphorIcon(
                                      PhosphorIconsLight.trash,
                                    ),
                                    tooltip: AppLocalizations.of(
                                      context,
                                    ).delete,
                                    onPressed: () async {
                                      final result = await showDialog<bool>(
                                        context: context,
                                        builder: (ctx) => const DeleteDialog(),
                                      );
                                      if (result != true) return;
                                      for (final template
                                          in _selectedTemplates) {
                                        await _templateSystem.deleteFile(
                                          template,
                                        );
                                      }
                                      _selectedTemplates.clear();
                                      load();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, String? title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title ?? 'Core',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),

          IconButton(
            icon: Icon(
              _selectedBackground == PatternBackground.light
                  ? PhosphorIconsLight.sun
                  : PhosphorIconsLight.moon,
            ),
            onPressed: () {
              setState(() {
                _selectedBackground =
                    _selectedBackground == PatternBackground.light
                    ? PatternBackground.dark
                    : PatternBackground.light;
                load();
              });
            },
            tooltip: AppLocalizations.of(context).background,
          ),
        ],
      ),
    );
  }

  Future<void> _showCreateDialog(DocumentBloc bloc) {
    final state = bloc.state;
    var initialName = '';
    if (state is DocumentLoaded) {
      initialName = state.metadata.name;
    }
    String name = initialName, directory = '';
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context).createTemplate),
          scrollable: true,
          content: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context).createTemplateContent),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: name,
                  onChanged: (e) => name = e,
                  decoration: InputDecoration(
                    labelText: LeapLocalizations.of(context).name,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  initialValue: directory,
                  onChanged: (e) => directory = e,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).directory,
                    filled: true,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text(LeapLocalizations.of(context).create),
              onPressed: () async {
                Navigator.of(context).pop();
                await bloc.createTemplate(
                  _templateSystem.storage?.identifier,
                  name: name,
                  directory: directory,
                );
                load();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _exportTemplates({
    bool useSelected = false,
    bool isTextBased = false,
  }) async {
    final archive = Archive();
    final files = (await _templateSystem.getFiles()).where((element) {
      if (useSelected) {
        return _selectedTemplates.contains(element.path);
      }
      return true;
    }).toList();
    for (final template in files) {
      final data = template.data!.toFile(isTextBased: isTextBased).data;
      archive.addFile(
        ArchiveFile(
          '${template.fileNameWithoutExtension}.${isTextBased ? 'tbfly' : 'bfly'}',
          data.length,
          data,
        ),
      );
    }
    final encoder = ZipEncoder();
    final bytes = encoder.encodeBytes(archive);
    await exportZip(context, bytes);
  }
}

class _TemplateDetailsView extends StatelessWidget {
  final NoteData template;
  final VoidCallback? onOpen;
  final bool scrollable;

  const _TemplateDetailsView({
    required this.template,
    this.onOpen,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final metadata =
        template.getMetadata() ?? FileMetadata(type: NoteFileType.template);
    final info = template.getInfo();
    final thumbnail = template.getThumbnail();
    const fallback = PhosphorIcon(
      PhosphorIconsLight.file,
      textDirection: TextDirection.ltr,
      size: 48,
    );
    final thumbnailWidget = thumbnail != null
        ? AspectRatio(
            aspectRatio: kThumbnailRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                thumbnail,
                fit: BoxFit.cover,
                cacheHeight: kThumbnailWidth,
                cacheWidth: kThumbnailHeight,
              ),
            ),
          )
        : fallback;

    final details = [
      if (metadata.description.isNotEmpty)
        ListTile(
          title: Text(AppLocalizations.of(context).description),
          subtitle: Text(metadata.description),
        ),
      if (metadata.directory.isNotEmpty)
        ListTile(
          title: Text(AppLocalizations.of(context).directory),
          subtitle: Text(metadata.directory),
        ),
      ListTile(
        title: Text(AppLocalizations.of(context).tools),
        subtitle: Wrap(
          alignment: WrapAlignment.center,
          children: [
            for (final tool in info?.tools ?? <Tool>[])
              SizedBox.square(
                dimension: 64,
                child: OptionButton(
                  icon: Icon(tool.icon(PhosphorIconsStyle.light)),
                  tooltip: tool.name,
                ),
              ),
          ],
        ),
      ),
    ];

    if (!scrollable) {
      return Column(
        children: [
          Card.filled(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(children: details),
            ),
          ),
          if (onOpen != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onOpen,
                  child: Text(LeapLocalizations.of(context).create),
                ),
              ),
            ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: thumbnailWidget,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      metadata.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    ...details,
                  ],
                ),
              ),
            ),
            if (onOpen != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: onOpen,
                    child: Text(LeapLocalizations.of(context).create),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TemplateItem extends StatelessWidget {
  final FileSystemFile<NoteData> file;
  final TemplateFileSystem fileSystem;
  final DocumentBloc? bloc;
  final VoidCallback onChanged, onSelected, onUnselected;
  final bool selected;
  final VoidCallback? onTap;
  final bool isCore;
  final bool starred;
  final FavoriteLocation location;

  const _TemplateItem({
    required this.file,
    required this.fileSystem,
    required this.onChanged,
    required this.selected,
    this.bloc,
    super.key,
    required this.onSelected,
    required this.onUnselected,
    this.onTap,
    this.isCore = false,
    required this.starred,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    final settings = settingsCubit.state;
    final template = file.data!;
    final path = file.pathWithoutLeadingSlash;
    final isDefault = settings.defaultTemplate == path;
    final metadata = template.getMetadata();
    if (metadata == null) {
      return const SizedBox();
    }
    final thumbnail = template.getThumbnail();
    const fallback = PhosphorIcon(
      PhosphorIconsLight.file,
      textDirection: TextDirection.ltr,
      size: 48,
    );
    final leading = thumbnail != null
        ? AspectRatio(
            aspectRatio: kThumbnailRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                thumbnail,
                fit: BoxFit.cover,
                cacheHeight: kThumbnailWidth,
                cacheWidth: kThumbnailHeight,
              ),
            ),
          )
        : fallback;
    return EditableListTile(
      showEditIcon: !isCore,
      initialValue: metadata.name,
      subtitle: Text(metadata.description),
      leading: SizedBox(
        width: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!isCore)
              Checkbox(
                value: selected,
                onChanged: (value) {
                  if (value == true) {
                    onSelected();
                  } else {
                    onUnselected();
                  }
                },
              )
            else
              const SizedBox(width: 48),
            IconButton(
              icon: Icon(PhosphorIconsLight.star),
              selectedIcon: Icon(PhosphorIconsFill.star),
              isSelected: starred,
              onPressed: () {
                settingsCubit.toggleFavoriteTemplate(location);
              },
            ),
            const SizedBox(width: 2),
            Flexible(child: leading),
          ],
        ),
      ),
      onSaved: isCore
          ? null
          : (value) async {
              if (value == path) return;
              await fileSystem.deleteFile(path);
              await fileSystem.createFile(
                value,
                template.setMetadata(metadata.copyWith(name: value)),
              );
              onChanged();
            },
      actions: [
        if (!isCore)
          CheckboxMenuButton(
            value: isDefault,
            child: Text(AppLocalizations.of(context).defaultTemplate),
            onChanged: (value) async {
              settingsCubit.changeDefaultTemplate(path);
              onChanged();
            },
          ),
        if (bloc != null && !isCore)
          MenuItemButton(
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.toolbox),
            child: Text(AppLocalizations.of(context).overrideTools),
            onPressed: () async {
              _overrideTools(fileSystem, bloc!, [file]);
            },
          ),
        MenuItemButton(
          leadingIcon: const PhosphorIcon(PhosphorIconsLight.copy),
          child: Text(AppLocalizations.of(context).duplicate),
          onPressed: () async {
            final result = await showDialog<String>(
              context: context,
              builder: (ctx) => NameDialog(
                value: file.fileNameWithoutExtension,
                validator: defaultFileNameValidator(context),
              ),
            );
            if (result == null) return;
            if (context.mounted) {
              await fileSystem.createFileWithName(
                template.setMetadata(metadata.copyWith(name: result)),
                name: result,
              );
              onChanged();
            }
          },
        ),
        if (!isCore)
          SubmenuButton(
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.download),
            menuChildren: [
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.archive),
                child: Text(AppLocalizations.of(context).packagedFile),
                onPressed: () async {
                  await exportData(context, file.data!, isTextBased: false);
                },
              ),
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.file),
                child: Text(AppLocalizations.of(context).rawFile),
                onPressed: () async {
                  await exportData(context, file.data!, isTextBased: true);
                },
              ),
            ],
            child: Text(AppLocalizations.of(context).export),
          ),
        if (!isCore)
          MenuItemButton(
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.trash),
            child: Text(AppLocalizations.of(context).delete),
            onPressed: () async {
              final result = await showDialog<bool>(
                context: context,
                builder: (ctx) => const DeleteDialog(),
              );
              if (result != true) return;
              if (context.mounted) {
                await fileSystem.deleteFile(path);
                onChanged();
              }
            },
          ),
      ],
      onTap:
          onTap ??
          () => openNewDocument(
            context,
            bloc != null,
            template,
            fileSystem.storage?.identifier,
          ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final FileSystemFile<NoteData> file;
  final TemplateFileSystem fileSystem;
  final DocumentBloc? bloc;
  final VoidCallback onChanged, onSelected, onUnselected;
  final bool selected;
  final VoidCallback? onTap;
  final bool isActive;
  final bool isCore;
  final bool starred;
  final FavoriteLocation location;

  const _TemplateCard({
    required this.file,
    required this.fileSystem,
    required this.onChanged,
    required this.selected,
    this.bloc,
    super.key,
    required this.onSelected,
    required this.onUnselected,
    this.onTap,
    this.isActive = false,
    this.isCore = false,
    required this.starred,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    final settings = settingsCubit.state;
    final template = file.data!;
    final path = file.pathWithoutLeadingSlash;
    final isDefault = settings.defaultTemplate == path;
    final metadata = template.getMetadata();
    if (metadata == null) {
      return const SizedBox();
    }
    final thumbnail = template.getThumbnail();
    const fallback = PhosphorIcon(
      PhosphorIconsLight.file,
      textDirection: TextDirection.ltr,
      size: 48,
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isActive
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap:
            onTap ??
            () => openNewDocument(
              context,
              bloc != null,
              template,
              fileSystem.storage?.identifier,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: kThumbnailRatio,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  thumbnail != null
                      ? Image.memory(
                          thumbnail,
                          fit: BoxFit.cover,
                          cacheHeight: kThumbnailWidth,
                          cacheWidth: kThumbnailHeight,
                        )
                      : Center(child: fallback),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton.filledTonal(
                      icon: Icon(PhosphorIconsLight.star),
                      selectedIcon: Icon(PhosphorIconsFill.star),
                      isSelected: starred,
                      onPressed: () {
                        settingsCubit.toggleFavoriteTemplate(location);
                      },
                    ),
                  ),
                  if (!isCore)
                    Positioned(
                      top: 4,
                      left: 4,
                      child: Checkbox(
                        value: selected,
                        onChanged: (value) {
                          if (value == true) {
                            onSelected();
                          } else {
                            onUnselected();
                          }
                        },
                      ),
                    ),
                  if (isDefault)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Icon(PhosphorIconsLight.star, size: 16),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            metadata.name,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (metadata.description.isNotEmpty)
                            Text(
                              metadata.description,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    MenuAnchor(
                      builder: (context, controller, child) {
                        return IconButton(
                          icon: const Icon(
                            PhosphorIconsLight.dotsThreeVertical,
                          ),
                          onPressed: () {
                            if (controller.isOpen) {
                              controller.close();
                            } else {
                              controller.open();
                            }
                          },
                        );
                      },
                      menuChildren: [
                        if (!isCore)
                          CheckboxMenuButton(
                            value: isDefault,
                            child: Text(
                              AppLocalizations.of(context).defaultTemplate,
                            ),
                            onChanged: (value) async {
                              settingsCubit.changeDefaultTemplate(path);
                              onChanged();
                            },
                          ),
                        if (bloc != null && !isCore)
                          MenuItemButton(
                            leadingIcon: const PhosphorIcon(
                              PhosphorIconsLight.toolbox,
                            ),
                            child: Text(
                              AppLocalizations.of(context).overrideTools,
                            ),
                            onPressed: () async {
                              _overrideTools(fileSystem, bloc!, [file]);
                            },
                          ),
                        MenuItemButton(
                          leadingIcon: const PhosphorIcon(
                            PhosphorIconsLight.copy,
                          ),
                          child: Text(AppLocalizations.of(context).duplicate),
                          onPressed: () async {
                            final result = await showDialog<String>(
                              context: context,
                              builder: (ctx) => NameDialog(
                                value: file.fileNameWithoutExtension,
                                validator: defaultFileNameValidator(context),
                              ),
                            );
                            if (result == null) return;
                            if (context.mounted) {
                              await fileSystem.createFileWithName(
                                template.setMetadata(
                                  metadata.copyWith(name: result),
                                ),
                                name: result,
                              );
                              onChanged();
                            }
                          },
                        ),
                        if (!isCore)
                          SubmenuButton(
                            leadingIcon: const PhosphorIcon(
                              PhosphorIconsLight.download,
                            ),
                            menuChildren: [
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.archive,
                                ),
                                child: Text(
                                  AppLocalizations.of(context).packagedFile,
                                ),
                                onPressed: () async {
                                  await exportData(
                                    context,
                                    file.data!,
                                    isTextBased: false,
                                  );
                                },
                              ),
                              MenuItemButton(
                                leadingIcon: const PhosphorIcon(
                                  PhosphorIconsLight.file,
                                ),
                                child: Text(
                                  AppLocalizations.of(context).rawFile,
                                ),
                                onPressed: () async {
                                  await exportData(
                                    context,
                                    file.data!,
                                    isTextBased: true,
                                  );
                                },
                              ),
                            ],
                            child: Text(AppLocalizations.of(context).export),
                          ),
                        if (!isCore)
                          MenuItemButton(
                            leadingIcon: const PhosphorIcon(
                              PhosphorIconsLight.trash,
                            ),
                            child: Text(AppLocalizations.of(context).delete),
                            onPressed: () async {
                              final result = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => const DeleteDialog(),
                              );
                              if (result != true) return;
                              if (context.mounted) {
                                await fileSystem.deleteFile(path);
                                onChanged();
                              }
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
