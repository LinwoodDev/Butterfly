import 'package:butterfly/api/open.dart';
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
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
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
                          const SizedBox(height: 16),
                          AdvancedTextField(
                            initialValue:
                                config.leftMouse?.add(1)?.toString() ?? '',
                            label: AppLocalizations.of(context).left,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.arrowLeft,
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(
                                  leftMouse: int.tryParse(value)?.subtract(1),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          AdvancedTextField(
                            initialValue:
                                config.middleMouse?.add(1)?.toString() ?? '',
                            label: AppLocalizations.of(context).middle,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.arrowUp,
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(
                                  middleMouse: int.tryParse(value)?.subtract(1),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          AdvancedTextField(
                            initialValue:
                                config.rightMouse?.add(1)?.toString() ?? '',
                            label: AppLocalizations.of(context).right,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.arrowRight,
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(
                                  rightMouse: int.tryParse(value)?.subtract(1),
                                ),
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
