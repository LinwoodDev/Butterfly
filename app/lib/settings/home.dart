import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Settings")),
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Column(children: [
          ListTile(
              title: const Text("Personalization"),
              onTap: () => Modular.to.pushNamed("/settings/personalization"))
        ]))));
  }
}
