import 'package:butterfly/dialogs/painters/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/painter.dart';
import '../../widgets/exact_slider.dart';

class PathEraserPainterDialog extends StatelessWidget {
  final int painterIndex;
  const PathEraserPainterDialog({super.key, required this.painterIndex});

  @override
  Widget build(BuildContext context) {
    return GeneralPainterDialog<PathEraserPainter>(
        index: painterIndex,
        title: AppLocalizations.of(context)!.pathEraser,
        iconBuilder: (_, __) => PhosphorIcons.pathLight,
        help: 'path_eraser',
        builder: (context, painter, setPainter) => [
              ExactSlider(
                  header: Text(AppLocalizations.of(context)!.strokeWidth),
                  value: painter.strokeWidth,
                  min: 0,
                  max: 70,
                  defaultValue: 5,
                  onChanged: (value) =>
                      setPainter(painter.copyWith(strokeWidth: value))),
              const SizedBox(height: 10),
              CheckboxListTile(
                  value: painter.includeEraser,
                  title: Text(AppLocalizations.of(context)!.includeEraser),
                  onChanged: (value) => setPainter(painter.copyWith(
                      includeEraser: value ?? painter.includeEraser))),
            ]);
  }
}
