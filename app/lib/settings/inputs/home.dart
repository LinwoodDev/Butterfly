import 'dart:ui';

import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InputsSettingsPage extends StatelessWidget {
  final bool inView;

  const InputsSettingsPage({super.key, this.inView = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: inView ? Colors.transparent : null,
      appBar: WindowTitleBar<SettingsCubit, ButterflySettings>(
        title: Text(AppLocalizations.of(context).inputs),
        backgroundColor: inView ? Colors.transparent : null,
        inView: inView,
      ),
      body: BlocBuilder<SettingsCubit, ButterflySettings>(
        builder: (context, state) {
          return ListView(
            children: [
              Card(
                margin: settingsCardMargin,
                child: Padding(
                  padding: settingsCardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.mouse),
                        title: Text(AppLocalizations.of(context).mouse),
                        onTap: () => context.push('/settings/inputs/mouse'),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.hand),
                        title: Text(AppLocalizations.of(context).touch),
                        onTap: () => context.push('/settings/inputs/touch'),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(
                          PhosphorIconsLight.keyboard,
                        ),
                        title: Text(AppLocalizations.of(context).keyboard),
                        onTap: () => context.push('/settings/inputs/keyboard'),
                      ),
                      ListTile(
                        leading: const PhosphorIcon(PhosphorIconsLight.pen),
                        title: Text(AppLocalizations.of(context).pen),
                        onTap: () => context.push('/settings/inputs/pen'),
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
                        child: Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context).sensitivity,
                              style: TextTheme.of(context).headlineSmall,
                            ),
                            Text(AppLocalizations.of(context).sensitivityHint),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ExactSlider(
                        min: 10,
                        max: 1000,
                        defaultValue: 100,
                        fractionDigits: 0,
                        value: state.selectSensitivity * 100,
                        header: Text(AppLocalizations.of(context).select),
                        onChangeEnd: (value) {
                          final cubit = context.read<SettingsCubit>();
                          cubit.changeSelectSensitivity(value / 100);
                        },
                      ),
                      ExactSlider(
                        min: 10,
                        max: 1000,
                        defaultValue: 100,
                        fractionDigits: 0,
                        value: state.touchSensitivity * 100,
                        header: Text(AppLocalizations.of(context).touch),
                        onChangeEnd: (value) {
                          final cubit = context.read<SettingsCubit>();
                          cubit.changeTouchSensitivity(value / 100);
                        },
                      ),
                      ExactSlider(
                        min: 10,
                        max: 1000,
                        defaultValue: 100,
                        value: state.gestureSensitivity * 100,
                        fractionDigits: 0,
                        header: Text(
                          AppLocalizations.of(context).inputGestures,
                        ),
                        onChangeEnd: (value) {
                          final cubit = context.read<SettingsCubit>();
                          cubit.changeGestureSensitivity(value / 100);
                        },
                      ),
                      ExactSlider(
                        min: 10,
                        max: 1000,
                        defaultValue: 100,
                        value: state.scrollSensitivity * 100,
                        header: Text(AppLocalizations.of(context).scroll),
                        fractionDigits: 0,
                        onChangeEnd: (value) {
                          final cubit = context.read<SettingsCubit>();
                          cubit.changeScrollSensitivity(value / 100);
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
                  child: _PointerTest(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PointerTest extends StatefulWidget {
  const _PointerTest();

  @override
  State<_PointerTest> createState() => __PointerTestState();
}

class __PointerTestState extends State<_PointerTest> {
  PointerDeviceKind? _kind;
  int _buttons = 0;
  double? _pressure, _pressureMin, _pressureMax;
  Color? _pressed;

  void Function(PointerEvent event) _changeInputTest(Color? color) =>
      (PointerEvent event) {
        setState(() {
          _kind = event.kind;
          _buttons = event.buttons;
          _pressure = event.pressure;
          _pressureMin = event.pressureMin;
          _pressureMax = event.pressureMax;
          _pressed = color;
        });
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: settingsCardTitlePadding,
          child: Text(
            AppLocalizations.of(context).pointerTest,
            style: TextTheme.of(context).headlineSmall,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: Listener(
            onPointerMove: _changeInputTest(Colors.blue),
            onPointerDown: _changeInputTest(Colors.green),
            onPointerUp: _changeInputTest(null),
            onPointerCancel: _changeInputTest(Colors.red),
            onPointerPanZoomStart: _changeInputTest(Colors.purple),
            onPointerPanZoomUpdate: _changeInputTest(Colors.purple[700]),
            onPointerPanZoomEnd: _changeInputTest(Colors.purple[900]),
            child: Material(color: _pressed),
          ),
        ),
        const SizedBox(height: 8),
        ListTile(
          title: Text(AppLocalizations.of(context).type),
          subtitle: Text(switch (_kind) {
            PointerDeviceKind.touch => AppLocalizations.of(context).touch,
            PointerDeviceKind.mouse => AppLocalizations.of(context).mouse,
            PointerDeviceKind.stylus => AppLocalizations.of(context).pen,
            PointerDeviceKind.invertedStylus => AppLocalizations.of(
              context,
            ).invert,
            PointerDeviceKind.unknown => AppLocalizations.of(context).error,
            _ => AppLocalizations.of(context).none,
          }),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).input),
          subtitle: Text('$_buttons (${_buttons.toRadixString(2)})'),
        ),
        ListTile(
          title: Text(AppLocalizations.of(context).pressure),
          subtitle: Text(
            '${_pressure ?? '?'} (${_pressureMin ?? '?'} - ${_pressureMax ?? '?'})',
          ),
        ),
      ],
    );
  }
}
