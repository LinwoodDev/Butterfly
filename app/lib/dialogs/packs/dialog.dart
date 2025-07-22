import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
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
  late final TabController _controller;
  late final ButterflyFileSystem _fileSystem;
  late PackFileSystem _packSystem;

  @override
  void initState() {
    _controller = TabController(length: widget.globalOnly ? 1 : 2, vsync: this);
    _fileSystem = context.read<ButterflyFileSystem>();
    _packSystem = _fileSystem.buildDefaultPackSystem();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
      title: Text(AppLocalizations.of(context).packs),
      headerActions: [
        ConnectionButton(
          currentRemote: _packSystem.storage?.identifier ?? '',
          onChanged: (value) {
            setState(() {
              _packSystem = _fileSystem.buildPackSystem(value);
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
                    if (!widget.globalOnly)
                      TabBar(
                        isScrollable: true,
                        controller: _controller,
                        tabs: [
                          HorizontalTab(
                            icon: const PhosphorIcon(PhosphorIconsLight.file),
                            label: Text(AppLocalizations.of(context).document),
                          ),
                          HorizontalTab(
                            icon: const PhosphorIcon(PhosphorIconsLight.folder),
                            label: Text(AppLocalizations.of(context).installed),
                          ),
                        ],
                      ),
                    Flexible(
                      child: TabBarView(
                        controller: _controller,
                        children: [
                          if (!widget.globalOnly)
                            BlocBuilder<DocumentBloc, DocumentState>(
                              builder: (context, state) {
                                if (state is! DocumentLoadSuccess) {
                                  return Container();
                                }
                                final packs = state.data.getPacks().toList();
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: packs.length,
                                  itemBuilder: (context, index) {
                                    final pack = state.data.getPack(
                                      packs[index],
                                    );
                                    final metadata = pack?.getMetadata();
                                    if (metadata == null) return Container();
                                    return Dismissible(
                                      key: ValueKey((
                                        'localpack',
                                        metadata.name,
                                      )),
                                      onDismissed: (direction) {
                                        context.read<DocumentBloc>().add(
                                          PackRemoved(metadata.name),
                                        );
                                      },
                                      background: Container(color: Colors.red),
                                      child: ContextRegion(
                                        tooltip: AppLocalizations.of(
                                          context,
                                        ).actions,
                                        menuChildren: [
                                          MenuItemButton(
                                            leadingIcon: const PhosphorIcon(
                                              PhosphorIconsLight.appWindow,
                                            ),
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              ).local,
                                            ),
                                            onPressed: () async {
                                              await _addPack(pack!, true);
                                              if (mounted) {
                                                setState(() {});
                                              }
                                            },
                                          ),
                                          MenuItemButton(
                                            leadingIcon: const PhosphorIcon(
                                              PhosphorIconsLight.download,
                                            ),
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              ).export,
                                            ),
                                            onPressed: () async {
                                              await _exportPack(pack!);
                                              if (mounted) {
                                                setState(() {});
                                              }
                                            },
                                          ),
                                          MenuItemButton(
                                            leadingIcon: const PhosphorIcon(
                                              PhosphorIconsLight.trash,
                                            ),
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              ).delete,
                                            ),
                                            onPressed: () {
                                              context.read<DocumentBloc>().add(
                                                PackRemoved(metadata.name),
                                              );
                                              if (mounted) {
                                                setState(() {});
                                              }
                                            },
                                          ),
                                        ],
                                        builder:
                                            (
                                              context,
                                              button,
                                              controller,
                                            ) => ListTile(
                                              title: Text(metadata.name),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (metadata
                                                      .author
                                                      .isNotEmpty)
                                                    Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      ).byAuthor(
                                                        metadata.author,
                                                      ),
                                                    ),
                                                  if (metadata
                                                      .description
                                                      .isNotEmpty)
                                                    Text(metadata.description),
                                                ],
                                              ),
                                              onTap: () async {
                                                final bloc = context
                                                    .read<DocumentBloc>();
                                                Navigator.of(context).pop();
                                                final newPack =
                                                    await showDialog<NoteData>(
                                                      context: context,
                                                      builder: (context) =>
                                                          BlocProvider.value(
                                                            value: bloc,
                                                            child: PackDialog(
                                                              pack: pack,
                                                            ),
                                                          ),
                                                    );
                                                if (newPack == null) return;
                                                bloc.add(
                                                  PackUpdated(
                                                    metadata.name,
                                                    newPack,
                                                  ),
                                                );
                                              },
                                              trailing: button,
                                            ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          FutureBuilder<List<FileSystemFile<NoteData>>>(
                            future: _packSystem.initialize().then(
                              (value) => _packSystem.getFiles(),
                            ),
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
                              return StatefulBuilder(
                                builder: (context, setInnerState) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: globalPacks.length,
                                    itemBuilder: (context, index) {
                                      final file = globalPacks[index];
                                      final pack = file.data!;
                                      final metadata = pack.getMetadata();
                                      if (metadata == null) return Container();
                                      return Dismissible(
                                        key: ValueKey((
                                          'globalpack',
                                          metadata.name,
                                        )),
                                        onDismissed: (direction) async {
                                          setInnerState(
                                            () => globalPacks.removeAt(index),
                                          );
                                          await _packSystem.deleteFile(
                                            file.path,
                                          );
                                          if (mounted) setState(() {});
                                        },
                                        background: Container(
                                          color: Colors.red,
                                        ),
                                        child: ContextRegion(
                                          tooltip: AppLocalizations.of(
                                            context,
                                          ).actions,
                                          menuChildren: [
                                            MenuItemButton(
                                              leadingIcon: const PhosphorIcon(
                                                PhosphorIconsLight.download,
                                              ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                ).export,
                                              ),
                                              onPressed: () async {
                                                await _exportPack(pack);
                                                if (mounted) {
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                            MenuItemButton(
                                              leadingIcon: const PhosphorIcon(
                                                PhosphorIconsLight.trash,
                                              ),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                ).delete,
                                              ),
                                              onPressed: () async {
                                                await _packSystem.deleteFile(
                                                  file.path,
                                                );
                                                if (mounted) {
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                          ],
                                          builder:
                                              (
                                                context,
                                                button,
                                                controller,
                                              ) => ListTile(
                                                title: Text(metadata.name),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (metadata
                                                        .author
                                                        .isNotEmpty)
                                                      Text(
                                                        AppLocalizations.of(
                                                          context,
                                                        ).byAuthor(
                                                          metadata.author,
                                                        ),
                                                      ),
                                                    if (metadata
                                                        .description
                                                        .isNotEmpty)
                                                      Text(
                                                        metadata.description,
                                                      ),
                                                  ],
                                                ),
                                                leading: widget.globalOnly
                                                    ? null
                                                    : IconButton.outlined(
                                                        icon:
                                                            const PhosphorIcon(
                                                              PhosphorIconsLight
                                                                  .plus,
                                                            ),
                                                        onPressed: () async {
                                                          await _addPack(
                                                            pack,
                                                            false,
                                                          );
                                                          _controller.animateTo(
                                                            0,
                                                          );
                                                          if (mounted) {
                                                            setState(() {});
                                                          }
                                                        },
                                                        tooltip:
                                                            AppLocalizations.of(
                                                              context,
                                                            ).install,
                                                      ),
                                                onTap: () async {
                                                  final bloc = context
                                                      .read<DocumentBloc>();
                                                  final newPack =
                                                      await showDialog<
                                                        NoteData
                                                      >(
                                                        context: context,
                                                        builder: (context) =>
                                                            BlocProvider.value(
                                                              value: bloc,
                                                              child: PackDialog(
                                                                pack: pack,
                                                              ),
                                                            ),
                                                      );
                                                  if (newPack == null) return;
                                                  final name =
                                                      newPack.name ?? '';
                                                  if (pack.name != name) {
                                                    await _packSystem
                                                        .deleteFile(file.path);
                                                  }
                                                  await _packSystem.updateFile(
                                                    '$name.bfly',
                                                    newPack,
                                                  );
                                                  setState(() {});
                                                },
                                                trailing: button,
                                              ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
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
                                ]);
                                if (data == null) return;
                                final pack = NoteData.fromData(data);
                                final metadata = pack.getMetadata();
                                if (metadata?.type != NoteFileType.pack) {
                                  return;
                                }
                                if (mounted) {
                                  final success =
                                      await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            AppLocalizations.of(
                                              context,
                                            ).sureImportPack,
                                          ),
                                          scrollable: true,
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                metadata!.name,
                                                style: TextTheme.of(
                                                  context,
                                                ).titleLarge,
                                              ),
                                              Text(
                                                AppLocalizations.of(
                                                  context,
                                                ).byAuthor(metadata.author),
                                              ),
                                              Text(metadata.description),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text(
                                                MaterialLocalizations.of(
                                                  context,
                                                ).cancelButtonLabel,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () => Navigator.of(
                                                context,
                                              ).pop(true),
                                              child: Text(
                                                AppLocalizations.of(
                                                  context,
                                                ).import,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ) ??
                                      false;
                                  if (!success) return;
                                  await _addPack(pack);
                                  if (context.mounted) {
                                    setState(() {});
                                  }
                                }
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

                                if (context.mounted) {
                                  setState(() {});
                                }
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
                                if (_isGlobal()) {
                                  try {
                                    await _packSystem.deleteFile(
                                      '${pack.name!}.bfly',
                                    );
                                  } catch (_) {}
                                } else if (mounted) {
                                  final bloc = context.read<DocumentBloc>();
                                  bloc.add(PackRemoved(pack.name!));
                                }
                                await _addPack(pack);
                                setState(() {});
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

  bool _isGlobal() => _controller.index == 1 || widget.globalOnly;

  Future<void> _addPack(NoteData pack, [bool? global]) async {
    if (global ?? _isGlobal()) {
      await _packSystem.createFileWithName(
        pack,
        name: pack.name ?? '',
        suffix: '.bfly',
      );
      setState(() {});
    } else {
      context.read<DocumentBloc>().add(PackAdded(pack));
    }
  }

  Future<void> _exportPack(NoteData pack) async {
    return exportData(context, pack.exportAsBytes());
  }
}
