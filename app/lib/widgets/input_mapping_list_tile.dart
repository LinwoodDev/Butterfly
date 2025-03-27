import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/settings.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InputMappingListTile extends StatelessWidget {
  final String inputName;
  final InputMapping currentValue;
  final Icon icon;
  final VoidCallback setter;

  const InputMappingListTile({
    super.key,
    required this.inputName,
    required this.currentValue,
    required this.icon,
    required this.setter,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(inputName),
      leading: icon,
      subtitle: Text(currentValue.getDescription(context)),
      trailing: IconButton(
        onPressed: () {},
        tooltip: LeapLocalizations.of(context).reset,
        icon: const PhosphorIcon(PhosphorIconsLight.clockClockwise),
      ),
      onTap: () =>
          {openInputMappingModal(context, inputName, currentValue, setter)},
    );
  }
}
