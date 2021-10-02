import 'package:flutter/material.dart';

class ColorPickerDialog extends StatefulWidget {
  final List<Color> palette;
  const ColorPickerDialog({Key? key, this.palette = const []}) : super(key: key);

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  @override
  Widget build(BuildContext context) {
    // TODO: Implement real gradient
    return SizedBox(
        width: 500,
        height: 500,
        child: Row(children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [],
            )),
          )),
          SingleChildScrollView(
            child: Column(
                children: widget.palette
                    .map<Widget>((e) => InkWell(
                        child: Container(
                            width: 100,
                            height: 100,
                            decoration:
                                ShapeDecoration(color: e, shape: const RoundedRectangleBorder()))))
                    .toList()),
          )
        ]));
  }
}
