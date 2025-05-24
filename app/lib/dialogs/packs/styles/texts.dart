import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../models/defaults.dart';
import '../../delete.dart';
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
  final _controller = TextEditingController();
  String? _currentStyle;

  @override
  void initState() {
    super.initState();

    _currentStyle = widget.value.spanProperties.keys.firstOrNull;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didUpdateWidget(covariant TextsStyleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _currentStyle != null) {
      setState(() {
        if (!widget.value.spanProperties.containsKey(_currentStyle!)) {
          _currentStyle = widget.value.paragraphProperties.keys.firstOrNull;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = DocumentDefaults.getSpanTranslations(context).entries
        .where(
          (element) => !widget.value.spanProperties.containsKey(element.key),
        );
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownMenu<String?>(
                controller: _controller,
                expandedInsets: const EdgeInsets.all(4),
                dropdownMenuEntries: [
                  ...widget.value.spanProperties.entries.map(
                    (style) =>
                        DropdownMenuEntry(value: style.key, label: style.key),
                  ),
                ],
                initialSelection: _currentStyle,
                onSelected: (value) {
                  setState(() {
                    _currentStyle = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filledTonal(
              icon: const PhosphorIcon(PhosphorIconsLight.plus),
              tooltip: AppLocalizations.of(context).add,
              onPressed: () async {
                final name = await showDialog<String>(
                  context: context,
                  builder: (context) => NameDialog(
                    validator: defaultFileNameValidator(
                      context,
                      widget.value.spanProperties.keys.toList(),
                    ),
                  ),
                );
                if (name == null) {
                  return;
                }
                widget.onChanged(
                  widget.value.copyWith(
                    spanProperties: {
                      ...widget.value.spanProperties,
                      name: const text.DefinedSpanProperty(),
                    },
                  ),
                );
              },
            ),
            MenuAnchor(
              builder: defaultMenuButton(
                tooltip: AppLocalizations.of(context).addElement,
                enabled: translations.isNotEmpty,
              ),
              menuChildren: translations
                  .map(
                    (e) => MenuItemButton(
                      child: Text(e.value),
                      onPressed: () {
                        widget.onChanged(
                          widget.value.copyWith(
                            spanProperties: {
                              ...widget.value.spanProperties,
                              e.key: const text.DefinedSpanProperty(),
                            },
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
            if (_currentStyle != null) ...[
              const VerticalDivider(),
              IconButton(
                icon: const PhosphorIcon(PhosphorIconsLight.pencil),
                tooltip: AppLocalizations.of(context).rename,
                onPressed: () async {
                  final name = await showDialog<String>(
                    context: context,
                    builder: (context) => NameDialog(
                      value: _currentStyle,
                      validator: defaultFileNameValidator(
                        context,
                        widget.value.spanProperties.keys.toList(),
                      ),
                      button: AppLocalizations.of(context).rename,
                    ),
                  );
                  if (name == null) {
                    return;
                  }
                  final lastStyle = _currentStyle;
                  _currentStyle = name;
                  widget.onChanged(
                    widget.value.copyWith(
                      spanProperties:
                          Map<String, text.DefinedSpanProperty>.from(
                              widget.value.spanProperties,
                            )
                            ..remove(lastStyle)
                            ..[name] = widget.value.spanProperties[lastStyle]!,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const PhosphorIcon(PhosphorIconsLight.trash),
                tooltip: AppLocalizations.of(context).delete,
                onPressed: () async {
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => const DeleteDialog(),
                  );
                  if (result != true) return;
                  if (context.mounted) {
                    final lastStyle = _currentStyle;
                    _currentStyle = null;
                    widget.onChanged(
                      widget.value.copyWith(
                        spanProperties:
                            Map<String, text.DefinedSpanProperty>.from(
                              widget.value.spanProperties,
                            )..remove(lastStyle),
                      ),
                    );
                  }
                },
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Flexible(
          child: Builder(
            builder: (context) {
              final currentSpan = widget.value.spanProperties[_currentStyle];
              if (currentSpan == null) {
                return Center(
                  child: ElevatedButton(
                    child: Text(LeapLocalizations.of(context).create),
                    onPressed: () {
                      widget.onChanged(
                        widget.value.copyWith(
                          spanProperties: {
                            ...widget.value.spanProperties,
                            _controller.text: const text.DefinedSpanProperty(),
                          },
                        ),
                      );
                      setState(() {
                        _currentStyle = _controller.text;
                      });
                    },
                  ),
                );
              }
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: TextStyleView(
                      value: currentSpan,
                      onChanged: (span) {
                        widget.onChanged(
                          widget.value.copyWith(
                            spanProperties: {
                              ...widget.value.spanProperties,
                              _currentStyle!: span,
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
