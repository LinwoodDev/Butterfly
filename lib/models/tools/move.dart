import 'package:butterfly/widgets/split/core.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';

import 'type.dart';

enum MoveToolType { location, rotation, scale }

class MoveTool extends Tool {
  final MoveToolType moveToolType;
  MoveTool({this.moveToolType = MoveToolType.location});
  @override
  Widget buildInspector() {
    return ListView(children: [
      ExpansionTile(
          title: Text(
            'Location',
          ),
          initiallyExpanded: true,
          childrenPadding: EdgeInsets.symmetric(horizontal: 10),
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: "X")),
            TextField(decoration: InputDecoration(labelText: "Y")),
            TextField(decoration: InputDecoration(labelText: "Z")),
          ]),
      ExpansionTile(
          title: Text(
            'Rotation',
          ),
          initiallyExpanded: true,
          childrenPadding: EdgeInsets.symmetric(horizontal: 10),
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: "X")),
            TextField(decoration: InputDecoration(labelText: "Y")),
            TextField(decoration: InputDecoration(labelText: "Z")),
          ]),
      ExpansionTile(
          title: Text(
            'Scale',
          ),
          childrenPadding: EdgeInsets.symmetric(horizontal: 10),
          initiallyExpanded: true,
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: "Height")),
            TextField(decoration: InputDecoration(labelText: "Width")),
          ])
    ]);
  }

  @override
  List<Widget> buildOptions(
      {BuildContext context,
      DocumentBloc bloc,
      bool expanded,
      bool isMobile,
      SplitWindow window,
      SplitView view}) {
    return [
      IconButton(
          icon: Icon(Mdi.crosshairs),
          tooltip: "Location",
          color: moveToolType == MoveToolType.location ? Theme.of(context).primaryColor : null,
          onPressed: () => bloc.add(ToolChanged(MoveTool(moveToolType: MoveToolType.location)))),
      IconButton(
          icon: Icon(Mdi.formatRotate90),
          tooltip: "Rotation",
          color: moveToolType == MoveToolType.rotation ? Theme.of(context).primaryColor : null,
          onPressed: () => bloc.add(ToolChanged(MoveTool(moveToolType: MoveToolType.rotation)))),
      IconButton(
          icon: Icon(Mdi.resize),
          tooltip: "Scale",
          color: moveToolType == MoveToolType.scale ? Theme.of(context).primaryColor : null,
          onPressed: () => bloc.add(ToolChanged(MoveTool(moveToolType: MoveToolType.scale))))
    ];
  }

  @override
  IconData get icon => Mdi.cursorMove;

  @override
  ToolType get type => ToolType.move;

  @override
  String get name => "Move";

  @override
  List<Object> get props => [type, moveToolType];
}
