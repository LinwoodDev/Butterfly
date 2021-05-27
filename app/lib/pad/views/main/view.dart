import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';

class MainViewViewport extends StatefulWidget {
  final DocumentLoadSuccess bloc;

  const MainViewViewport({Key? key, required this.bloc}) : super(key: key);
  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

class _MainViewViewportState extends State<MainViewViewport> {
  @override
  Widget build(BuildContext context) {
    return widget.bloc.currentPad == null
        ? Center(child: Text("No pad selected"))
        : Container(color: Colors.white, child: Stack(children: [FlutterLogo(size: 50)]));
  }
}
