import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'components.dart';
import 'general.dart';
import 'palettes.dart';
import 'styles/view.dart';
import 'toolbars.dart';

class PackDialog extends StatefulWidget {
  final NoteData? pack;

  const PackDialog({super.key, this.pack});

  @override
  State<PackDialog> createState() => _PackDialogState();
}

class _PackDialogState extends State<PackDialog> {
  late NoteData pack;

  @override
  void initState() {
    super.initState();
    NoteData pack = widget.pack ?? DocumentDefaults.createPack();
    this.pack = pack;
  }

  void _onChanged(NoteData pack) {
    setState(() {
      this.pack = pack.setMetadata(
        pack.getMetadata()!.copyWith(updatedAt: DateTime.now().toUtc()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(
        widget.pack == null
            ? AppLocalizations.of(context).createPack
            : AppLocalizations.of(context).editPack,
      ),
      constraints: const BoxConstraints(maxWidth: 700, maxHeight: 800),
      content: DefaultTabController(
        length: widget.pack == null ? 1 : 5,
        child: Column(
          children: [
            if (widget.pack != null)
              TabBar(
                isScrollable: true,
                tabs:
                    [
                          (
                            PhosphorIconsLight.gear,
                            AppLocalizations.of(context).general,
                          ),
                          (
                            PhosphorIconsLight.puzzlePiece,
                            AppLocalizations.of(context).components,
                          ),
                          (
                            PhosphorIconsLight.pencilCircle,
                            AppLocalizations.of(context).styles,
                          ),
                          (
                            PhosphorIconsLight.palette,
                            AppLocalizations.of(context).palettes,
                          ),
                          (
                            PhosphorIconsLight.toolbox,
                            AppLocalizations.of(context).toolbars,
                          ),
                        ]
                        .map(
                          (e) => HorizontalTab(
                            icon: PhosphorIcon(e.$1),
                            label: Text(e.$2),
                          ),
                        )
                        .toList(),
              ),
            const SizedBox(height: 8),
            Expanded(
              child: TabBarView(
                children: [
                  GeneralPackView(value: pack, onChanged: _onChanged),
                  if (widget.pack != null) ...[
                    ComponentsPackView(value: pack, onChanged: _onChanged),
                    StylesPackView(value: pack, onChanged: _onChanged),
                    PalettesPackView(value: pack, onChanged: _onChanged),
                    ToolbarsPackView(value: pack, onChanged: _onChanged),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(pack),
          child: Text(
            widget.pack == null
                ? LeapLocalizations.of(context).create
                : AppLocalizations.of(context).save,
          ),
        ),
      ],
    );
  }
}
