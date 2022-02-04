import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

typedef OnValueChanged = void Function(double value);

class ExactSlider extends StatefulWidget {
  final String? label;
  final int fractionDigits;
  final Widget? header;
  final double defaultValue, min, max;
  final double? value;
  final OnValueChanged onChanged;
  const ExactSlider(
      {Key? key,
      this.label,
      this.fractionDigits = 2,
      this.defaultValue = 1,
      this.min = 0,
      this.max = 100,
      this.value,
      this.header,
      required this.onChanged})
      : super(key: key);

  @override
  _ExactSliderState createState() => _ExactSliderState();
}

class _ExactSliderState extends State<ExactSlider> {
  late double _value;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? widget.defaultValue;
    _controller.text = _value.toStringAsFixed(widget.fractionDigits);
  }

  void _changeValue(double value) {
    setState(() {
      _value = value;
      _controller.text = _value.toStringAsFixed(widget.fractionDigits);
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              children: [
                if (widget.header != null)
                  Padding(
                      padding: const EdgeInsets.all(8), child: widget.header!),
                Row(children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 125),
                    child: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            labelText: widget.label,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center),
                        textAlign: TextAlign.center,
                        controller: _controller,
                        onChanged: (value) =>
                            _changeValue(double.tryParse(value) ?? _value)),
                  ),
                  Expanded(
                      child: Slider(
                    value: _value.clamp(widget.min, widget.max),
                    min: widget.min,
                    max: widget.max,
                    onChanged: (value) => _changeValue(value),
                  )),
                  IconButton(
                      onPressed: () => _changeValue(widget.defaultValue),
                      icon:
                          const Icon(PhosphorIcons.arrowCounterClockwiseLight)),
                ]),
              ],
            )));
  }
}
