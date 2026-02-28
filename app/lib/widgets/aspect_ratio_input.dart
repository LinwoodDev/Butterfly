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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double? _parseInput(String input) {
    final cleanInput = input.replaceAll(' ', '').replaceAll(',', '.');
    if (cleanInput.isEmpty) return null;

    if (cleanInput.contains(':')) {
      final parts = cleanInput.split(':');
      if (parts.length == 2) {
        final x = double.tryParse(parts[0]);
        final y = double.tryParse(parts[1]);
        if (x != null && y != null && y > 0 && x > 0) {
          return x / y;
        }
      }
    } else {
      final val = double.tryParse(cleanInput);
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
      decoration: const InputDecoration(
        isDense: true,
        filled: true,
        hintText: '16:9, 1.5',
      ),
    );
  }
}
