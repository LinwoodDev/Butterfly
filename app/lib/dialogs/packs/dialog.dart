import 'package:butterfly/api/file_system/file_system.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/save_data.dart';
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
  late final PackFileSystem _fileSystem;

  @override
  initState() {
    _controller = TabController(length: widget.globalOnly ? 1 : 2, vsync: this);
    _fileSystem = PackFileSystem.fromPlatform(
        remote: context.read<SettingsCubit>().state.getDefaultRemote());
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 800),
        child: Column(
          children: [
            Flexible(
              child: Stack(children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Header(
                      title: Text(AppLocalizations.of(context).packs),
                    ),
                    if (!widget.globalOnly)
                      TabBar(
                        controller: _controller,
                        tabs: [
                          Tab(
                            icon: const PhosphorIcon(PhosphorIconsLight.file),
                            text: AppLocalizations.of(context).document,
                          ),
                          Tab(
                            icon: const PhosphorIcon(
                                PhosphorIconsLight.appWindow),
                            text: AppLocalizations.of(context).local,
                          ),
                        ],
                      ),
                    Flexible(
                      child: TabBarView(controller: _controller, children: [
                        if (!widget.globalOnly)
                          Builder(builder: (context) {
                            final state = context.read<DocumentBloc>().state;
                            if (state is! DocumentLoadSuccess) {
                              return Container();
                            }
                            return StreamBuilder<List<String>>(
                                stream: state.data.onChange
                                    .map((event) => event.getPacks()),
                                builder: (context, snapshot) {
                                  final packs = snapshot.data ?? [];
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: packs.length,
                                    itemBuilder: (context, index) {
                                      final pack =
                                          state.data.getPack(packs[index]);
                                      final metadata = pack?.getMetadata();
                                      if (metadata == null) return Container();
                                      return Dismissible(
                                        key: ValueKey(
                                            'localpack:${metadata.name}'),
                                        onDismissed: (direction) {
                                          context.read<DocumentBloc>().add(
                                              DocumentPackRemoved(
                                                  metadata.name));
                                        },
                                        background: Container(
                                          color: Colors.red,
                                        ),
                                        child: ListTile(
                                          title: Text(metadata.name),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (metadata.author.isNotEmpty)
                                                Text(AppLocalizations.of(
                                                        context)
                                                    .byAuthor(metadata.author)),
                                              if (metadata
                                                  .description.isNotEmpty)
                                                Text(metadata.description),
                                            ],
                                          ),
                                          onTap: () async {
                                            final bloc =
                                                context.read<DocumentBloc>();
                                            Navigator.of(context).pop();
                                            final newPack =
                                                await showDialog<NoteData>(
                                                    context: context,
                                                    builder: (context) =>
                                                        BlocProvider.value(
                                                            value: bloc,
                                                            child: PackDialog(
                                                                pack: pack)));
                                            if (newPack == null) return;
                                            bloc.add(DocumentPackUpdated(
                                                metadata.name, newPack));
                                          },
                                          trailing: MenuAnchor(
                                            builder: defaultMenuButton(),
                                            menuChildren: [
                                              MenuItemButton(
                                                leadingIcon: const PhosphorIcon(
                                                    PhosphorIconsLight
                                                        .appWindow),
                                                child: Text(
                                                    AppLocalizations.of(context)
                                                        .local),
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  _addPack(pack!, true);
                                                },
                                              ),
                                              MenuItemButton(
                                                leadingIcon: const PhosphorIcon(
                                                    PhosphorIconsLight
                                                        .download),
                                                child: Text(
                                                    AppLocalizations.of(context)
                                                        .export),
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  _exportPack(pack!);
                                                },
                                              ),
                                              MenuItemButton(
                                                leadingIcon: const PhosphorIcon(
                                                    PhosphorIconsLight.trash),
                                                child: Text(
                                                    AppLocalizations.of(context)
                                                        .delete),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  context
                                                      .read<DocumentBloc>()
                                                      .add(DocumentPackRemoved(
                                                          metadata.name));
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                });
                          }),
                        FutureBuilder<List<NoteData>>(
                          future: _fileSystem
                              .createDefault(context)
                              .then((value) => _fileSystem.getPacks()),
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
                            final globalPacks = snapshot.data!;
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: globalPacks.length,
                              itemBuilder: (context, index) {
                                final pack = globalPacks[index];
                                final metadata = pack.getMetadata();
                                if (metadata == null) return Container();
                                return Dismissible(
                                  key: ValueKey('globalpack:${metadata.name}'),
                                  onDismissed: (direction) async {
                                    await _fileSystem.deletePack(metadata.name);
                                    if (mounted) Navigator.of(context).pop();
                                  },
                                  background: Container(
                                    color: Colors.red,
                                  ),
                                  child: ListTile(
                                    title: Text(metadata.name),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (metadata.author.isNotEmpty)
                                          Text(AppLocalizations.of(context)
                                              .byAuthor(metadata.author)),
                                        if (metadata.description.isNotEmpty)
                                          Text(metadata.description),
                                      ],
                                    ),
                                    onTap: () async {
                                      final bloc = context.read<DocumentBloc>();
                                      final newPack =
                                          await showDialog<NoteData>(
                                              context: context,
                                              builder: (context) =>
                                                  BlocProvider.value(
                                                    value: bloc,
                                                    child:
                                                        PackDialog(pack: pack),
                                                  ));
                                      if (newPack == null) return;
                                      if (pack.name != newPack.name) {
                                        await _fileSystem
                                            .deletePack(metadata.name);
                                      }
                                      await _fileSystem.updatePack(newPack);
                                      setState(() {});
                                    },
                                    trailing: MenuAnchor(
                                      builder: defaultMenuButton(),
                                      menuChildren: [
                                        if (!widget.globalOnly)
                                          MenuItemButton(
                                            leadingIcon: const PhosphorIcon(
                                                PhosphorIconsLight.file),
                                            child: Text(
                                                AppLocalizations.of(context)
                                                    .document),
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                              _addPack(pack, false);
                                            },
                                          ),
                                        MenuItemButton(
                                          leadingIcon: const PhosphorIcon(
                                              PhosphorIconsLight.download),
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  .export),
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            _exportPack(pack);
                                          },
                                        ),
                                        MenuItemButton(
                                          leadingIcon: const PhosphorIcon(
                                              PhosphorIconsLight.trash),
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  .delete),
                                          onPressed: () async {
                                            await _fileSystem
                                                .deletePack(metadata.name);
                                            if (mounted) {
                                              Navigator.of(context).pop();
                                            }
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ]),
                    )
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
                          title: AppLocalizations.of(context).add,
                          childrenBuilder: (ctx) => [
                            ListTile(
                              title: Text(AppLocalizations.of(ctx).import),
                              leading: const PhosphorIcon(
                                  PhosphorIconsLight.arrowSquareIn),
                              onTap: () async {
                                Navigator.of(ctx).pop();
                                final data = await openBfly();
                                if (data == null) return;
                                final pack = NoteData.fromData(data);
                                final metadata = pack.getMetadata();
                                if (metadata?.type != NoteFileType.pack) {
                                  return;
                                }
                                if (context.mounted) {
                                  final success = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                              AppLocalizations.of(context)
                                                  .sureImportPack),
                                          scrollable: true,
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(metadata!.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge),
                                              Text(AppLocalizations.of(context)
                                                  .byAuthor(metadata.author)),
                                              Text(metadata.description),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text(
                                                  AppLocalizations.of(context)
                                                      .cancel),
                                            ),
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: Text(
                                                  AppLocalizations.of(context)
                                                      .import),
                                            ),
                                          ],
                                        ),
                                      ) ??
                                      false;
                                  if (!success) return;
                                  _addPack(pack);
                                }
                              },
                            ),
                            ListTile(
                              title: Text(AppLocalizations.of(ctx).create),
                              leading: const PhosphorIcon(
                                  PhosphorIconsLight.plusCircle),
                              onTap: () async {
                                Navigator.of(ctx).pop();
                                final pack = await showDialog<NoteData>(
                                  context: ctx,
                                  builder: (context) => const PackDialog(),
                                );
                                if (pack != null) {
                                  _addPack(pack);
                                }
                              },
                            ),
                            ListTile(
                              title:
                                  Text(AppLocalizations.of(ctx).importCorePack),
                              subtitle: Text(AppLocalizations.of(ctx)
                                  .importCorePackDescription),
                              leading:
                                  const PhosphorIcon(PhosphorIconsLight.cube),
                              onTap: () async {
                                Navigator.of(ctx).pop();
                                final pack =
                                    await DocumentDefaults.getCorePack();
                                if (_isGlobal()) {
                                  await _fileSystem.deletePack(pack.name!);
                                  setState(() {});
                                } else if (context.mounted) {
                                  final bloc = context.read<DocumentBloc>();
                                  bloc.add(DocumentPackRemoved(pack.name!));
                                }
                                _addPack(pack);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context).close),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isGlobal() => _controller.index == 1 || widget.globalOnly;

  Future<void> _addPack(NoteData pack, [bool? global]) async {
    if (global ?? _isGlobal()) {
      await _fileSystem.createPack(pack);
      setState(() {});
    } else {
      context.read<DocumentBloc>().add(DocumentPackAdded(pack));
    }
  }

  Future<void> _exportPack(NoteData pack) async {
    return saveData(context, pack.save());
  }
}
