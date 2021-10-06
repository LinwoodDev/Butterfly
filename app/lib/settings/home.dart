import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Column(children: [
          ListTile(
              title: Text(AppLocalizations.of(context)!.personalization),
              onTap: () => Modular.to.pushNamed("/settings/personalization"))
        ]))));
  }
}
