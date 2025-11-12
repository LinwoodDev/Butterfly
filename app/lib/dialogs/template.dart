import 'package:archive/archive.dart';
import 'package:butterfly/actions/new.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/visualizer/tool.dart';
import 'package:butterfly/widgets/connection_button.dart';
import 'package:butterfly/widgets/option_button.dart';
import 'package:butterfly_api/butterfly_api.dart';
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
  Future<List<FileSystemFile<NoteData>>>? _templatesFuture;
  final TextEditingController _searchController = TextEditingController();
  final List<String> _selectedTemplates = [];

  @override
  void initState() {
    super.initState();
    _fileSystem = context.read<ButterflyFileSystem>();
    _templateSystem = _fileSystem.buildDefaultTemplateSystem();
    WidgetsBinding.instance.addPostFrameCallback((_) => load());
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void load() {
    setState(() {
      _templatesFuture = _templateSystem.initialize().then((value) async {
        var templates = (await _templateSystem.getFiles()).toList();
        templates = templates
            .where(
              (element) =>
                  element.data!.name?.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ) ??
                  true,
            )
            .toList();
        return templates;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
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
              leadingIcon: const PhosphorIcon(PhosphorIconsLight.file),
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
        IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.clockCounterClockwise),
          tooltip: AppLocalizations.of(context).defaultTemplate,
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(AppLocalizations.of(context).defaultTemplate),
                content: Text(AppLocalizations.of(context).reallyReset),
                actions: [
                  TextButton(
                    child: Text(
                      MaterialLocalizations.of(context).cancelButtonLabel,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  ElevatedButton(
                    child: Text(
                      MaterialLocalizations.of(context).okButtonLabel,
                    ),
                    onPressed: () async {
                      for (final template in await _templateSystem.getKeys()) {
                        _templateSystem.deleteFile(template);
                      }
                      if (context.mounted) {
                        await _templateSystem.initialize(force: true);
                      }
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        load();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
      content: FutureBuilder<List<FileSystemFile<NoteData>>>(
        future: _templatesFuture,
        builder: _buildBody,
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AsyncSnapshot<List<FileSystemFile<NoteData>>> snapshot,
  ) {
    if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }
    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }
    final templates = snapshot.data!;
    final everythingSelected = _selectedTemplates.length == templates.length;
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ListView.builder(
          itemCount: templates.length,
          padding: const EdgeInsets.only(
            top: 64,
            bottom: 32,
            left: 8,
            right: 8,
          ),
          itemBuilder: (context, index) {
            final template = templates[index];
            final path = template.path;
            return _TemplateItem(
              file: template,
              fileSystem: _templateSystem,
              bloc: widget.bloc,
              key: ValueKey(path),
              selected: _selectedTemplates.contains(path),
              onSelected: () {
                setState(() {
                  _selectedTemplates.add(path);
                });
              },
              onUnselected: () {
                setState(() {
                  _selectedTemplates.remove(path);
                });
              },
              onChanged: () {
                load();
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SearchBar(
            leading: const PhosphorIcon(PhosphorIconsLight.magnifyingGlass),
            constraints: const BoxConstraints(maxWidth: 500, minHeight: 50),
            controller: _searchController,
            hintText: AppLocalizations.of(context).search,
            onChanged: (value) async {
              load();
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
                    ? widget.bloc == null
                          ? SizedBox()
                          : FloatingActionButton.extended(
                              onPressed: () => _showCreateDialog(widget.bloc!),
                              label: Text(LeapLocalizations.of(context).create),
                              icon: const PhosphorIcon(
                                PhosphorIconsLight.floppyDisk,
                              ),
                            )
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
                                        final inverted = templates
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
                                            templates.map((e) => e.path),
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
                                            templates
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

class _TemplateItem extends StatelessWidget {
  final FileSystemFile<NoteData> file;
  final TemplateFileSystem fileSystem;
  final DocumentBloc? bloc;
  final VoidCallback onChanged, onSelected, onUnselected;
  final bool selected;

  const _TemplateItem({
    required this.file,
    required this.fileSystem,
    required this.onChanged,
    required this.selected,
    this.bloc,
    super.key,
    required this.onSelected,
    required this.onUnselected,
  });

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    final settings = settingsCubit.state;
    final template = file.data!;
    final path = file.pathWithoutLeadingSlash;
    final isDefault = settings.defaultTemplate == path;
    final metadata = template.getMetadata();
    final info = template.getInfo();
    if (metadata == null) {
      return const SizedBox();
    }
    final thumbnail = template.getThumbnail();
    const fallback = PhosphorIcon(PhosphorIconsLight.file, size: 48);
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
      initialValue: metadata.name,
      subtitle: Text(metadata.description),
      leading: SizedBox(
        width: 112,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: selected,
              onChanged: (value) {
                if (value == true) {
                  onSelected();
                } else {
                  onUnselected();
                }
              },
            ),
            const SizedBox(width: 2),
            Flexible(child: leading),
          ],
        ),
      ),
      onSaved: (value) async {
        if (value == path) return;
        await fileSystem.deleteFile(path);
        await fileSystem.createFile(
          value,
          template.setMetadata(metadata.copyWith(name: value)),
        );
        onChanged();
      },
      actions: [
        CheckboxMenuButton(
          value: isDefault,
          child: Text(AppLocalizations.of(context).defaultTemplate),
          onChanged: (value) async {
            settingsCubit.changeDefaultTemplate(path);
            onChanged();
          },
        ),
        if (bloc != null)
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
        MenuItemButton(
          leadingIcon: const PhosphorIcon(PhosphorIconsLight.info),
          child: Text(AppLocalizations.of(context).information),
          onPressed: () async {
            showLeapBottomSheet(
              context: context,
              titleBuilder: (context) => Text(metadata.name),
              leadingBuilder: (context) => Center(child: leading),
              leadingWidth: 128,
              childrenBuilder: (context) => [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card.filled(
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Column(
                        children: [
                          if (metadata.description.isNotEmpty)
                            ListTile(
                              title: Text(
                                AppLocalizations.of(context).description,
                              ),
                              subtitle: Text(metadata.description),
                            ),
                          if (metadata.directory.isNotEmpty)
                            ListTile(
                              title: Text(
                                AppLocalizations.of(context).directory,
                              ),
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
                                      icon: Icon(
                                        tool.icon(PhosphorIconsStyle.light),
                                      ),
                                      tooltip: tool.name,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
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
      onTap: () => openNewDocument(
        context,
        bloc != null,
        template,
        fileSystem.storage?.identifier,
      ),
    );
  }
}
