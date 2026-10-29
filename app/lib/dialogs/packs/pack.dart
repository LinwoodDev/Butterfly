import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/dialogs/packs/tools.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_ui/material_ui.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'components.dart';
import 'fonts.dart';
import 'general.dart';
import 'palettes.dart';
import 'styles/view.dart';
import 'textures.dart';
import 'toolbars.dart';
import 'widgets.dart';

class PackDialog extends StatefulWidget {
  final NoteData? pack;

  const PackDialog({super.key, this.pack});

  @override
  State<PackDialog> createState() => _PackDialogState();
}

class _PackDialogState extends State<PackDialog> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late NoteData _pack;
  PackSection _section = PackSection.general;

  @override
  void initState() {
    super.initState();
    _pack = widget.pack ?? DocumentDefaults.createPack();
  }

  void _onChanged(NoteData pack) {
    setState(() {
      _pack = pack.setMetadata(
        pack.getMetadata()!.copyWith(updatedAt: DateTime.now().toUtc()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final title = widget.pack == null ? loc.createPack : loc.editPack;
    return ResponsiveDialog(
      constraints: const BoxConstraints(maxWidth: 1000, maxHeight: 800),
      clipBehavior: .antiAlias,
      builder: (context, fullscreen) => SizedBox(
        width: 1000,
        height: fullscreen ? double.infinity : 760,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final desktop = constraints.maxWidth >= 800;
            final page = KeyedSubtree(
              key: ValueKey(_section),
              child: _buildSection(),
            );
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  desktop ? title : _section.label(context),
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
                leading: desktop
                    ? IconButton.outlined(
                        icon: const PhosphorIcon(PhosphorIconsLight.x),
                        tooltip: MaterialLocalizations.of(context)
                            .closeButtonTooltip,
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    : null,
                actions: [
                  if (!desktop)
                    IconButton(
                      icon: const PhosphorIcon(PhosphorIconsLight.x),
                      tooltip: MaterialLocalizations.of(context)
                          .closeButtonTooltip,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                ],
              ),
              drawer: desktop
                  ? null
                  : SizedBox(
                      width: 320,
                      child: _buildNavigation(context, modal: true),
                    ),
              body: desktop
                  ? Row(
                      crossAxisAlignment: .stretch,
                      children: [
                        SizedBox(width: 320, child: _buildNavigation(context)),
                        const VerticalDivider(width: 1),
                        Expanded(
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            appBar: AppBar(
                              automaticallyImplyLeading: false,
                              backgroundColor: Colors.transparent,
                              title: Text(
                                _section.label(context),
                                maxLines: 1,
                                overflow: .ellipsis,
                              ),
                              actions: [
                                if (_section != PackSection.general)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Center(
                                      child: Text('${_section.count(_pack)}'),
                                    ),
                                  ),
                              ],
                            ),
                            body: page,
                          ),
                        ),
                      ],
                    )
                  : page,
              bottomNavigationBar: SafeArea(
                top: false,
                minimum: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: OverflowBar(
                  alignment: .end,
                  spacing: 8,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        MaterialLocalizations.of(context).cancelButtonLabel,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(_pack),
                      child: Text(
                        widget.pack == null
                            ? LeapLocalizations.of(context).create
                            : loc.save,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavigation(BuildContext context, {bool modal = false}) {
    final loc = AppLocalizations.of(context);
    return NavigationDrawer(
      selectedIndex: _section.index,
      onDestinationSelected: (index) {
        setState(() => _section = PackSection.values[index]);
        if (modal) _scaffoldKey.currentState?.closeDrawer();
      },
      header: Padding(
        padding: const EdgeInsets.fromLTRB(28, 16, 16, 24),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                getPackDisplayName(
                  _pack,
                  widget.pack == null ? loc.createPack : loc.editPack,
                ),
                maxLines: 1,
                softWrap: false,
                overflow: .ellipsis,
                style: TextTheme.of(context).titleMedium,
              ),
              if (_pack.getMetadata()?.author.isNotEmpty ?? false) ...[
                const SizedBox(height: 4),
                Text(
                  loc.byAuthor(_pack.getMetadata()!.author),
                  maxLines: 1,
                  softWrap: false,
                  overflow: .ellipsis,
                  style: TextTheme.of(context).bodySmall?.copyWith(
                    color: ColorScheme.of(context).onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      children: [
        for (final section in PackSection.values)
          NavigationDrawerDestination(
            icon: PhosphorIcon(section.icon),
            selectedIcon: PhosphorIcon(section.icon),
            label: Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        section.label(context),
                        maxLines: 1,
                        softWrap: false,
                        overflow: .ellipsis,
                      ),
                    ),
                    if (section != PackSection.general) ...[
                      const SizedBox(width: 8),
                      Text('${section.count(_pack)}'),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSection() => switch (_section) {
    PackSection.general => GeneralPackView(value: _pack, onChanged: _onChanged),
    PackSection.components => ComponentsPackView(
      value: _pack,
      onChanged: _onChanged,
    ),
    PackSection.styles => StylesPackView(value: _pack, onChanged: _onChanged),
    PackSection.palettes => PalettesPackView(
      value: _pack,
      onChanged: _onChanged,
    ),
    PackSection.textures => TexturesPackView(
      value: _pack,
      onChanged: _onChanged,
    ),
    PackSection.fonts => FontsPackView(value: _pack, onChanged: _onChanged),
    PackSection.toolbars => ToolbarsPackView(
      value: _pack,
      onChanged: _onChanged,
    ),
    PackSection.tools => ToolPresetsPackView(
      value: _pack,
      onChanged: _onChanged,
    ),
  };
}
