import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/template.dart';
import 'package:butterfly/theme.dart';
import 'package:butterfly/visualizer/connection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../dialogs/packs/dialog.dart';

class DataSettingsPage extends StatefulWidget {
  final bool inView;
  const DataSettingsPage({super.key, this.inView = false});

  @override
  State<DataSettingsPage> createState() => _DataSettingsPageState();
}

class _DataSettingsPageState extends State<DataSettingsPage> {
  late final DocumentFileSystem _documentSystem;

  @override
  void initState() {
    super.initState();
    _documentSystem = context.read<ButterflyFileSystem>().buildDocumentSystem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.inView ? Colors.transparent : null,
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        inView: widget.inView,
        backgroundColor: widget.inView ? Colors.transparent : null,
        title: Text(AppLocalizations.of(context).data),
      ),
      body: BlocBuilder<SettingsCubit, ButterflySettings>(
        builder: (context, state) {
          return ListView(
            children: [
              Card(
                margin: settingsCardMargin,
                child: Padding(
                  padding: settingsCardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!kIsWeb) ...[
                        ListTile(
                          title: Text(AppLocalizations.of(context).syncMode),
                          leading: PhosphorIcon(state.syncMode.getIcon()),
                          subtitle: Text(
                            state.syncMode.getLocalizedName(context),
                          ),
                          onTap: () => _openSyncModeModal(context),
                        ),
                        if (!Platform.isIOS)
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context).dataDirectory,
                            ),
                            leading: const PhosphorIcon(
                              PhosphorIconsLight.folder,
                            ),
                            subtitle: state.documentPath.isNotEmpty
                                ? FutureBuilder<String>(
                                    future: getButterflyDirectory(),
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
                                    AppLocalizations.of(context).defaultPath,
                                  ),
                            onTap: _changeDataDirectory,
                            trailing: state.documentPath.isNotEmpty
                                ? IconButton(
                                    icon: const PhosphorIcon(
                                      PhosphorIconsLight.clockClockwise,
                                    ),
                                    tooltip: AppLocalizations.of(
                                      context,
                                    ).defaultPath,
                                    onPressed: () => _changePath(
                                      context.read<SettingsCubit>(),
                                      '',
                                    ),
                                  )
                                : null,
                          ),
                      ],
                      ListTile(
                        title: Text(AppLocalizations.of(context).templates),
                        leading: const PhosphorIcon(
                          PhosphorIconsLight.file,
                          textDirection: TextDirection.ltr,
                        ),
                        onTap: () => showDialog(
                          context: context,
                          builder: (ctx) => const TemplateDialog(),
                        ),
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context).packs),
                        leading: const PhosphorIcon(PhosphorIconsLight.package),
                        onTap: () => showDialog(
                          context: context,
                          builder: (ctx) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                lazy: false,
                                create: (ctx) => DocumentBloc.placeholder(
                                  context.read<ButterflyFileSystem>(),
                                  context.read<WindowCubit>(),
                                ),
                              ),
                            ],
                            child: const PacksDialog(globalOnly: true),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).exportAllFiles,
                        ),
                        leading: const PhosphorIcon(PhosphorIconsLight.export),
                        onTap: () async {
                          final directory = await _documentSystem.fileSystem
                              .getRootDirectory(listLevel: allListLevel);
                          final archive = exportDirectory(directory);
                          final encoder = ZipEncoder();
                          final bytes = encoder.encodeBytes(archive);
                          exportZip(context, bytes);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: settingsCardMargin,
                child: Padding(
                  padding: settingsCardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).restoreSettingsFromFile,
                        ),
                        leading: Icon(PhosphorIconsLight.arrowSquareIn),
                        onTap: () => _importSettings(context),
                      ),
                      ListTile(
                        title: Text(
                          AppLocalizations.of(context).exportSettingsToFile,
                        ),
                        leading: Icon(PhosphorIconsLight.arrowSquareOut),
                        onTap: () => _exportSettings(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _changeDataDirectory() async {
    try {
      final settingsCubit = context.read<SettingsCubit>();
      final selectedDir = await FilePicker.platform.getDirectoryPath();
      if (selectedDir != null) {
        _changePath(settingsCubit, selectedDir);
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context).error),
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> _changePath(SettingsCubit settingsCubit, String newPath) async {
    var oldPath = settingsCubit.state.documentPath;
    final defaultPath = await getButterflyDirectory(usePrefs: false);
    if (oldPath.isEmpty) {
      oldPath = defaultPath;
    }
    var movedPath = newPath;
    if (movedPath.isEmpty) {
      movedPath = defaultPath;
    }
    if (!(await _documentSystem.moveAbsolute(oldPath, movedPath)) &&
        newPath.isNotEmpty) {
      return;
    }
    settingsCubit.changeDocumentPath(newPath);
  }

  Future<void> _openSyncModeModal(BuildContext context) => showLeapBottomSheet(
    context: context,
    titleBuilder: (ctx) => Text(AppLocalizations.of(ctx).syncMode),
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
    },
  );

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

  void _importSettings(BuildContext context) async {
    final settingsCubit = context.read<SettingsCubit>();
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );
    final bytes = result?.files.firstOrNull?.bytes;
    if (bytes == null) return;
    final data = utf8.decode(bytes);
    settingsCubit.importSettings(data);
  }

  void _exportSettings(BuildContext context) async {
    final settingsCubit = context.read<SettingsCubit>();
    await exportFile(
      bytes: utf8.encode(await settingsCubit.exportSettings()),
      context: context,
      fileExtension: 'json',
      fileName: 'settings',
      label: AppLocalizations.of(context).exportSettingsToFile,
      mimeType: 'application/json',
      uniformTypeIdentifier: 'public.json',
    );
  }
}
