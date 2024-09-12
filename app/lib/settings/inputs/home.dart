import 'dart:ui';

import 'package:butterfly/cubits/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InputsSettingsPage extends StatelessWidget {
  final bool inView;

  const InputsSettingsPage({super.key, this.inView = false});

  @override
  Widget build(BuildContext context) {
    PointerDeviceKind? kind;
    int? buttons;
    double? pressure;
    Color? pressed;
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
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            leading:
                                const PhosphorIcon(PhosphorIconsLight.mouse),
                            title: Text(AppLocalizations.of(context).mouse),
                            onTap: () =>
                                context.push('/settings/behaviors/mouse'),
                          ),
                          ListTile(
                            leading:
                                const PhosphorIcon(PhosphorIconsLight.hand),
                            title: Text(AppLocalizations.of(context).touch),
                            onTap: () =>
                                context.push('/settings/behaviors/touch'),
                          ),
                          ListTile(
                            leading:
                                const PhosphorIcon(PhosphorIconsLight.keyboard),
                            title: Text(AppLocalizations.of(context).keyboard),
                            onTap: () =>
                                context.push('/settings/behaviors/keyboard'),
                          ),
                          ListTile(
                            leading: const PhosphorIcon(PhosphorIconsLight.pen),
                            title: Text(AppLocalizations.of(context).pen),
                            onTap: () =>
                                context.push('/settings/behaviors/pen'),
                          ),
                        ]),
                  )),
              Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(AppLocalizations.of(context).sensitivity,
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text(AppLocalizations.of(context).sensitivityHint),
                      const SizedBox(height: 16),
                      ExactSlider(
                          min: 0,
                          max: 10,
                          defaultValue: 1,
                          value: state.selectSensitivity,
                          header: Text(AppLocalizations.of(context).select),
                          onChangeEnd: (value) {
                            final cubit = context.read<SettingsCubit>();
                            cubit.changeSelectSensitivity(value);
                          }),
                      ExactSlider(
                          min: 0,
                          max: 10,
                          defaultValue: 1,
                          value: state.touchSensitivity,
                          header: Text(AppLocalizations.of(context).touch),
                          onChangeEnd: (value) {
                            final cubit = context.read<SettingsCubit>();
                            cubit.changeTouchSensitivity(value);
                          }),
                      ExactSlider(
                          min: 0,
                          max: 10,
                          defaultValue: 1,
                          value: state.gestureSensitivity,
                          header:
                              Text(AppLocalizations.of(context).inputGestures),
                          onChangeEnd: (value) {
                            final cubit = context.read<SettingsCubit>();
                            cubit.changeGestureSensitivity(value);
                          }),
                      ExactSlider(
                          min: 0,
                          max: 10,
                          defaultValue: 1,
                          value: state.scrollSensitivity,
                          header: Text(AppLocalizations.of(context).scroll),
                          onChangeEnd: (value) {
                            final cubit = context.read<SettingsCubit>();
                            cubit.changeScrollSensitivity(value);
                          }),
                    ],
                  ),
                ),
              ),
              Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: StatefulBuilder(builder: (context, setState) {
                      changeInputTest(Color? color) => (PointerEvent event) {
                            setState(() {
                              kind = event.kind;
                              buttons = event.buttons;
                              pressure = event.pressure;
                              pressed = color;
                            });
                          };

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(AppLocalizations.of(context).pointerTest,
                              style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 150,
                            child: Listener(
                              onPointerMove: changeInputTest(Colors.blue),
                              onPointerDown: changeInputTest(Colors.green),
                              onPointerUp: changeInputTest(null),
                              onPointerCancel: changeInputTest(Colors.red),
                              onPointerPanZoomStart:
                                  changeInputTest(Colors.purple),
                              onPointerPanZoomUpdate:
                                  changeInputTest(Colors.purple[700]),
                              onPointerPanZoomEnd:
                                  changeInputTest(Colors.purple[900]),
                              child: Material(
                                color: pressed,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ListTile(
                            title: Text(AppLocalizations.of(context).type),
                            subtitle: Text(switch (kind) {
                              PointerDeviceKind.touch =>
                                AppLocalizations.of(context).touch,
                              PointerDeviceKind.mouse =>
                                AppLocalizations.of(context).mouse,
                              PointerDeviceKind.stylus =>
                                AppLocalizations.of(context).pen,
                              PointerDeviceKind.invertedStylus =>
                                AppLocalizations.of(context).invert,
                              PointerDeviceKind.unknown =>
                                AppLocalizations.of(context).error,
                              _ => AppLocalizations.of(context).none,
                            }),
                          ),
                          ListTile(
                            title: Text(AppLocalizations.of(context).input),
                            subtitle: Text(buttons.toString()),
                          ),
                          ListTile(
                            title: Text(AppLocalizations.of(context).pressure),
                            subtitle: Text(pressure.toString()),
                          ),
                        ],
                      );
                    }),
                  )),
            ],
          );
        }));
  }
}
