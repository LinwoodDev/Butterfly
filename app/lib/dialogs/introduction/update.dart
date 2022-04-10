import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/open_release_notes.dart';

class UpdateIntroductionDialog extends StatelessWidget {
  const UpdateIntroductionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
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
                      Text(
                          AppLocalizations.of(context)!
                              .updated(snapshot.data?.version ?? ''),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 10),
                      const Divider(),
                      ElevatedButton(
                          onPressed: () => openReleaseNotes(),
                          child:
                              Text(AppLocalizations.of(context)!.releaseNotes)),
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
        });
  }
}
