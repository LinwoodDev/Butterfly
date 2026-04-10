import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly/helpers/number.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AreaSizePicker extends StatefulWidget {
  final double width;
  final double height;
  final ValueChanged<Size> onChanged;

  const AreaSizePicker({
    super.key,
    required this.width,
    required this.height,
    required this.onChanged,
  });

  @override
  State<AreaSizePicker> createState() => _AreaSizePickerState();
}

class _AreaSizePickerState extends State<AreaSizePicker> {
  late final TextEditingController _widthController;
  late final TextEditingController _heightController;
  AreaSizePreset? _selectedPreset;
  bool _isNotifying = false;

  @override
  void initState() {
    super.initState();
    _widthController = TextEditingController(text: widget.width.toString());
    _heightController = TextEditingController(text: widget.height.toString());
    _updateSelectedPreset(widget.width, widget.height);

    _widthController.addListener(_notifyChanged);
    _heightController.addListener(_notifyChanged);
  }

  @override
  void didUpdateWidget(AreaSizePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.width != widget.width || oldWidget.height != widget.height) {
      _isNotifying = true;
      if (parseDoubleInput(_widthController.text) != widget.width) {
        _widthController.text = widget.width.toString();
      }
      if (parseDoubleInput(_heightController.text) != widget.height) {
        _heightController.text = widget.height.toString();
      }
      _updateSelectedPreset(widget.width, widget.height);
      _isNotifying = false;
    }
  }

  void _updateSelectedPreset(double width, double height) {
    _selectedPreset = null;
    for (final preset in AreaSizePreset.values) {
      if (preset.width == width && preset.height == height) {
        _selectedPreset = preset;
        break;
      }
    }
    // Note: If no preset matches, _selectedPreset remains null
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _notifyChanged() {
    if (_isNotifying) return;
    final width = parseDoubleInput(_widthController.text);
    final height = parseDoubleInput(_heightController.text);
    if (width != null && height != null && width > 0 && height > 0) {
      _isNotifying = true;
      _updateSelectedPreset(width, height);
      widget.onChanged(Size(width, height));
      _isNotifying = false;
    }
  }

  void _applyPreset(AreaSizePreset preset) {
    _isNotifying = true;
    _selectedPreset = preset;
    _widthController.text = preset.width.toString();
    _heightController.text = preset.height.toString();
    widget.onChanged(Size(preset.width, preset.height));
    _isNotifying = false;
  }

  void _flipSize() {
    _isNotifying = true;
    final width = _widthController.text;
    _widthController.text = _heightController.text;
    _heightController.text = width;

    final pWidth = parseDoubleInput(_widthController.text);
    final pHeight = parseDoubleInput(_heightController.text);
    if (pWidth != null && pHeight != null) {
      _updateSelectedPreset(pWidth, pHeight);
      widget.onChanged(Size(pWidth, pHeight));
    }
    _isNotifying = false;
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownMenuFormField<AreaSizePreset>(
          initialSelection: _selectedPreset, // Can be null
          dropdownMenuEntries: AreaSizePreset.values
              .map(
                (preset) => DropdownMenuEntry<AreaSizePreset>(
                  value: preset,
                  label:
                      '${preset.label} (${preset.width.toInt()}×${preset.height.toInt()})',
                ),
              )
              .toList(),
          label: Text(locale.presets),
          expandedInsets: EdgeInsets.zero,
          onSelected: (preset) {
            if (preset == null) return;
            setState(() => _applyPreset(preset));
          },
        ),
        const SizedBox(height: 8),
        Divider(),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _widthController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(labelText: locale.width),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filledTonal(
              onPressed: _flipSize,
              tooltip: locale.swap,
              icon: const Icon(PhosphorIconsLight.swap),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _heightController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(labelText: locale.height),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
