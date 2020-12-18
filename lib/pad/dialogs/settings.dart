import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

class PadSettingsDialog extends StatefulWidget {
  @override
  _PadSettingsDialogState createState() => _PadSettingsDialogState();
}

class _PadSettingsDialogState extends State<PadSettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: DefaultTabController(
            length: 2,
            child: Container(
                constraints: BoxConstraints(maxWidth: 600, maxHeight: 800),
                child: Column(children: [
                  TabBar(
                    tabs: [
                      Tab(icon: Icon(Mdi.tune), text: "General"),
                      Tab(icon: Icon(Mdi.packageVariantClosed), text: "Packs")
                    ],
                  ),
                  Expanded(
                      child: Container(
                          child: TabBarView(children: [
                    Icon(Icons.directions_car),
                    Icon(Icons.directions_transit)
                  ]))),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        RaisedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text("Ok", style: Theme.of(context).primaryTextTheme.button),
                            color: Theme.of(context).primaryColor)
                      ]))
                ]))));
  }
}
