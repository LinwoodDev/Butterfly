import 'package:butterfly/models/input_type.dart';
import 'package:butterfly/views/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BehaviorsSettingsPage extends StatefulWidget {
  const BehaviorsSettingsPage({Key? key}) : super(key: key);

  @override
  _BehaviorsSettingsPageState createState() => _BehaviorsSettingsPageState();
}

class _BehaviorsSettingsPageState extends State<BehaviorsSettingsPage> {
  SharedPreferences? _prefs;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        _prefs = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.behaviors),
          actions: [
            if (isWindow()) ...[const VerticalDivider(), const WindowButtons()]
          ],
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text(AppLocalizations.of(context)!.input),
              leading: const Icon(PhosphorIcons.mouseLight),
              subtitle: Text(InputType.values[_prefs?.getInt('input') ?? 0]
                  .toLocalizedString(context)),
              onTap: _showInput,
            ),
          ],
        ));
  }

  void _showInput() {
    var currentInput = InputType.values[_prefs?.getInt('input') ?? 0];
    showModalBottomSheet(
        context: context,
        builder: (context) {
          Future<void> changeInput(InputType inputType) async {
            await _prefs?.setInt('input', inputType.index);
            Navigator.of(context).pop();
            setState(() {});
          }

          return Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    AppLocalizations.of(context)!.input,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                ),
                ...InputType.values.map((e) {
                  return ListTile(
                      title: Text(e.toLocalizedString(context)),
                      selected: e == currentInput,
                      onTap: () => changeInput(e));
                })
              ]));
        });
  }
}
