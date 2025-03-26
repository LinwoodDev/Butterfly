import 'package:flutter/material.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InputMappingListTile extends StatelessWidget {
  final String inputName;
  final String currentValueDescription;
  final Icon icon;
  // final VoidCallback setter;

  const InputMappingListTile({
    super.key,
    required this.inputName,
    required this.currentValueDescription,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(inputName),
      leading: icon,
      subtitle: Text(currentValueDescription),
      trailing: IconButton(
        onPressed: () {},
        tooltip: LeapLocalizations.of(context).reset,
        icon: const PhosphorIcon(PhosphorIconsLight.clockClockwise),
      ),
      onTap: () => {},
    );
  }
}
