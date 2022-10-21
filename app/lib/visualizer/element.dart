import 'package:butterfly/visualizer/property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../models/element.dart';

extension ElementVisualizer on PadElement {
  String getLocalizedName(BuildContext context) {
    if (this is PenElement) {
      return AppLocalizations.of(context)!.pen;
    }
    if (this is LabelElement) {
      return AppLocalizations.of(context)!.label;
    }
    if (this is EraserElement) {
      return AppLocalizations.of(context)!.eraser;
    }
    if (this is ImageElement) {
      return AppLocalizations.of(context)!.image;
    }
    if (this is ShapeElement) {
      return AppLocalizations.of(context)!.shape;
    }
    if (this is SvgElement) {
      return AppLocalizations.of(context)!.svg;
    }
    throw UnimplementedError();
  }

  IconData getIcon() {
    if (this is PenElement) {
      return PhosphorIcons.penLight;
    }
    if (this is LabelElement) {
      return PhosphorIcons.textTLight;
    }
    if (this is EraserElement) {
      return PhosphorIcons.eraserLight;
    }
    if (this is ImageElement) {
      return PhosphorIcons.imageLight;
    }
    if (this is ShapeElement) {
      final shape = (this as ShapeElement).property.shape;
      return shape.getIcon();
    }
    if (this is SvgElement) {
      return PhosphorIcons.sunLight;
    }
    throw UnimplementedError();
  }
}

extension ElementConstraintsVisualizer on ElementConstraints? {
  String getLocalizedName(BuildContext context) {
    if (this is FixedElementConstraints) {
      return AppLocalizations.of(context)!.fixed;
    }
    if (this is ScaledElementConstraints) {
      return AppLocalizations.of(context)!.scaled;
    }
    if (this is DynamicElementConstraints) {
      return AppLocalizations.of(context)!.dynamicContent;
    }
    return AppLocalizations.of(context)!.none;
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
