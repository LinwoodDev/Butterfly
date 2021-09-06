import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ObjectToolbar extends StatefulWidget {
  const ObjectToolbar({Key? key}) : super(key: key);

  @override
  _ObjectToolbarState createState() => _ObjectToolbarState();
}

enum MoveToolType { translate, rotate, scale }

enum SelectionMode { add, replace, remove }

class _ObjectToolbarState extends State<ObjectToolbar> {
  MoveToolType _moveToolType = MoveToolType.translate;
  SelectionMode _selectionMode = SelectionMode.replace;

  @override
  Widget build(BuildContext context) {
    IconData selectionIcon;
    switch (_selectionMode) {
      case SelectionMode.add:
        selectionIcon = PhosphorIcons.plusLight;
        break;
      case SelectionMode.replace:
        selectionIcon = PhosphorIcons.plusMinusLight;
        break;
      case SelectionMode.remove:
        selectionIcon = PhosphorIcons.minusLight;
        break;
    }
    return Row(children: [
      PopupMenuButton<SelectionMode>(
          icon: Icon(PhosphorIcons.mathOperationsLight),
          tooltip: "Selection operation",
          itemBuilder: (context) => [
                PopupMenuItem(
                    child: ListTile(
                        leading: Icon(PhosphorIcons.xLight),
                        title: Text("Select all"),
                        mouseCursor: MouseCursor.defer),
                    onTap: () {}),
                PopupMenuItem(
                    child: ListTile(
                        leading: Icon(PhosphorIcons.divideLight),
                        title: Text("Deselect"),
                        mouseCursor: MouseCursor.defer),
                    onTap: () {}),
                PopupMenuItem(
                    child: ListTile(
                        leading: Icon(PhosphorIcons.percentLight),
                        title: Text("Select inverse"),
                        mouseCursor: MouseCursor.defer),
                    onTap: () {}),
              ]),
      PopupMenuButton<SelectionMode>(
          icon: Icon(selectionIcon),
          tooltip: "Selection mode",
          onSelected: (SelectionMode mode) => setState(() => _selectionMode = mode),
          itemBuilder: (context) => [
                PopupMenuItem(
                    child: ListTile(
                        mouseCursor: MouseCursor.defer,
                        title: Text("Add to selection"),
                        leading: Icon(PhosphorIcons.plusLight)),
                    value: SelectionMode.add),
                PopupMenuItem(
                    child: ListTile(
                        mouseCursor: MouseCursor.defer,
                        title: Text("Replace selection"),
                        leading: Icon(PhosphorIcons.plusMinusLight)),
                    value: SelectionMode.replace),
                PopupMenuItem(
                    child: ListTile(
                        mouseCursor: MouseCursor.defer,
                        title: Text("Remove from selection"),
                        leading: Icon(PhosphorIcons.minusLight)),
                    value: SelectionMode.remove),
              ]),
      PopupMenuButton(
          tooltip: "Clipboard",
          icon: Icon(PhosphorIcons.clipboardTextLight),
          itemBuilder: (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  child: ListTile(
                      mouseCursor: MouseCursor.defer,
                      title: Text("Cut"),
                      leading: Icon(PhosphorIcons.scissorsLight)),
                ),
                PopupMenuItem(
                  child: ListTile(
                      mouseCursor: MouseCursor.defer,
                      title: Text("Copy"),
                      leading: Icon(PhosphorIcons.copyLight)),
                ),
                PopupMenuItem(
                  child: ListTile(
                      mouseCursor: MouseCursor.defer,
                      title: Text("Paste"),
                      leading: Icon(PhosphorIcons.clipboardLight)),
                ),
                PopupMenuDivider(),
                PopupMenuItem(
                  child: ListTile(
                      mouseCursor: MouseCursor.defer,
                      title: Text("Duplicate"),
                      leading: Icon(PhosphorIcons.filesLight)),
                ),
                PopupMenuItem(
                  child: ListTile(
                      mouseCursor: MouseCursor.defer,
                      title: Text("Delete"),
                      leading: Icon(PhosphorIcons.trashLight)),
                )
              ]),
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
    ]);
  }
}
