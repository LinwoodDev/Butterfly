import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
            icon: PhosphorIcon(PhosphorIcons.light.textT),
            filled: true,
          ),
          initialValue: value.name,
          onChanged: (name) => onChanged(value.copyWith(name: name)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).author,
            icon: PhosphorIcon(PhosphorIcons.light.person),
            filled: true,
          ),
          initialValue: value.author,
          onChanged: (author) => onChanged(value.copyWith(author: author)),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).description,
            icon: PhosphorIcon(PhosphorIcons.light.paragraph),
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
