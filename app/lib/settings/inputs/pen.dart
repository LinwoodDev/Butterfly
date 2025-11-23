import 'package:butterfly/theme.dart';
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

  String _getIgnorePressureName(
    IgnorePressure ignorePressure,
    BuildContext context,
  ) => switch (ignorePressure) {
    IgnorePressure.never => AppLocalizations.of(context).never,
    IgnorePressure.first => AppLocalizations.of(context).first,
    IgnorePressure.always => AppLocalizations.of(context).always,
  };

  String? _getIgnorePressureDescription(
    IgnorePressure ignorePressure,
    BuildContext context,
  ) => switch (ignorePressure) {
    IgnorePressure.first => AppLocalizations.of(
      context,
    ).ignoreFirstPressureDescription,
    _ => null,
  };

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
                    margin: settingsCardMargin,
                    child: Padding(
                      padding: settingsCardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SwitchListTile(
                            value: state.penOnlyInput,
                            title: Text(
                              AppLocalizations.of(context).penOnlyInput,
                            ),
                            secondary: const PhosphorIcon(
                              PhosphorIconsLight.pencilSimpleLine,
                            ),
                            onChanged: (value) => context
                                .read<SettingsCubit>()
                                .changePenOnlyInput(value),
                          ),
                          ListTile(
                            title: Text(
                              AppLocalizations.of(context).ignorePressure,
                            ),
                            subtitle: Text(
                              _getIgnorePressureName(
                                state.ignorePressure,
                                context,
                              ),
                            ),
                            leading: const PhosphorIcon(
                              PhosphorIconsLight.lineSegments,
                            ),
                            onTap: () {
                              final cubit = context.read<SettingsCubit>();
                              final ignorePressure = cubit.state.ignorePressure;

                              showLeapBottomSheet(
                                context: context,
                                titleBuilder: (context) => Text(
                                  AppLocalizations.of(context).ignorePressure,
                                ),
                                childrenBuilder: (context) {
                                  return [
                                    ...IgnorePressure.values.map((e) {
                                      final description =
                                          _getIgnorePressureDescription(
                                            e,
                                            context,
                                          );
                                      return ListTile(
                                        title: Text(
                                          _getIgnorePressureName(e, context),
                                        ),
                                        subtitle: description != null
                                            ? Text(description)
                                            : null,
                                        selected: e == ignorePressure,
                                        onTap: () {
                                          cubit.changeIgnorePressure(e);
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }),
                                  ];
                                },
                              );
                            },
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
                            inputName: AppLocalizations.of(context).pen,
                            currentValue: config.pen,
                            defaultValue: InputMappingDefault.pen,
                            icon: const PhosphorIcon(PhosphorIconsLight.pen),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(pen: value),
                              );
                            },
                          ),
                          InputMappingListTile(
                            inputName: AppLocalizations.of(context).invertedPen,
                            currentValue: config.invertedPen,
                            defaultValue: InputMappingDefault.invertedPen,
                            icon: Transform.flip(
                              flipX: true,
                              flipY: true,
                              child: PhosphorIcon(PhosphorIconsLight.pen),
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(invertedPen: value),
                              );
                            },
                          ),
                          InputMappingListTile(
                            inputName: AppLocalizations.of(context).first,
                            currentValue: config.firstPenButton,
                            defaultValue: InputMappingDefault.firstPenButton,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.numberCircleOne,
                              textDirection: TextDirection.ltr,
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(firstPenButton: value),
                              );
                            },
                          ),
                          InputMappingListTile(
                            inputName: AppLocalizations.of(context).second,
                            currentValue: config.secondPenButton,
                            defaultValue: InputMappingDefault.secondPenButton,
                            icon: const PhosphorIcon(
                              PhosphorIconsLight.numberCircleTwo,
                              textDirection: TextDirection.ltr,
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(
                                config.copyWith(secondPenButton: value),
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
