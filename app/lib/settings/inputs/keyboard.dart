import 'package:butterfly/actions/shortcuts.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:keybinder/keybinder.dart';

import '../../cubits/settings.dart';

class KeyboardInputSettings extends StatelessWidget {
  const KeyboardInputSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final generalShortcuts = [
      (newShortcut, AppLocalizations.of(context).newNote),
      (newFromTemplateShortcut, 'New from template'),
      (exportShortcut, AppLocalizations.of(context).export),
      (exportTextShortcut, 'Export as text'),
      (imageExportShortcut, 'Export as image'),
      (pdfExportShortcut, 'Export as PDF'),
      (svgExportShortcut, 'Export as SVG'),
      (packsShortcut, AppLocalizations.of(context).packs),
      (settingsShortcut, AppLocalizations.of(context).settings),
      (exitShortcut, AppLocalizations.of(context).exit),
    ];

    final projectShortcuts = [
      (searchShortcut, AppLocalizations.of(context).search),
      (undoShortcut, AppLocalizations.of(context).undo),
      (redoShortcut, AppLocalizations.of(context).redo),
      (backgroundShortcut, AppLocalizations.of(context).background),
      (saveShortcut, AppLocalizations.of(context).save),
      (changePathShortcut, 'Change path'),
      (zoomInShortcut, AppLocalizations.of(context).zoomIn),
      (zoomOutShortcut, AppLocalizations.of(context).zoomOut),
      (fullScreenShortcut, 'Full screen'),
      (hideUIShortcut, AppLocalizations.of(context).hideUI),
      (nextShortcut, AppLocalizations.of(context).nextSlide),
      (previousShortcut, AppLocalizations.of(context).previousSlide),
      (selectAllShortcut, AppLocalizations.of(context).selectAll),
      (pasteShortcut, AppLocalizations.of(context).paste),
      ...changeToolShortcuts.map(
        (e) => (e, 'Tool ${int.parse(e.id.split('_').last) + 1}'),
      ),
    ];

    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).keyboard),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: BlocBuilder<SettingsCubit, ButterflySettings>(
              builder: (context, state) => ListenableBuilder(
                listenable: keybinder,
                builder: (context, _) => Column(
                  children: [
                    Card(
                      margin: settingsCardMargin,
                      child: Padding(
                        padding: settingsCardPadding,
                        child: ListTile(
                          title: Text(AppLocalizations.of(context).shortcuts),
                          leading: const PhosphorIcon(
                            PhosphorIconsLight.keyboard,
                          ),
                          onTap: () => openHelp(['shortcuts'], 'keyboard'),
                          trailing: const PhosphorIcon(
                            PhosphorIconsLight.arrowSquareOut,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSection(
                      context,
                      AppLocalizations.of(context).general,
                      generalShortcuts,
                    ),
                    const SizedBox(height: 16),
                    _buildSection(context, 'Project', projectShortcuts),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<(ShortcutDefinition, String)> shortcuts,
  ) {
    return Card(
      margin: settingsCardMargin,
      child: Padding(
        padding: settingsCardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: settingsCardTitlePadding,
              child: Text(title, style: TextTheme.of(context).headlineSmall),
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final columns = width > 600 ? 2 : 1;
                final itemWidth = width / columns;

                return Wrap(
                  children: shortcuts
                      .map(
                        (e) => SizedBox(
                          width: itemWidth,
                          child: _buildShortcutTile(context, e.$1, e.$2),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShortcutTile(
    BuildContext context,
    ShortcutDefinition def,
    String title,
  ) {
    return KeyRecorderListTile(
      title: Text(title),
      currentActivator: keybinder.getActivator(def.id),
      onNewKey: (newKey) => keybinder.updateBinding(def.id, newKey),
      // Only set reset if it has not default
      onReset: keybinder.getActivator(def.id) != def.defaultActivator
          ? () => keybinder.resetBinding(def.id)
          : null,
    );
  }
}
