import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/dialogs/import/confirmation.dart';
import 'package:butterfly/dialogs/packs/bundled.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/save.dart';
import '../../widgets/connection_button.dart';
import 'pack.dart';

class PacksDialog extends StatefulWidget {
  final bool globalOnly;
  const PacksDialog({super.key, this.globalOnly = false});

  @override
  State<PacksDialog> createState() => _PacksDialogState();
}

class _PacksDialogState extends State<PacksDialog>
    with TickerProviderStateMixin {
  late final ButterflyFileSystem _fileSystem;
  late PackFileSystem _packSystem;
  Future<List<FileSystemFile<NoteData>>>? _packsFuture;

  @override
  void initState() {
    _fileSystem = context.read<ButterflyFileSystem>();
    _packSystem = _fileSystem.buildDefaultPackSystem();
    super.initState();

    _packsFuture = _getPacks();
  }

  Future<List<FileSystemFile<NoteData>>> _getPacks() {
    return _packSystem.initialize().then((value) => _packSystem.getFiles());
  }

  void _refresh() {
    if (!mounted) return;
    setState(() {
      _packsFuture = _getPacks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      constraints: const BoxConstraints(
        maxWidth: LeapBreakpoints.medium,
        maxHeight: 800,
      ),
      title: Text(AppLocalizations.of(context).packs),
      headerActions: [
        if (!widget.globalOnly)
          IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.cube),
            tooltip: AppLocalizations.of(context).bundledPacks,
            onPressed: () async {
              final bloc = context.read<DocumentBloc>();
              await showDialog(
                context: context,
                builder: (context) => BlocProvider.value(
                  value: bloc,
                  child: BundledPacksDialog(onRefresh: _refresh),
                ),
              );
            },
          ),
        ConnectionButton(
          currentRemote: _packSystem.storage?.identifier ?? '',
          onChanged: (value) {
            setState(() {
              _packSystem = _fileSystem.buildPackSystem(value);
              _packsFuture = _getPacks();
            });
          },
        ),
      ],
      leading: IconButton.outlined(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(PhosphorIconsLight.x),
        tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      ),
      content: Column(
        children: [
          Flexible(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder<List<FileSystemFile<NoteData>>>(
                      future: _packsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        if (!snapshot.hasData) {
                          return const Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          );
                        }
                        final globalPacks = snapshot.data ?? [];
                        return _PacksList(
                          globalPacks: globalPacks,
                          globalOnly: widget.globalOnly,
                        );
                      },
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FloatingActionButton.extended(
                      icon: const PhosphorIcon(PhosphorIconsLight.plus),
                      label: Text(AppLocalizations.of(context).add),
                      onPressed: () {
                        showLeapBottomSheet(
                          context: context,
                          titleBuilder: (ctx) =>
                              Text(AppLocalizations.of(ctx).add),
                          childrenBuilder: (ctx) => [
                            ListTile(
                              title: Text(AppLocalizations.of(ctx).import),
                              leading: const PhosphorIcon(
                                PhosphorIconsLight.arrowSquareIn,
                              ),
                              onTap: () async {
                                Navigator.of(ctx).pop();
                                final (data, _) = await importFile(context, [
                                  AssetFileType.note,
                                  AssetFileType.textNote,
                                ]);
                                if (data == null) return;
                                final pack = NoteData.fromData(data);
                                final metadata = pack.getMetadata();
                                if (metadata?.type != NoteFileType.pack) {
                                  return;
                                }
                                if (!mounted) return;
                                final success =
                                    await showDialog<bool>(
                                      context: context,
                                      builder: (context) =>
                                          PackImportConfirmationDialog(
                                            pack: metadata!,
                                          ),
                                    ) ??
                                    false;
                                if (!success) return;
                                await _addPack(pack);
                                _refresh();
                              },
                            ),
                            ListTile(
                              title: Text(LeapLocalizations.of(ctx).create),
                              leading: const PhosphorIcon(
                                PhosphorIconsLight.plusCircle,
                              ),
                              onTap: () async {
                                Navigator.of(ctx).pop();
                                final pack = await showDialog<NoteData>(
                                  context: ctx,
                                  builder: (context) => const PackDialog(),
                                );
                                if (pack == null) return;
                                await _addPack(pack);
                              },
                            ),
                            ListTile(
                              title: Text(
                                AppLocalizations.of(ctx).importCorePack,
                              ),
                              subtitle: Text(
                                AppLocalizations.of(
                                  ctx,
                                ).importCorePackDescription,
                              ),
                              leading: const PhosphorIcon(
                                PhosphorIconsLight.cube,
                              ),
                              onTap: () async {
                                Navigator.of(ctx).pop();
                                final pack =
                                    await DocumentDefaults.getCorePack();
                                try {
                                  await _packSystem.deleteFile(
                                    '${pack.name!}.bfly',
                                  );
                                } catch (_) {}
                                await _addPack(pack);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addPack(NoteData pack) async {
    await _packSystem.createFileWithName(
      pack,
      name: pack.name ?? '',
      suffix: '.bfly',
    );
    _refresh();
  }
}

class _PacksList extends StatefulWidget {
  final List<FileSystemFile<NoteData>> globalPacks;
  final bool globalOnly;

  const _PacksList({required this.globalPacks, this.globalOnly = false});

  @override
  State<_PacksList> createState() => __PacksListState();
}

class __PacksListState extends State<_PacksList> {
  late final List<FileSystemFile<NoteData>> _globalPacks;
  late final PackFileSystem _packSystem;

  @override
  void initState() {
    super.initState();
    _globalPacks = widget.globalPacks;
    _packSystem = context.read<ButterflyFileSystem>().buildDefaultPackSystem();
  }

  @override
  void didUpdateWidget(covariant _PacksList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.globalPacks != widget.globalPacks) {
      setState(() {
        _globalPacks.clear();
        _globalPacks.addAll(widget.globalPacks);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _globalPacks.length,
      itemBuilder: (context, index) {
        final file = _globalPacks[index];
        final pack = file.data!;
        final metadata =
            pack.getMetadata() ?? DocumentDefaults.createMetadata();
        return Dismissible(
          key: ValueKey(('globalpack', file.path)),
          onDismissed: (direction) async {
            await _packSystem.deleteFile(file.path);
            if (!mounted) return;
            setState(() {
              _globalPacks.removeAt(index);
            });
          },
          background: Container(color: Colors.red),
          child: ContextRegion(
            tooltip: AppLocalizations.of(context).actions,
            menuChildren: [
              if (!widget.globalOnly)
                MenuItemButton(
                  leadingIcon: const PhosphorIcon(PhosphorIconsLight.cube),
                  child: Text(
                    AppLocalizations.of(context).bundlePackInDocument,
                  ),
                  onPressed: () {
                    context.read<DocumentBloc>().add(PackAdded(pack));
                  },
                ),
              SubmenuButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.download),
                menuChildren: [
                  MenuItemButton(
                    leadingIcon: const PhosphorIcon(PhosphorIconsLight.archive),
                    child: Text(AppLocalizations.of(context).packagedFile),
                    onPressed: () async {
                      await _exportPack(pack);
                    },
                  ),
                  MenuItemButton(
                    leadingIcon: const PhosphorIcon(PhosphorIconsLight.file),
                    child: Text(AppLocalizations.of(context).rawFile),
                    onPressed: () async {
                      await _exportPack(pack, isTextBased: true);
                    },
                  ),
                ],
                child: Text(AppLocalizations.of(context).export),
              ),
              MenuItemButton(
                leadingIcon: const PhosphorIcon(PhosphorIconsLight.trash),
                child: Text(AppLocalizations.of(context).delete),
                onPressed: () async {
                  await _packSystem.deleteFile(file.path);
                  if (!mounted) return;
                  setState(() {
                    _globalPacks.removeAt(index);
                  });
                },
              ),
            ],
            builder: (context, button, controller) => ListTile(
              title: Text(metadata.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (metadata.author.isNotEmpty)
                    Text(
                      AppLocalizations.of(context).byAuthor(metadata.author),
                    ),
                  if (metadata.description.isNotEmpty)
                    Text(metadata.description),
                ],
              ),
              onTap: () async {
                final bloc = context.read<DocumentBloc>();
                final newPack = await showDialog<NoteData>(
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: bloc,
                    child: PackDialog(pack: pack),
                  ),
                );
                if (newPack == null) return;
                final name = newPack.name ?? '';
                if (pack.name != name) {
                  await _packSystem.deleteFile(file.path);
                }
                await _packSystem.updateFile('$name.bfly', newPack);
                setState(() {
                  _globalPacks[index] = FileSystemFile(
                    file.location,
                    data: newPack,
                  );
                });
              },
              trailing: button,
            ),
          ),
        );
      },
    );
  }

  Future<void> _exportPack(NoteData pack, {bool isTextBased = false}) async {
    return exportData(context, pack, isTextBased: isTextBased);
  }
}
