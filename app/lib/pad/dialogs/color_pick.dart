import 'package:flutter/material.dart';

class ColorPickerDialog extends StatefulWidget {
  final List<Color> palette;
  const ColorPickerDialog({Key? key, this.palette = const []}) : super(key: key);

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  static const colors = [
    Colors.white,
    Colors.pink,
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blue,
    Colors.indigo,
    Colors.blueGrey,
    Colors.purple,
    Colors.brown,
    Colors.grey,
    Colors.black
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: Implement real gradient
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Wrap(
              alignment: WrapAlignment.center,
              children: colors
                  .map<Widget>((e) => InkWell(
                      onTap: () => Navigator.of(context).pop(e),
                      child: Container(
                          width: 100,
                          height: 100,
                          decoration:
                              ShapeDecoration(color: e, shape: const RoundedRectangleBorder()))))
                  .toList()),
        ));
  }
}
