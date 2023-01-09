import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../models/text.dart';

class GeneralStyleView extends StatelessWidget {
  final TextStyleSheet styleSheet;
  final ValueChanged<TextStyleSheet> onChanged;

  const GeneralStyleView({
    super.key,
    required this.styleSheet,
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
          initialValue: styleSheet.name,
          onChanged: (value) => onChanged(styleSheet.copyWith(name: value)),
        ),
      ],
    );
  }
}
