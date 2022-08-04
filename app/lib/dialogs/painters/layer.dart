import 'package:butterfly/dialogs/painters/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/painter.dart';

class LayerPainterDialog extends StatelessWidget {
  final int painterIndex;

  const LayerPainterDialog({super.key, required this.painterIndex});

  @override
  Widget build(BuildContext context) {
    return GeneralPainterDialog<LayerPainter>(
        index: painterIndex,
        title: AppLocalizations.of(context)!.layer,
        iconBuilder: (_, __) => PhosphorIcons.squaresFourLight,
        help: 'layer',
        builder: (context, painter, setPainter) => [
              TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      labelText: AppLocalizations.of(context)!.layer),
                  initialValue: painter.layer,
                  onChanged: (value) =>
                      setPainter(painter.copyWith(layer: value))),
              const SizedBox(height: 10),
              CheckboxListTile(
                  value: painter.includeEraser,
                  title: Text(AppLocalizations.of(context)!.includeEraser),
                  onChanged: (value) => setPainter(painter.copyWith(
                      includeEraser: value ?? painter.includeEraser))),
            ]);
  }
}
