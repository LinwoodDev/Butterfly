import 'dart:io';

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system/file_system_io.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/template.dart';
import 'package:butterfly/visualizer/sync.dart';
import 'package:butterfly/widgets/window.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../api/file_system/file_system.dart';
import '../dialogs/packs/dialog.dart';

class DataSettingsPage extends StatefulWidget {
  final bool inView;
  const DataSettingsPage({super.key, this.inView = false});

  @override
  State<DataSettingsPage> createState() => _DataSettingsPageState();
}

class _DataSettingsPageState extends State<DataSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.inView ? Colors.transparent : null,
        appBar: WindowTitleBar(
          inView: widget.inView,
          backgroundColor: widget.inView ? Colors.transparent : null,
          title: Text(AppLocalizations.of(context).data),
        ),
        body: BlocBuilder<SettingsCubit, ButterflySettings>(
            builder: (context, state) {
          return ListView(
            children: [
              Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (!kIsWeb) ...[
                          ListTile(
                            title: Text(AppLocalizations.of(context).syncMode),
                            leading: PhosphorIcon(state.syncMode.getIcon()),
                            subtitle:
                                Text(state.syncMode.getLocalizedName(context)),
                            onTap: () => _openSyncModeModal(context),
                          ),
                          ListTile(
                            title: Text(
                                AppLocalizations.of(context).dataDirectory),
                            leading:
                                const PhosphorIcon(PhosphorIconsLight.folder),
                            subtitle: state.documentPath.isNotEmpty
                                ? FutureBuilder<String>(
                                    future: getButterflyDirectory(true),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Text(snapshot.data!);
                                      }
                                      return const SizedBox(
                                        height: 16,
                                        width: 16,
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  )
                                : Text(
                                    AppLocalizations.of(context).defaultPath),
                            onTap: Platform.isAndroid
                                ? null
                                : () async {
                                    final settingsCubit =
                                        context.read<SettingsCubit>();
                                    final selectedDir =
                                        await getDirectoryPath();
                                    if (selectedDir != null) {
                                      _changePath(settingsCubit, selectedDir);
                                    }
                                  },
                            trailing: state.documentPath.isNotEmpty
                                ? IconButton(
                                    icon: const PhosphorIcon(
                                        PhosphorIconsLight.clockClockwise),
                                    tooltip: AppLocalizations.of(context)
                                        .defaultPath,
                                    onPressed: () => _changePath(
                                        context.read<SettingsCubit>(), ''),
                                  )
                                : null,
                          ),
                        ],
                        ListTile(
                          title: Text(AppLocalizations.of(context).templates),
                          leading: const PhosphorIcon(PhosphorIconsLight.file),
                          onTap: () => showDialog(
                            context: context,
                            builder: (ctx) => const TemplateDialog(),
                          ),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context).packs),
                          leading:
                              const PhosphorIcon(PhosphorIconsLight.package),
                          onTap: () => showDialog(
                            context: context,
                            builder: (ctx) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                    value: context.read<SettingsCubit>()),
                                BlocProvider(
                                  lazy: false,
                                  create: (ctx) => DocumentBloc.placeholder(
                                      context.read<SettingsCubit>()),
                                ),
                              ],
                              child: const PacksDialog(globalOnly: true),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context).export),
                          leading:
                              const PhosphorIcon(PhosphorIconsLight.export),
                          onTap: () async {
                            final fileSystem =
                                DocumentFileSystem.fromPlatform();
                            final directory =
                                await fileSystem.getRootDirectory(true);
                            final archive = exportDirectory(directory);
                            final encoder = ZipEncoder();
                            final bytes = encoder.encode(archive);
                            if (bytes != null) {
                              exportZip(context, bytes);
                            }
                          },
                        ),
                      ]),
                ),
              ),
            ],
          );
        }));
  }

  Future<void> _changePath(SettingsCubit settingsCubit, String newPath) async {
    final oldPath = settingsCubit.state.documentPath;
    if (!(await DocumentFileSystem.fromPlatform()
        .moveAbsolute(oldPath, newPath))) {
      return;
    }
    settingsCubit.changeDocumentPath(newPath);
  }

  Future<void> _openSyncModeModal(BuildContext context) => showLeapBottomSheet(
      context: context,
      title: AppLocalizations.of(context).syncMode,
      childrenBuilder: (ctx) {
        final settingsCubit = context.read<SettingsCubit>();
        void changeSyncMode(SyncMode syncMode) {
          settingsCubit.changeSyncMode(syncMode);
          Navigator.of(context).pop();
        }

        return [
          ...SyncMode.values.map((syncMode) {
            return ListTile(
              title: Text(syncMode.getLocalizedName(context)),
              leading: PhosphorIcon(syncMode.getIcon()),
              selected: syncMode == settingsCubit.state.syncMode,
              onTap: () => changeSyncMode(syncMode),
            );
          }),
          const SizedBox(height: 32),
        ];
      });

/* 
  Future<void> _openIceServersModal(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    return showLeapBottomSheet(
        context: context,
        title: AppLocalizations.of(context).iceServers,
        actionsBuilder: (ctx) => [
              IconButton.outlined(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await settingsCubit.resetIceServers();
                  _openIceServersModal(context);
                },
                icon: const PhosphorIcon(
                    PhosphorIconsLight.clockCounterClockwise),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final result = await showDialog<String>(
                    context: context,
                    builder: (_) => NameDialog(
                      title: AppLocalizations.of(context).enterUrl,
                      hint: AppLocalizations.of(context).url,
                    ),
                  );
                  if (result == null) return;
                  await settingsCubit.addIceServer(result);
                  _openIceServersModal(context);
                },
                icon: const PhosphorIcon(PhosphorIconsLight.plus),
              ),
            ],
        childrenBuilder: (ctx) {
          final settings = settingsCubit.state;
          final servers = List.of(settings.iceServers);

          return [
            ...servers.map((server) {
              return Dismissible(
                key: Key(server),
                background: Container(color: Colors.red),
                child: ListTile(
                  title: Text(server),
                ),
                onDismissed: (direction) {
                  settingsCubit.removeIceServer(server);
                  servers.remove(server);
                },
              );
            }),
          ];
        });
  } */
}
