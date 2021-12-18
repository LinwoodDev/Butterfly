import 'package:butterfly/actions/background.dart';
import 'package:butterfly/actions/waypoints.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BackgroundContextMenu extends StatelessWidget {
  final VoidCallback close;
  const BackgroundContextMenu({Key? key, required this.close})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
            leading: const Icon(PhosphorIcons.imageLight),
            title: Text(AppLocalizations.of(context)!.background),
            onTap: () {
              close();
              Actions.maybeInvoke<BackgroundIntent>(
                  context, BackgroundIntent(context));
            }),
        ListTile(
            leading: const Icon(PhosphorIcons.mapPinLight),
            title: Text(AppLocalizations.of(context)!.waypoints),
            onTap: () {
              close();
              Actions.maybeInvoke<WaypointsIntent>(
                  context, WaypointsIntent(context));
            }),
      ],
    );
  }
}
