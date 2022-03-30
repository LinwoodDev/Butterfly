import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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
            title: Text(AppLocalizations.of(context)!.data),
            leading: const Icon(PhosphorIcons.databaseLight),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).push('/settings/data');
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.behaviors),
            leading: const Icon(PhosphorIcons.fadersLight),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).push('/settings/behaviors');
            },
          ),
          ListTile(
              leading: const Icon(PhosphorIcons.monitorLight),
              title: Text(AppLocalizations.of(context)!.personalization),
              onTap: () {
                Navigator.of(context).pop();
                GoRouter.of(context).push('/settings/personalization');
              }),
          const Divider(),
          ListTile(
              leading: const Icon(PhosphorIcons.articleLight),
              title: Text(AppLocalizations.of(context)!.documentation),
              onTap: () => launch('https://docs.butterfly.linwood.dev')),
          ListTile(
              leading: const Icon(PhosphorIcons.usersLight),
              title: const Text('Discord'),
              onTap: () => launch('https://go.linwood.dev/discord')),
          ListTile(
              leading: const Icon(PhosphorIcons.translateLight),
              title: const Text('Crowdin'),
              onTap: () => launch('https://go.linwood.dev/butterfly/crowdin')),
          ListTile(
              leading: const Icon(PhosphorIcons.codeLight),
              title: Text(AppLocalizations.of(context)!.source),
              onTap: () => launch('https://go.linwood.dev/butterfly/source')),
          ListTile(
              leading: const Icon(PhosphorIcons.arrowCounterClockwiseLight),
              title: Text(AppLocalizations.of(context)!.changelog),
              onTap: () =>
                  launch('https://docs.butterfly.linwood.dev/changelog')),
          const Divider(),
          ListTile(
              leading: const Icon(PhosphorIcons.stackLight),
              title: Text(AppLocalizations.of(context)!.license),
              onTap: () => launch('https://go.linwood.dev/butterfly/license')),
          ListTile(
              leading: const Icon(PhosphorIcons.identificationCardLight),
              title: Text(AppLocalizations.of(context)!.imprint),
              onTap: () => launch('https://go.linwood.dev/impress')),
          ListTile(
              leading: const Icon(PhosphorIcons.shieldLight),
              title: Text(AppLocalizations.of(context)!.privacypolicy),
              onTap: () =>
                  launch('https://docs.butterfly.linwood.dev/privacypolicy')),
          ListTile(
              leading: const Icon(PhosphorIcons.infoLight),
              title: Text(AppLocalizations.of(context)!.information),
              onTap: () => PackageInfo.fromPlatform().then((info) =>
                  showAboutDialog(
                      context: context,
                      children: [
                        ElevatedButton(
                            child:
                                Text(AppLocalizations.of(context)!.copyVersion),
                            onPressed: () => Clipboard.setData(
                                ClipboardData(text: info.version))),
                      ],
                      applicationVersion: info.version,
                      applicationIcon:
                          Image.asset('images/logo.png', height: 50)))),
          if (kIsWeb)
            Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                    onTap: () => launch(
                        'https://vercel.com?utm_source=Linwood&utm_campaign=oss'),
                    child: Material(
                      child: SizedBox(
                          height: 50,
                          child: SvgPicture.asset(
                              'images/powered-by-vercel.svg',
                              placeholderBuilder: (BuildContext context) =>
                                  Container(
                                      padding: const EdgeInsets.all(30.0),
                                      child: const CircularProgressIndicator()),
                              semanticsLabel: 'Powered by Vercel')),
                    )))
        ]))));
  }
}
