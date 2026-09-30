import 'dart:math';

import 'package:butterfly/actions/zoom.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ZoomView extends StatefulWidget {
  final bool isMobile;

  const ZoomView({super.key, this.isMobile = false});

  @override
  State<ZoomView> createState() => _ZoomViewState();
}

class _ZoomViewState extends State<ZoomView> {
  bool _rotationFocused = false;
  bool _rotating = false;

  Offset get _center {
    final viewport = context
        .read<EditorController>()
        .rendererCubit
        .state
        .cameraViewport;
    return (viewport.viewportSize ?? viewport.toRealSize()).center(Offset.zero);
  }

  void _bake() {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return;
    final controller = context.read<EditorController>();
    controller.rendererCubit.bake(controller, state);
  }

  void _zoom(double percent) {
    final controller = context.read<EditorController>();
    controller.transformCubit.sizeConstrained(
      percent / 100,
      cursor: _center,
      force: true,
      runtime: controller,
    );
  }

  void _rotate(double degrees) {
    final controller = context.read<EditorController>();
    final transform = controller.transformCubit;
    transform.rotateConstrained(
      degrees * pi / 180 - transform.state.rotation,
      cursor: _center,
      force: true,
      runtime: controller,
    );
  }

  Widget _controlRow({
    required Key key,
    required String label,
    required String unit,
    required Color color,
    required double value,
    required double min,
    required double max,
    required double defaultValue,
    required double step,
    required ZoomPanelControls controls,
    required String resetTooltip,
    required Widget resetIcon,
    required Widget decrementIcon,
    required Widget incrementIcon,
    required ValueChanged<double> onChanged,
    required ValueChanged<double> onChangeEnd,
    ValueChanged<bool>? onFocusChanged,
  }) => LayoutBuilder(
    key: key,
    builder: (context, constraints) {
      final reset = IconButton(
        tooltip: resetTooltip,
        visualDensity: VisualDensity.compact,
        onPressed: (value - defaultValue).abs() < 1e-6
            ? null
            : () {
                FocusScope.of(context).unfocus();
                onChanged(defaultValue);
                onChangeEnd(defaultValue);
              },
        icon: resetIcon,
      );
      final slider = Semantics(
        label: label,
        child: Tooltip(
          message: '$label: ${value.toStringAsFixed(1)}$unit',
          excludeFromSemantics: true,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              showValueIndicator: ShowValueIndicator.onDrag,
              valueIndicatorColor: color,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              activeColor: color,
              label: '${value.toStringAsFixed(1)}$unit',
              semanticFormatterCallback: (value) =>
                  '${value.toStringAsFixed(1)}$unit',
              onChanged: onChanged,
              onChangeEnd: onChangeEnd,
            ),
          ),
        ),
      );
      if (!controls.showInput) {
        return Row(
          children: [
            reset,
            Expanded(child: slider),
          ],
        );
      }
      final input = Focus(
        onFocusChange: onFocusChanged,
        child: NumberInput(
          label: label,
          value: value,
          min: min,
          max: max,
          step: step,
          fractionDigits: 1,
          roundValues: true,
          showButtons: controls.showButtons,
          decrementIcon: decrementIcon,
          incrementIcon: incrementIcon,
          onChanged: onChanged,
          onChangeEnd: onChangeEnd,
        ),
      );
      // Share the available width on small windows without stacking controls.
      // Reserve space for the reset and separator before sizing the input.
      final inputWidth = ((constraints.maxWidth - 40) * .65)
          .clamp(0.0, controls.showButtons ? 180.0 : 96.0)
          .toDouble();
      return Row(
        children: [
          reset,
          const SizedBox(height: 24, child: VerticalDivider(width: 8)),
          if (controls.showSlider)
            SizedBox(width: inputWidth, child: input)
          else
            Expanded(child: input),
          if (controls.showSlider) Expanded(child: slider),
        ],
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    final loaded = context.select<DocumentBloc, bool>(
      (bloc) => bloc.state is DocumentLoadSuccess,
    );
    final settings = context
        .select<
          SettingsCubit,
          ({
            bool enabled,
            RotationDisplay rotation,
            ZoomPanelControls controls,
            double zoomStep,
            double rotationStep,
          })
        >(
          (cubit) => (
            enabled: cubit.state.zoomEnabled,
            rotation: cubit.state.rotationDisplay,
            controls: cubit.state.zoomPanelControls,
            zoomStep: ZoomAction.step(cubit.state),
            rotationStep: cubit.state.rotationStep,
          ),
        );
    final fullScreen = context.select<WindowCubit, bool>(
      (cubit) => cubit.state.fullScreen,
    );
    final layoutFullScreen = context.select<DocumentSaveCubit, bool>(
      (cubit) => cubit.state.fullScreen,
    );
    final hideUi = context.select<EditorInputCubit, HideState>(
      (cubit) => cubit.state.hideUi,
    );
    final transform = context
        .select<TransformCubit, ({double size, double rotation})>(
          (cubit) => (size: cubit.state.size, rotation: cubit.state.rotation),
        );
    if (!loaded ||
        !settings.enabled ||
        fullScreen ||
        layoutFullScreen ||
        hideUi != HideState.visible) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return IconButtonTheme(
      data: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size(32, 32),
          padding: const EdgeInsets.all(4),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (settings.rotation != RotationDisplay.hidden &&
                  (settings.rotation == RotationDisplay.always ||
                      transform.rotation.abs() > 1e-6 ||
                      _rotationFocused ||
                      _rotating)) ...[
                _controlRow(
                  key: const ValueKey('camera-rotation'),
                  label: '${l10n.rotation} (°)',
                  unit: '°',
                  color: colorScheme.secondary,
                  value: transform.rotation * 180 / pi,
                  min: -180,
                  max: 180,
                  defaultValue: 0,
                  step: settings.rotationStep,
                  controls: settings.controls,
                  resetTooltip: l10n.resetRotation,
                  resetIcon: const PhosphorIcon(
                    PhosphorIconsLight.clockCounterClockwise,
                  ),
                  decrementIcon: Tooltip(
                    message: l10n.rotateLeft,
                    child: const PhosphorIcon(
                      PhosphorIconsLight.arrowCounterClockwise,
                    ),
                  ),
                  incrementIcon: Tooltip(
                    message: l10n.rotateRight,
                    child: const PhosphorIcon(
                      PhosphorIconsLight.arrowClockwise,
                    ),
                  ),
                  onFocusChanged: (focused) =>
                      setState(() => _rotationFocused = focused),
                  onChanged: (value) {
                    setState(() => _rotating = true);
                    _rotate(value);
                  },
                  onChangeEnd: (_) {
                    _bake();
                    setState(() => _rotating = false);
                  },
                ),
                const SizedBox(height: 8),
              ],
              _controlRow(
                key: const ValueKey('camera-zoom'),
                label: '${l10n.zoom} (%)',
                unit: '%',
                color: colorScheme.primary,
                value: transform.size * 100,
                min: kMinZoom * 100,
                max: kMaxZoom * 100,
                defaultValue: 100,
                step: settings.zoomStep * 100,
                controls: settings.controls,
                resetTooltip: l10n.resetZoom,
                resetIcon: const PhosphorIcon(
                  PhosphorIconsLight.magnifyingGlass,
                ),
                decrementIcon: Tooltip(
                  message: l10n.zoomOut,
                  child: const PhosphorIcon(PhosphorIconsLight.minus),
                ),
                incrementIcon: Tooltip(
                  message: l10n.zoomIn,
                  child: const PhosphorIcon(PhosphorIconsLight.plus),
                ),
                onChanged: _zoom,
                onChangeEnd: (_) => _bake(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
