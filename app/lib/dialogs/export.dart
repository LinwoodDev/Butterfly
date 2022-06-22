import 'package:butterfly/api/save_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ExportDialog extends StatelessWidget {
  final String data;

  const ExportDialog({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(PhosphorIcons.exportLight),
            ),
            Text(AppLocalizations.of(context)!.export),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancel)),
        ],
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
              onTap: () {
                Clipboard.setData(ClipboardData(text: data));
                Navigator.of(context).pop();
              },
              title: Text(AppLocalizations.of(context)!.clipboard)),
          ListTile(
              onTap: () async {
                final navigator = Navigator.of(context);
                await saveData(context, data);
                navigator.pop();
              },
              title: Text(AppLocalizations.of(context)!.file)),
        ]));
  }
}
