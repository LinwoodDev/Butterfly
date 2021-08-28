import 'package:butterfly/pad/bloc/document_bloc.dart';
import 'package:butterfly/pad/views/main/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Container(child: BlocBuilder<DocumentBloc, DocumentState>(builder: (context, state) {
      var bloc = state as DocumentLoadSuccess;
      return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Hero(tag: 'main_view', child: MainViewViewport(bloc: bloc))),
          ]);
    }));
  }
}
