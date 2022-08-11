import 'package:butterfly/models/element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../renderers/renderer.dart';

class ElementsDialog extends StatefulWidget {
  final List<Renderer<PadElement>> renderers;

  const ElementsDialog({super.key, required this.renderers});

  @override
  State<ElementsDialog> createState() => _ElementsDialogState();
}

class _ElementsDialogState extends State<ElementsDialog> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Flexible(
          child: ListView(
        shrinkWrap: true,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.move),
            leading: const Icon(PhosphorIcons.arrowsOutCardinalLight),
            onTap: () {},
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.duplicate),
            leading: const Icon(PhosphorIcons.copyLight),
            onTap: () {},
          ),
          ListTile(
              onTap: () {},
              title: Text(AppLocalizations.of(context)!.delete),
              leading: const Icon(PhosphorIcons.trashLight)),
          ListTile(
            onTap: () {},
            title: Text(AppLocalizations.of(context)!.properties),
            leading: const Icon(PhosphorIcons.fadersLight),
          ),
        ],
      ))
    ]);
  }
}
