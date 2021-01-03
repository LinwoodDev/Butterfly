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
    return Expanded(
        child: BlocBuilder<DocumentBloc, DocumentState>(
            builder: (context, state) => (state as DocumentLoadSuccess).currentSelected == null
                ? Center(child: Text("No file selected"))
                : Container(color: Colors.white, child: Stack(children: [FlutterLogo(size: 10)]))));
  }
}
