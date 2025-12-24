import 'dart:math';

import 'package:butterfly/dialogs/packs/color_pick.dart';
import 'package:butterfly/visualizer/element.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:material_leap/material_leap.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/document_bloc.dart';
import '../../dialogs/packs/select.dart';
import '../../models/defaults.dart';
import '../../models/label.dart';
import 'view.dart';

class LabelToolbarView extends StatefulWidget implements PreferredSizeWidget {
  final LabelContext value;
  final ValueChanged<LabelContext> onChanged;

  const LabelToolbarView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<LabelToolbarView> createState() => _LabelToolbarViewState();

  @override
  Size get preferredSize => kToolbarLarge;
}

class _LabelToolbarViewState extends State<LabelToolbarView> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _sizeController = TextEditingController(),
      _scaleController = TextEditingController();

  final GlobalKey _paragraphKey = GlobalKey(), _spanKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    _sizeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LabelToolbarView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _scrollController.jumpTo(0);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final markdownParagraphTools = <(IconGetter, String, String)>[
      ...[
        PhosphorIcons.textHOne,
        PhosphorIcons.textHTwo,
        PhosphorIcons.textHThree,
        PhosphorIcons.textHFour,
        PhosphorIcons.textHFive,
        PhosphorIcons.textHSix,
      ].asMap().entries.map(
        (e) => (
          e.value,
          AppLocalizations.of(context).headline(e.key + 1),
          '#' * (e.key + 1),
        ),
      ),
      (PhosphorIcons.quotes, AppLocalizations.of(context).quote, '>'),
      (PhosphorIcons.codeBlock, AppLocalizations.of(context).code, '```'),
    ];
    final markdownSpanTools = <(IconGetter, String, String)>[
      (PhosphorIcons.textB, AppLocalizations.of(context).bold, '**'),
      (PhosphorIcons.textItalic, AppLocalizations.of(context).italic, '*'),
      (
        PhosphorIcons.textStrikethrough,
        AppLocalizations.of(context).strikethrough,
        '~~',
      ),
      (PhosphorIcons.code, AppLocalizations.of(context).code, '`'),
      (PhosphorIcons.mathOperations, AppLocalizations.of(context).math, '\$'),
    ];
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return Container();
    final document = state.data;
    final value = widget.value;
    final paragraph =
        switch (value) {
          TextContext e => e.getDefinedProperty(document),
          _ => null,
        } ??
        const text.DefinedParagraphProperty();
    final property = switch (value) {
      TextContext e => e.getDefinedForcedSpanProperty(document),
      _ => null,
    };
    final named = value.getNamedStyleSheet(document);
    final styleSheet = named?.item;
    _scaleController.text = (value.labelElement?.scale ?? value.tool.scale)
        .toString();
    _sizeController.text = property?.getSize(paragraph).toString() ?? '';
    var paragraphSelection = switch (paragraph) {
      text.NamedParagraphProperty e => e.name,
      _ => null,
    };
    final paragraphSelections = [
      ...styleSheet?.paragraphProperties.keys ?? <String>[],
      '',
    ];
    final lineIndex = value.previousLineIndex(
      value.selection.baseOffset.clamp(0, value.text?.length ?? 0),
    );
    final linePrefix =
        value.text?.substring(min(lineIndex + 1, value.text!.length)) ?? '';
    final mode = value.tool.mode;
    if (!paragraphSelections.contains(paragraphSelection)) {
      paragraphSelection = '';
    }

    var spanSelection = switch (value) {
      TextContext e => switch (e.getSpanProperty(document)) {
        text.NamedSpanProperty e => e.name,
        _ => '',
      },
      _ => null,
    };
    final spanSelections = [
      ...styleSheet?.spanProperties.keys ?? <String>[],
      '',
    ];
    if (!spanSelections.contains(spanSelection)) {
      spanSelection = '';
    }

    void updateSpan(
      text.DefinedSpanProperty Function(text.DefinedSpanProperty) update,
    ) {
      final value = widget.value;
      if (value is! TextContext) return;
      final selection = value.selection;
      var element = value.element;
      if (element == null) {
        final newSpan = update(property!);
        widget.onChanged(
          value.copyWith(
            forcedProperty: text.ParagraphProperty.defined(span: newSpan),
            forcedSpanProperty: newSpan,
          ),
        );
        return;
      }
      if (value.isParagraph()) {
        final currentParagraphProperty = styleSheet.resolveParagraphProperty(
          element.area.paragraph.property,
        );
        element = element.copyWith(
          area: element.area.copyWith(
            paragraph: element.area.paragraph.copyWith(
              property:
                  currentParagraphProperty?.copyWith(
                    span: update(currentParagraphProperty.span),
                  ) ??
                  element.area.paragraph.property,
            ),
          ),
        );
      } else {
        element = element.copyWith(
          area: element.area.copyWith(
            paragraph: element.area.paragraph.updateSpans(
              (span) => span.copyWith(
                property: update(
                  styleSheet.resolveSpanProperty(span.property) ??
                      const text.DefinedSpanProperty(),
                ),
              ),
              selection.start,
              selection.end - selection.start,
            ),
          ),
        );
      }
      widget.onChanged(
        value.copyWith(element: element, forcedSpanProperty: update(property!)),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) => Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: TextDirection.ltr,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const PhosphorIcon(PhosphorIconsLight.package),
                        tooltip: AppLocalizations.of(context).selectAsset,
                        onPressed: () async {
                          final bloc = context.read<DocumentBloc>();
                          final result =
                              await showDialog<PackItem<text.TextStyleSheet>>(
                                context: context,
                                builder: (context) => BlocProvider.value(
                                  value: bloc,
                                  child: SelectPackAssetDialog(
                                    selectedItem: named,
                                    getItems: (pack) => pack.getNamedStyles(),
                                  ),
                                ),
                              );
                          if (result == null) return;
                          if (value.element == null) {
                            widget.onChanged(
                              value.copyWith(
                                tool: value.tool.copyWith(
                                  styleSheet: result.toNamed(),
                                ),
                              ),
                            );
                            return;
                          }
                          final resultNamed = result.toNamed();
                          var newValue = value.copyWith(
                            tool: value.tool.copyWith(styleSheet: resultNamed),
                          );
                          newValue = switch (value) {
                            TextContext e => e.copyWith(
                              element: e.element?.copyWith(
                                styleSheet: resultNamed,
                              ),
                            ),
                            MarkdownContext e => e.copyWith(
                              element: e.element?.copyWith(
                                styleSheet: resultNamed,
                              ),
                            ),
                          };
                          widget.onChanged(newValue);
                        },
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const PhosphorIcon(
                          PhosphorIconsLight.magnifyingGlass,
                        ),
                        selectedIcon: const PhosphorIcon(
                          PhosphorIconsFill.magnifyingGlass,
                        ),
                        isSelected: value.tool.zoomDependent,
                        tooltip: AppLocalizations.of(context).zoomDependent,
                        onPressed: () => widget.onChanged(
                          value.copyWith(
                            tool: value.tool.copyWith(
                              zoomDependent: !widget.value.tool.zoomDependent,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      MenuAnchor(
                        menuChildren: LabelMode.values
                            .map(
                              (e) => MenuItemButton(
                                leadingIcon: Icon(
                                  e.icon(PhosphorIconsStyle.light),
                                ),
                                child: Text(e.getLocalizedName(context)),
                                onPressed: () => widget.onChanged(
                                  value.copyWith(
                                    tool: value.tool.copyWith(mode: e),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        builder: defaultMenuButton(
                          icon: PhosphorIcon(
                            mode.icon(PhosphorIconsStyle.light),
                          ),
                          tooltip: AppLocalizations.of(context).chooseLabelMode,
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).scale,
                            filled: true,
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            alignLabelWithHint: true,
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _scaleController,
                          onFieldSubmitted: (current) {
                            final newScale = double.tryParse(current);
                            if (newScale == null) return;
                            final element = value.element;
                            if (element == null) {
                              widget.onChanged(
                                value.copyWith(
                                  tool: value.tool.copyWith(scale: newScale),
                                ),
                              );
                              return;
                            }
                            widget.onChanged(switch (value) {
                              TextContext e => e.copyWith(
                                element: e.element!.copyWith(scale: newScale),
                              ),
                              MarkdownContext e => e.copyWith(
                                element: e.element!.copyWith(scale: newScale),
                              ),
                            });
                          },
                        ),
                      ),
                      if (value is TextContext) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.article),
                          selectedIcon: const PhosphorIcon(
                            PhosphorIconsFill.article,
                          ),
                          tooltip: AppLocalizations.of(context).paragraph,
                          isSelected: value.isParagraph(),
                          onPressed: value.area == null
                              ? null
                              : () => widget.onChanged(
                                  value.copyWith(
                                    forceParagraph: !value.isParagraph(),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 8),
                        value.isParagraph()
                            ? DropdownMenu<String>(
                                key: _paragraphKey,
                                dropdownMenuEntries: paragraphSelections.map((
                                  e,
                                ) {
                                  final isSpecial =
                                      DocumentDefaults.getParagraphTranslations(
                                        context,
                                      ).containsKey(e);
                                  return DropdownMenuEntry<String>(
                                    value: e,
                                    label: DocumentDefaults.translateParagraph(
                                      e,
                                      context,
                                    ),
                                    style: isSpecial
                                        ? ButtonStyle(
                                            foregroundColor:
                                                WidgetStateProperty.all(
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                ),
                                          )
                                        : null,
                                  );
                                }).toList(),
                                initialSelection: paragraphSelection,
                                onSelected: (name) {
                                  if (name == null) return;
                                  widget.onChanged(
                                    value.copyWith(
                                      forcedProperty:
                                          text.ParagraphProperty.named(name),
                                      element: value.element?.copyWith(
                                        area: value.element!.area.copyWith(
                                          paragraph: value
                                              .element!
                                              .area
                                              .paragraph
                                              .copyWith(
                                                property:
                                                    text.ParagraphProperty.named(
                                                      name,
                                                    ),
                                              ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                label: Text(AppLocalizations.of(context).style),
                                trailingIcon: value.modified(document)
                                    ? const PhosphorIcon(
                                        PhosphorIconsLight.star,
                                      )
                                    : null,
                              )
                            : DropdownMenu<String>(
                                key: _spanKey,
                                dropdownMenuEntries: spanSelections.map((e) {
                                  final isSpecial =
                                      DocumentDefaults.getSpanTranslations(
                                        context,
                                      ).containsKey(e);
                                  return DropdownMenuEntry<String>(
                                    value: e,
                                    label: DocumentDefaults.translateBlock(
                                      e,
                                      context,
                                    ),
                                    style: isSpecial
                                        ? ButtonStyle(
                                            foregroundColor:
                                                WidgetStateProperty.all(
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                ),
                                          )
                                        : null,
                                  );
                                }).toList(),
                                initialSelection: spanSelection,
                                onSelected: (name) {
                                  if (name == null) return;
                                  widget.onChanged(
                                    value.copyWith(
                                      forcedSpanProperty:
                                          text.SpanProperty.named(name),
                                      element: value.element?.copyWith.area(
                                        paragraph: value.element!.area.paragraph
                                            .applyStyle(
                                              text.SpanProperty.named(name),
                                              value.selection.start,
                                              value.selection.end -
                                                  value.selection.start,
                                            ),
                                      ),
                                    ),
                                  );
                                },
                                label: Text(AppLocalizations.of(context).style),
                                trailingIcon: value.modified(document)
                                    ? const PhosphorIcon(
                                        PhosphorIconsLight.star,
                                      )
                                    : null,
                              ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.eraser),
                          selectedIcon: const PhosphorIcon(
                            PhosphorIconsFill.eraser,
                          ),
                          tooltip: AppLocalizations.of(context).clearStyle,
                          isSelected: value.isParagraph()
                              ? switch (value.getProperty()) {
                                  text.UndefinedParagraphProperty _ => true,
                                  _ => false,
                                }
                              : switch (value.paragraph
                                    ?.getSpan(value.selection.start)
                                    ?.property) {
                                  text.UndefinedSpanProperty _ => true,
                                  _ => false,
                                },
                          onPressed: () async {
                            if (value.isParagraph()) {
                              widget.onChanged(
                                value.copyWith(
                                  forcedProperty: null,
                                  element: value.element?.copyWith.area.paragraph(
                                    property:
                                        const text.ParagraphProperty.undefined(),
                                  ),
                                ),
                              );
                            } else {
                              widget.onChanged(
                                value.copyWith(
                                  forcedSpanProperty: null,
                                  element: value.element?.copyWith.area(
                                    paragraph: value.element!.area.paragraph
                                        .applyStyle(
                                          const text.SpanProperty.undefined(),
                                          value.selection.start,
                                          value.selection.end -
                                              value.selection.start,
                                        ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        _buildMathWidget(context, value),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: switch (value) {
                    TextContext value => Row(
                      children: [
                        /*ToggleButtons(
                          isSelected: text.VerticalAlignment.values
                              .map((e) =>
                                  e == value.area?.areaProperty.alignment)
                              .toList(),
                          onPressed: value.element == null
                              ? null
                              : (align) {
                                  onChanged(value.copyWith(
                                    element: value.element!.copyWith(
                                      area: value.element!.area.copyWith(
                                        areaProperty: value
                                            .element!.area.areaProperty
                                            .copyWith(
                                          alignment: text
                                              .VerticalAlignment.values[align],
                                        ),
                                      ),
                                    ),
                                  ));
                                },
                          children: const [
                            PhosphorIcon(PhosphorIconsLight.alignTop),
                            PhosphorIcon(PhosphorIconsLight.alignCenterVertical),
                            PhosphorIcon(PhosphorIconsLight.alignBottom),
                          ],
                        ),
                        const SizedBox(width: 16),*/
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: ToggleButtons(
                            isSelected: text.HorizontalAlignment.values
                                .map((e) => e == paragraph.alignment)
                                .toList(),
                            children: const [
                              PhosphorIconsLight.textAlignLeft,
                              PhosphorIconsLight.textAlignCenter,
                              PhosphorIconsLight.textAlignRight,
                              PhosphorIconsLight.textAlignJustify,
                            ].map((e) => PhosphorIcon(e)).toList(),
                            onPressed: (current) {
                              final newParagraph = paragraph.copyWith(
                                alignment:
                                    text.HorizontalAlignment.values[current],
                              );
                              widget.onChanged(
                                value.copyWith(
                                  forcedProperty: newParagraph,
                                  element: value.element?.copyWith.area
                                      .paragraph(property: newParagraph),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        /*FutureBuilder<List<String>?>(
                          future: Future.value(SysInfo.getFonts()),
                          builder: (context, snapshot) {
                            return DropdownMenu<String>(
                              dropdownMenuEntries: snapshot.data
                                      ?.map((e) => DropdownMenuEntry<String>(
                                            value: e,
                                            label: e,
                                          ))
                                      .toList() ??
                                  [],
                              enableFilter: true,
                              onSelected: (value) {
                                if (kDebugMode) {
                                  print(value);
                                }
                              },
                              width: 200,
                              label:
                                  Text(AppLocalizations.of(context).fontFamily),
                              inputDecorationTheme:
                                  const InputDecorationTheme(filled: true),
                            );
                          },
                        ),
                        const SizedBox(width: 8),*/
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).size,
                              filled: true,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              alignLabelWithHint: true,
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: _sizeController,
                            onFieldSubmitted: (current) {
                              updateSpan(
                                (value) => value.copyWith(
                                  size:
                                      double.tryParse(current) ??
                                      property?.size,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32),
                          ),
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: property!.getColor(paragraph).toColor(),
                              border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32),
                              ),
                            ),
                          ),
                          onTap: () async {
                            final result = await showDialog<SRGBColor>(
                              context: context,
                              builder: (_) => ColorPalettePickerDialog(
                                value: property.getColor(paragraph),
                                bloc: context.read<DocumentBloc>(),
                              ),
                            );
                            if (result == null) return;
                            updateSpan(
                              (value) => value.copyWith(
                                color: result.withValues(
                                  a: widget.value.tool.foreground.a,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: ToggleButtons(
                            isSelected: [
                              property.getFontWeight(paragraph) !=
                                  text.kFontWeightNormal,
                              property.getItalic(paragraph),
                              property.getUnderline(paragraph),
                            ],
                            children: [
                              GestureDetector(
                                child: const PhosphorIcon(
                                  PhosphorIconsLight.textB,
                                ),
                                onLongPressEnd: (details) {
                                  final RenderObject? overlay = Overlay.of(
                                    context,
                                  ).context.findRenderObject();
                                  final RenderBox referenceBox =
                                      context.findRenderObject() as RenderBox;
                                  var tapPosition = referenceBox.globalToLocal(
                                    details.globalPosition,
                                  );
                                  showMenu(
                                    context: context,
                                    position: RelativeRect.fromRect(
                                      Rect.fromLTWH(
                                        tapPosition.dx,
                                        tapPosition.dy,
                                        30,
                                        30,
                                      ),
                                      Rect.fromLTWH(
                                        0,
                                        0,
                                        overlay!.paintBounds.size.width,
                                        overlay.paintBounds.size.height,
                                      ),
                                    ),
                                    initialValue:
                                        FontWeight.values[property
                                            .getFontWeight(paragraph)],
                                    items: List.generate(
                                      FontWeight.values.length,
                                      (index) {
                                        var text = ((index + 1) * 100)
                                            .toString();
                                        if (index == 3) {
                                          text = AppLocalizations.of(
                                            context,
                                          ).normal;
                                        } else if (index == 6) {
                                          text = AppLocalizations.of(
                                            context,
                                          ).bold;
                                        }
                                        return PopupMenuItem(
                                          value: FontWeight.values[index],
                                          child: Text(text),
                                          onTap: () {
                                            updateSpan(
                                              (value) => value.copyWith(
                                                fontWeight: index,
                                              ),
                                            );
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              const PhosphorIcon(PhosphorIconsLight.textItalic),
                              const PhosphorIcon(
                                PhosphorIconsLight.textUnderline,
                              ),
                            ],
                            onPressed: (current) => switch (current) {
                              0 => updateSpan(
                                (value) => value.copyWith(
                                  fontWeight:
                                      property.fontWeight ==
                                          text.kFontWeightNormal
                                      ? text.kFontWeightBold
                                      : text.kFontWeightNormal,
                                ),
                              ),
                              1 => updateSpan(
                                (value) => value.copyWith(
                                  italic: !property.getItalic(paragraph),
                                ),
                              ),
                              2 => updateSpan(
                                (value) => value.copyWith(
                                  underline: !property.getUnderline(paragraph),
                                ),
                              ),
                              _ => null,
                            },
                          ),
                        ),
                      ],
                    ),
                    MarkdownContext value => Row(
                      children: [
                        ToggleButtons(
                          isSelected: markdownParagraphTools
                              .map((e) => linePrefix.startsWith('${e.$3} '))
                              .toList(),
                          onPressed: value.element == null
                              ? null
                              : (index) {
                                  final current = markdownParagraphTools[index];
                                  final prefix = current.$3;
                                  final text = value.text;
                                  if (text == null) return;
                                  final enabled = linePrefix.startsWith(
                                    '$prefix ',
                                  );
                                  final newText = enabled
                                      ? text.replaceRange(
                                          lineIndex + 1,
                                          lineIndex + 2 + prefix.length,
                                          '',
                                        )
                                      : text.replaceRange(
                                          lineIndex + 1,
                                          lineIndex + 1,
                                          '$prefix ',
                                        );
                                  var newSelection =
                                      value.selection.start +
                                      (prefix.length + 1) * (enabled ? -1 : 1);
                                  widget.onChanged(
                                    value.copyWith(
                                      element: value.element?.copyWith(
                                        text: newText,
                                      ),
                                      selection: TextSelection.collapsed(
                                        offset: newSelection,
                                      ),
                                    ),
                                  );
                                },
                          children: markdownParagraphTools
                              .map(
                                (e) => Tooltip(
                                  message: e.$2,
                                  child: Icon(e.$1(PhosphorIconsStyle.light)),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(width: 16),
                        ToggleButtons(
                          isSelected: markdownSpanTools
                              .map((e) => false)
                              .toList(),
                          onPressed: value.element == null
                              ? null
                              : (index) {
                                  final current = markdownSpanTools[index];
                                  final prefix = current.$3;
                                  final selection = value.selection;
                                  final text = value.text;
                                  if (text == null) return;
                                  final newText =
                                      text.substring(0, selection.start) +
                                      prefix +
                                      text.substring(
                                        selection.start,
                                        value.selection.end,
                                      ) +
                                      prefix +
                                      text.substring(selection.end);
                                  widget.onChanged(
                                    value.copyWith(
                                      element: value.element?.copyWith(
                                        text: newText,
                                      ),
                                      selection: selection.isCollapsed
                                          ? TextSelection.collapsed(
                                              offset:
                                                  selection.start +
                                                  prefix.length,
                                            )
                                          : TextSelection(
                                              baseOffset: selection.start,
                                              extentOffset:
                                                  selection.end +
                                                  prefix.length * 2,
                                              affinity: selection.affinity,
                                              isDirectional:
                                                  selection.isDirectional,
                                            ),
                                    ),
                                  );
                                },
                          children: markdownSpanTools
                              .map(
                                (e) => Tooltip(
                                  message: e.$2,
                                  child: Icon(e.$1(PhosphorIconsStyle.light)),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMathWidget(BuildContext context, TextContext value) {
    final isMath = value.isMathSelection();
    return IconButton(
      icon: const PhosphorIcon(PhosphorIconsLight.mathOperations),
      selectedIcon: const PhosphorIcon(PhosphorIconsFill.mathOperations),
      tooltip: AppLocalizations.of(context).math,
      isSelected: isMath,
      onPressed: () async {
        final selection = value.selection;
        final element = value.element;
        if (element == null) return;
        // Get selection text
        var content = element.text.substring(selection.start, selection.end);
        var newSelection = selection;
        if (content.isEmpty && !isMath) {
          content = ' ';
          newSelection = TextSelection(
            baseOffset: selection.start,
            extentOffset: selection.start + 1,
          );
        }
        // Create new span
        final newSpan = isMath
            ? text.TextSpan(text: content)
            : text.MathTextSpan(text: content);
        // Replace spans in paragraph
        var paragraph = element.area.paragraph.replace(
          newSpan,
          selection.start,
          selection.end - selection.start,
        );
        widget.onChanged(
          value.copyWith(
            element: element.copyWith.area(paragraph: paragraph),
            selection: newSelection,
          ),
        );
      },
    );
  }
}
