import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/open.dart';
import '../../cubits/settings.dart';

class TouchInputSettings extends StatelessWidget {
  const TouchInputSettings({super.key});

  @override
  Widget build(BuildContext context) {
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
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CheckboxListTile(
                            value: state.inputGestures,
                            title: Text(
                              AppLocalizations.of(context).inputGestures,
                            ),
                            secondary:
                                const PhosphorIcon(PhosphorIconsLight.handTap),
                            onChanged: (value) => context
                                .read<SettingsCubit>()
                                .changeInputGestures(value ?? true),
                          ),
                          CheckboxListTile(
                            value: state.moveOnGesture,
                            title: Text(
                              AppLocalizations.of(context).moveOnGesture,
                            ),
                            secondary: const PhosphorIcon(
                              PhosphorIconsLight.arrowsOutCardinal,
                            ),
                            onChanged: (value) => context
                                .read<SettingsCubit>()
                                .changeMoveOnGesture(value ?? true),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                                config.touch?.add(1)?.toString() ?? '',
                            label: AppLocalizations.of(context).touch,
                            icon: const PhosphorIcon(PhosphorIconsLight.hand),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(
                                  touch: int.tryParse(value)?.subtract(1),
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
