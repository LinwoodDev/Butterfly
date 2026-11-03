import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

import 'widgets.dart';

class ToolPresetsPackView extends StatelessWidget {
  final NoteData value;
  final ValueChanged<NoteData> onChanged;

  const ToolPresetsPackView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PackAssetList(
      icon: PhosphorIconsLight.paintRoller,
      children: value
          .getToolPresets()
          .map(
            (name) => Dismissible(
              key: ValueKey(name),
              onDismissed: (_) => onChanged(value.removeToolPreset(name)),
              child: ListTile(
                leading: const PhosphorIcon(PhosphorIconsLight.paintRoller),
                title: Text(name),
                trailing: IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.trash),
                  tooltip: AppLocalizations.of(context).delete,
                  onPressed: () => onChanged(value.removeToolPreset(name)),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
