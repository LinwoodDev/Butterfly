import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/widgets/area_size_picker.dart';
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
  double _width = AreaSizePreset.a4.width;
  double _height = AreaSizePreset.a4.height;
  bool _areaAsInitial = false;
  AreaPositionMode _positionMode = AreaPositionMode.currentCenter;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _nameController.addListener(_notifyChanged);
    _notifyChanged();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  AreaConfig? _buildConfig() {
    if (_width <= 0 || _height <= 0 || _nameController.text.trim().isEmpty) {
      return null;
    }
    return AreaConfig(
      name: _nameController.text.trim(),
      width: _width,
      height: _height,
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
          AreaSizePicker(
            width: _width,
            height: _height,
            onChanged: (size) {
              setState(() {
                _width = size.width;
                _height = size.height;
              });
              _notifyChanged();
            },
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
