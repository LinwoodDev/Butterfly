import 'package:butterfly/api/full_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PresentationControlsDialog extends StatelessWidget {
  const PresentationControlsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).presentationControls),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...<dynamic>[
            [
              PhosphorIcons.light.arrowRight,
              AppLocalizations.of(context).nextSlide,
              AppLocalizations.of(context).nextSlideDescription,
            ],
            [
              PhosphorIcons.light.arrowLeft,
              AppLocalizations.of(context).previousSlide,
              AppLocalizations.of(context).previousSlideDescription,
            ],
            [
              PhosphorIcons.light.pauseCircle,
              AppLocalizations.of(context).pausePresentation,
              AppLocalizations.of(context).pausePresentationDescription,
            ],
            [
              PhosphorIcons.light.door,
              AppLocalizations.of(context).exitPresentation,
              AppLocalizations.of(context).exitPresentationDescription,
            ]
          ].map((e) => ListTile(
                leading: PhosphorIcon(e[0]),
                title: Text(e[1]),
                subtitle: Text(e[2]),
              )),
          FutureBuilder<bool>(
            future: Future.value(isFullScreen()),
            builder: (context, snapshot) {
              var fullscreen = snapshot.data ?? false;
              return StatefulBuilder(
                builder: (context, setState) => SwitchListTile(
                  value: fullscreen,
                  title: Text(AppLocalizations.of(context).fullScreen),
                  onChanged: (value) {
                    setFullScreen(value);
                    setState(() => fullscreen = value);
                  },
                ),
              );
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(AppLocalizations.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(AppLocalizations.of(context).start),
        ),
      ],
    );
  }
}
