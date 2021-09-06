import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ViewToolbar extends StatefulWidget {
  const ViewToolbar({Key? key}) : super(key: key);

  @override
  _ViewToolbarState createState() => _ViewToolbarState();
}

class _ViewToolbarState extends State<ViewToolbar> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
          icon: Icon(PhosphorIcons.arrowSquareOutLight), tooltip: "Export", onPressed: () {}),
      IconButton(icon: Icon(PhosphorIcons.printerLight), tooltip: "Print", onPressed: () {}),
      IconButton(
          icon: Icon(PhosphorIcons.monitorPlayLight), tooltip: "Presentation", onPressed: () {})
    ]);
  }
}
