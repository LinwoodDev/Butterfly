import 'package:butterfly_api/butterfly_models.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum DisplayIcons {
  pen(PhosphorIcons.pen),
  pencil(PhosphorIcons.pencil),
  pencilSimple(PhosphorIcons.pencilSimple),
  penNib(PhosphorIcons.penNib),
  highlighterCircle(PhosphorIcons.highlighterCircle);

  final IconGetter icon;

  const DisplayIcons(this.icon);

  static IconGetter from(Object painter) {
    try {
      final displayIcon = painter is Painter ? painter.displayIcon : null;
      return DisplayIcons.values.byName(displayIcon ?? '').icon;
    } catch (_) {
      return recommended(painter).firstOrNull?.icon ?? PhosphorIcons.question;
    }
  }

  static List<DisplayIcons> recommended(Object painter) {
    if (painter is! Painter) return const [];
    return painter.maybeMap(
        pen: (_) => [
              DisplayIcons.pen,
              DisplayIcons.pencil,
              DisplayIcons.pencilSimple,
              DisplayIcons.penNib,
              DisplayIcons.highlighterCircle,
            ],
        orElse: () => const []);
  }
}
