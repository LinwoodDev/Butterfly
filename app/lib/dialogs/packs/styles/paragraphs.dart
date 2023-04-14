import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly/models/defaults.dart';
import 'package:butterfly_api/butterfly_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'paragraph.dart';

class ParagraphsStyleView extends StatefulWidget {
  final TextStyleSheet value;
  final ValueChanged<TextStyleSheet> onChanged;

  const ParagraphsStyleView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<ParagraphsStyleView> createState() => _ParagraphsStyleViewState();
}

class _ParagraphsStyleViewState extends State<ParagraphsStyleView> {
  String? _currentStyle;

  @override
  void initState() {
    super.initState();

    _currentStyle = widget.value.paragraphProperties.keys.firstOrNull;
  }

  @override
  void didUpdateWidget(covariant ParagraphsStyleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _currentStyle != null) {
      setState(() {
        if (!widget.value.paragraphProperties.containsKey(_currentStyle!)) {
          _currentStyle = widget.value.paragraphProperties.keys.firstOrNull;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            ...widget.value.paragraphProperties.entries.map(
                              (style) => DropdownMenuItem(
                                value: style.key,
                                child: Text(style.key),
                              ),
                            ),
                          ],
                          value: _currentStyle,
                          onChanged: (value) {
                            setState(() {
                              _currentStyle = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const PhosphorIcon(PhosphorIconsLight.plus),
                        onPressed: () async {
                          final name = await showDialog<String>(
                            context: context,
                            builder: (context) => NameDialog(
                              validator: defaultNameValidator(
                                context,
                                widget.value.paragraphProperties.keys.toList(),
                              ),
                            ),
                          );
                          if (name == null) {
                            return;
                          }
                          widget.onChanged(widget.value.copyWith(
                            paragraphProperties: {
                              ...widget.value.paragraphProperties,
                              name: const DefinedParagraphProperty(),
                            },
                          ));
                        },
                      ),
                      MenuAnchor(
                        builder: (context, controller, _) {
                          return IconButton(
                            icon: const PhosphorIcon(PhosphorIconsLight.list),
                            onPressed: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                          );
                        },
                        menuChildren:
                            DocumentDefaults.getParagraphTranslations(context)
                                .entries
                                .where((element) => !widget
                                    .value.paragraphProperties
                                    .containsKey(element.key))
                                .map(
                                  (e) => MenuItemButton(
                                    child: Text(e.value),
                                    onPressed: () {
                                      widget.onChanged(widget.value.copyWith(
                                        paragraphProperties: {
                                          ...widget.value.paragraphProperties,
                                          e.key:
                                              const DefinedParagraphProperty(),
                                        },
                                      ));
                                    },
                                  ),
                                )
                                .toList(),
                      ),
                      if (_currentStyle != null) ...[
                        const VerticalDivider(),
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.pencil),
                          onPressed: () async {
                            final name = await showDialog<String>(
                              context: context,
                              builder: (context) => NameDialog(
                                value: _currentStyle,
                                validator: defaultNameValidator(
                                  context,
                                  widget.value.paragraphProperties.keys
                                      .toList(),
                                ),
                              ),
                            );
                            if (name == null) {
                              return;
                            }
                            final lastStyle = _currentStyle;
                            _currentStyle = name;
                            widget.onChanged(widget.value.copyWith(
                              paragraphProperties:
                                  Map<String, DefinedParagraphProperty>.from(
                                      widget.value.paragraphProperties)
                                    ..remove(lastStyle)
                                    ..[name] = widget
                                        .value.paragraphProperties[lastStyle]!,
                            ));
                          },
                        ),
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.trash),
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
                            final lastStyle = _currentStyle;
                            _currentStyle = null;
                            widget.onChanged(widget.value.copyWith(
                              paragraphProperties:
                                  Map<String, DefinedParagraphProperty>.from(
                                      widget.value.paragraphProperties)
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
                      final currentParagraph =
                          widget.value.paragraphProperties[_currentStyle];
                      if (currentParagraph == null) {
                        return const SizedBox();
                      }
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: ParagraphStyleView(
                              value: currentParagraph,
                              onChanged: (paragraph) {
                                widget.onChanged(widget.value.copyWith(
                                  paragraphProperties: {
                                    ...widget.value.paragraphProperties,
                                    _currentStyle!: paragraph,
                                  },
                                ));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ));
  }
}
