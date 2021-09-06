import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ObjectToolbar extends StatefulWidget {
  const ObjectToolbar({Key? key}) : super(key: key);

  @override
  _ObjectToolbarState createState() => _ObjectToolbarState();
}

enum MoveToolType { translate, rotate, scale }

class _ObjectToolbarState extends State<ObjectToolbar> {
  MoveToolType _moveToolType = MoveToolType.translate;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(icon: Icon(PhosphorIcons.xLight), tooltip: "Select all", onPressed: () {}),
      IconButton(icon: Icon(PhosphorIcons.divideLight), tooltip: "Deselect", onPressed: () {}),
      IconButton(
          icon: Icon(PhosphorIcons.percentLight), tooltip: "Select inverse", onPressed: () {}),
      VerticalDivider(),
      IconButton(
          icon: Icon(PhosphorIcons.plusLight), tooltip: "Add to selection", onPressed: () {}),
      IconButton(
          icon: Icon(PhosphorIcons.plusMinusLight), tooltip: "Replace selection", onPressed: () {}),
      IconButton(
          icon: Icon(PhosphorIcons.minusLight), tooltip: "Remove from selection", onPressed: () {}),
      VerticalDivider(),
      IconButton(
          icon: Icon(PhosphorIcons.arrowsOutCardinalLight),
          tooltip: "Translate",
          color: _moveToolType == MoveToolType.translate
              ? Theme.of(context).colorScheme.primary
              : null,
          onPressed: () => setState(() => _moveToolType = MoveToolType.translate)),
      IconButton(
          icon: Icon(PhosphorIcons.arrowClockwiseLight),
          tooltip: "Rotate",
          color:
              _moveToolType == MoveToolType.rotate ? Theme.of(context).colorScheme.primary : null,
          onPressed: () => setState(() => _moveToolType = MoveToolType.rotate)),
      IconButton(
          icon: Icon(PhosphorIcons.arrowsOutLight),
          tooltip: "Scale",
          color: _moveToolType == MoveToolType.scale ? Theme.of(context).colorScheme.primary : null,
          onPressed: () => setState(() => _moveToolType = MoveToolType.scale)),
      VerticalDivider(),
      IconButton(icon: Icon(PhosphorIcons.scissorsLight), tooltip: "Cut", onPressed: () {}),
      IconButton(icon: Icon(PhosphorIcons.copyLight), tooltip: "Copy", onPressed: () {}),
      IconButton(icon: Icon(PhosphorIcons.clipboardLight), tooltip: "Paste", onPressed: () {}),
      VerticalDivider(),
      IconButton(icon: Icon(PhosphorIcons.filesLight), tooltip: "Duplicate", onPressed: () {}),
      IconButton(icon: Icon(PhosphorIcons.trashLight), tooltip: "Delete", onPressed: () {})
    ]);
  }
}
