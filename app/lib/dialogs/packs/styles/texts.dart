import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'text.dart';

class TextsStyleView extends StatefulWidget {
  final text.TextStyleSheet value;
  final ValueChanged<text.TextStyleSheet> onChanged;

  const TextsStyleView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<TextsStyleView> createState() => _TextsStyleViewState();
}

class _TextsStyleViewState extends State<TextsStyleView> {
  String? _currentStyle;

  @override
  void initState() {
    super.initState();

    _currentStyle = widget.value.spanProperties.keys.firstOrNull;
  }

  @override
  void didUpdateWidget(covariant TextsStyleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        if (!widget.value.spanProperties.containsKey(_currentStyle!)) {
          _currentStyle = widget.value.spanProperties.keys.firstOrNull;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 64,
          child: Row(
            children: [
              Flexible(
                child: DropdownButtonFormField<String?>(
                  items: [
                    ...widget.value.spanProperties.entries.map(
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
                icon: const Icon(PhosphorIcons.plusLight),
                onPressed: () async {
                  final textController = TextEditingController();
                  final formKey = GlobalKey<FormState>();
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (context) => Form(
                      key: formKey,
                      child: AlertDialog(
                        title: Text(AppLocalizations.of(context).enterName),
                        content: TextFormField(
                          controller: textController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).name,
                          ),
                          validator: (name) {
                            if (widget.value.spanProperties.containsKey(name)) {
                              return AppLocalizations.of(context).alreadyExists;
                            }
                            return null;
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(AppLocalizations.of(context).cancel),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (!formKey.currentState!.validate()) {
                                return;
                              }
                              Navigator.of(context).pop(true);
                            },
                            child: Text(AppLocalizations.of(context).create),
                          ),
                        ],
                      ),
                    ),
                  );
                  final name = textController.text;
                  if (result != true) {
                    return;
                  }
                  widget.onChanged(widget.value.copyWith(
                    spanProperties: {
                      ...widget.value.spanProperties,
                      name: const text.DefinedSpanProperty(),
                    },
                  ));
                },
              ),
              if (_currentStyle != null) ...[
                IconButton(
                  icon: const Icon(PhosphorIcons.pencilLight),
                  onPressed: () async {
                    final textController =
                        TextEditingController(text: _currentStyle);
                    final formKey = GlobalKey<FormState>();
                    final result = await showDialog<bool>(
                      context: context,
                      builder: (context) => Form(
                        key: formKey,
                        child: AlertDialog(
                          title: Text(AppLocalizations.of(context).enterName),
                          content: TextFormField(
                            controller: textController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).name,
                            ),
                            validator: (name) {
                              if (widget.value.spanProperties
                                  .containsKey(widget.value)) {
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
                              child: Text(AppLocalizations.of(context).cancel),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }
                                Navigator.of(context).pop(true);
                              },
                              child: Text(AppLocalizations.of(context).create),
                            ),
                          ],
                        ),
                      ),
                    );
                    final name = textController.text;
                    if (result != true) {
                      return;
                    }
                    final lastStyle = _currentStyle;
                    _currentStyle = name;
                    widget.onChanged(widget.value.copyWith(
                      spanProperties:
                          Map<String, text.DefinedSpanProperty>.from(
                              widget.value.spanProperties)
                            ..remove(lastStyle)
                            ..[name] = widget.value.spanProperties[lastStyle]!,
                    ));
                  },
                ),
                IconButton(
                  icon: const Icon(PhosphorIcons.trashLight),
                  onPressed: () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(AppLocalizations.of(context).delete),
                        content:
                            Text(AppLocalizations.of(context).reallyDelete),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(AppLocalizations.of(context).cancel),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text(AppLocalizations.of(context).delete),
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
                      spanProperties:
                          Map<String, text.DefinedSpanProperty>.from(
                              widget.value.spanProperties)
                            ..remove(lastStyle),
                    ));
                  },
                ),
              ]
            ],
          ),
        ),
        Flexible(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  final currentspan =
                      widget.value.spanProperties[_currentStyle];
                  if (currentspan == null) {
                    return const SizedBox();
                  }
                  return SingleChildScrollView(
                    child: TextStyleView(
                      value: currentspan,
                      onChanged: (span) {
                        widget.onChanged(widget.value.copyWith(
                          spanProperties: {
                            ...widget.value.spanProperties,
                            _currentStyle!: span,
                          },
                        ));
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
