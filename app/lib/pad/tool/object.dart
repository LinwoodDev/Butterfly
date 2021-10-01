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
          icon: const Icon(PhosphorIcons.mathOperationsLight),
          tooltip: "Selection operation",
          itemBuilder: (context) => [
                PopupMenuItem(
                    child: const ListTile(
                        leading: Icon(PhosphorIcons.xLight),
                        title: Text("Select all"),
                        mouseCursor: MouseCursor.defer),
                    onTap: () {}),
                PopupMenuItem(
                    child: const ListTile(
                        leading: Icon(PhosphorIcons.divideLight),
                        title: Text("Deselect"),
                        mouseCursor: MouseCursor.defer),
                    onTap: () {}),
                PopupMenuItem(
                    child: const ListTile(
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
                const PopupMenuItem(
                    child: ListTile(
                        mouseCursor: MouseCursor.defer,
                        title: Text("Add to selection"),
                        leading: Icon(PhosphorIcons.plusLight)),
                    value: SelectionMode.add),
                const PopupMenuItem(
                    child: ListTile(
                        mouseCursor: MouseCursor.defer,
                        title: Text("Replace selection"),
                        leading: Icon(PhosphorIcons.plusMinusLight)),
                    value: SelectionMode.replace),
                const PopupMenuItem(
                    child: ListTile(
                        mouseCursor: MouseCursor.defer,
                        title: Text("Remove from selection"),
                        leading: Icon(PhosphorIcons.minusLight)),
                    value: SelectionMode.remove),
              ]),
      PopupMenuButton(
          tooltip: "Clipboard",
          icon: const Icon(PhosphorIcons.clipboardTextLight),
          itemBuilder: (context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  child: ListTile(
                      mouseCursor: MouseCursor.defer,
                      title: Text("Cut"),
                      leading: Icon(PhosphorIcons.scissorsLight)),
                ),
                const PopupMenuItem(
                  child: ListTile(
                      mouseCursor: MouseCursor.defer,
                      title: Text("Copy"),
                      leading: Icon(PhosphorIcons.copyLight)),
                ),
                const PopupMenuItem(
                  child: ListTile(
                      mouseCursor: MouseCursor.defer,
                      title: Text("Paste"),
                      leading: Icon(PhosphorIcons.clipboardLight)),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  child: ListTile(
                      mouseCursor: MouseCursor.defer,
                      title: Text("Duplicate"),
                      leading: Icon(PhosphorIcons.filesLight)),
                ),
                const PopupMenuItem(
                  child: ListTile(
                      mouseCursor: MouseCursor.defer,
                      title: Text("Delete"),
                      leading: Icon(PhosphorIcons.trashLight)),
                )
              ]),
      const VerticalDivider(),
      IconButton(
          icon: const Icon(PhosphorIcons.arrowsOutCardinalLight),
          tooltip: "Translate",
          color: _moveToolType == MoveToolType.translate
              ? Theme.of(context).colorScheme.primary
              : null,
          onPressed: () => setState(() => _moveToolType = MoveToolType.translate)),
      IconButton(
          icon: const Icon(PhosphorIcons.arrowClockwiseLight),
          tooltip: "Rotate",
          color:
              _moveToolType == MoveToolType.rotate ? Theme.of(context).colorScheme.primary : null,
          onPressed: () => setState(() => _moveToolType = MoveToolType.rotate)),
      IconButton(
          icon: const Icon(PhosphorIcons.arrowsOutLight),
          tooltip: "Scale",
          color: _moveToolType == MoveToolType.scale ? Theme.of(context).colorScheme.primary : null,
          onPressed: () => setState(() => _moveToolType = MoveToolType.scale)),
    ]);
  }
}
