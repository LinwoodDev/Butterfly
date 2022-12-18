import 'package:butterfly/models/property.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension PathShapeVisualizer on PathShape {
  IconData getIcon({bool filled = false}) {
    return map(
      circle: (_) =>
          filled ? PhosphorIcons.circleFill : PhosphorIcons.circleLight,
      rectangle: (_) =>
          filled ? PhosphorIcons.squareFill : PhosphorIcons.squareLight,
      line: (_) => filled
          ? PhosphorIcons.lineSegmentFill
          : PhosphorIcons.lineSegmentLight,
    );
  }

  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return map(
      circle: (_) => loc.circle,
      rectangle: (_) => loc.rectangle,
      line: (_) => loc.line,
    );
  }
}
