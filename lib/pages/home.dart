import 'package:butterfly/views/pad/menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Butterfly"),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: PadMenuView(),
          )),
      body: Column(children: []),
    );
  }
}
