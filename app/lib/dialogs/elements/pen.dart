import 'package:butterfly/dialogs/elements/general.dart';
import 'package:butterfly/widgets/color_field.dart';
import 'package:butterfly/widgets/context_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/element.dart';

class PenElementDialog extends StatelessWidget {
  final int index;
  final ContextCloseFunction close;
  final Offset position;

  const PenElementDialog(
      {super.key,
      required this.index,
      required this.close,
      required this.position});

  @override
  Widget build(BuildContext context) {
    return GeneralElementDialog<PenElement>(
      index: index,
      close: close,
      position: position,
      builder: (context, renderer, onChanged) => [
        ColorField(
          title: Text(AppLocalizations.of(context)!.color),
          value: Color(renderer.element.property.color),
          onOpen: () => close(),
          onChanged: (color) {
            onChanged(renderer.element.copyWith(
                property:
                    renderer.element.property.copyWith(color: color.value)));
          },
        ),
      ],
    );
  }
}
