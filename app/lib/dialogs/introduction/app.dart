import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/open_release_notes.dart';

class AppIntroductionDialog extends StatelessWidget {
  const AppIntroductionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 700),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView(shrinkWrap: true, children: [
                Image.asset('images/logo.png', height: 150),
                Text(AppLocalizations.of(context)!.welcome,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                Text(AppLocalizations.of(context)!.welcomeContent),
                const SizedBox(height: 10),
                const Divider(),
                TextButton(
                    onPressed: () => openReleaseNotes(),
                    child: Text(AppLocalizations.of(context)!.releaseNotes)),
                TextButton(
                    onPressed: () =>
                        launchUrl(Uri.https('docs.butterfly.linwood.dev', '')),
                    child: Text(AppLocalizations.of(context)!.documentation)),
              ]),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.ok)),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
