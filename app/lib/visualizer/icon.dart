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

  static IconGetter from(Object tool) {
    if (tool is Tool && tool.displayIcon.isNotEmpty) {
      try {
        final displayIcon = tool.displayIcon;
        return DisplayIcons.values.byName(displayIcon).icon;
      } catch (_) {}
    }
    return recommended(tool).firstOrNull?.icon ?? PhosphorIcons.question;
  }

  static List<DisplayIcons> recommended(Object? tool) {
    return switch (tool) {
      PenTool _ => [
        DisplayIcons.pen,
        DisplayIcons.pencil,
        DisplayIcons.pencilSimple,
        DisplayIcons.penNib,
        DisplayIcons.highlighterCircle,
      ],
      _ => const [],
    };
  }
}
