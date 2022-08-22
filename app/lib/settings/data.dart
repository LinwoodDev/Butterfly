import 'package:archive/archive.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../api/file_system.dart';
import '../api/open.dart';

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
        appBar: AppBar(
          automaticallyImplyLeading: !widget.inView,
          backgroundColor: widget.inView ? Colors.transparent : null,
          title: Text(AppLocalizations.of(context)!.data),
          actions: [
            if (!widget.inView && !kIsWeb && isWindow()) ...[
              const VerticalDivider(),
              const WindowButtons()
            ]
          ],
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
                        if (!kIsWeb)
                          ListTile(
                            title: Text(AppLocalizations.of(context)!
                                .documentDirectory),
                            leading: const Icon(PhosphorIcons.folderLight),
                            subtitle: Text(state.documentPath.isNotEmpty
                                ? state.documentPath
                                : AppLocalizations.of(context)!.defaultPath),
                            onTap: () async {
                              final settingsCubit =
                                  context.read<SettingsCubit>();
                              final selectedDir =
                                  await FilePicker.platform.getDirectoryPath();
                              if (selectedDir != null) {
                                _changePath(settingsCubit, selectedDir);
                              }
                            },
                            trailing: state.documentPath.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(PhosphorIcons.trashLight),
                                    onPressed: () => _changePath(
                                        context.read<SettingsCubit>(), ''),
                                  )
                                : null,
                          ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.dateFormat),
                          leading: const Icon(PhosphorIcons.calendarLight),
                          subtitle: Text(state.dateFormat),
                          onTap: () async {
                            final settingsCubit = context.read<SettingsCubit>();
                            // Show input dialog
                            final TextEditingController controller =
                                TextEditingController(text: state.dateFormat);
                            final String? newFormat = await showDialog<String>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                    AppLocalizations.of(context)!.dateFormat),
                                content: TextField(
                                  controller: controller,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                    hintText: 'yyyy-MM-dd',
                                    filled: true,
                                    labelText: AppLocalizations.of(context)!
                                        .dateFormat,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                        AppLocalizations.of(context)!.cancel),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  ElevatedButton(
                                    child:
                                        Text(AppLocalizations.of(context)!.ok),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(controller.text);
                                    },
                                  ),
                                ],
                              ),
                            );
                            if (newFormat != null) {
                              settingsCubit.changeDateFormat(newFormat);
                            }
                          },
                        ),
                        ListTile(
                          title: Text(AppLocalizations.of(context)!.export),
                          leading: const Icon(PhosphorIcons.exportLight),
                          onTap: () async {
                            final fileSystem =
                                DocumentFileSystem.fromPlatform();
                            final directory =
                                await fileSystem.getRootDirectory();
                            final archive = exportDirectory(directory);
                            final encoder = ZipEncoder();
                            final bytes = encoder.encode(archive);
                            if (bytes != null) {
                              openZip(bytes);
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
}
