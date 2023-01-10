import 'package:butterfly/models/pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralPackView extends StatelessWidget {
  final ButterflyPack value;
  final ValueChanged<ButterflyPack> onChanged;

  const GeneralPackView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).name,
            icon: const Icon(Icons.title_outlined),
            filled: true,
          ),
          initialValue: value.name,
          onChanged: (name) => onChanged(value.copyWith(name: name)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).author,
            icon: const Icon(Icons.person_outline),
            filled: true,
          ),
          initialValue: value.author,
          onChanged: (author) => onChanged(value.copyWith(author: author)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).description,
            icon: const Icon(Icons.description_outlined),
            border: const OutlineInputBorder(),
          ),
          minLines: 3,
          maxLines: 5,
          initialValue: value.description,
          onChanged: (description) =>
              onChanged(value.copyWith(description: description)),
        ),
      ],
    );
  }
}
