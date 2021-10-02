import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditToolbar extends StatefulWidget {
  const EditToolbar({Key? key}) : super(key: key);

  @override
  _EditToolbarState createState() => _EditToolbarState();
}

class _EditToolbarState extends State<EditToolbar> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(icon: const Icon(PhosphorIcons.penLight), tooltip: "Pencil", onPressed: () {}),
      IconButton(
          icon: const Icon(PhosphorIcons.markerCircleLight), tooltip: "Marker", onPressed: () {})
    ]);
  }
}
