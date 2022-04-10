import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              ]),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
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
