import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../api/open.dart';
import '../../cubits/settings.dart';

class PenInputSettings extends StatelessWidget {
  const PenInputSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).pen),
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
                          const SizedBox(height: 8),
                          CheckboxListTile(
                            value: state.penOnlyInput,
                            title: Text(
                              AppLocalizations.of(context).penOnlyInput,
                            ),
                            onChanged: (value) => context
                                .read<SettingsCubit>()
                                .changePenOnlyInput(value ?? false),
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
                            initialValue: config.pen?.add(1)?.toString() ?? '',
                            label: AppLocalizations.of(context).pen,
                            icon: const PhosphorIcon(PhosphorIconsLight.pen),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(
                                  pen: int.tryParse(value)?.subtract(1),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          AdvancedTextField(
                            initialValue:
                                config.firstPenButton?.add(1)?.toString() ?? '',
                            label: AppLocalizations.of(context).first,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.numberCircleOne,
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(
                                  firstPenButton: int.tryParse(
                                    value,
                                  )?.subtract(1),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          AdvancedTextField(
                            initialValue:
                                config.secondPenButton?.add(1)?.toString() ??
                                    '',
                            label: AppLocalizations.of(context).second,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.numberCircleTwo,
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(
                                  secondPenButton: int.tryParse(
                                    value,
                                  )?.subtract(1),
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
