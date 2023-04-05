import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../widgets/color_field.dart';
import '../../../widgets/exact_slider.dart';

class TextStyleView extends StatefulWidget {
  final text.DefinedSpanProperty value;
  final ValueChanged<text.DefinedSpanProperty> onChanged;
  const TextStyleView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<TextStyleView> createState() => _TextStyleViewState();
}

class _TextStyleViewState extends State<TextStyleView> {
  bool _decorationExpanded = false;

  @override
  void didUpdateWidget(covariant TextStyleView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorField(
            title: Text(AppLocalizations.of(context).color),
            subtitle: widget.value.color == null
                ? Text(AppLocalizations.of(context).notSet)
                : null,
            custom: true,
            value: widget.value.color == null
                ? Colors.transparent
                : Color(widget.value.color!),
            leading: widget.value.color == null
                ? null
                : IconButton(
                    icon: PhosphorIcon(PhosphorIcons.light.eraser),
                    onPressed: () =>
                        widget.onChanged(widget.value.copyWith(color: null))),
            defaultColor: null,
            onChanged: (color) =>
                widget.onChanged(widget.value.copyWith(color: color.value))),
        ExactSlider(
            header: Text(AppLocalizations.of(context).size),
            bottom: widget.value.size == null
                ? Text(AppLocalizations.of(context).notSet)
                : null,
            leading: widget.value.size == null
                ? null
                : IconButton(
                    icon: PhosphorIcon(PhosphorIcons.light.eraser),
                    onPressed: () =>
                        widget.onChanged(widget.value.copyWith(size: null)),
                  ),
            value: widget.value.size,
            defaultValue: 12,
            min: 6,
            max: 512,
            onChangeEnd: (size) =>
                widget.onChanged(widget.value.copyWith(size: size))),
        ExactSlider(
            header: Text(AppLocalizations.of(context).spacing),
            bottom: widget.value.letterSpacing == null
                ? Text(AppLocalizations.of(context).notSet)
                : null,
            leading: widget.value.letterSpacing == null
                ? null
                : IconButton(
                    icon: PhosphorIcon(PhosphorIcons.light.eraser),
                    onPressed: () => widget
                        .onChanged(widget.value.copyWith(letterSpacing: null)),
                  ),
            value: widget.value.letterSpacing,
            defaultValue: 0,
            min: 0,
            max: 20,
            onChangeEnd: (spacing) => widget.onChanged(
                  widget.value.copyWith(letterSpacing: spacing),
                )),
        const SizedBox(height: 16),
        ListTile(
            title: Text(AppLocalizations.of(context).fontWeight),
            trailing: DropdownButton<FontWeight?>(
                value: widget.value.fontWeight == null
                    ? null
                    : FontWeight.values[widget.value.fontWeight!],
                items: [
                  ...List.generate(FontWeight.values.length, (index) {
                    var current = ((index + 1) * 100).toString();
                    if (index == text.kFontWeightNormal) {
                      current = AppLocalizations.of(context).normal;
                    } else if (index == text.kFontWeightBold) {
                      current = AppLocalizations.of(context).bold;
                    }
                    return DropdownMenuItem(
                        value: FontWeight.values[index], child: Text(current));
                  }),
                  DropdownMenuItem(
                    value: null,
                    child: Text(AppLocalizations.of(context).notSet),
                  ),
                ],
                onChanged: (weight) => widget.onChanged(
                    widget.value.copyWith(fontWeight: weight?.index)))),
        CheckboxListTile(
            title: Text(AppLocalizations.of(context).italic),
            value: widget.value.italic,
            tristate: true,
            onChanged: (italic) =>
                widget.onChanged(widget.value.copyWith(italic: italic))),
        StatefulBuilder(
          builder: ((context, setState) => ExpansionPanelList(
                expansionCallback: (panelIndex, isExpanded) =>
                    setState(() => _decorationExpanded = !_decorationExpanded),
                children: [
                  ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: _decorationExpanded,
                      headerBuilder: (context, isExpanded) => ListTile(
                            title:
                                Text(AppLocalizations.of(context).decoration),
                          ),
                      body: Column(children: [
                        CheckboxListTile(
                            title: Text(
                                AppLocalizations.of(context).strikethrough),
                            value: widget.value.lineThrough,
                            tristate: true,
                            onChanged: (lineThrough) => widget.onChanged(widget
                                .value
                                .copyWith(lineThrough: lineThrough))),
                        CheckboxListTile(
                            title: Text(AppLocalizations.of(context).underline),
                            value: widget.value.underline,
                            tristate: true,
                            onChanged: (underline) => widget.onChanged(
                                widget.value.copyWith(underline: underline))),
                        CheckboxListTile(
                            title: Text(AppLocalizations.of(context).overline),
                            value: widget.value.overline,
                            tristate: true,
                            onChanged: (overline) => widget.onChanged(
                                widget.value.copyWith(overline: overline))),
                        ListTile(
                            title: Text(AppLocalizations.of(context).style),
                            trailing: DropdownButton<text.TextDecorationStyle?>(
                                value: widget.value.decorationStyle,
                                items: [
                                  ...text.TextDecorationStyle.values
                                      .map((style) {
                                    String name;
                                    switch (style) {
                                      case text.TextDecorationStyle.solid:
                                        name =
                                            AppLocalizations.of(context).solid;
                                        break;
                                      case text.TextDecorationStyle.dashed:
                                        name =
                                            AppLocalizations.of(context).dashed;
                                        break;
                                      case text.TextDecorationStyle.dotted:
                                        name =
                                            AppLocalizations.of(context).dotted;
                                        break;
                                      case text.TextDecorationStyle.double:
                                        name =
                                            AppLocalizations.of(context).double;
                                        break;
                                      case text.TextDecorationStyle.wavy:
                                        name =
                                            AppLocalizations.of(context).wavy;
                                    }
                                    return DropdownMenuItem(
                                        value: style, child: Text(name));
                                  }).toList(),
                                  DropdownMenuItem(
                                    value: null,
                                    child: Text(
                                        AppLocalizations.of(context).notSet),
                                  ),
                                ],
                                onChanged: (decorationStyle) =>
                                    widget.onChanged(widget.value.copyWith(
                                        decorationStyle: decorationStyle)))),
                        ColorField(
                            title: Text(AppLocalizations.of(context).color),
                            custom: true,
                            subtitle: widget.value.decorationColor == null
                                ? Text(AppLocalizations.of(context).notSet)
                                : null,
                            value: widget.value.decorationColor == null
                                ? Colors.transparent
                                : Color(widget.value.decorationColor!),
                            leading: widget.value.decorationColor == null
                                ? null
                                : IconButton(
                                    icon: PhosphorIcon(
                                        PhosphorIcons.light.eraser),
                                    onPressed: () => widget.onChanged(widget
                                        .value
                                        .copyWith(decorationColor: null))),
                            defaultColor: null,
                            onChanged: (color) => widget.onChanged(widget.value
                                .copyWith(decorationColor: color.value))),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ExactSlider(
                              header:
                                  Text(AppLocalizations.of(context).thickness),
                              defaultValue: 1,
                              value: widget.value.decorationThickness,
                              bottom: widget.value.decorationThickness == null
                                  ? Text(AppLocalizations.of(context).notSet)
                                  : null,
                              leading: widget.value.decorationThickness == null
                                  ? null
                                  : IconButton(
                                      icon: PhosphorIcon(
                                          PhosphorIcons.light.eraser),
                                      onPressed: () => widget.onChanged(widget
                                          .value
                                          .copyWith(decorationThickness: null)),
                                    ),
                              min: 0.1,
                              max: 4,
                              onChangeEnd: (thickness) => widget.onChanged(
                                  widget.value.copyWith(
                                      decorationThickness: thickness))),
                        ),
                      ]))
                ],
              )),
        ),
      ],
    );
  }
}
