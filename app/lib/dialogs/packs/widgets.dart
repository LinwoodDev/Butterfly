import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/theme.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum PackSection {
  general(PhosphorIconsLight.gear),
  components(PhosphorIconsLight.puzzlePiece),
  styles(PhosphorIconsLight.pencilCircle),
  palettes(PhosphorIconsLight.palette),
  textures(PhosphorIconsLight.imageSquare),
  fonts(PhosphorIconsLight.textAa),
  toolbars(PhosphorIconsLight.toolbox),
  tools(PhosphorIconsLight.paintRoller);

  final IconData icon;

  const PackSection(this.icon);

  String label(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return switch (this) {
      general => loc.general,
      components => loc.components,
      styles => loc.styles,
      palettes => loc.palettes,
      textures => loc.textures,
      fonts => loc.fonts,
      toolbars => loc.toolbars,
      tools => loc.tools,
    };
  }

  int count(NoteData pack) => switch (this) {
    general => 0,
    components => pack.getComponents().length,
    styles => pack.getStyles().length,
    palettes => pack.getPalettes().length,
    textures => pack.getTextures().length,
    fonts => pack.getFonts().length,
    toolbars => pack.getToolbars().length,
    tools => pack.getToolPresets().length,
  };
}

class PackEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? description;
  final Widget? action;

  const PackEmptyState({
    super.key,
    this.icon = PhosphorIconsLight.package,
    required this.title,
    this.description,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: .min,
          children: [
            PhosphorIcon(icon, size: 48, color: colors.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: .center,
              style: TextTheme.of(context).titleMedium,
            ),
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(
                description!,
                textAlign: .center,
                style: TextStyle(color: colors.onSurfaceVariant),
              ),
            ],
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}

/// Keeps collection actions visible without covering the last asset in a list.
class PackAssetList extends StatelessWidget {
  final List<Widget> children;
  final Widget? action;
  final IconData icon;

  const PackAssetList({
    super.key,
    required this.children,
    required this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Expanded(
          child: children.isEmpty
              ? PackEmptyState(
                  icon: icon,
                  title: AppLocalizations.of(context).noElements,
                )
              : ListView(
                  children: [
                    Card(
                      margin: settingsCardMargin,
                      clipBehavior: .antiAlias,
                      child: Padding(
                        padding: settingsCardPadding,
                        child: Column(
                          mainAxisSize: .min,
                          crossAxisAlignment: .stretch,
                          children: children,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        if (action != null) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: action,
            ),
          ),
        ],
      ],
    );
  }
}

class PackAssetCounts extends StatelessWidget {
  final NoteData pack;

  const PackAssetCounts({super.key, required this.pack});

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    final sections = PackSection.values
        .where(
          (section) =>
              section != PackSection.general && section.count(pack) > 0,
        )
        .toList();
    if (sections.isEmpty) {
      return Text(
        AppLocalizations.of(context).noElements,
        style: TextTheme.of(context).bodySmall
            ?.copyWith(color: colors.onSurfaceVariant),
      );
    }
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: sections.map((section) {
        final label = section.label(context);
        final count = section.count(pack);
        return Tooltip(
          message: '$label: $count',
          child: Semantics(
            label: '$label: $count',
            excludeSemantics: true,
            child: Chip(
              avatar: PhosphorIcon(section.icon, size: 16),
              label: Text('$count'),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        );
      }).toList(),
    );
  }
}
