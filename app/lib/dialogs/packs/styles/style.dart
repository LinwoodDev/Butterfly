import 'package:butterfly/dialogs/packs/styles/general.dart';
import 'package:butterfly/dialogs/packs/styles/paragraphs.dart';
import 'package:butterfly/dialogs/packs/styles/texts.dart';
import 'package:butterfly/models/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StyleDialog extends StatefulWidget {
  final TextStyleSheet value;
  final ValueChanged<TextStyleSheet> onChanged;

  const StyleDialog({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<StyleDialog> createState() => _StyleDialogState();
}

class _StyleDialogState extends State<StyleDialog> {
  late TextStyleSheet _style;

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

  void _onChanged(TextStyleSheet style) => setState(() => _style = style);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).style),
      content: SizedBox(
        height: 600,
        width: 700,
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                  isScrollable: true,
                  tabs: <dynamic>[
                    [
                      PhosphorIcons.gearLight,
                      AppLocalizations.of(context).general
                    ],
                    [
                      PhosphorIcons.articleLight,
                      AppLocalizations.of(context).paragraph
                    ],
                    [
                      PhosphorIcons.textTLight,
                      AppLocalizations.of(context).text
                    ]
                  ]
                      .map((e) => Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(e[0]),
                                const SizedBox(width: 8),
                                Text(e[1]),
                              ],
                            ),
                          ))
                      .toList()),
              const SizedBox(height: 8),
              Expanded(
                child: TabBarView(
                  children: [
                    GeneralStyleView(value: _style, onChanged: _onChanged),
                    ParagraphsStyleView(value: _style, onChanged: _onChanged),
                    TextsStyleView(value: _style, onChanged: _onChanged),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(AppLocalizations.of(context).cancel),
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
