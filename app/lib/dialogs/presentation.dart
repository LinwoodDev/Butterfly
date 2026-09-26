import 'package:material_ui/material_ui.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PresentationControlsDialog extends StatelessWidget {
  final bool fullScreen;

  const PresentationControlsDialog({super.key, required this.fullScreen});

  @override
  Widget build(BuildContext context) {
    var selectedFullScreen = fullScreen;
    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: Text(AppLocalizations.of(context).presentationControls),
        scrollable: true,
        content: Column(
          mainAxisSize: .min,
          children: [
            ...[
              (
                PhosphorIconsLight.arrowRight,
                AppLocalizations.of(context).nextSlide,
                AppLocalizations.of(context).nextSlideDescription,
              ),
              (
                PhosphorIconsLight.arrowLeft,
                AppLocalizations.of(context).previousSlide,
                AppLocalizations.of(context).previousSlideDescription,
              ),
              (
                PhosphorIconsLight.pauseCircle,
                AppLocalizations.of(context).pausePresentation,
                AppLocalizations.of(context).pausePresentationDescription,
              ),
              (
                PhosphorIconsLight.door,
                AppLocalizations.of(context).exitPresentation,
                AppLocalizations.of(context).exitPresentationDescription,
              ),
            ].map(
              (e) => ListTile(
                leading: PhosphorIcon(e.$1),
                title: Text(e.$2),
                subtitle: Text(e.$3),
              ),
            ),
            SwitchListTile(
              value: selectedFullScreen,
              title: Text(LeapLocalizations.of(context).fullScreen),
              onChanged: (value) => setState(() => selectedFullScreen = value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(selectedFullScreen),
            child: Text(AppLocalizations.of(context).start),
          ),
        ],
      ),
    );
  }
}
