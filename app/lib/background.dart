import 'package:butterfly/models/packs/background.dart';
import 'package:flutter/material.dart';

class BackgroundPacksPage extends StatelessWidget {
  final List<BackgroundPack> _packs = [];

  BackgroundPacksPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(_packs.length, (index) => Container()),
    ));
  }
}
