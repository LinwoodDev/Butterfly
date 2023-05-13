import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension ElementVisualizer on PadElement {
  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return map(
      pen: (_) => loc.pen,
      text: (_) => loc.text,
      image: (_) => loc.image,
      shape: (_) => loc.shape,
      svg: (_) => loc.svg,
      markdown: (_) => loc.markdown,
    );
  }

  IconGetter get icon {
    return map(
      pen: (_) => PhosphorIcons.pen,
      text: (_) => PhosphorIcons.textT,
      image: (_) => PhosphorIcons.image,
      shape: (element) => element.property.shape.icon,
      svg: (_) => PhosphorIcons.sun,
      markdown: (_) => PhosphorIcons.textbox,
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

extension LabelModeVisualizer on LabelMode {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case LabelMode.markdown:
        return AppLocalizations.of(context).markdown;
      case LabelMode.text:
        return AppLocalizations.of(context).text;
    }
  }

  IconGetter get icon {
    switch (this) {
      case LabelMode.markdown:
        return PhosphorIcons.textbox;
      case LabelMode.text:
        return PhosphorIcons.textT;
    }
  }
}
