import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/painter.dart';
import '../../widgets/exact_slider.dart';
import 'general.dart';

class EraserPainterDialog extends StatelessWidget {
  final int painterIndex;
  const EraserPainterDialog({super.key, required this.painterIndex});

  @override
  Widget build(BuildContext context) {
    return GeneralPainterDialog<EraserPainter>(
        index: painterIndex,
        title: AppLocalizations.of(context)!.eraser,
        iconBuilder: (_, __) => PhosphorIcons.eraserLight,
        help: 'eraser',
        builder: (context, painter, setPainter) => [
              ExactSlider(
                  header: Text(AppLocalizations.of(context)!.strokeWidth),
                  value: painter.property.strokeWidth,
                  min: 0,
                  max: 70,
                  defaultValue: 5,
                  onChanged: (value) => setPainter(painter.copyWith(
                      property:
                          painter.property.copyWith(strokeWidth: value)))),
              ExactSlider(
                  header: Text(AppLocalizations.of(context)!.strokeMultiplier),
                  value: painter.property.strokeMultiplier,
                  min: 0,
                  max: 70,
                  defaultValue: 5,
                  onChanged: (value) => setPainter(painter.copyWith(
                      property:
                          painter.property.copyWith(strokeMultiplier: value)))),
            ]);
  }
}
