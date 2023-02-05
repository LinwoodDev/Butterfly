import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension ElementVisualizer on PadElement {
  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return map(
      pen: (_) => loc.pen,
      label: (_) => loc.label,
      image: (_) => loc.image,
      shape: (_) => loc.shape,
      svg: (_) => loc.svg,
    );
  }

  IconData getIcon() {
    return map(
      pen: (_) => PhosphorIcons.penLight,
      label: (_) => PhosphorIcons.textTLight,
      image: (_) => PhosphorIcons.imageLight,
      shape: (element) => element.property.shape.getIcon(),
      svg: (_) => PhosphorIcons.sunLight,
    );
  }
}

extension ElementConstraintsVisualizer on ElementConstraints? {
  String getLocalizedName(BuildContext context) {
    return this?.map(
          fixed: (_) => AppLocalizations.of(context).fixed,
          scaled: (_) => AppLocalizations.of(context).scaled,
          dynamic: (_) => AppLocalizations.of(context).dynamicContent,
        ) ??
        AppLocalizations.of(context).none;
  }

  ElementConstraints scale(double scaleX, double scaleY) {
    final constraints = this;
    if (constraints is ScaledElementConstraints) {
      return constraints.copyWith(
        scaleX: constraints.scaleX * scaleX,
        scaleY: constraints.scaleY * scaleY,
      );
    } else if (constraints is FixedElementConstraints) {
      return constraints.copyWith(
        width: constraints.width * scaleX,
        height: constraints.height * scaleY,
      );
    } else if (constraints is DynamicElementConstraints) {
      if (constraints.aspectRatio != 0) {
        return constraints.copyWith(
          aspectRatio: constraints.aspectRatio * (scaleX / scaleY),
          width: constraints.width * scaleX,
          height: constraints.height * scaleY,
        );
      } else {
        return constraints.copyWith(
          width: constraints.width * scaleX,
          height: constraints.height * scaleY,
        );
      }
    }
    return ScaledElementConstraints(scaleX: scaleX, scaleY: scaleY);
  }
}
