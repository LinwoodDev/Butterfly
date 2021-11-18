import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BehaviorsSettingsPage extends StatefulWidget {
  const BehaviorsSettingsPage({Key? key}) : super(key: key);

  @override
  _BehaviorsSettingsPageState createState() => _BehaviorsSettingsPageState();
}

class _BehaviorsSettingsPageState extends State<BehaviorsSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.behaviors)),
        body: ListView(
          children: [
            ListTile(
              title: Text(AppLocalizations.of(context)!.input),
              leading: const Icon(PhosphorIcons.mouseLight),
              subtitle: Text(AppLocalizations.of(context)!.multiDraw),
            ),
          ],
        ));
  }
}
