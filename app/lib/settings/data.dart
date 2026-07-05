import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/save.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/template.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/visualizer/connection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../dialogs/packs/dialog.dart';

Widget buildDataDirectorySetting(
  BuildContext context,
  ButterflySettings state,
) {
  return ListTile(
    title: Text(AppLocalizations.of(context).dataDirectory),
    leading: const PhosphorIcon(PhosphorIconsLight.folder),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        state.documentPath.isNotEmpty
            ? FutureBuilder<String>(
                future: getButterflyDirectory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) return Text(snapshot.data!);
                  return const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(),
                  );
                },
              )
            : Text(AppLocalizations.of(context).defaultPath),
        if (Platform.isAndroid || Platform.isIOS)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              AppLocalizations.of(context).platformExperimentalWarning,
              style: const TextStyle(color: Colors.red),
            ),
          ),
      ],
    ),
    onTap: () => changeDataDirectory(context),
    trailing: state.documentPath.isNotEmpty
        ? IconButton(
            icon: const PhosphorIcon(PhosphorIconsLight.clockClockwise),
            tooltip: AppLocalizations.of(context).defaultPath,
            onPressed: () =>
                changePath(context, context.read<SettingsCubit>(), ''),
          )
        : null,
  );
}

Future<void> changeDataDirectory(BuildContext context) async {
  try {
    final settingsCubit = context.read<SettingsCubit>();
    final selectedDir = Platform.isAndroid
        ? await AndroidSafDirectoryFileSystem.pickDirectory()
        : await FilePicker.getDirectoryPath();
    if (selectedDir != null) {
      if (!context.mounted) return;
      await changePath(context, settingsCubit, selectedDir);
    }
  } catch (e) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).error),
        content: Text(e.toString()),
      ),
    );
  }
}

Future<void> changePath(
  BuildContext context,
  SettingsCubit settingsCubit,
  String newPath,
) async {
  var oldPath = settingsCubit.state.documentPath;
  final defaultPath = await getButterflyDirectory(usePrefs: false);
  if (oldPath.isEmpty) {
    oldPath = defaultPath;
  }
  var movedPath = newPath;
  if (movedPath.isEmpty) {
    movedPath = defaultPath;
  }

  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(AppLocalizations.of(context).warning),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(AppLocalizations.of(context).changeDataDirectoryWarningContent),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    oldPath,
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movedPath,
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(MaterialLocalizations.of(context).continueButtonLabel),
        ),
      ],
    ),
  );

  if (confirm != true) return;

  final documentSystem = context
      .read<ButterflyFileSystem>()
      .buildDocumentSystem();
  if (!(await documentSystem.moveAbsolute(oldPath, movedPath)) &&
      newPath.isNotEmpty) {
    return;
  }
  settingsCubit.changeDocumentPath(newPath);
}

Future<void> openSyncModeModal(BuildContext context) => showLeapBottomSheet(
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

void openTemplatesDialog(BuildContext context) {
  showDialog(context: context, builder: (ctx) => const TemplateDialog());
}

void openPacksDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (ctx) {
            final transformCubit = TransformCubit(
              MediaQuery.devicePixelRatioOf(context),
            );
            return DocumentBloc.placeholder(
              context.read<ButterflyFileSystem>(),
              EditorController(
                context.read<SettingsCubit>(),
                transformCubit,
                CameraViewport.unbaked(),
              ),
              context.read<WindowCubit>(),
            );
          },
        ),
      ],
      child: const PacksDialog(globalOnly: true),
    ),
  );
}

Future<void> exportData(BuildContext context) async {
  final localizations = AppLocalizations.of(context);
  bool exportDocuments = true;
  bool exportPacks = true;
  bool exportTemplates = true;
  double? exportProgress;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          final isExporting = exportProgress != null;
          return AlertDialog(
            title: Text(localizations.exportAllFiles),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckboxListTile(
                  title: Text(localizations.files),
                  value: exportDocuments,
                  onChanged: isExporting
                      ? null
                      : (value) =>
                            setState(() => exportDocuments = value ?? false),
                ),
                CheckboxListTile(
                  title: Text(localizations.packs),
                  value: exportPacks,
                  onChanged: isExporting
                      ? null
                      : (value) => setState(() => exportPacks = value ?? false),
                ),
                CheckboxListTile(
                  title: Text(localizations.templates),
                  value: exportTemplates,
                  onChanged: isExporting
                      ? null
                      : (value) =>
                            setState(() => exportTemplates = value ?? false),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: isExporting
                    ? null
                    : () => Navigator.of(context).pop(),
                child: Text(
                  MaterialLocalizations.of(context).cancelButtonLabel,
                ),
              ),
              TextButton(
                onPressed: isExporting
                    ? null
                    : () async {
                        if (!exportDocuments &&
                            !exportPacks &&
                            !exportTemplates) {
                          return;
                        }

                        setState(() => exportProgress = -1.0);

                        try {
                          final fs = context.read<ButterflyFileSystem>();
                          final archive = Archive();
                          final multiple =
                              [
                                exportDocuments,
                                exportPacks,
                                exportTemplates,
                              ].where((e) => e).length >
                              1;

                          List<String> packKeys = [];
                          List<String> templateKeys = [];

                          if (exportPacks) {
                            packKeys = await fs.buildPackSystem().getKeys();
                          }
                          if (exportTemplates) {
                            templateKeys = await fs
                                .buildTemplateSystem()
                                .getKeys();
                          }

                          int totalTasks =
                              (exportDocuments ? 1 : 0) +
                              packKeys.length +
                              templateKeys.length +
                              1; // +1 for zip
                          int completedTasks = 0;

                          void updateProgress() {
                            if (totalTasks > 0) {
                              setState(
                                () => exportProgress =
                                    completedTasks / totalTasks,
                              );
                            }
                          }

                          updateProgress();

                          if (exportDocuments) {
                            final documentSystem = context
                                .read<ButterflyFileSystem>()
                                .buildDocumentSystem();
                            final directory = await documentSystem.fileSystem
                                .getRootDirectory(listLevel: allListLevel);
                            final docArchive = exportDirectory(directory);
                            for (final file in docArchive.files) {
                              archive.addFile(
                                ArchiveFile.bytes(
                                  multiple
                                      ? 'Documents/${file.name}'
                                      : file.name,
                                  file.content as List<int>,
                                ),
                              );
                            }
                            completedTasks++;
                            updateProgress();
                          }

                          if (exportPacks) {
                            final packSystem = fs.buildPackSystem();
                            for (final key in packKeys) {
                              final data = await packSystem.fileSystem.getFile(
                                key,
                              );
                              if (data != null) {
                                archive.addFile(
                                  ArchiveFile.bytes(
                                    multiple ? 'Packs/$key' : key,
                                    data,
                                  ),
                                );
                              }
                              completedTasks++;
                              updateProgress();
                            }
                          }

                          if (exportTemplates) {
                            final templateSystem = fs.buildTemplateSystem();
                            for (final key in templateKeys) {
                              final data = await templateSystem.fileSystem
                                  .getFile(key);
                              if (data != null) {
                                archive.addFile(
                                  ArchiveFile.bytes(
                                    multiple ? 'Templates/$key' : key,
                                    data,
                                  ),
                                );
                              }
                              completedTasks++;
                              updateProgress();
                            }
                          }

                          // Small delay to allow UI to render the 99% progress
                          // before ZipEncoder blocks the thread synchronously.
                          await Future.delayed(
                            const Duration(milliseconds: 50),
                          );

                          final encoder = ZipEncoder();
                          final bytes = encoder.encodeBytes(archive);
                          completedTasks++;
                          updateProgress();

                          if (context.mounted) {
                            Navigator.of(context).pop();
                            exportZip(context, bytes);
                          }
                        } catch (e) {
                          if (context.mounted) {
                            setState(() => exportProgress = null);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        }
                      },
                child: isExporting
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: exportProgress! < 0 ? null : exportProgress,
                        ),
                      )
                    : Text(localizations.export),
              ),
            ],
          );
        },
      );
    },
  );
}

void importSettings(BuildContext context) async {
  final settingsCubit = context.read<SettingsCubit>();
  final result = await FilePicker.pickFile(
    type: FileType.custom,
    allowedExtensions: ['json'],
  );
  final bytes = await result?.readAsBytes();
  if (bytes == null) return;
  final data = utf8.decode(bytes);
  try {
    await settingsCubit.importSettings(data);
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

void exportSettings(BuildContext context) async {
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
