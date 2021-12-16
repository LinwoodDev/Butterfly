import 'dart:io';

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/views/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DataSettingsPage extends StatelessWidget {
  const DataSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.data),
          actions: [
            if (isWindow()) ...[const VerticalDivider(), const WindowButtons()]
          ],
        ),
        body: BlocBuilder<SettingsCubit, ButterflySettings>(
            builder: (context, state) {
          return ListView(
            children: [
              if (!kIsWeb && (Platform.isWindows || Platform.isLinux))
                ListTile(
                  title: Text(AppLocalizations.of(context)!.documentDirectory),
                  leading: const Icon(PhosphorIcons.folderLight),
                  subtitle: Text(state.documentPath.isNotEmpty
                      ? state.documentPath
                      : AppLocalizations.of(context)!.defaultPath),
                  onTap: () async {
                    var selectedDir =
                        await FilePicker.platform.getDirectoryPath();
                    if (selectedDir != null) {
                      context
                          .read<SettingsCubit>()
                          .changeDocumentPath(selectedDir);
                    }
                  },
                  trailing: state.documentPath.isNotEmpty
                      ? IconButton(
                          icon: const Icon(PhosphorIcons.trashLight),
                          onPressed: () =>
                              context.read<SettingsCubit>().resetDocumentPath(),
                        )
                      : null,
                ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.dateFormat),
                leading: const Icon(PhosphorIcons.calendarLight),
                subtitle: Text(state.dateFormat),
                onTap: () async {
                  // Show input dialog
                  final TextEditingController controller =
                      TextEditingController(text: state.dateFormat);
                  final String? newFormat = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(AppLocalizations.of(context)!.dateFormat),
                      content: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'yyyy-MM-dd',
                          labelText: AppLocalizations.of(context)!.dateFormat,
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.cancel),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.ok),
                          onPressed: () {
                            Navigator.of(context).pop(controller.text);
                          },
                        ),
                      ],
                    ),
                  );
                  if (newFormat != null) {
                    context.read<SettingsCubit>().changeDateFormat(newFormat);
                  }
                },
              ),
            ],
          );
        }));
  }
}
