import 'package:butterfly/theme.dart';
import 'package:butterfly/widgets/input_mapping_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/open.dart';
import '../../cubits/settings.dart';
import 'shortcut.dart';

class TouchInputSettings extends StatelessWidget {
  final ButterflySettings state;
  const TouchInputSettings({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final availableShortcuts = getInputShortcutOptions(context);

    final config = state.inputConfiguration;
    return Column(
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
                  title: Text(AppLocalizations.of(context).inputGestures),
                  secondary: const PhosphorIcon(PhosphorIconsLight.handTap),
                  onChanged: (value) =>
                      context.read<SettingsCubit>().changeInputGestures(value),
                ),
                SwitchListTile(
                  value: state.moveOnGesture,
                  title: Text(AppLocalizations.of(context).moveOnGesture),
                  secondary: const PhosphorIcon(
                    PhosphorIconsLight.arrowsOutCardinal,
                  ),
                  onChanged: (value) =>
                      context.read<SettingsCubit>().changeMoveOnGesture(value),
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
                        onPressed: () => openHelp(['shortcuts'], 'configure'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InputMappingListTile(
                  inputName: AppLocalizations.of(context).touch,
                  currentValue: config.touch,
                  defaultValue: InputMappingDefault.touch,
                  icon: const PhosphorIcon(PhosphorIconsLight.handPointing),
                  onChanged: (value) {
                    final cubit = context.read<SettingsCubit>();
                    cubit.changeInputConfiguration(
                      config.copyWith(touch: value),
                    );
                  },
                ),
                InputShortcutListTile(
                  inputName: AppLocalizations.of(context).doublePressAction,
                  currentValue: config.doubleTouchShortcut,
                  availableShortcuts: availableShortcuts,
                  icon: const PhosphorIcon(PhosphorIconsLight.handTap),
                  onChanged: (value) {
                    context.read<SettingsCubit>().changeInputConfiguration(
                      config.copyWith(doubleTouchShortcut: value),
                    );
                  },
                ),
                InputShortcutListTile(
                  inputName: AppLocalizations.of(context).triplePressAction,
                  currentValue: config.tripleTouchShortcut,
                  availableShortcuts: availableShortcuts,
                  icon: const PhosphorIcon(PhosphorIconsLight.handTap),
                  onChanged: (value) {
                    context.read<SettingsCubit>().changeInputConfiguration(
                      config.copyWith(tripleTouchShortcut: value),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
