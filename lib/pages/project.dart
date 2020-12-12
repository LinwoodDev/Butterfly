import 'package:butterfly/widgets/split.dart';
import 'package:flutter/material.dart';

class ProjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SplitView(
            axis: Axis.horizontal,
            first: SplitWindow(
                widget: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                      child: FlutterLogo(
                    size: 256,
                  )),
                ),
                minSize: 100),
            second: SplitWindow(
                minSize: 100,
                widget: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                        child: FlutterLogo(
                      size: 256,
                    ))))));
  }
}
