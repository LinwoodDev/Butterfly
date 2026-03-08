import 'package:butterfly/theme.dart';
import 'package:butterfly/widgets/input_mapping_list_tile.dart';
import 'package:butterfly/actions/shortcuts.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/open.dart';
import '../../cubits/settings.dart';

void _showShortcutPicker(
  BuildContext context,
  String title,
  List<(String?, String)> availableShortcuts,
  String? currentValue,
  ValueChanged<String?> onChanged,
) {
  showLeapBottomSheet(
    context: context,
    titleBuilder: (ctx) => Text(title),
    childrenBuilder: (ctx) => [
      RadioGroup<String?>(
        groupValue: currentValue,
        onChanged: (val) {
          onChanged(val);
          Navigator.of(context).pop();
        },
        child: Column(
          children: availableShortcuts
              .map(
                (e) => RadioListTile<String?>(value: e.$1, title: Text(e.$2)),
              )
              .toList(),
        ),
      ),
    ],
  );
}

class TouchInputSettings extends StatelessWidget {
  const TouchInputSettings({super.key});

  @override
  Widget build(BuildContext context) {
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
      selectAllShortcut,
      pasteShortcut,
      ...changeToolShortcuts,
    ];

    final availableShortcuts = [
      (null, AppLocalizations.of(context).none),
      ('long_press', AppLocalizations.of(context).longPress),
      ...projectShortcuts.map((e) => (e.id, e.getLocalizedName(context))),
    ];

    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).touch),
      ),
      body: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
          child: BlocBuilder<SettingsCubit, ButterflySettings>(
            builder: (context, state) {
              final config = state.inputConfiguration;
              return ListView(
                children: [
                  Card(
                    margin: settingsCardMargin,
                    child: Padding(
                      padding: settingsCardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SwitchListTile(
                            value: state.inputGestures,
                            title: Text(
                              AppLocalizations.of(context).inputGestures,
                            ),
                            secondary: const PhosphorIcon(
                              PhosphorIconsLight.handTap,
                            ),
                            onChanged: (value) => context
                                .read<SettingsCubit>()
                                .changeInputGestures(value),
                          ),
                          SwitchListTile(
                            value: state.moveOnGesture,
                            title: Text(
                              AppLocalizations.of(context).moveOnGesture,
                            ),
                            secondary: const PhosphorIcon(
                              PhosphorIconsLight.arrowsOutCardinal,
                            ),
                            onChanged: (value) => context
                                .read<SettingsCubit>()
                                .changeMoveOnGesture(value),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: settingsCardMargin,
                    child: Padding(
                      padding: settingsCardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: settingsCardTitlePadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context).shortcuts,
                                  style: TextTheme.of(context).headlineSmall,
                                ),
                                IconButton(
                                  icon: const PhosphorIcon(
                                    PhosphorIconsLight.sealQuestion,
                                  ),
                                  tooltip: AppLocalizations.of(context).help,
                                  onPressed: () =>
                                      openHelp(['shortcuts'], 'configure'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          InputMappingListTile(
                            inputName: AppLocalizations.of(context).touch,
                            currentValue: config.touch,
                            defaultValue: InputMappingDefault.touch,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.handPointing,
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(touch: value),
                              );
                            },
                          ),
                          ListTile(
                            leading: const PhosphorIcon(
                              PhosphorIconsLight.handTap,
                            ),
                            title: Text(
                              AppLocalizations.of(context).doublePressAction,
                            ),
                            subtitle: Text(
                              availableShortcuts
                                      .firstWhereOrNull(
                                        (e) =>
                                            e.$1 == config.doubleTouchShortcut,
                                      )
                                      ?.$2 ??
                                  AppLocalizations.of(context).none,
                            ),
                            onTap: () {
                              _showShortcutPicker(
                                context,
                                AppLocalizations.of(context).doublePressAction,
                                availableShortcuts,
                                config.doubleTouchShortcut,
                                (value) {
                                  context
                                      .read<SettingsCubit>()
                                      .changeInputConfiguration(
                                        config.copyWith(
                                          doubleTouchShortcut: value,
                                        ),
                                      );
                                },
                              );
                            },
                          ),
                          ListTile(
                            leading: const PhosphorIcon(
                              PhosphorIconsLight.handTap,
                            ),
                            title: Text(
                              AppLocalizations.of(context).triplePressAction,
                            ),
                            subtitle: Text(
                              availableShortcuts
                                      .firstWhereOrNull(
                                        (e) =>
                                            e.$1 == config.tripleTouchShortcut,
                                      )
                                      ?.$2 ??
                                  AppLocalizations.of(context).none,
                            ),
                            onTap: () {
                              _showShortcutPicker(
                                context,
                                AppLocalizations.of(context).triplePressAction,
                                availableShortcuts,
                                config.tripleTouchShortcut,
                                (value) {
                                  context
                                      .read<SettingsCubit>()
                                      .changeInputConfiguration(
                                        config.copyWith(
                                          tripleTouchShortcut: value,
                                        ),
                                      );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
