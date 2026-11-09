import 'dart:convert';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/dialogs/display_calibration.dart';
import 'package:butterfly/helpers/actual_size.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_ui/material_ui.dart';

Future<DisplayCalibrationProfile> readDisplayCalibrationProfile(
  BuildContext context,
) async {
  final display = View.of(context).display;
  final ratio = MediaQuery.devicePixelRatioOf(context);
  final metrics = await SysAPI.getDisplayMetrics();
  // Prefer the model name across restarts; native session IDs are only a
  // fallback. Browsers may not distinguish monitors with identical reports.
  final key = jsonEncode([
    kIsWeb ? 'web' : defaultTargetPlatform.name,
    metrics?.name ?? metrics?.displayId ?? display.id,
    display.size.width,
    display.size.height,
    ratio,
    metrics?.dpiX,
    metrics?.dpiY,
  ]);
  return DisplayCalibrationProfile(key, metrics, ratio);
}

double displayZoom(BuildContext context, {bool listen = false}) {
  final settings = listen
      ? context.watch<SettingsCubit>().state
      : context.read<SettingsCubit>().state;
  if (!settings.hasFlag('calibratedZoom') || !settings.useCalibratedZoom) {
    return 1;
  }
  final profile = listen
      ? context.select<EditorViewCubit, DisplayCalibrationProfile?>(
          (cubit) => cubit.state.displayCalibration,
        )
      : context.read<EditorViewCubit>().state.displayCalibration;
  if (profile == null) return 1;
  final zoom =
      settings.getDisplayCalibration(profile.key) ?? profile.automaticZoom;
  return zoom != null && zoom.isFinite && zoom >= kMinZoom && zoom <= kMaxZoom
      ? zoom
      : 1;
}

Future<bool> calibrateDisplay(BuildContext context) async {
  final profile = await readDisplayCalibrationProfile(context);
  if (!context.mounted) return false;
  final settings = context.read<SettingsCubit>();
  final saved = settings.state.getDisplayCalibration(profile.key);
  final zoom = await showDialog<double>(
    context: context,
    builder: (_) => DisplayCalibrationDialog(
      initialZoom: saved ?? profile.automaticZoom,
      metrics: profile.metrics,
    ),
  );
  if (zoom == null || !context.mounted) return false;
  final current = await readDisplayCalibrationProfile(context);
  if (current.key != profile.key) return false;
  await settings.changeDisplayCalibration(profile.key, zoom);
  return true;
}
