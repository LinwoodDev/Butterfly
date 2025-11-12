import 'package:butterfly_api/butterfly_text.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GeneralStyleView extends StatelessWidget {
  final TextStyleSheet value;
  final ValueChanged<TextStyleSheet> onChanged;
  final String name;
  final void Function(String) onNameChanged;

  const GeneralStyleView({
    super.key,
    required this.value,
    required this.onChanged,
    required this.name,
    required this.onNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            labelText: LeapLocalizations.of(context).name,
            icon: const PhosphorIcon(PhosphorIconsLight.textT),
            filled: true,
          ),
          initialValue: name,
          onChanged: onNameChanged,
        ),
      ],
    );
  }
}
