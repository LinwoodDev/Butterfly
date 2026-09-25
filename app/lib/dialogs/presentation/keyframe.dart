import 'dart:math';

import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';

class KeyframeConfigurationDialog extends StatefulWidget {
  final AnimationKey keyframe;
  final CameraTransform camera;

  const KeyframeConfigurationDialog({
    super.key,
    required this.keyframe,
    required this.camera,
  });

  @override
  State<KeyframeConfigurationDialog> createState() =>
      _KeyframeConfigurationDialogState();
}

class _KeyframeConfigurationDialogState
    extends State<KeyframeConfigurationDialog> {
  late Point<double>? _position;
  late double? _zoom;
  late double? _rotation;
  late bool _breakpoint;

  @override
  void initState() {
    super.initState();
    _position = widget.keyframe.cameraPosition;
    _zoom = widget.keyframe.cameraZoom;
    _rotation = widget.keyframe.cameraRotation;
    _breakpoint = widget.keyframe.breakpoint;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(loc.configureKeyframe),
      scrollable: true,
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: .min,
          children: [
            SwitchListTile(
              value: _breakpoint,
              title: Text(loc.breakpoint),
              onChanged: (value) => setState(() => _breakpoint = value),
            ),
            SwitchListTile(
              value: _position != null,
              title: Text(loc.position),
              onChanged: (value) => setState(
                () => _position = value
                    ? Point(
                        widget.camera.position.dx,
                        widget.camera.position.dy,
                      )
                    : null,
              ),
            ),
            if (_position != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('X'),
                  NumberInput(
                    value: _position!.x,
                    fractionDigits: 2,
                    onChanged: (value) =>
                        setState(() => _position = Point(value, _position!.y)),
                  ),
                  const Text('Y'),
                  NumberInput(
                    value: _position!.y,
                    fractionDigits: 2,
                    onChanged: (value) =>
                        setState(() => _position = Point(_position!.x, value)),
                  ),
                ],
              ),
            SwitchListTile(
              value: _zoom != null,
              title: Text(loc.zoom),
              onChanged: (value) =>
                  setState(() => _zoom = value ? widget.camera.size : null),
            ),
            if (_zoom != null)
              NumberInput(
                value: _zoom!,
                min: kMinZoom,
                max: kMaxZoom,
                step: 0.1,
                fractionDigits: 2,
                onChanged: (value) => setState(() => _zoom = value),
              ),
            SwitchListTile(
              value: _rotation != null,
              title: Text(loc.rotation),
              onChanged: (value) => setState(
                () => _rotation = value ? widget.camera.rotation : null,
              ),
            ),
            if (_rotation != null)
              ListTile(
                title: Text(
                  '${(_rotation! * 180 / pi).round()}°',
                  textAlign: TextAlign.center,
                ),
                subtitle: Slider(
                  min: -180,
                  max: 180,
                  divisions: 360,
                  value: _rotation! * 180 / pi,
                  onChanged: (value) =>
                      setState(() => _rotation = value * pi / 180),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(
            context,
            AnimationKey(
              cameraPosition: _position,
              cameraZoom: _zoom,
              cameraRotation: _rotation,
              breakpoint: _breakpoint,
            ),
          ),
          child: Text(loc.save),
        ),
      ],
    );
  }
}
