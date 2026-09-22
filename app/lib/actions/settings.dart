import 'package:butterfly/settings/home.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:keybinder/keybinder.dart';
import 'package:settings_leap/settings_leap.dart';

class SettingsIntent extends Intent {
  const SettingsIntent();
}

const settingsShortcut = ShortcutDefinition(
  id: 'settings',
  intent: SettingsIntent(),
  defaultActivator: SingleActivator(
    LogicalKeyboardKey.keyS,
    control: true,
    alt: true,
  ),
);

class SettingsAction extends Action<SettingsIntent> {
  final BuildContext context;

  SettingsAction(this.context);

  @override
  Future<void> invoke(SettingsIntent intent) => openSettings(context);
}

Future<void> openSettings(BuildContext context) => showSettingsLeapDialog<void>(
  context: context,
  child: const SettingsPage(inView: true),
);
