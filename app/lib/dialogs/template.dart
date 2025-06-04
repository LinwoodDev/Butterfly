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
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../bloc/document_bloc.dart';
import '../widgets/editable_list_tile.dart';
import 'delete.dart';

Future<void> _overrideTools(
  TemplateFileSystem templateSystem,
  DocumentBloc bloc,
  List<NoteData> templates,
) async {
  final state = bloc.state;
  if (state is! DocumentLoaded) return;
  final tools = state.info.tools;
  for (var template in templates) {
    final info = template.getInfo();
    if (info == null) continue;
    template = template.setInfo(info.copyWith(tools: tools));
    await templateSystem.updateFile(template.name ?? '', template);
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
  Future<List<NoteData>>? _templatesFuture;
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
        var templates = (await _templateSystem.getFiles())
            .map((e) => e.data!)
            .toList();
        templates = templates
            .where(
              (element) =>
                  element.name?.toLowerCase().contains(
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
        IconButton(
          icon: const PhosphorIcon(PhosphorIconsLight.export),
          tooltip: AppLocalizations.of(context).export,
          onPressed: () async {
            final archive = Archive();
            for (final template in (await _templateSystem.getFiles())) {
              final data = template.data!.exportAsBytes();
              archive.addFile(
                ArchiveFile('${template.fileName}.bfly', data.length, data),
              );
            }
            final encoder = ZipEncoder();
            final bytes = encoder.encode(archive);
            await exportZip(context, bytes);
          },
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
      content: FutureBuilder<List<NoteData>>(
        future: _templatesFuture,
        builder: _buildBody,
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AsyncSnapshot<List<NoteData>> snapshot,
  ) {
    if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }
    if (!snapshot.hasData) {
      return const Center(child: CircularProgressIndicator());
    }
    var templates = snapshot.data!;
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
            var template = templates[index];
            return _TemplateItem(
              template: template,
              fileSystem: _templateSystem,
              bloc: widget.bloc,
              selected: _selectedTemplates.contains(template.name),
              onSelected: () {
                setState(() {
                  _selectedTemplates.add(template.name!);
                });
              },
              onUnselected: () {
                setState(() {
                  _selectedTemplates.remove(template.name);
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
                                            .map((e) => e.name!)
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
                                            templates.map((e) => e.name!),
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
                                                            element.name,
                                                          ),
                                                )
                                                .toList(),
                                          ).then(
                                            (value) => setState(
                                              () => _selectedTemplates.clear(),
                                            ),
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
                bloc.createTemplate(
                  _templateSystem.storage?.identifier,
                  name: name,
                  directory: directory,
                );
                Navigator.of(context).pop();
                load();
              },
            ),
          ],
        );
      },
    );
  }
}

class _TemplateItem extends StatelessWidget {
  final NoteData template;
  final TemplateFileSystem fileSystem;
  final DocumentBloc? bloc;
  final VoidCallback onChanged, onSelected, onUnselected;
  final bool selected;

  const _TemplateItem({
    required this.template,
    required this.fileSystem,
    required this.onChanged,
    required this.selected,
    this.bloc,
    required this.onSelected,
    required this.onUnselected,
  });

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    final settings = settingsCubit.state;
    final isDefault = settings.defaultTemplate == template.name;
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
        if (value == metadata.name) return;
        await fileSystem.deleteFile(metadata.name);
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
            final name = metadata.name;
            settingsCubit.changeDefaultTemplate(name);
            onChanged();
          },
        ),
        if (bloc != null)
          MenuItemButton(
            leadingIcon: const PhosphorIcon(PhosphorIconsLight.toolbox),
            child: Text(AppLocalizations.of(context).overrideTools),
            onPressed: () async {
              _overrideTools(fileSystem, bloc!, [template]);
            },
          ),
        MenuItemButton(
          leadingIcon: const PhosphorIcon(PhosphorIconsLight.copy),
          child: Text(AppLocalizations.of(context).duplicate),
          onPressed: () async {
            final result = await showDialog<String>(
              context: context,
              builder: (ctx) => NameDialog(
                value: template.name,
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
              await fileSystem.deleteFile(metadata.name);
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
