import 'package:butterfly/services/display_calibration.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/helpers/actual_size.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DisplayCalibrationSetting extends StatefulWidget {
  final bool showToggle;
  final bool showCalibration;

  const DisplayCalibrationSetting({
    super.key,
    this.showToggle = false,
    this.showCalibration = true,
  });

  @override
  State<DisplayCalibrationSetting> createState() =>
      _DisplayCalibrationSettingState();
}

class _DisplayCalibrationSettingState extends State<DisplayCalibrationSetting> {
  Future<DisplayCalibrationProfile>? _profile;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profile = null;
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<SettingsCubit, ButterflySettings>(
    builder: (context, settings) {
      if (!settings.hasFlag('calibratedZoom')) return const SizedBox.shrink();
      return FutureBuilder(
        future: _profile ??= readDisplayCalibrationProfile(context),
        builder: (context, snapshot) {
          final l10n = AppLocalizations.of(context);
          final key = snapshot.data?.key;
          final saved = key == null
              ? null
              : settings.getDisplayCalibration(key);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showToggle)
                SwitchListTile(
                  title: Text(l10n.calibratedZoom),
                  subtitle: Text(l10n.calibratedZoomDescription),
                  value: settings.useCalibratedZoom,
                  onChanged: !snapshot.hasData
                      ? null
                      : (enabled) async {
                          final zoom = saved ?? snapshot.data!.automaticZoom;
                          if (enabled &&
                              (zoom == null ||
                                  !zoom.isFinite ||
                                  zoom < kMinZoom ||
                                  zoom > kMaxZoom)) {
                            if (!await calibrateDisplay(context) || !mounted) {
                              return;
                            }
                          }
                          if (context.mounted) {
                            await context
                                .read<SettingsCubit>()
                                .changeUseCalibratedZoom(enabled);
                          }
                        },
                ),
              if (widget.showCalibration)
                ListTile(
                  leading: const PhosphorIcon(PhosphorIconsLight.ruler),
                  title: Text(l10n.calibrateDisplay),
                  subtitle: Text(l10n.displayCalibrationSettingsDescription),
                  onTap: () => calibrateDisplay(context),
                  trailing: saved == null
                      ? null
                      : IconButton.filledTonal(
                          tooltip: LeapLocalizations.of(context).reset,
                          icon: const PhosphorIcon(
                            PhosphorIconsLight.arrowCounterClockwise,
                          ),
                          onPressed: () async {
                            await context
                                .read<SettingsCubit>()
                                .changeDisplayCalibration(
                                  snapshot.data!.key,
                                  null,
                                );
                          },
                        ),
                ),
            ],
          );
        },
      );
    },
  );
}
