import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
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
    if (metadata == null) {
      return const SizedBox();
    }
    void changeMetadata(FileMetadata metadata) {
      onChanged(value.setMetadata(metadata));
    }

    return ListView(
      children: [
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: LeapLocalizations.of(context).name,
            icon: const PhosphorIcon(PhosphorIconsLight.textT),
            filled: true,
          ),
          initialValue: metadata.name,
          onChanged: (value) => changeMetadata(metadata.copyWith(name: value)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).author,
            icon: const PhosphorIcon(PhosphorIconsLight.user),
            filled: true,
          ),
          initialValue: metadata.author,
          onChanged: (value) =>
              changeMetadata(metadata.copyWith(author: value)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).version,
            icon: const PhosphorIcon(PhosphorIconsLight.info),
            filled: true,
          ),
          initialValue: metadata.version,
          onChanged: (value) =>
              changeMetadata(metadata.copyWith(version: value)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).description,
            icon: const PhosphorIcon(PhosphorIconsLight.paragraph),
            border: const OutlineInputBorder(),
          ),
          minLines: 3,
          maxLines: 5,
          initialValue: metadata.description,
          onChanged: (value) =>
              changeMetadata(metadata.copyWith(description: value)),
        ),
      ],
    );
  }
}
