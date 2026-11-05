import 'dart:math';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/helpers/actual_size.dart';
import 'package:butterfly/helpers/number.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_ui/material_ui.dart';

enum DisplayCalibrationMethod { adjust, measure, displayData }

/// Returns the camera zoom for the document's physical printed size.
class DisplayCalibrationDialog extends StatefulWidget {
  final double? initialZoom;
  final DisplayMetrics? metrics;

  const DisplayCalibrationDialog({super.key, this.initialZoom, this.metrics});

  @override
  State<DisplayCalibrationDialog> createState() =>
      _DisplayCalibrationDialogState();
}

class _DisplayCalibrationDialogState extends State<DisplayCalibrationDialog> {
  final _contentKey = GlobalKey();
  final _lengthController = TextEditingController();
  final _referenceController = TextEditingController(text: '50');
  late final TextEditingController _dpiController;
  late double _adjustedZoom;
  bool _densitySeeded = false;
  DisplayCalibrationMethod _method = DisplayCalibrationMethod.adjust;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialZoom;
    _adjustedZoom = initial != null && initial.isFinite
        ? initial.clamp(kMinZoom, kMaxZoom)
        : 1;
    final metrics = widget.metrics;
    _dpiController = TextEditingController(
      text: metrics == null ? '' : sqrt(metrics.dpiX * metrics.dpiY).toString(),
    );
  }

  @override
  void dispose() {
    _lengthController.dispose();
    _referenceController.dispose();
    _dpiController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_densitySeeded) return;
    _densitySeeded = true;
    final zoom = widget.initialZoom;
    if (zoom != null && zoom.isFinite && zoom > 0) {
      _dpiController.text =
          (zoom * kCanvasUnitsPerInch * MediaQuery.devicePixelRatioOf(context))
              .toString();
    }
  }

  double? get _zoom {
    final content =
        _contentKey.currentContext?.findRenderObject() as RenderBox?;
    final width = content != null && content.hasSize
        ? content.size.width
        : min(400.0, max(0.0, MediaQuery.sizeOf(context).width - 128));
    double? zoom;
    switch (_method) {
      case DisplayCalibrationMethod.adjust:
        final millimeters = parseDoubleInput(_referenceController.text);
        if (millimeters == null || millimeters <= 0) return null;
        final maxZoom = min(
          kMaxZoom,
          width / (millimeters * kCanvasUnitsPerMillimeter),
        );
        if (maxZoom < kMinZoom) return null;
        zoom = _adjustedZoom.clamp(kMinZoom, maxZoom);
      case DisplayCalibrationMethod.measure:
        final millimeters = parseDoubleInput(_lengthController.text);
        if (millimeters == null || millimeters <= 0) return null;
        zoom = min(200, width) / (millimeters * kCanvasUnitsPerMillimeter);
      case DisplayCalibrationMethod.displayData:
        final dpi = parseDoubleInput(_dpiController.text);
        if (dpi == null || dpi <= 0) return null;
        zoom =
            dpi /
            (kCanvasUnitsPerInch * MediaQuery.devicePixelRatioOf(context));
    }
    return zoom.isFinite && zoom >= kMinZoom && zoom <= kMaxZoom ? zoom : null;
  }

  Widget _reference(double width) => Center(
    child: SizedBox(
      width: width,
      height: 24,
      child: CustomPaint(
        key: const ValueKey('display-calibration-ruler'),
        painter: _CalibrationRuler(Theme.of(context).colorScheme.onSurface),
      ),
    ),
  );

  Widget _adjustment(AppLocalizations l10n) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(l10n.displayCalibrationAdjustDescription),
      const SizedBox(height: 16),
      TextField(
        key: const ValueKey('display-calibration-reference-length'),
        controller: _referenceController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: l10n.knownLength,
          suffixText: 'mm',
        ),
        onChanged: (_) => setState(() {}),
      ),
      const SizedBox(height: 24),
      LayoutBuilder(
        builder: (context, constraints) {
          final length = parseDoubleInput(_referenceController.text);
          final valid =
              length != null &&
              length > 0 &&
              length * kCanvasUnitsPerMillimeter * kMinZoom <=
                  constraints.maxWidth;
          final maxZoom = valid
              ? min(
                  kMaxZoom,
                  constraints.maxWidth / (length * kCanvasUnitsPerMillimeter),
                )
              : kMaxZoom;
          final zoom = _adjustedZoom.clamp(kMinZoom, maxZoom);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _reference(
                valid ? length * kCanvasUnitsPerMillimeter * zoom : 200,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton.filledTonal(
                    tooltip: l10n.zoomOut,
                    onPressed: !valid || zoom <= kMinZoom
                        ? null
                        : () => setState(
                            () => _adjustedZoom = max(kMinZoom, zoom - .001),
                          ),
                    icon: const Icon(Icons.remove),
                  ),
                  Expanded(
                    child: Slider(
                      key: const ValueKey('display-calibration-adjustment'),
                      min: kMinZoom,
                      max: maxZoom,
                      value: zoom,
                      onChanged: !valid
                          ? null
                          : (value) => setState(() => _adjustedZoom = value),
                    ),
                  ),
                  IconButton.filledTonal(
                    tooltip: l10n.zoomIn,
                    onPressed: !valid || zoom >= maxZoom
                        ? null
                        : () => setState(
                            () => _adjustedZoom = min(maxZoom, zoom + .001),
                          ),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              if (!valid)
                Text(
                  l10n.displayCalibrationInvalid,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
            ],
          );
        },
      ),
    ],
  );

  Widget _measurement(AppLocalizations l10n) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(l10n.displayCalibrationDescription),
      const SizedBox(height: 24),
      _reference(200),
      const SizedBox(height: 24),
      TextField(
        key: const ValueKey('display-calibration-length'),
        controller: _lengthController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: l10n.measuredLength,
          suffixText: 'mm',
          errorText: _lengthController.text.isNotEmpty && _zoom == null
              ? l10n.displayCalibrationInvalid
              : null,
        ),
        onChanged: (_) => setState(() {}),
        onSubmitted: (_) => _submit(),
      ),
    ],
  );

  Widget _displayData(AppLocalizations l10n) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(l10n.displayCalibrationDataDescription),
      const SizedBox(height: 16),
      TextField(
        key: const ValueKey('display-calibration-dpi'),
        controller: _dpiController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: l10n.physicalPixelDensity,
          suffixText: 'PPI',
          errorText: _dpiController.text.isNotEmpty && _zoom == null
              ? l10n.displayCalibrationInvalid
              : null,
        ),
        onChanged: (_) => setState(() {}),
        onSubmitted: (_) => _submit(),
      ),
      const SizedBox(height: 16),
      Text(
        '${l10n.devicePixelRatio}: ${MediaQuery.devicePixelRatioOf(context)}',
      ),
    ],
  );

  void _submit() {
    final zoom = _zoom;
    if (zoom != null) Navigator.of(context).pop(zoom);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.calibrateDisplay),
      content: SizedBox(
        key: _contentKey,
        width: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.displayCalibrationQuestion),
              const SizedBox(height: 12),
              DropdownMenuFormField<DisplayCalibrationMethod>(
                key: const ValueKey('display-calibration-method'),
                initialSelection: _method,
                expandedInsets: EdgeInsets.zero,
                selectOnly: true,
                label: Text(l10n.mode),
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                    value: DisplayCalibrationMethod.adjust,
                    label: l10n.matchKnownLength,
                  ),
                  DropdownMenuEntry(
                    value: DisplayCalibrationMethod.measure,
                    label: l10n.measureReference,
                  ),
                  DropdownMenuEntry(
                    value: DisplayCalibrationMethod.displayData,
                    label: l10n.enterDisplayData,
                  ),
                ],
                onSelected: (method) {
                  if (method != null) setState(() => _method = method);
                },
              ),
              const SizedBox(height: 24),
              switch (_method) {
                DisplayCalibrationMethod.adjust => _adjustment(l10n),
                DisplayCalibrationMethod.measure => _measurement(l10n),
                DisplayCalibrationMethod.displayData => _displayData(l10n),
              },
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        FilledButton(
          onPressed: _zoom == null ? null : _submit,
          child: Text(l10n.save),
        ),
      ],
    );
  }
}

class _CalibrationRuler extends CustomPainter {
  final Color color;

  _CalibrationRuler(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
    canvas.drawLine(Offset.zero, Offset(0, size.height), paint);
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CalibrationRuler oldDelegate) =>
      oldDelegate.color != color;
}
