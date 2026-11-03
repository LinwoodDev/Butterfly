import 'package:butterfly/theme.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GeneralPackView extends StatelessWidget {
  final NoteData value;
  final ValueChanged<NoteData> onChanged;

  const GeneralPackView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final metadata = value.getMetadata();
    if (metadata == null) return const SizedBox();
    final loc = AppLocalizations.of(context);
    InputDecoration decoration(String label, IconData icon) => InputDecoration(
      labelText: label,
      icon: PhosphorIcon(icon),
      filled: true,
    );

    return ListView(
      children: [
        Card(
          margin: settingsCardMargin,
          child: Padding(
            padding: settingsCardPadding,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                TextFormField(
                  decoration: decoration(
                    LeapLocalizations.of(context).name,
                    PhosphorIconsLight.textT,
                  ),
                  initialValue: metadata.name,
                  onChanged: (name) => onChanged(
                    value.setMetadata(metadata.copyWith(name: name)),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: decoration(loc.author, PhosphorIconsLight.user),
                  initialValue: metadata.author,
                  onChanged: (author) => onChanged(
                    value.setMetadata(metadata.copyWith(author: author)),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: decoration(loc.version, PhosphorIconsLight.info),
                  initialValue: metadata.version,
                  onChanged: (version) => onChanged(
                    value.setMetadata(metadata.copyWith(version: version)),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: decoration(
                    loc.description,
                    PhosphorIconsLight.paragraph,
                  ).copyWith(alignLabelWithHint: true),
                  minLines: 3,
                  maxLines: 5,
                  initialValue: metadata.description,
                  onChanged: (description) => onChanged(
                    value.setMetadata(
                      metadata.copyWith(description: description),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
