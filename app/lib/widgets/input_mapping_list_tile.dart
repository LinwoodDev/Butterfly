import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/input.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InputMappingListTile extends StatelessWidget {
  final String inputName;
  final InputMapping currentValue;
  final InputMapping defaultValue;
  final Widget icon;
  final ValueChanged<InputMapping> onChanged;

  const InputMappingListTile({
    super.key,
    required this.inputName,
    required this.currentValue,
    required this.defaultValue,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(inputName),
      leading: icon,
      subtitle: Text(currentValue.getDescription(context)),
      trailing: currentValue != defaultValue
          ? IconButton(
              onPressed: () => onChanged(defaultValue),
              tooltip: LeapLocalizations.of(context).reset,
              icon: const PhosphorIcon(PhosphorIconsLight.clockClockwise),
            )
          : null,
      onTap: () =>
          openInputMappingModal(context, inputName, currentValue, onChanged),
    );
  }
}
