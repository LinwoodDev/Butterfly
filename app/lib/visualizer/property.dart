import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../helpers/icon_helper.dart';

extension PathShapeVisualizer on PathShape {
  IconGetter get icon {
    return map(
      circle: (_) => PhosphorIcons.circle,
      rectangle: (_) => PhosphorIcons.square,
      line: (_) => PhosphorIcons.lineSegment,
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
