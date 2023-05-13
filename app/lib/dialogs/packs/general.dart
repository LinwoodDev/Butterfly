import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      value.setMetadata(metadata);
      onChanged(value);
    }

    return ListView(
      children: [
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).name,
            icon: const PhosphorIcon(PhosphorIconsLight.textT),
            filled: true,
          ),
          initialValue: metadata.name,
          onChanged: (name) => changeMetadata(metadata.copyWith(name: name)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).author,
            icon: const PhosphorIcon(PhosphorIconsLight.person),
            filled: true,
          ),
          initialValue: metadata.author,
          onChanged: (author) =>
              changeMetadata(metadata.copyWith(author: author)),
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
          onChanged: (description) =>
              changeMetadata(metadata.copyWith(description: description)),
        ),
      ],
    );
  }
}
