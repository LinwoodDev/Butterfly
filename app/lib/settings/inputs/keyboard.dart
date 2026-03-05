import 'package:butterfly/actions/shortcuts.dart';
import 'package:butterfly/api/open.dart';
import 'package:butterfly/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:keybinder/keybinder.dart';
import 'package:butterfly/dialogs/input.dart';

import '../../cubits/settings.dart';

class KeyboardInputSettings extends StatelessWidget {
  const KeyboardInputSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final generalShortcuts = [
      newShortcut,
      newFromTemplateShortcut,
      exportShortcut,
      exportTextShortcut,
      imageExportShortcut,
      pdfExportShortcut,
      svgExportShortcut,
      packsShortcut,
      settingsShortcut,
      exitShortcut,
    ];

    final projectShortcuts = [
      searchShortcut,
      undoShortcut,
      redoShortcut,
      backgroundShortcut,
      saveShortcut,
      changePathShortcut,
      zoomInShortcut,
      zoomOutShortcut,
      fullScreenShortcut,
      hideUIShortcut,
      nextShortcut,
      previousShortcut,
      selectAllShortcut,
      pasteShortcut,
      ...changeToolShortcuts,
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
                    _buildHoldShortcutsSection(
                      context,
                      state.inputConfiguration,
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

  Widget _buildHoldShortcutsSection(
    BuildContext context,
    InputConfiguration config,
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context).holdShortcuts,
                          style: TextTheme.of(context).headlineSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppLocalizations.of(context).holdShortcutsDescription,
                          style: TextTheme.of(context).bodyMedium?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.plus),
                    onPressed: () {
                      context.read<SettingsCubit>().changeInputConfiguration(
                        config.copyWith(
                          holdShortcuts: [
                            ...config.holdShortcuts,
                            const HoldShortcut(
                              keyId: 0,
                              mapping: InputMapping(InputMapping.handToolValue),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...config.holdShortcuts.asMap().entries.map((entry) {
              final index = entry.key;
              final shortcut = entry.value;
              return Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(shortcut.mapping.getDescription(context)),
                      subtitle: Text(AppLocalizations.of(context).action),
                      onTap: () {
                        openInputMappingModal(
                          context,
                          AppLocalizations.of(context).action,
                          shortcut.mapping,
                          (mapping) {
                            final newShortcuts = List<HoldShortcut>.from(
                              config.holdShortcuts,
                            );
                            newShortcuts[index] = shortcut.copyWith(
                              mapping: mapping,
                            );
                            context
                                .read<SettingsCubit>()
                                .changeInputConfiguration(
                                  config.copyWith(holdShortcuts: newShortcuts),
                                );
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: KeyRecorderListTile(
                      title: Text(AppLocalizations.of(context).key),
                      currentActivator: SingleActivator(
                        LogicalKeyboardKey(shortcut.keyId),
                      ),
                      onNewKey: (activator) {
                        final newShortcuts = List<HoldShortcut>.from(
                          config.holdShortcuts,
                        );
                        newShortcuts[index] = shortcut.copyWith(
                          keyId: activator.trigger.keyId,
                        );
                        context.read<SettingsCubit>().changeInputConfiguration(
                          config.copyWith(holdShortcuts: newShortcuts),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    icon: const PhosphorIcon(PhosphorIconsLight.trash),
                    onPressed: () {
                      final newShortcuts = List<HoldShortcut>.from(
                        config.holdShortcuts,
                      );
                      newShortcuts.removeAt(index);
                      context.read<SettingsCubit>().changeInputConfiguration(
                        config.copyWith(holdShortcuts: newShortcuts),
                      );
                    },
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<ShortcutDefinition> shortcuts,
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
                          child: _buildShortcutTile(
                            context,
                            e,
                            e.getLocalizedName(context),
                          ),
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
