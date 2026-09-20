import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_ui/material_ui.dart';

class TransitionDurationDialog extends StatefulWidget {
  final double duration;

  const TransitionDurationDialog({super.key, required this.duration});

  @override
  State<TransitionDurationDialog> createState() =>
      _TransitionDurationDialogState();
}

class _TransitionDurationDialogState extends State<TransitionDurationDialog> {
  late double _duration;

  @override
  void initState() {
    super.initState();
    _duration = widget.duration.clamp(0.1, 10);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(loc.transitionDuration),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              loc.transitionDurationDescription,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              loc.transitionDurationValue(_duration.toStringAsFixed(1)),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: _duration,
              min: 0.1,
              max: 10,
              divisions: 99,
              label: '${_duration.toStringAsFixed(1)}s',
              onChanged: (value) => setState(() => _duration = value),
            ),
            Wrap(
              spacing: 8,
              children: [0.5, 1.0, 2.0, 3.0]
                  .map(
                    (value) => ChoiceChip(
                      label: Text('${value.toStringAsFixed(1)}s'),
                      selected: (_duration - value).abs() < 0.01,
                      onSelected: (_) => setState(() => _duration = value),
                    ),
                  )
                  .toList(),
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
          onPressed: () => Navigator.pop(context, _duration),
          child: Text(loc.save),
        ),
      ],
    );
  }
}
