part of '../home.dart';

final _inputsSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).inputs,
  icon: PhosphorIconsLight.keyboard,
  appBarBuilder: _butterflyAppBar,
  children: {
    'mouse': _mouseSettingsPage,
    'touch': _touchSettingsPage,
    'keyboard': _keyboardSettingsPage,
    'pen': _penSettingsPage,
  },
  sections: {
    'devices': SettingsLeapSection(
      settings: [
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).mouse,
          icon: PhosphorIconsLight.mouse,
          onTap: (context) => context.push('/settings/inputs/mouse'),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).touch,
          icon: PhosphorIconsLight.hand,
          onTap: (context) => context.push('/settings/inputs/touch'),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).keyboard,
          icon: PhosphorIconsLight.keyboard,
          onTap: (context) => context.push('/settings/inputs/keyboard'),
        ),
        SettingsLeapActionSetting(
          displayName: (context) => AppLocalizations.of(context).pen,
          icon: PhosphorIconsLight.pen,
          onTap: (context) => context.push('/settings/inputs/pen'),
        ),
      ],
    ),
    'sensitivity': SettingsLeapSection(
      displayName: (context) => AppLocalizations.of(context).sensitivity,
      descriptionBuilder: (context) =>
          AppLocalizations.of(context).sensitivityHint,
      settings: [
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).select,
          builder: _selectSensitivitySetting,
        ),
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).touch,
          builder: _touchSensitivitySetting,
        ),
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).inputGestures,
          builder: _gestureSensitivitySetting,
        ),
        SettingsLeapCustomSetting(
          displayName: (context) => AppLocalizations.of(context).scroll,
          builder: _scrollSensitivitySetting,
        ),
      ],
    ),
    'pointerTest': SettingsLeapSection(
      displayName: (context) => AppLocalizations.of(context).pointerTest,
      builder: _pointerTestSection,
    ),
  },
);

final _mouseSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).mouse,
  icon: PhosphorIconsLight.mouse,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'content': SettingsLeapSection(
      wrapBuilder: false,
      builder: (context, state, inView) => MouseInputSettings(state: state),
    ),
  },
);

final _touchSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).touch,
  icon: PhosphorIconsLight.hand,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'content': SettingsLeapSection(
      wrapBuilder: false,
      builder: (context, state, inView) => TouchInputSettings(state: state),
    ),
  },
);

final _keyboardSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).keyboard,
  icon: PhosphorIconsLight.keyboard,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'content': SettingsLeapSection(
      wrapBuilder: false,
      builder: (context, state, inView) => KeyboardInputSettings(state: state),
    ),
  },
);

final _penSettingsPage = SettingsLeapPage<ButterflySettings>(
  displayName: (context) => AppLocalizations.of(context).pen,
  icon: PhosphorIconsLight.pen,
  appBarBuilder: _butterflyAppBar,
  sections: {
    'content': SettingsLeapSection(
      wrapBuilder: false,
      builder: (context, state, inView) => PenInputSettings(state: state),
    ),
  },
);

Widget _selectSensitivitySetting(
  BuildContext context,
  ButterflySettings state,
) {
  return _sensitivitySlider(
    context,
    label: AppLocalizations.of(context).select,
    value: state.selectSensitivity,
    onChangeEnd: (value) =>
        context.read<SettingsCubit>().changeSelectSensitivity(value),
  );
}

Widget _touchSensitivitySetting(BuildContext context, ButterflySettings state) {
  return _sensitivitySlider(
    context,
    label: AppLocalizations.of(context).touch,
    value: state.touchSensitivity,
    onChangeEnd: (value) =>
        context.read<SettingsCubit>().changeTouchSensitivity(value),
  );
}

Widget _gestureSensitivitySetting(
  BuildContext context,
  ButterflySettings state,
) {
  return _sensitivitySlider(
    context,
    label: AppLocalizations.of(context).inputGestures,
    value: state.gestureSensitivity,
    onChangeEnd: (value) =>
        context.read<SettingsCubit>().changeGestureSensitivity(value),
  );
}

Widget _scrollSensitivitySetting(
  BuildContext context,
  ButterflySettings state,
) {
  return _sensitivitySlider(
    context,
    label: AppLocalizations.of(context).scroll,
    value: state.scrollSensitivity,
    onChangeEnd: (value) =>
        context.read<SettingsCubit>().changeScrollSensitivity(value),
  );
}

Widget _sensitivitySlider(
  BuildContext context, {
  required String label,
  required double value,
  required ValueChanged<double> onChangeEnd,
}) {
  return ExactSlider(
    min: 10,
    max: 1000,
    defaultValue: 100,
    fractionDigits: 0,
    value: value * 100,
    header: Text(label),
    onChangeEnd: (value) => onChangeEnd(value / 100),
  );
}

Widget _pointerTestSection(
  BuildContext context,
  ButterflySettings state,
  Widget child,
) {
  return const _PointerTest();
}

void _changeFlag(BuildContext context, String flag, bool enabled) {
  final cubit = context.read<SettingsCubit>();
  if (enabled) {
    cubit.addFlag(flag);
  } else {
    cubit.removeFlag(flag);
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

  void Function(PointerEvent event) _changeInputTest(Color? color) {
    return (PointerEvent event) {
      setState(() {
        _kind = event.kind;
        _buttons = event.buttons;
        _pressure = event.pressure;
        _pressureMin = event.pressureMin;
        _pressureMax = event.pressureMax;
        _pressed = color;
      });
    };
  }

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
