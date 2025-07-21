import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';

extension PathShapeVisualizer on PathShape {
  IconGetter get icon => switch (this) {
    CircleShape _ => PhosphorIcons.circle,
    RectangleShape _ => PhosphorIcons.square,
    LineShape _ => PhosphorIcons.lineSegment,
    TriangleShape _ => PhosphorIcons.triangle,
  };

  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      CircleShape _ => loc.circle,
      RectangleShape _ => loc.rectangle,
      LineShape _ => loc.line,
      TriangleShape _ => loc.triangle,
    };
  }
}
