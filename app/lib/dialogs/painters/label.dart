import 'package:butterfly/dialogs/painters/general.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../models/painter.dart';
import '../../selections/selection.dart';

class LabelPainterDialog extends StatelessWidget {
  final int painterIndex;

  const LabelPainterDialog({super.key, required this.painterIndex});

  @override
  Widget build(BuildContext context) {
    return GeneralPainterDialog<LabelPainter>(
        index: painterIndex,
        title: AppLocalizations.of(context)!.label,
        iconBuilder: (_, __) => PhosphorIcons.textTLight,
        help: 'label',
        builder: (context, painter, setPainter) => [
              LabelPropertyView(
                  initialValue: painter.property,
                  onChanged: (property) =>
                      setPainter(painter.copyWith(property: property))),
            ]);
  }
}
