import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AdvancedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String initialValue, resetValue;
  final ValueChanged<String>? onChanged;
  final String? label;
  final Widget? icon;
  AdvancedTextField({
    super.key,
    this.initialValue = '',
    this.resetValue = '',
    this.onChanged,
    this.label,
    this.icon,
  }) : controller = TextEditingController(text: initialValue);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
        filled: true,
        suffix: IconButton(
          onPressed: () {
            controller.text = resetValue;
            onChanged?.call(resetValue);
          },
          icon: const Icon(PhosphorIcons.clockClockwiseLight),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
