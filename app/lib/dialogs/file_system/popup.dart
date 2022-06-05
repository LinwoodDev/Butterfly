import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OpenPopupButton extends StatelessWidget {
  const OpenPopupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      icon: const Icon(PhosphorIcons.houseLight),
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: ListTile(
            mouseCursor: MouseCursor.defer,
            title: Text(AppLocalizations.of(context)!.local),
            leading: const Icon(PhosphorIcons.houseLight),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: ListTile(
            mouseCursor: MouseCursor.defer,
            title: Text(AppLocalizations.of(context)!.addRemote),
            leading: const Icon(PhosphorIcons.plusLight),
          ),
        ),
      ],
    );
  }
}
