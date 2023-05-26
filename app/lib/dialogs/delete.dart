import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).areYouSure),
      content: Text(AppLocalizations.of(context).reallyDelete),
      actions: [
        TextButton(
            child: Text(AppLocalizations.of(context).no),
            onPressed: () => Navigator.of(context).pop(false)),
        ElevatedButton(
          child: Text(AppLocalizations.of(context).yes),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        )
      ],
    );
  }
}
