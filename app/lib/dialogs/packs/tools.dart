import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

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
    return ListView(
      children: [
        const SizedBox(height: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: value
              .getToolPresets()
              .map(
                (e) => Dismissible(
                  key: ValueKey(e),
                  onDismissed: (direction) {
                    onChanged(value.removeToolPreset(e));
                  },
                  child: ListTile(
                    title: Text(e),
                    trailing: IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.trash),
                      onPressed: () async {
                        onChanged(value.removeToolPreset(e));
                      },
                      tooltip: AppLocalizations.of(context).delete,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
