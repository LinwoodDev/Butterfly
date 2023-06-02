import 'package:butterfly/dialogs/name.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
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
  String? _currentStyle;

  @override
  void initState() {
    super.initState();

    _currentStyle = widget.value.spanProperties.keys.firstOrNull;
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
                icon: const PhosphorIcon(PhosphorIconsLight.plus),
                onPressed: () async {
                  final name = await showDialog<String>(
                    context: context,
                    builder: (context) => NameDialog(
                      validator: defaultNameValidator(
                        context,
                        widget.value.spanProperties.keys.toList(),
                      ),
                    ),
                  );
                  if (name == null) {
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
              MenuAnchor(
                builder: defaultMenuButton(),
                menuChildren: DocumentDefaults.getSpanTranslations(context)
                    .entries
                    .where((element) =>
                        !widget.value.spanProperties.containsKey(element.key))
                    .map(
                      (e) => MenuItemButton(
                        child: Text(e.value),
                        onPressed: () {
                          widget.onChanged(widget.value.copyWith(
                            spanProperties: {
                              ...widget.value.spanProperties,
                              e.key: const text.DefinedSpanProperty(),
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
                          widget.value.spanProperties.keys.toList(),
                        ),
                      ),
                    );
                    if (name == null) {
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
                  icon: const PhosphorIcon(PhosphorIconsLight.trash),
                  onPressed: () async {
                    final result = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => const DeleteDialog());
                    if (result != true) return;
                    if (context.mounted) {
                      final lastStyle = _currentStyle;
                      _currentStyle = null;
                      widget.onChanged(widget.value.copyWith(
                        spanProperties:
                            Map<String, text.DefinedSpanProperty>.from(
                                widget.value.spanProperties)
                              ..remove(lastStyle),
                      ));
                    }
                  },
                ),
              ]
            ],
          ),
        ),
        Flexible(
          child: Builder(
            builder: (context) {
              final currentspan = widget.value.spanProperties[_currentStyle];
              if (currentspan == null) {
                return const SizedBox();
              }
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
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
