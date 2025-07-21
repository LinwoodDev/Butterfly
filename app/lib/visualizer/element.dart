import 'package:butterfly/visualizer/property.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

extension ElementVisualizer on PadElement {
  String getLocalizedName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      PenElement _ => loc.pen,
      TextElement _ => loc.text,
      ImageElement _ => loc.image,
      ShapeElement _ => loc.shape,
      SvgElement _ => loc.svg,
      MarkdownElement _ => loc.markdown,
      TextureElement _ => loc.texture,
    };
  }

  IconGetter get icon => switch (this) {
    PenElement _ => PhosphorIcons.pen,
    TextElement _ => PhosphorIcons.textT,
    ImageElement _ => PhosphorIcons.image,
    ShapeElement element => element.property.shape.icon,
    SvgElement _ => PhosphorIcons.fileSvg,
    MarkdownElement _ => PhosphorIcons.textbox,
    TextureElement e => e.texture.icon,
  };
}

extension ElementConstraintsVisualizer on ElementConstraints? {
  String getLocalizedName(BuildContext context) => switch (this) {
    FixedElementConstraints _ => AppLocalizations.of(context).fixed,
    ScaledElementConstraints _ => AppLocalizations.of(context).scaled,
    DynamicElementConstraints _ => AppLocalizations.of(context).dynamicContent,
    null => AppLocalizations.of(context).none,
  };

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
  String getLocalizedName(BuildContext context) => switch (this) {
    LabelMode.markdown => AppLocalizations.of(context).markdown,
    LabelMode.text => AppLocalizations.of(context).text,
  };

  IconGetter get icon => switch (this) {
    LabelMode.markdown => PhosphorIcons.textbox,
    LabelMode.text => PhosphorIcons.textT,
  };
}

extension SurfaceTextureVisualizer on SurfaceTexture {
  String getLocalizedName(BuildContext context) => switch (this) {
    PatternTexture() => AppLocalizations.of(context).pattern,
  };

  IconGetter get icon => switch (this) {
    PatternTexture() => PhosphorIcons.blueprint,
  };
}
