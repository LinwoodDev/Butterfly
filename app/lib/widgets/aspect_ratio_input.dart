import 'dart:math';

import 'package:butterfly/helpers/number.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';

class AspectRatioInput extends StatefulWidget {
  final double aspectRatio;
  final ValueChanged<double> onChanged;

  const AspectRatioInput({
    super.key,
    required this.aspectRatio,
    required this.onChanged,
  });

  @override
  State<AspectRatioInput> createState() => _AspectRatioInputState();
}

class _AspectRatioInputState extends State<AspectRatioInput> {
  late final TextEditingController _controller;
  bool _isNotifying = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _updateControllersFromAspect(widget.aspectRatio);

    _controller.addListener(_notifyChanged);
  }

  @override
  void didUpdateWidget(AspectRatioInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.aspectRatio != widget.aspectRatio) {
      _isNotifying = true;
      _updateControllersFromAspect(widget.aspectRatio);
      _isNotifying = false;
    }
  }

  void _updateControllersFromAspect(double aspect) {
    if (aspect <= 0) {
      if (_controller.text.isNotEmpty) _controller.text = '';
      return;
    }

    final currentAspect = _parseInput(_controller.text);

    if (currentAspect == null || (currentAspect - aspect).abs() > 0.001) {
      if ((aspect - sqrt2).abs() < 0.001) {
        _controller.text = '√2:1';
      } else if ((aspect - 1 / sqrt2).abs() < 0.001) {
        _controller.text = '1:√2';
      } else {
        // Find a clean representation if possible
        bool foundClean = false;
        for (int y = 1; y <= 32; y++) {
          final x = aspect * y;
          if ((x - x.round()).abs() < 0.01) {
            if (y == 1) {
              _controller.text = x.round().toString();
            } else {
              _controller.text = '${x.round()}:$y';
            }
            foundClean = true;
            break;
          }
        }

        if (!foundClean) {
          _controller.text = aspect
              .toStringAsFixed(3)
              .replaceAll(RegExp(r'0+$'), '')
              .replaceAll(RegExp(r'\.$'), '');
        }
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double? _parseInput(String input) {
    if (input == '√2:1' || input == 'sqrt(2)' || input == 'sqrt2') return sqrt2;
    if (input == '1:√2' || input == '1/sqrt(2)' || input == '1/sqrt2') {
      return 1 / sqrt2;
    }

    final cleanInput = input.replaceAll(' ', '').replaceAll(',', '.');
    if (cleanInput.isEmpty) return null;

    if (cleanInput.contains(':')) {
      final parts = cleanInput.split(':');
      if (parts.length == 2) {
        final x = parseDoubleInput(parts[0]);
        final y = parseDoubleInput(parts[1]);
        if (x != null && y != null && y > 0 && x > 0) {
          return x / y;
        }
      }
    } else {
      final val = parseDoubleInput(cleanInput);
      if (val != null && val > 0) {
        return val;
      }
    }
    return null;
  }

  void _notifyChanged() {
    if (_isNotifying) return;
    final aspect = _parseInput(_controller.text);
    if (aspect != null && aspect > 0) {
      _isNotifying = true;
      widget.onChanged(aspect);
      _isNotifying = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        filled: true,
        hintText: AppLocalizations.of(context).aspectRatioHint,
      ),
    );
  }
}
