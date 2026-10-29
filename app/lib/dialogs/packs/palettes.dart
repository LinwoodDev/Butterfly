import 'package:butterfly/dialogs/packs/color_pick.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

import 'widgets.dart';

class PalettesPackView extends StatelessWidget {
  final NoteData value;
  final ValueChanged<NoteData> onChanged;

  const PalettesPackView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PackAssetList(
      icon: PhosphorIconsLight.palette,
      action: ElevatedButton.icon(
        onPressed: () async {
          final name = await showDialog<String>(
            context: context,
            builder: (context) => NameDialog(
              validator: defaultFileNameValidator(
                context,
                value.getPalettes().toList(),
              ),
            ),
          );
          if (name == null) return;
          onChanged(value.setPalette(name, ColorPalette()));
        },
        icon: const PhosphorIcon(PhosphorIconsLight.plus),
        label: Text(LeapLocalizations.of(context).create),
      ),
      children: value
          .getPalettes()
          .map(
            (name) => Dismissible(
              key: ValueKey(name),
              onDismissed: (_) => onChanged(value.removePalette(name)),
              child: ListTile(
                leading: const PhosphorIcon(PhosphorIconsLight.palette),
                title: Text(name),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => ColorPalettePickerDialog(
                    palette: value.getPalette(name),
                    viewMode: true,
                    name: name,
                    onChanged: (palette, newName) {
                      var pack = value;
                      if (newName != null) pack = pack.removePalette(name);
                      onChanged(pack.setPalette(newName ?? name, palette));
                    },
                  ),
                ),
                trailing: IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.trash),
                  tooltip: AppLocalizations.of(context).delete,
                  onPressed: () => onChanged(value.removePalette(name)),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
