import 'package:butterfly/api/open.dart';
import 'package:butterfly/helpers/int_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/settings.dart';
import '../../widgets/exact_slider.dart';

class MouseBehaviorSettings extends StatelessWidget {
  const MouseBehaviorSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.mouse),
      ),
      body: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
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
                          ExactSlider(
                              min: 0,
                              max: 100,
                              value: state.mouseSensitivity,
                              header: Row(children: [
                                const Icon(PhosphorIcons.lightningLight),
                                const SizedBox(width: 8),
                                Text(AppLocalizations.of(context)!.sensitivity),
                              ]),
                              onChangeEnd: (value) {
                                final cubit = context.read<SettingsCubit>();
                                cubit.changeMouseSensitivity(value);
                              }),
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
                                AppLocalizations.of(context)!.shortcuts,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              IconButton(
                                icon: const Icon(
                                    PhosphorIcons.circleWavyQuestionLight),
                                onPressed: () =>
                                    openHelp(['shortcuts'], 'configure'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue:
                                config.leftMouse?.add(1)?.toString() ?? '',
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.left,
                              prefixIcon:
                                  const Icon(PhosphorIcons.arrowLeftLight),
                              suffix: IconButton(
                                  onPressed: () {
                                    final cubit = context.read<SettingsCubit>();
                                    cubit.changeInputConfiguration(
                                        config.copyWith(leftMouse: null));
                                  },
                                  icon: const Icon(
                                      PhosphorIcons.clockClockwiseLight)),
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(config.copyWith(
                                  leftMouse: int.tryParse(value)?.subtract(1)));
                            },
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue:
                                config.middleMouse?.add(1)?.toString() ?? '',
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.middle,
                              prefixIcon:
                                  const Icon(PhosphorIcons.arrowUpLight),
                              suffix: IconButton(
                                  onPressed: () {
                                    final cubit = context.read<SettingsCubit>();
                                    cubit.changeInputConfiguration(
                                        config.copyWith(middleMouse: 2));
                                  },
                                  icon: const Icon(
                                      PhosphorIcons.clockClockwiseLight)),
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(config.copyWith(
                                  middleMouse:
                                      int.tryParse(value)?.subtract(1)));
                            },
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue:
                                config.rightMouse?.add(1)?.toString() ?? '',
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.right,
                              prefixIcon:
                                  const Icon(PhosphorIcons.arrowRightLight),
                              suffix: IconButton(
                                  onPressed: () {
                                    final cubit = context.read<SettingsCubit>();
                                    cubit.changeInputConfiguration(
                                        config.copyWith(rightMouse: 1));
                                  },
                                  icon: const Icon(
                                      PhosphorIcons.clockClockwiseLight)),
                            ),
                            onChanged: (value) {
                              final cubit = context.read<SettingsCubit>();
                              cubit.changeInputConfiguration(config.copyWith(
                                  rightMouse:
                                      int.tryParse(value)?.subtract(1)));
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
