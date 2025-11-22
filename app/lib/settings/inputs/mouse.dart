import 'package:butterfly/api/open.dart';
import 'package:butterfly/theme.dart';
import 'package:butterfly/widgets/input_mapping_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/settings.dart';

class MouseInputSettings extends StatelessWidget {
  const MouseInputSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).mouse),
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
                        children: [
                          SwitchListTile(
                            value: state.hideCursorWhileDrawing,
                            title: Text(
                              AppLocalizations.of(
                                context,
                              ).hideCursorWhileDrawing,
                            ),
                            secondary: const PhosphorIcon(
                              PhosphorIconsLight.cursorClick,
                            ),
                            onChanged: (value) => context
                                .read<SettingsCubit>()
                                .changeHideCursorWhileDrawing(value),
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
                            inputName: AppLocalizations.of(context).left,
                            currentValue: config.leftMouse,
                            defaultValue: InputMappingDefault.leftMouse,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.mouseLeftClick,
                              textDirection: TextDirection.ltr,
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(leftMouse: value),
                              );
                            },
                          ),
                          InputMappingListTile(
                            inputName: AppLocalizations.of(context).middle,
                            currentValue: config.middleMouse,
                            defaultValue: InputMappingDefault.middleMouse,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.mouseMiddleClick,
                              textDirection: TextDirection.ltr,
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(middleMouse: value),
                              );
                            },
                          ),
                          InputMappingListTile(
                            inputName: AppLocalizations.of(context).right,
                            currentValue: config.rightMouse,
                            defaultValue: InputMappingDefault.rightMouse,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.mouseRightClick,
                              textDirection: TextDirection.ltr,
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(rightMouse: value),
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
