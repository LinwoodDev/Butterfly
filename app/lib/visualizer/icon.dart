import 'package:butterfly_api/butterfly_models.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum DisplayIcons {
  pen(PhosphorIconsLight.pen, PhosphorIconsFill.pen),
  pencil(PhosphorIconsLight.pencil, PhosphorIconsFill.pencil),
  pencilSimple(PhosphorIconsLight.pencilSimple, PhosphorIconsFill.pencilSimple),
  penNib(PhosphorIconsLight.penNib, PhosphorIconsFill.penNib),
  highlighterCircle(
    PhosphorIconsLight.highlighterCircle,
    PhosphorIconsFill.highlighterCircle,
  );

  final PhosphorIconData lightIcon;
  final PhosphorIconData fillIcon;

  const DisplayIcons(this.lightIcon, this.fillIcon);

  // Flutter copies unreferenced package fonts unchanged. Keep one explicit
  // glyph from each remaining Phosphor family so its font is subsetted too.
  @pragma('vm:entry-point')
  static const fontSubsetAnchors = <PhosphorIconData>[
    PhosphorIconsBold.circle,
    PhosphorIconsRegular.circle,
    PhosphorIconsThin.circle,
  ];

  PhosphorIconData icon({bool filled = false}) => filled ? fillIcon : lightIcon;

  static PhosphorIconData from(Object tool, {bool filled = false}) {
    if (tool is Tool && tool.displayIcon.isNotEmpty) {
      try {
        final displayIcon = tool.displayIcon;
        return DisplayIcons.values.byName(displayIcon).icon(filled: filled);
      } catch (_) {}
    }
    return recommended(tool).firstOrNull?.icon(filled: filled) ??
        (filled ? PhosphorIconsFill.question : PhosphorIconsLight.question);
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
