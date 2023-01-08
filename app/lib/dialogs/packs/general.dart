import 'package:butterfly/models/pack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralPackView extends StatelessWidget {
  final ButterflyPack pack;
  final ValueChanged<ButterflyPack> onChanged;

  const GeneralPackView({
    super.key,
    required this.pack,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.name,
            icon: const Icon(Icons.title_outlined),
            filled: true,
          ),
          initialValue: pack.name,
          onChanged: (value) => onChanged(pack.copyWith(name: value)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.author,
            icon: const Icon(Icons.person_outline),
            filled: true,
          ),
          initialValue: pack.author,
          onChanged: (value) => onChanged(pack.copyWith(author: value)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.description,
            icon: const Icon(Icons.description_outlined),
            border: const OutlineInputBorder(),
          ),
          minLines: 3,
          maxLines: 5,
          initialValue: pack.description,
          onChanged: (value) => onChanged(pack.copyWith(description: value)),
        ),
      ],
    );
  }
}
