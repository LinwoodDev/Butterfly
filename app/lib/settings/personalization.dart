import 'package:flutter/material.dart';
import 'package:butterfly/theme.dart';

class PersonalizationSettingsPage extends StatefulWidget {
  const PersonalizationSettingsPage({Key? key}) : super(key: key);

  @override
  _PersonalizationSettingsPageState createState() => _PersonalizationSettingsPageState();
}

class _PersonalizationSettingsPageState extends State<PersonalizationSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Personalization")),
        body: Builder(
          builder: (context) => ListView(children: [
            ListTile(
                title: Text("Theme"),
                subtitle: Text(ThemeController.of(context)?.currentTheme.toString() ?? ""),
                onTap: () => _openThemeModal())
          ]),
        ));
  }

  void _openThemeModal() async {
    var _currentTheme = ThemeController.of(context)?.currentTheme;
    var themeMode = await showModalBottomSheet<ThemeMode>(
        context: context,
        builder: (context) {
          return Container(
              margin: EdgeInsets.only(bottom: 20),
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    "Theme",
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                    title: Text("System"),
                    selected: _currentTheme == ThemeMode.system,
                    leading: Icon(Icons.settings_outlined),
                    onTap: () => Navigator.of(context).pop(ThemeMode.system)),
                ListTile(
                    title: Text("Light"),
                    selected: _currentTheme == ThemeMode.light,
                    leading: Icon(Icons.wb_sunny_outlined),
                    onTap: () => Navigator.of(context).pop(ThemeMode.light)),
                ListTile(
                    title: Text("Dark"),
                    selected: _currentTheme == ThemeMode.dark,
                    leading: Icon(Icons.nightlight_round),
                    onTap: () => Navigator.of(context).pop(ThemeMode.dark)),
                const SizedBox(height: 32),
              ]));
        });
    if (themeMode != null) setState(() => ThemeController.of(context)?.currentTheme = themeMode);
  }
}
