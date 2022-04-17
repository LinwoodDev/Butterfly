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
  final OnValueChanged? onChangeEnd;
  final Color? color;

  const ExactSlider(
      {Key? key,
      this.label,
      this.fractionDigits = 2,
      this.defaultValue = 1,
      this.min = 0,
      this.max = 100,
      this.color,
      this.value,
      this.header,
      this.onChangeEnd,
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
    _controller.text = _value.toStringAsFixed(widget.fractionDigits);
    if (_value != value) {
      setState(() {
        _value = value;
      });
    }
    widget.onChanged(value);
  }

  @override
  @override
  void didUpdateWidget(covariant ExactSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        _value = widget.value ?? widget.defaultValue;
        _controller.text = _value.toStringAsFixed(widget.fractionDigits);
      });
    }
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
                      padding: const EdgeInsets.all(8),
                      child: DefaultTextStyle(
                          style: Theme.of(context).textTheme.titleMedium!,
                          child: widget.header!)),
                Row(children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 75),
                    child: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            labelText: widget.label,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center),
                        textAlign: TextAlign.center,
                        controller: _controller,
                        onEditingComplete: () =>
                            widget.onChangeEnd?.call(_value),
                        onChanged: (value) =>
                            _changeValue(double.tryParse(value) ?? _value)),
                  ),
                  Expanded(
                      child: Slider(
                    value: _value.clamp(widget.min, widget.max),
                    min: widget.min,
                    max: widget.max,
                    activeColor: widget.color,
                    onChangeEnd: widget.onChangeEnd,
                    onChanged: (value) {
                      _value = value;
                      _changeValue(value);
                    },
                  )),
                  IconButton(
                      onPressed: () => _changeValue(widget.defaultValue),
                      icon:
                          const Icon(PhosphorIcons.clockCounterClockwiseLight)),
                ]),
              ],
            )));
  }
}
