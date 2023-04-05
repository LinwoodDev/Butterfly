import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension PathShapeVisualizer on PathShape {
  PhosphorIconData getIcon({bool filled = false}) {
    return map(
      circle: (_) =>
          filled ? PhosphorIcons.fill.circle : PhosphorIcons.light.circle,
      rectangle: (_) =>
          filled ? PhosphorIcons.fill.square : PhosphorIcons.light.square,
      line: (_) => filled
          ? PhosphorIcons.fill.lineSegment
          : PhosphorIcons.light.lineSegment,
    );
  }

  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return map(
      circle: (_) => loc.circle,
      rectangle: (_) => loc.rectangle,
      line: (_) => loc.line,
    );
  }
}
