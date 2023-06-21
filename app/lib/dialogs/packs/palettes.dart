import 'package:butterfly/dialogs/color_pick.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                        value.removePalette(e);
                        onChanged(value);
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
                                value.setPalette(palette);
                                onChanged(value);
                              },
                            ),
                          );
                        },
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
                  validator:
                      defaultFileNameValidator(context, value.getPalettes()),
                ),
              );
              if (name == null) return;
              value.setPalette(ColorPalette(name: name));
              onChanged(value);
            },
            icon: const PhosphorIcon(PhosphorIconsLight.plus),
            label: Text(AppLocalizations.of(context).create),
          ),
        ),
      ],
    );
  }
}
