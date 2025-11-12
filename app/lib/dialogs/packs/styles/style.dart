import 'package:butterfly/dialogs/packs/styles/general.dart';
import 'package:butterfly/dialogs/packs/styles/paragraphs.dart';
import 'package:butterfly/dialogs/packs/styles/texts.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StyleDialog extends StatefulWidget {
  final text.TextStyleSheet value;
  final ValueChanged<text.TextStyleSheet> onChanged;
  final String name;
  final void Function(String) onNameChanged;

  const StyleDialog({
    super.key,
    required this.value,
    required this.onChanged,
    required this.name,
    required this.onNameChanged,
  });

  @override
  State<StyleDialog> createState() => _StyleDialogState();
}

class _StyleDialogState extends State<StyleDialog> {
  late text.TextStyleSheet _style;

  @override
  void initState() {
    super.initState();

    _style = widget.value;
  }

  @override
  void didUpdateWidget(covariant StyleDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _onChanged(widget.value);
    }
  }

  void _onChanged(text.TextStyleSheet style) => setState(() => _style = style);

  @override
  Widget build(BuildContext context) {
    return ResponsiveAlertDialog(
      title: Text(AppLocalizations.of(context).style),
      constraints: const BoxConstraints(maxWidth: 700, maxHeight: 800),
      content: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabs:
                  [
                        (
                          PhosphorIconsLight.gear,
                          AppLocalizations.of(context).general,
                        ),
                        (
                          PhosphorIconsLight.article,
                          AppLocalizations.of(context).paragraph,
                        ),
                        (
                          PhosphorIconsLight.textT,
                          AppLocalizations.of(context).text,
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
                  GeneralStyleView(
                    value: _style,
                    onChanged: _onChanged,
                    name: widget.name,
                    onNameChanged: widget.onNameChanged,
                  ),
                  ParagraphsStyleView(value: _style, onChanged: _onChanged),
                  TextsStyleView(value: _style, onChanged: _onChanged),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onChanged(_style);
            Navigator.of(context).pop(true);
          },
          child: Text(AppLocalizations.of(context).save),
        ),
      ],
    );
  }
}
