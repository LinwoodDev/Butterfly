import 'package:butterfly/models/tools/type.dart';
import 'package:butterfly/pad/views/inspector.dart';
import 'package:butterfly/pad/views/layers.dart';
import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ViewTool extends Tool {
  const ViewTool();
  @override
  Widget buildInspector(DocumentBloc bloc) {
    return Container();
  }

  @override
  List<Widget> buildOptions({required BuildContext context, required DocumentLoadSuccess state}) {
    var bloc = BlocProvider.of<DocumentBloc>(context);
    return [
      IconButton(
          icon: Icon(PhosphorIcons.cubeLight),
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LayersView()))),
      IconButton(
          icon: Icon(PhosphorIcons.fadersLight),
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => InspectorView()))),
      VerticalDivider(),
      IconButton(
          icon: Icon(PhosphorIcons.arrowSquareOutLight), tooltip: "Export", onPressed: () {}),
      IconButton(icon: Icon(PhosphorIcons.printerLight), tooltip: "Print", onPressed: () {}),
      IconButton(
          icon: Icon(PhosphorIcons.monitorPlayLight), tooltip: "Presentation", onPressed: () {})
    ];
  }

  @override
  IconData get icon => PhosphorIcons.cursorLight;

  @override
  IconData get activeIcon => PhosphorIcons.cursorFill;

  @override
  ToolType get type => ToolType.view;

  @override
  String get name => "View";
}
