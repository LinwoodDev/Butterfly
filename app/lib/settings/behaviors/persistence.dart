import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../cubits/settings.dart';

class PersistenceBehaviorSettings extends StatelessWidget {
  const PersistenceBehaviorSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).persistenceDocumentStates),
      ),
      body: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: LeapBreakpoints.compact),
          child: BlocBuilder<SettingsCubit, ButterflySettings>(
            builder: (context, state) {
              final settings = state.documentStatePersistence;
              void change(DocumentStatePersistenceSettings next) {
                context.read<SettingsCubit>().changeDocumentStatePersistence(
                  next,
                );
              }

              return ListView(
                children: [
                  SwitchListTile(
                    value: settings.enabled,
                    secondary: const PhosphorIcon(PhosphorIconsLight.power),
                    title: const Text('Enable persistent document states'),
                    onChanged: (value) =>
                        change(settings.copyWith(enabled: value)),
                  ),
                  const Divider(),
                  SwitchListTile(
                    value: settings.page,
                    secondary: const PhosphorIcon(PhosphorIconsLight.file),
                    title: const Text('Current page'),
                    onChanged: settings.enabled
                        ? (value) => change(settings.copyWith(page: value))
                        : null,
                  ),
                  SwitchListTile(
                    value: settings.camera,
                    secondary: const PhosphorIcon(
                      PhosphorIconsLight.frameCorners,
                    ),
                    title: const Text('Viewport position and zoom'),
                    onChanged: settings.enabled
                        ? (value) => change(settings.copyWith(camera: value))
                        : null,
                  ),
                  SwitchListTile(
                    value: settings.locks,
                    secondary: const PhosphorIcon(PhosphorIconsLight.lockKey),
                    title: Text(AppLocalizations.of(context).lock),
                    onChanged: settings.enabled
                        ? (value) => change(settings.copyWith(locks: value))
                        : null,
                  ),
                  SwitchListTile(
                    value: settings.tool,
                    secondary: const PhosphorIcon(PhosphorIconsLight.toolbox),
                    title: const Text('Selected tool'),
                    onChanged: settings.enabled
                        ? (value) => change(settings.copyWith(tool: value))
                        : null,
                  ),
                  SwitchListTile(
                    value: settings.navigator,
                    secondary: const PhosphorIcon(PhosphorIconsLight.sidebar),
                    title: Text(AppLocalizations.of(context).navigator),
                    onChanged: settings.enabled
                        ? (value) => change(settings.copyWith(navigator: value))
                        : null,
                  ),
                  SwitchListTile(
                    value: settings.layers,
                    secondary: const PhosphorIcon(PhosphorIconsLight.stack),
                    title: Text(AppLocalizations.of(context).layers),
                    onChanged: settings.enabled
                        ? (value) => change(settings.copyWith(layers: value))
                        : null,
                  ),
                  SwitchListTile(
                    value: settings.areas,
                    secondary: const PhosphorIcon(PhosphorIconsLight.selection),
                    title: Text(AppLocalizations.of(context).areas),
                    onChanged: settings.enabled
                        ? (value) => change(settings.copyWith(areas: value))
                        : null,
                  ),
                  const Divider(),
                  ExactSlider(
                    header: const Text('Maximum stored records'),
                    leading: const PhosphorIcon(PhosphorIconsLight.listNumbers),
                    value: settings.maxEntries.toDouble(),
                    min: 20,
                    max: 2000,
                    defaultValue: 400,
                    fractionDigits: 0,
                    onChangeEnd: (value) =>
                        change(settings.copyWith(maxEntries: value.toInt())),
                  ),
                  ExactSlider(
                    header: const Text('Delete records older than days'),
                    leading: const PhosphorIcon(PhosphorIconsLight.calendar),
                    value: settings.maxAgeDays.toDouble(),
                    min: 7,
                    max: 730,
                    defaultValue: 180,
                    fractionDigits: 0,
                    onChangeEnd: (value) =>
                        change(settings.copyWith(maxAgeDays: value.toInt())),
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
