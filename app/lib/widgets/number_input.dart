import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NumberInput extends StatefulWidget {
  final double value, min, max, step;
  final int fractionDigits;
  final ValueChanged<double>? onChanged;
  final String? errorText;

  const NumberInput({
    super.key,
    required this.value,
    this.min = double.negativeInfinity,
    this.max = double.infinity,
    this.step = 1,
    this.fractionDigits = 1,
    this.onChanged,
    this.errorText,
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  final TextEditingController _controller = TextEditingController();
  Timer? _stepTimer;
  late double _value;
  bool _invalid = false;

  @override
  void initState() {
    super.initState();
    _syncValue(widget.value);
  }

  @override
  void didUpdateWidget(covariant NumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _syncValue(widget.value);
    }
  }

  @override
  void dispose() {
    _stepTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  bool _isValid(double value) =>
      value.isFinite && value >= widget.min && value <= widget.max;

  void _syncValue(double value) {
    _value = value;
    _invalid = !_isValid(value);
    _controller.text = value.toStringAsFixed(widget.fractionDigits);
  }

  void _changeValue(double value) {
    final nextValue = value.clamp(widget.min, widget.max).toDouble();
    setState(() {
      _value = nextValue;
      _invalid = false;
      _controller.text = nextValue.toStringAsFixed(widget.fractionDigits);
    });
    widget.onChanged?.call(nextValue);
  }

  void _commitTextValue() {
    final parsed = double.tryParse(
      _controller.text.trim().replaceAll(',', '.'),
    );
    if (parsed == null || !_isValid(parsed)) {
      setState(() => _invalid = true);
      return;
    }
    _changeValue(parsed);
  }

  void _startStepping(double delta) {
    _stepTimer?.cancel();
    if (!_step(delta)) return;
    _stepTimer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (!_step(delta)) _stopStepping();
    });
  }

  void _stopStepping() {
    _stepTimer?.cancel();
    _stepTimer = null;
  }

  bool _step(double delta) {
    final nextValue = _value + delta;
    _changeValue(nextValue);
    return nextValue > widget.min && nextValue < widget.max;
  }

  Widget _buildStepButton({
    required double delta,
    required IconData icon,
    required bool enabled,
  }) {
    return GestureDetector(
      onLongPressStart: enabled ? (_) => _startStepping(delta) : null,
      onLongPressEnd: enabled ? (_) => _stopStepping() : null,
      child: IconButton(
        onPressed: enabled ? () => _step(delta) : null,
        icon: PhosphorIcon(icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStepButton(
          delta: -widget.step,
          icon: PhosphorIconsLight.minus,
          enabled: _value > widget.min,
        ),
        const SizedBox(width: 2),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 60),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              errorText: _invalid ? (widget.errorText ?? '') : null,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 0,
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            textAlign: TextAlign.center,
            onSubmitted: (_) => _commitTextValue(),
            onTapOutside: (_) => _commitTextValue(),
          ),
        ),
        const SizedBox(width: 2),
        _buildStepButton(
          delta: widget.step,
          icon: PhosphorIconsLight.plus,
          enabled: _value < widget.max,
        ),
      ],
    );
  }
}
