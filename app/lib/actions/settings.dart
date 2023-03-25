import 'package:butterfly/settings/home.dart';
import 'package:flutter/material.dart';

class SettingsIntent extends Intent {
  final BuildContext context;

  const SettingsIntent(this.context);
}

class SettingsAction extends Action<SettingsIntent> {
  SettingsAction();

  @override
  Future<void> invoke(SettingsIntent intent) => openSettings(intent.context);
}

Future<void> openSettings(BuildContext context) => showDialog<void>(
    context: context,
    builder: (context) => Dialog(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 600, maxWidth: 800),
            child: const SettingsPage(isDialog: true))));
