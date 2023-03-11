import 'package:butterfly/dialogs/color_pick.dart';
import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PalettesPackView extends StatelessWidget {
  final ButterflyPack value;
  final ValueChanged<ButterflyPack> onChanged;

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
              children: value.palettes
                  .asMap()
                  .entries
                  .map(
                    (e) => Dismissible(
                      key: ValueKey(e.key),
                      onDismissed: (direction) {
                        onChanged(value.copyWith(
                          palettes: value.palettes..removeAt(e.key),
                        ));
                      },
                      child: ListTile(
                        title: Text(e.value.name),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => ColorPickerDialog(
                              palette: e.value,
                              viewMode: true,
                              onChanged: (palette) {
                                onChanged(value.copyWith(
                                  palettes: List<ColorPalette>.from(
                                    value.palettes,
                                  )..[e.key] = palette,
                                ));
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
                  validator: defaultNameValidator(
                      context, value.palettes.map((e) => e.name).toList()),
                ),
              );
              if (name == null) return;
              onChanged(value.copyWith(
                palettes: List<ColorPalette>.from(value.palettes)
                  ..add(ColorPalette(name: name)),
              ));
            },
            icon: const Icon(PhosphorIcons.plusLight),
            label: Text(AppLocalizations.of(context).create),
          ),
        ),
      ],
    );
  }
}
