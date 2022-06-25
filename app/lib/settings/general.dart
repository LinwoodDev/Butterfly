import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/open_release_notes.dart';
import '../views/main.dart';

class GeneralSettingsPage extends StatelessWidget {
  final bool inView;
  const GeneralSettingsPage({super.key, this.inView = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: inView ? Colors.transparent : null,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.general),
          backgroundColor: inView ? Colors.transparent : null,
          automaticallyImplyLeading: !inView,
          actions: [
            if (!inView && !kIsWeb && isWindow()) ...[
              const VerticalDivider(),
              const WindowButtons()
            ]
          ],
        ),
        body: ListView(children: [
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                        leading: const Icon(PhosphorIcons.articleLight),
                        title:
                            Text(AppLocalizations.of(context)!.documentation),
                        onTap: () => launchUrl(
                            Uri.https('docs.butterfly.linwood.dev', ''))),
                    ListTile(
                        leading: const Icon(PhosphorIcons.flagLight),
                        title: Text(AppLocalizations.of(context)!.releaseNotes),
                        onTap: () => openReleaseNotes()),
                    ListTile(
                        leading: const Icon(PhosphorIcons.usersLight),
                        title: const Text('Discord'),
                        onTap: () =>
                            launchUrl(Uri.https('go.linwood.dev', 'discord'))),
                    ListTile(
                        leading: const Icon(PhosphorIcons.translateLight),
                        title: const Text('Crowdin'),
                        onTap: () => launchUrl(
                            Uri.https('go.linwood.dev', 'butterfly/crowdin'))),
                    ListTile(
                        leading: const Icon(PhosphorIcons.codeLight),
                        title: Text(AppLocalizations.of(context)!.source),
                        onTap: () => launchUrl(
                            Uri.https('go.linwood.dev', 'butterfly/source'))),
                    ListTile(
                        leading: const Icon(
                            PhosphorIcons.arrowCounterClockwiseLight),
                        title: Text(AppLocalizations.of(context)!.changelog),
                        onTap: () => launchUrl(Uri.https(
                            'docs.butterfly.linwood.dev', 'changelog'))),
                  ]),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                        leading: const Icon(PhosphorIcons.stackLight),
                        title: Text(AppLocalizations.of(context)!.license),
                        onTap: () => launchUrl(
                            Uri.https('go.linwood.dev', 'butterfly/license'))),
                    ListTile(
                        leading:
                            const Icon(PhosphorIcons.identificationCardLight),
                        title: Text(AppLocalizations.of(context)!.imprint),
                        onTap: () =>
                            launchUrl(Uri.https('go.linwood.dev', 'impress'))),
                    ListTile(
                        leading: const Icon(PhosphorIcons.shieldLight),
                        title:
                            Text(AppLocalizations.of(context)!.privacypolicy),
                        onTap: () => launchUrl(Uri.https(
                            'docs.butterfly.linwood.dev', 'privacypolicy'))),
                    ListTile(
                      title: Text(AppLocalizations.of(context)!.license),
                      leading: const Icon(PhosphorIcons.fileLight),
                      onTap: () => showLicensePage(context: context),
                    )
                  ]),
            ),
          ),
        ]));
  }
}
