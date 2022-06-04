import 'package:butterfly/dialogs/painters/general.dart';
import 'package:butterfly/widgets/color_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/painter.dart';
import '../../widgets/exact_slider.dart';

class LaserPainterDialog extends StatelessWidget {
  final int painterIndex;
  const LaserPainterDialog({super.key, required this.painterIndex});

  @override
  Widget build(BuildContext context) {
    return GeneralPainterDialog<LaserPainter>(
        index: painterIndex,
        title: AppLocalizations.of(context)!.laser,
        icon: PhosphorIcons.cursorLight,
        help: 'laser',
        builder: (context, painter, setPainter) => [
              ExactSlider(
                  header: Text(AppLocalizations.of(context)!.strokeWidth),
                  value: painter.strokeWidth,
                  min: 0,
                  max: 70,
                  defaultValue: 5,
                  onChanged: (value) =>
                      setPainter(painter.copyWith(strokeWidth: value))),
              ExactSlider(
                  header: Text(AppLocalizations.of(context)!.strokeMultiplier),
                  value: painter.strokeMultiplier,
                  min: 0,
                  max: 70,
                  defaultValue: 5,
                  onChanged: (value) =>
                      setPainter(painter.copyWith(strokeMultiplier: value))),
              const SizedBox(height: 10),
              ColorField(
                color: Color(painter.color),
                onChanged: (color) =>
                    setPainter(painter.copyWith(color: color.value)),
                title: Text(AppLocalizations.of(context)!.color),
              ),
              ExactSlider(
                  header: Text(AppLocalizations.of(context)!.duration),
                  value: painter.duration,
                  min: 0,
                  max: 30,
                  defaultValue: 5,
                  onChanged: (value) =>
                      setPainter(painter.copyWith(duration: value))),
            ]);
  }
}
