import 'package:butterfly/settings/home.dart';
import 'package:flutter/material.dart';

class SettingsIntent extends Intent {
  final BuildContext context;

  const SettingsIntent(this.context);
}

class SettingsAction extends Action<SettingsIntent> {
  SettingsAction();

  @override
  Future<dynamic> invoke(SettingsIntent intent) {
    return showDialog(
        context: intent.context,
        builder: (context) => Dialog(
            child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 600, maxWidth: 800),
                child: const SettingsPage(isDialog: true))));
  }
}
