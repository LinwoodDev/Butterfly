import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  final bool isDialog;

  const SettingsPage({Key? key, this.isDialog = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: isDialog ? Colors.transparent : null,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.settings),
          leading: isDialog
              ? IconButton(
                  icon: const Icon(PhosphorIcons.xLight),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
        ),
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Column(children: [
          ListTile(
              leading: const Icon(PhosphorIcons.monitorLight),
              title: Text(AppLocalizations.of(context)!.personalization),
              onTap: () {
                Navigator.of(context).pop();
                Modular.to.pushNamed('/settings/personalization');
              }),
          const Divider(),
          ListTile(
              leading: const Icon(PhosphorIcons.stackLight),
              title: Text(AppLocalizations.of(context)!.license),
              onTap: () => launch(
                  'https://github.com/LinwoodCloud/butterfly/blob/main/LICENSE')),
          ListTile(
              leading: const Icon(PhosphorIcons.codeLight),
              title: Text(AppLocalizations.of(context)!.source),
              onTap: () =>
                  launch('https://github.com/LinwoodCloud/dev_doctor')),
          ListTile(
              leading: const Icon(PhosphorIcons.usersLight),
              title: const Text('Discord'),
              onTap: () => launch('https://discord.linwood.dev')),
          ListTile(
              leading: const Icon(PhosphorIcons.translateLight),
              title: const Text('Crowdin'),
              onTap: () => launch('https://linwood.crowdin.com')),
          ListTile(
              leading: const Icon(PhosphorIcons.articleLight),
              title: Text(AppLocalizations.of(context)!.documentation),
              onTap: () => launch('https://docs.butterfly.linwood.dev')),
          ListTile(
              leading: const Icon(PhosphorIcons.arrowCounterClockwiseLight),
              title: Text(AppLocalizations.of(context)!.changelog),
              onTap: () =>
                  launch('https://docs.butterfly.linwood.dev/changelog')),
          ListTile(
              leading: const Icon(PhosphorIcons.identificationCardLight),
              title: Text(AppLocalizations.of(context)!.imprint),
              onTap: () => launch('https://codedoctor.tk/impress')),
          ListTile(
              leading: const Icon(PhosphorIcons.shieldLight),
              title: Text(AppLocalizations.of(context)!.privacypolicy),
              onTap: () => launch(
                  'https://docs.butterfly.linwood.dev/docs/privacypolicy')),
          ListTile(
              leading: const Icon(PhosphorIcons.infoLight),
              title: Text(AppLocalizations.of(context)!.information),
              onTap: () => PackageInfo.fromPlatform().then((info) =>
                  showAboutDialog(
                      context: context,
                      applicationVersion: info.version,
                      applicationIcon:
                          Image.asset('images/logo.png', height: 50)))),
        ]))));
  }
}
