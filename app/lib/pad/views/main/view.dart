import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainViewViewport extends StatefulWidget {
  @override
  _MainViewViewportState createState() => _MainViewViewportState();
}

class _MainViewViewportState extends State<MainViewViewport> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentBloc, DocumentState>(
        builder: (context, state) => (state as DocumentLoadSuccess).currentPad == null
            ? Center(child: Text("No pad selected"))
            : Container(color: Colors.white, child: Stack(children: [FlutterLogo(size: 50)])));
  }
}
