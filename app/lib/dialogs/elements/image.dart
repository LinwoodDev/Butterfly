import 'package:butterfly/api/open_image.dart';
import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/element.dart';
import '../constraints.dart';

class ImageElementDialog extends StatelessWidget {
  final int index;
  final VoidCallback close;
  final Offset position;

  const ImageElementDialog(
      {super.key,
      required this.index,
      required this.close,
      required this.position});

  @override
  Widget build(BuildContext context) {
    return GeneralElementDialog<ImageElement>(
      close: close,
      index: index,
      position: position,
      builder: (context, renderer, onChanged) {
        String constraints;
        final element = renderer.element;
        if (element.constraints is ScaledElementConstraints) {
          constraints = AppLocalizations.of(context)!.scaledConstraints;
        } else if (element.constraints is FixedElementConstraints) {
          constraints = AppLocalizations.of(context)!.fixedConstraints;
        } else if (element.constraints is DynamicElementConstraints) {
          constraints = AppLocalizations.of(context)!.dynamicConstraints;
        } else {
          constraints = AppLocalizations.of(context)!.none;
        }
        return [
          ListTile(
            title: Text(AppLocalizations.of(context)!.constraints),
            leading: const Icon(PhosphorIcons.selectionLight),
            subtitle: Text(constraints),
            onTap: () {
              close();
              showContextMenu(
                  context: context,
                  position: position,
                  builder: (context, close) => ConstraintsContextMenu(
                      position: position,
                      enableScaled: true,
                      initialConstraints: element.constraints,
                      close: close,
                      onChanged: (constraints) {
                        close();
                        onChanged(element.copyWith(constraints: constraints));
                      }));
            },
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.export),
            leading: const Icon(PhosphorIcons.exportLight),
            onTap: () {
              openImage(element.pixels);
            },
          ),
        ];
      },
    );
  }
}
