import 'package:butterfly/widgets/input_mapping_list_tile.dart';
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
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SwitchListTile(
                            value: state.penOnlyInput,
                            title: Text(
                              AppLocalizations.of(context).penOnlyInput,
                            ),
                            secondary: const PhosphorIcon(
                                PhosphorIconsLight.pencilSimpleLine),
                            onChanged: (value) => context
                                .read<SettingsCubit>()
                                .changePenOnlyInput(value),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
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
                          InputMappingListTile(
                            inputName: AppLocalizations.of(context).pen,
                            currentValue: config.pen,
                            defaultValue: InputMappingDefault.pen,
                            icon: const PhosphorIcon(PhosphorIconsLight.pen),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(
                                  pen: value,
                                ),
                              );
                            },
                          ),
                          InputMappingListTile(
                            inputName: AppLocalizations.of(context)
                                .first, // TODO: New phrasing?
                            currentValue: config.firstPenButton,
                            defaultValue: InputMappingDefault.firstPenButton,
                            icon: const PhosphorIcon(
                                PhosphorIconsLight.numberCircleOne),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(
                                  firstPenButton: value,
                                ),
                              );
                            },
                          ),
                          InputMappingListTile(
                            inputName: AppLocalizations.of(context)
                                .second, // TODO: New phrasing?
                            currentValue: config.secondPenButton,
                            defaultValue: InputMappingDefault.secondPenButton,
                            icon: const PhosphorIcon(
                                PhosphorIconsLight.numberCircleTwo),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(
                                  secondPenButton: value,
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
