import 'package:butterfly/dialogs/painters/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/painter.dart';
import '../../widgets/exact_slider.dart';

class AreaPainterDialog extends StatelessWidget {
  final int painterIndex;

  const AreaPainterDialog({super.key, required this.painterIndex});

  @override
  Widget build(BuildContext context) {
    return GeneralPainterDialog<AreaPainter>(
        iconBuilder: (_, __) => PhosphorIcons.monitorLight,
        title: AppLocalizations.of(context)!.area,
        help: 'area',
        index: painterIndex,
        builder: (context, painter, setPainter) => [
              ExactSlider(
                  header: Text(AppLocalizations.of(context)!.width),
                  value: painter.constrainedWidth,
                  min: 0,
                  max: 500,
                  defaultValue: 0,
                  onChanged: (value) =>
                      setPainter(painter.copyWith(constrainedWidth: value))),
              ExactSlider(
                  header: Text(AppLocalizations.of(context)!.height),
                  value: painter.constrainedHeight,
                  min: 0,
                  max: 500,
                  defaultValue: 0,
                  onChanged: (value) =>
                      setPainter(painter.copyWith(constrainedHeight: value))),
              ExactSlider(
                  header: Row(
                    children: [
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.aspectRatio,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      PopupMenuButton<AreaRatioPreset>(
                        itemBuilder: (context) => AreaRatioPreset.values
                            .map((e) => PopupMenuItem(
                                  value: e,
                                  child: Text(e.getLocalizedName(context)),
                                ))
                            .toList(),
                        onSelected: (preset) => setPainter(painter.copyWith(
                            constrainedAspectRatio: preset.ratio)),
                        tooltip: AppLocalizations.of(context)!.presets,
                      )
                    ],
                  ),
                  value: painter.constrainedAspectRatio,
                  min: 0,
                  max: 10,
                  defaultValue: 0,
                  onChanged: (value) => setPainter(painter =
                      painter.copyWith(constrainedAspectRatio: value))),
            ]);
  }
}
