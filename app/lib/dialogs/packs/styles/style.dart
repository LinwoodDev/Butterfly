import 'package:butterfly/dialogs/packs/styles/general.dart';
import 'package:butterfly/dialogs/packs/styles/paragraphs.dart';
import 'package:butterfly/dialogs/packs/styles/texts.dart';
import 'package:butterfly/models/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StyleDialog extends StatefulWidget {
  final TextStyleSheet styleSheet;
  final ValueChanged<TextStyleSheet> onChanged;

  const StyleDialog({
    super.key,
    required this.styleSheet,
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

    _style = widget.styleSheet;
  }

  @override
  void didUpdateWidget(covariant StyleDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.styleSheet != widget.styleSheet) {
      _onChanged(widget.styleSheet);
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
                    GeneralStyleView(styleSheet: _style, onChanged: _onChanged),
                    ParagraphsStyleView(
                        styleSheet: _style, onChanged: _onChanged),
                    TextsStyleView(styleSheet: _style, onChanged: _onChanged),
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
