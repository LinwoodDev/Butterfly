import 'package:butterfly/models/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'text.dart';

class TextsStyleView extends StatelessWidget {
  final TextStyleSheet value;
  final ValueChanged<TextStyleSheet> onChanged;

  const TextsStyleView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    String? currentStyle;
    return StatefulBuilder(
        builder: (context, setState) => Column(
              children: [
                SizedBox(
                  height: 64,
                  child: Row(
                    children: [
                      Flexible(
                        child: DropdownButtonFormField<String?>(
                          items: [
                            ...value.spanProperties.entries.map(
                              (style) => DropdownMenuItem(
                                value: style.key,
                                child: Text(style.key),
                              ),
                            ),
                          ],
                          value: currentStyle,
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
                          final formKey = GlobalKey<FormState>();
                          final result = await showDialog<bool>(
                            context: context,
                            builder: (context) => Form(
                              key: formKey,
                              child: AlertDialog(
                                title: Text(
                                    AppLocalizations.of(context).enterName),
                                content: TextFormField(
                                  controller: textController,
                                  decoration: InputDecoration(
                                    labelText:
                                        AppLocalizations.of(context).name,
                                  ),
                                  validator: (name) {
                                    if (value.spanProperties
                                        .containsKey(name)) {
                                      return AppLocalizations.of(context)
                                          .alreadyExists;
                                    }
                                    return null;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context).cancel),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (!formKey.currentState!.validate()) {
                                        return;
                                      }
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context).create),
                                  ),
                                ],
                              ),
                            ),
                          );
                          final name = textController.text;
                          if (result != true) {
                            return;
                          }
                          onChanged(value.copyWith(
                            spanProperties: {
                              ...value.spanProperties,
                              name: const DefinedSpanProperty(),
                            },
                          ));
                        },
                      ),
                      if (currentStyle != null) ...[
                        IconButton(
                          icon: const Icon(PhosphorIcons.pencilLight),
                          onPressed: () async {
                            final textController =
                                TextEditingController(text: currentStyle);
                            final formKey = GlobalKey<FormState>();
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => Form(
                                key: formKey,
                                child: AlertDialog(
                                  title: Text(
                                      AppLocalizations.of(context).enterName),
                                  content: TextFormField(
                                    controller: textController,
                                    decoration: InputDecoration(
                                      labelText:
                                          AppLocalizations.of(context).name,
                                    ),
                                    validator: (name) {
                                      if (value.spanProperties
                                          .containsKey(value)) {
                                        return AppLocalizations.of(context)
                                            .alreadyExists;
                                      }
                                      return null;
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text(
                                          AppLocalizations.of(context).cancel),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (!formKey.currentState!.validate()) {
                                          return;
                                        }
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text(
                                          AppLocalizations.of(context).create),
                                    ),
                                  ],
                                ),
                              ),
                            );
                            final name = textController.text;
                            if (result != true) {
                              return;
                            }
                            final lastStyle = currentStyle;
                            currentStyle = name;
                            onChanged(value.copyWith(
                              spanProperties:
                                  Map<String, DefinedSpanProperty>.from(
                                      value.spanProperties)
                                    ..remove(lastStyle)
                                    ..[name] = value.spanProperties[lastStyle]!,
                            ));
                          },
                        ),
                        IconButton(
                          icon: const Icon(PhosphorIcons.trashLight),
                          onPressed: () async {
                            final result = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title:
                                    Text(AppLocalizations.of(context).delete),
                                content: Text(
                                    AppLocalizations.of(context).reallyDelete),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context).cancel),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context).delete),
                                  ),
                                ],
                              ),
                            );
                            if (result != true) {
                              return;
                            }
                            final lastStyle = currentStyle;
                            currentStyle = null;
                            onChanged(value.copyWith(
                              spanProperties:
                                  Map<String, DefinedSpanProperty>.from(
                                      value.spanProperties)
                                    ..remove(lastStyle),
                            ));
                          },
                        ),
                      ]
                    ],
                  ),
                ),
                Flexible(
                  child: Builder(
                    builder: (context) {
                      final currentspan = value.spanProperties[currentStyle];
                      if (currentspan == null) {
                        return const SizedBox();
                      }
                      return SingleChildScrollView(
                        child: TextStyleView(
                          value: currentspan,
                          onChanged: (span) {
                            onChanged(value.copyWith(
                              spanProperties: {
                                ...value.spanProperties,
                                currentStyle!: span,
                              },
                            ));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ));
  }
}
