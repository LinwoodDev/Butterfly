import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GroupDialog extends StatelessWidget {
  final String groupId;
  const GroupDialog({Key? key, required this.groupId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(PhosphorIcons.squaresFourLight),
          ),
          Text(AppLocalizations.of(context)!.layer),
        ],
      ),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(
          title: Text(AppLocalizations.of(context)!.rename),
          leading: const Icon(PhosphorIcons.textTLight),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.selectElements),
          leading: const Icon(PhosphorIcons.selectionLight),
          onTap: () {},
        ),
        ListTile(
          title: Text(AppLocalizations.of(context)!.delete),
          leading: const Icon(PhosphorIcons.trashLight),
          onTap: () {},
        ),
      ]),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.cancel)),
      ],
    );
  }
}
