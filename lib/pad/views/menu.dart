import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pluto_menu_bar/pluto_menu_bar.dart';

class PadMenuView extends StatefulWidget {
  @override
  _PadMenuViewState createState() => _PadMenuViewState();
}

class _PadMenuViewState extends State<PadMenuView> {
  void message(context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return PlutoMenuBar(
      menuIconColor: Theme.of(context).primaryIconTheme.color,
      moreIconColor: Theme.of(context).primaryIconTheme.color,
      backgroundColor: Theme.of(context).primaryColor,
      textStyle: Theme.of(context).primaryTextTheme.bodyText2,
      menus: [
        MenuItem(title: 'File', icon: MdiIcons.fileOutline, children: [
          MenuItem(
            title: 'New',
            icon: MdiIcons.filePlusOutline,
            onTap: () => message(context, 'New'),
          ),
          MenuItem(
            title: 'Save',
            icon: MdiIcons.contentSaveOutline,
            onTap: () => message(context, 'New'),
          ),
          MenuItem(
            title: 'Present',
            icon: MdiIcons.presentation,
            onTap: () => message(context, 'New'),
          ),
          MenuItem(
            title: 'Export',
            icon: MdiIcons.fileExportOutline,
            onTap: () => message(context, 'New'),
          ),
          MenuItem(
            title: 'Print',
            icon: MdiIcons.printer,
            onTap: () => message(context, 'New'),
          ),
          MenuItem(
            title: 'Property',
            icon: MdiIcons.fileSettingsOutline,
            onTap: () => message(context, 'New'),
          )
        ]),
        MenuItem(title: 'Edit', icon: MdiIcons.clipboardOutline, children: [
          MenuItem(title: 'Menu 1-1', onTap: () => message(context, 'Menu 1-1 tap'), children: [
            MenuItem(
                title: 'Menu 1-1-1',
                onTap: () => message(context, 'Menu 1-1-1 tap'),
                children: [
                  MenuItem(
                    title: 'Menu 1-1-1-1',
                    onTap: () => message(context, 'Menu 1-1-1-1 tap'),
                  ),
                  MenuItem(
                    title: 'Menu 1-1-1-2',
                    onTap: () => message(context, 'Menu 1-1-1-2 tap'),
                  )
                ]),
            MenuItem(
              title: 'Menu 1-1-2',
              onTap: () => message(context, 'Menu 1-1-2 tap'),
            )
          ]),
          MenuItem(
            title: 'Menu 1-2',
            onTap: () => message(context, 'Menu 1-2 tap'),
          )
        ]),
        MenuItem(title: 'View', icon: MdiIcons.monitor, children: [
          MenuItem(title: 'Menu 1-1', onTap: () => message(context, 'Menu 1-1 tap'), children: [
            MenuItem(
                title: 'Menu 1-1-1',
                onTap: () => message(context, 'Menu 1-1-1 tap'),
                children: [
                  MenuItem(
                    title: 'Menu 1-1-1-1',
                    onTap: () => message(context, 'Menu 1-1-1-1 tap'),
                  ),
                  MenuItem(
                    title: 'Menu 1-1-1-2',
                    onTap: () => message(context, 'Menu 1-1-1-2 tap'),
                  )
                ]),
            MenuItem(
              title: 'Menu 1-1-2',
              onTap: () => message(context, 'Menu 1-1-2 tap'),
            )
          ]),
          MenuItem(
            title: 'Menu 1-2',
            onTap: () => message(context, 'Menu 1-2 tap'),
          )
        ]),
        MenuItem(title: 'Layer', icon: MdiIcons.layersOutline, children: [
          MenuItem(title: 'Menu 1-1', onTap: () => message(context, 'Menu 1-1 tap'), children: [
            MenuItem(
                title: 'Menu 1-1-1',
                onTap: () => message(context, 'Menu 1-1-1 tap'),
                children: [
                  MenuItem(
                    title: 'Menu 1-1-1-1',
                    onTap: () => message(context, 'Menu 1-1-1-1 tap'),
                  ),
                  MenuItem(
                    title: 'Menu 1-1-1-2',
                    onTap: () => message(context, 'Menu 1-1-1-2 tap'),
                  )
                ]),
            MenuItem(
              title: 'Menu 1-1-2',
              onTap: () => message(context, 'Menu 1-1-2 tap'),
            )
          ]),
          MenuItem(
            title: 'Menu 1-2',
            onTap: () => message(context, 'Menu 1-2 tap'),
          )
        ]),
        MenuItem(title: 'Help', icon: MdiIcons.helpCircleOutline, children: [
          MenuItem(title: 'Menu 1-1', onTap: () => message(context, 'Menu 1-1 tap'), children: [
            MenuItem(
                title: 'Menu 1-1-1',
                onTap: () => message(context, 'Menu 1-1-1 tap'),
                children: [
                  MenuItem(
                    title: 'Menu 1-1-1-1',
                    onTap: () => message(context, 'Menu 1-1-1-1 tap'),
                  ),
                  MenuItem(
                    title: 'Menu 1-1-1-2',
                    onTap: () => message(context, 'Menu 1-1-1-2 tap'),
                  )
                ]),
            MenuItem(
              title: 'Menu 1-1-2',
              onTap: () => message(context, 'Menu 1-1-2 tap'),
            )
          ]),
          MenuItem(
            title: 'Menu 1-2',
            onTap: () => message(context, 'Menu 1-2 tap'),
          )
        ])
      ],
    );
  }
}
