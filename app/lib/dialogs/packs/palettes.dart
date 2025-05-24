import 'package:butterfly/dialogs/packs/color_pick.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

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
    return Stack(
      children: [
        ListView(
          children: [
            const SizedBox(height: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: value
                  .getPalettes()
                  .map(
                    (e) => Dismissible(
                      key: ValueKey(e),
                      onDismissed: (direction) {
                        onChanged(value.removePalette(e));
                      },
                      child: ListTile(
                        title: Text(e),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ColorPalettePickerDialog(
                              palette: value.getPalette(e),
                              viewMode: true,
                              onChanged: (palette) {
                                onChanged(value.setPalette(e, palette));
                              },
                            ),
                          );
                        },
                        trailing: IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.trash),
                          onPressed: () async {
                            onChanged(value.removePalette(e));
                          },
                          tooltip: AppLocalizations.of(context).delete,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
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
        ),
      ],
    );
  }
}
