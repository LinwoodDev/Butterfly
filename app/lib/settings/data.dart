import 'dart:io';

import 'package:butterfly/views/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataSettingsPage extends StatefulWidget {
  const DataSettingsPage({Key? key}) : super(key: key);

  @override
  _DataSettingsPageState createState() => _DataSettingsPageState();
}

class _DataSettingsPageState extends State<DataSettingsPage> {
  SharedPreferences? _prefs;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        _prefs = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.data),
          actions: [
            if (isWindow()) ...[const VerticalDivider(), const WindowButtons()]
          ],
        ),
        body: ListView(
          children: [
            if (!kIsWeb && (Platform.isWindows || Platform.isLinux))
              ListTile(
                title: Text(AppLocalizations.of(context)!.documentDirectory),
                leading: const Icon(PhosphorIcons.folderLight),
                subtitle: _prefs?.containsKey('document_path') ?? false
                    ? Text(_prefs!.getString('document_path') ?? '')
                    : Text(AppLocalizations.of(context)!.defaultPath),
                onTap: () async {
                  var selectedDir =
                      await FilePicker.platform.getDirectoryPath();
                  if (selectedDir != null) {
                    _prefs!.setString('document_path', selectedDir);
                    setState(() {});
                  }
                },
                trailing: _prefs?.containsKey('document_path') ?? false
                    ? IconButton(
                        icon: const Icon(PhosphorIcons.trashLight),
                        onPressed: () async {
                          _prefs!.remove('document_path');
                          setState(() {});
                        },
                      )
                    : null,
              ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.dateFormat),
              leading: const Icon(PhosphorIcons.calendarLight),
              subtitle: Text(_prefs?.getString('date_format') ?? ''),
              onTap: () async {
                // Show input dialog
                final TextEditingController controller = TextEditingController(
                    text: _prefs?.getString('date_format') ?? '');
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
                  _prefs!.setString('date_format', newFormat);
                  setState(() {});
                }
              },
            ),
          ],
        ));
  }
}
