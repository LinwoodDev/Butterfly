import 'package:butterfly/models/element.dart';
import 'package:butterfly/renderers/renderer.dart';
import 'package:butterfly/visualizer/element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectElementDialog extends StatefulWidget {
  final List<Renderer<PadElement>> renderers;

  const SelectElementDialog({Key? key, this.renderers = const []})
      : super(key: key);

  @override
  State<SelectElementDialog> createState() => _SelectElementDialogState();
}

class _SelectElementDialogState extends State<SelectElementDialog> {
  Renderer<PadElement>? current;

  @override
  void initState() {
    current = widget.renderers.isEmpty ? null : widget.renderers.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(AppLocalizations.of(context)!.selectElement),
        actions: [
          TextButton(
            child: Text(AppLocalizations.of(context)!.cancel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.ok),
            onPressed: () => Navigator.of(context).pop(current),
          ),
        ],
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 100),
          child: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.renderers.length,
                itemBuilder: (context, index) {
                  final renderer = widget.renderers[index];
                  return IconButton(
                    icon: Icon(renderer.element.getIcon()),
                    color: current == renderer
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    onPressed: () => setState(() => current = renderer),
                  );
                }),
          ),
        ));
  }
}
