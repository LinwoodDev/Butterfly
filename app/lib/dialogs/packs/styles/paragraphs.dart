import 'package:butterfly/models/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ParagraphsStyleView extends StatelessWidget {
  final TextStyleSheet styleSheet;
  final ValueChanged<TextStyleSheet> onChanged;

  const ParagraphsStyleView({
    super.key,
    required this.styleSheet,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    String? currentStyle;
    return StatefulBuilder(
        builder: (context, setState) => Column(
              children: [
                SizedBox(
                  height: 32,
                  child: Row(
                    children: [
                      Flexible(
                        child: DropdownButtonFormField<String?>(
                          items: [
                            ...styleSheet.paragraphProperties.entries.map(
                              (style) => DropdownMenuItem(
                                value: style.key,
                                child: Text(style.key),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              currentStyle = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(PhosphorIcons.plusLight),
                        onPressed: () async {
                          final textController = TextEditingController();
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title:
                                  Text(AppLocalizations.of(context).enterText),
                              content: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context).name,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child:
                                      Text(AppLocalizations.of(context).cancel),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child:
                                      Text(AppLocalizations.of(context).create),
                                ),
                              ],
                            ),
                          );
                          final name = textController.text;
                          if (result != true ||
                              styleSheet.paragraphProperties
                                  .containsKey(name)) {
                            return;
                          }
                          onChanged(styleSheet.copyWith(
                            paragraphProperties: {
                              ...styleSheet.paragraphProperties,
                              name: const DefinedParagraphProperty(),
                            },
                          ));
                        },
                      ),
                      if (currentStyle != null) ...[
                        IconButton(
                          icon: const Icon(PhosphorIcons.pencilLight),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(PhosphorIcons.trashLight),
                          onPressed: () {},
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ));
  }
}
