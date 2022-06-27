import 'package:butterfly/models/property.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension PathShapeVisualizer on PathShape {
  IconData getIcon() {
    if (this is CircleShape) {
      return PhosphorIcons.circleLight;
    }
    if (this is RectangleShape) {
      return PhosphorIcons.squareLight;
    }
    if (this is LineShape) {
      return PhosphorIcons.lineSegmentLight;
    }

    throw UnimplementedError();
  }

  String getLocalizedName(BuildContext context) {
    if (this is CircleShape) {
      return AppLocalizations.of(context)!.circle;
    }
    if (this is RectangleShape) {
      return AppLocalizations.of(context)!.rectangle;
    }
    if (this is LineShape) {
      return AppLocalizations.of(context)!.line;
    }

    throw UnimplementedError();
  }
}
