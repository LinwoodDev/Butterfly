import 'package:butterfly/dialogs/painters/general.dart';
import 'package:butterfly/models/painter.dart';
import 'package:butterfly/widgets/color_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/exact_slider.dart';

class PenPainterDialog extends StatelessWidget {
  final int painterIndex;

  const PenPainterDialog({super.key, required this.painterIndex});

  @override
  Widget build(BuildContext context) {
    return GeneralPainterDialog<PenPainter>(
        index: painterIndex,
        title: AppLocalizations.of(context)!.pen,
        iconBuilder: (_, __) => PhosphorIcons.penLight,
        help: 'pen',
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
              const SizedBox(height: 50),
              ColorField(
                value: Color(painter.property.color),
                onChanged: (color) => setPainter(painter.copyWith(
                    property: painter.property.copyWith(color: color.value))),
                title: Text(AppLocalizations.of(context)!.color),
              ),
              const SizedBox(height: 15),
              CheckboxListTile(
                  value: painter.zoomDependent,
                  title: Text(AppLocalizations.of(context)!.zoomDependent),
                  onChanged: (value) => setPainter(painter.copyWith(
                      zoomDependent: value ?? painter.zoomDependent))),
              CheckboxListTile(
                  value: painter.property.fill,
                  title: Text(AppLocalizations.of(context)!.fill),
                  onChanged: (value) => setPainter(painter.copyWith(
                      property: painter.property
                          .copyWith(fill: value ?? painter.property.fill))))
            ]);
  }
}
