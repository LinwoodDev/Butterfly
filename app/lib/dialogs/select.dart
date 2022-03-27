import 'package:butterfly/models/elements/element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SelectElementDialog extends StatefulWidget {
  final List<PadElement> elements;

  const SelectElementDialog({Key? key, this.elements = const []})
      : super(key: key);

  @override
  State<SelectElementDialog> createState() => _SelectElementDialogState();
}

class _SelectElementDialogState extends State<SelectElementDialog> {
  PadElement? current;

  @override
  void initState() {
    current = widget.elements.isEmpty ? null : widget.elements.first;
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
          TextButton(
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
                itemCount: widget.elements.length,
                itemBuilder: (context, index) {
                  final element = widget.elements[index];
                  final elementType = element.toJson()['type'];
                  IconData icon;
                  switch (elementType) {
                    case 'image':
                      icon = PhosphorIcons.imageLight;
                      break;
                    case 'label':
                      icon = PhosphorIcons.textTLight;
                      break;
                    case 'eraser':
                      icon = PhosphorIcons.eraserLight;
                      break;
                    default:
                      icon = PhosphorIcons.penLight;
                      break;
                  }
                  return IconButton(
                    icon: Icon(icon),
                    color: current == element
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    onPressed: () {
                      current = element;
                    },
                  );
                }),
          ),
        ));
  }
}
