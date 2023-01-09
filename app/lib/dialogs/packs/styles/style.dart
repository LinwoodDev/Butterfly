import 'package:butterfly/dialogs/packs/styles/general.dart';
import 'package:butterfly/dialogs/packs/styles/paragraph.dart';
import 'package:butterfly/dialogs/packs/styles/text.dart';
import 'package:butterfly/models/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StyleDialog extends StatelessWidget {
  final TextStyleSheet styleSheet;
  final ValueChanged<TextStyleSheet> onChanged;

  const StyleDialog({
    super.key,
    required this.styleSheet,
    required this.onChanged,
  });

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
                      GeneralStyleView(
                          styleSheet: styleSheet, onChanged: onChanged),
                      ParagraphStyleView(
                          styleSheet: styleSheet, onChanged: onChanged),
                      TextStyleView(
                          styleSheet: styleSheet, onChanged: onChanged),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
