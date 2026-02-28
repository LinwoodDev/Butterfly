import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AreaConfig {
  final String name;
  final double width;
  final double height;
  final AreaPositionMode positionMode;
  final bool areaAsInitial;

  const AreaConfig({
    required this.name,
    required this.width,
    required this.height,
    required this.positionMode,
    this.areaAsInitial = false,
  });

  Size get size => Size(width, height);
}

class AreasInitializationView extends StatefulWidget {
  final bool insideDocument;
  final void Function(AreaConfig)? onCreate;
  final ValueChanged<AreaConfig>? onChanged;
  final bool scrollable;
  final bool showAsInitial;
  final bool showPosition;

  final String? initialName;

  const AreasInitializationView({
    super.key,
    this.initialName,
    this.onCreate,
    this.onChanged,
    this.insideDocument = false,
    this.scrollable = true,
    bool? showAsInitial,
    bool? showPosition,
  }) : showAsInitial = showAsInitial ?? insideDocument,
       showPosition = showPosition ?? insideDocument;

  @override
  State<AreasInitializationView> createState() =>
      _AreasInitializationViewState();
}

class _AreasInitializationViewState extends State<AreasInitializationView> {
  late final TextEditingController _nameController;
  late final TextEditingController _widthController;
  late final TextEditingController _heightController;
  late AreaSizePreset _selectedPreset;
  bool _areaAsInitial = false;
  AreaPositionMode _positionMode = AreaPositionMode.currentCenter;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    final preset = AreaSizePreset.values.firstWhere(
      (element) => element == AreaSizePreset.a4,
      orElse: () => AreaSizePreset.values.first,
    );
    _selectedPreset = preset;
    _widthController = TextEditingController(text: preset.width.toString());
    _heightController = TextEditingController(text: preset.height.toString());
    _widthController.addListener(_notifyChanged);
    _heightController.addListener(_notifyChanged);
    _nameController.addListener(_notifyChanged);
    _notifyChanged();
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  AreaConfig? _buildConfig() {
    final width = _parseNumber(_widthController.text);
    final height = _parseNumber(_heightController.text);
    if (width == null ||
        height == null ||
        width <= 0 ||
        height <= 0 ||
        _nameController.text.trim().isEmpty) {
      return null;
    }
    return AreaConfig(
      name: _nameController.text.trim(),
      width: width,
      height: height,
      positionMode: _positionMode,
      areaAsInitial: _areaAsInitial,
    );
  }

  void _notifyChanged() {
    if (widget.onChanged == null) return;
    final config = _buildConfig();
    if (config != null) {
      widget.onChanged!(config);
    }
  }

  void _createArea() {
    final config = _buildConfig();
    if (config == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).error)),
      );
      return;
    }
    widget.onCreate?.call(config);
  }

  double? _parseNumber(String value) =>
      double.tryParse(value.trim().replaceAll(',', '.'));

  void _applyPreset(AreaSizePreset preset) {
    _selectedPreset = preset;
    _widthController.text = preset.width.toString();
    _heightController.text = preset.height.toString();
  }

  void _flipSize() {
    final width = _widthController.text;
    _widthController.text = _heightController.text;
    _heightController.text = width;
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final content = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.onCreate != null) ...[
            Text(
              locale.createAreas,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: LeapLocalizations.of(context).name,
              filled: true,
            ),
          ),
          const SizedBox(height: 16),
          DropdownMenuFormField<AreaSizePreset>(
            initialSelection: _selectedPreset,
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
              _notifyChanged();
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
          if (widget.showAsInitial)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(locale.areaAsInitial),
              value: _areaAsInitial,
              onChanged: (value) {
                if (value == null) return;
                setState(() => _areaAsInitial = value);
                _notifyChanged();
              },
            ),
          if (widget.showPosition) ...[
            const SizedBox(height: 16),
            Text(
              locale.position,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            SegmentedButton<AreaPositionMode>(
              segments: [
                ButtonSegment<AreaPositionMode>(
                  value: AreaPositionMode.origin,
                  label: Text(locale.origin),
                ),
                ButtonSegment<AreaPositionMode>(
                  value: AreaPositionMode.currentCenter,
                  label: Text(locale.center),
                ),
              ],
              selected: {_positionMode},
              onSelectionChanged: (selection) {
                if (selection.isEmpty) return;
                setState(() => _positionMode = selection.first);
                _notifyChanged();
              },
            ),
          ],
          if (widget.onCreate != null) ...[
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: _createArea,
                icon: const PhosphorIcon(PhosphorIconsLight.plus),
                label: Text(LeapLocalizations.of(context).create),
              ),
            ),
          ],
        ],
      ),
    );

    if (widget.scrollable) {
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [Center(child: content)],
      );
    }
    return content;
  }
}

enum AreaPositionMode { origin, currentCenter }
