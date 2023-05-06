import 'package:butterfly/dialogs/color_pick.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:butterfly_api/butterfly_text.dart' as text;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/document_bloc.dart';
import '../../dialogs/packs/select.dart';
import '../../models/text.dart';

class LabelToolbarView extends StatefulWidget {
  final TextContext value;
  final ValueChanged<TextContext> onChanged;

  const LabelToolbarView({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<LabelToolbarView> createState() => _LabelToolbarViewState();
}

class _LabelToolbarViewState extends State<LabelToolbarView> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _sizeController = TextEditingController();

  final GlobalKey _paragraphKey = GlobalKey(), _spanKey = GlobalKey();

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
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return Container();
    final document = state.data;
    final paragraph = widget.value.getDefinedProperty(document) ??
        const text.DefinedParagraphProperty();
    final span = widget.value.getDefinedForcedSpanProperty(document);
    final styleSheet =
        widget.value.element?.styleSheet ?? widget.value.painter.styleSheet;
    final style = styleSheet.resolveStyle(document);
    _sizeController.text = span.getSize(paragraph).toString();
    var paragraphSelection = paragraph.mapOrNull(named: (value) => value.name);
    final paragraphSelections = [
      ...style?.paragraphProperties.keys ?? <String>[],
      ''
    ];
    if (!paragraphSelections.contains(paragraphSelection)) {
      paragraphSelection = '';
    }

    var spanSelection = widget.value
            .getSpanProperty(document)
            ?.mapOrNull(named: (value) => value.name) ??
        '';
    final spanSelections = [...style?.spanProperties.keys ?? <String>[], ''];
    if (!spanSelections.contains(spanSelection)) {
      spanSelection = '';
    }

    void updateSpan(
        text.DefinedSpanProperty Function(text.DefinedSpanProperty) update) {
      final selection = widget.value.selection;
      var element = widget.value.element;
      if (element == null) {
        final newSpan = update(span);
        widget.onChanged(widget.value.copyWith(
          forcedProperty: text.ParagraphProperty.defined(
            span: newSpan,
          ),
          forcedSpanProperty: newSpan,
        ));
        return;
      }
      if (widget.value.isParagraph()) {
        final currentParagraphProperty = style.resolveParagraphProperty(
          element.area.paragraph.property,
        );
        element = element.copyWith(
          area: element.area.copyWith(
            paragraph: element.area.paragraph.copyWith(
              property: currentParagraphProperty?.copyWith(
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
                    property: update(style.resolveSpanProperty(span.property) ??
                        const text.DefinedSpanProperty())),
                selection.start,
                selection.end - selection.start),
          ),
        );
      }
      widget.onChanged(widget.value.copyWith(
        element: element,
        forcedSpanProperty: update(span),
      ));
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
                  minHeight: constraints.maxHeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.package),
                          onPressed: () async {
                            final bloc = context.read<DocumentBloc>();
                            final result = await showDialog<PackAssetLocation>(
                              context: context,
                              builder: (context) => BlocProvider.value(
                                value: bloc,
                                child: SelectPackAssetDialog(
                                  type: PackAssetType.style,
                                  selected: styleSheet,
                                ),
                              ),
                            );
                            if (result == null) return;
                            if (widget.value.element == null) {
                              widget.onChanged(widget.value.copyWith(
                                painter: LabelPainter(
                                  styleSheet: result,
                                ),
                              ));
                              return;
                            }
                            widget.onChanged(widget.value.copyWith(
                              painter: LabelPainter(
                                styleSheet: result,
                              ),
                              element: widget.value.element!.copyWith(
                                styleSheet: result,
                              ),
                            ));
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const PhosphorIcon(
                              PhosphorIconsLight.magnifyingGlass),
                          isSelected: widget.value.painter.zoomDependent,
                          tooltip: AppLocalizations.of(context).zoomDependent,
                          onPressed: () => widget.onChanged(widget.value
                              .copyWith(
                                  painter: widget.value.painter.copyWith(
                                      zoomDependent: !widget
                                          .value.painter.zoomDependent))),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.article),
                          isSelected: widget.value.isParagraph(),
                          onPressed: widget.value.area == null
                              ? null
                              : () => widget.onChanged(widget.value.copyWith(
                                  forceParagraph: !widget.value.isParagraph())),
                        ),
                        const SizedBox(width: 8),
                        widget.value.isParagraph()
                            ? DropdownMenu<String>(
                                key: _paragraphKey,
                                dropdownMenuEntries: paragraphSelections
                                    .map((e) => DropdownMenuEntry<String>(
                                          value: e,
                                          label: e,
                                        ))
                                    .toList(),
                                initialSelection: paragraphSelection,
                                onSelected: (name) {
                                  if (name == null) return;
                                  widget.onChanged(widget.value.copyWith(
                                    forcedProperty:
                                        text.ParagraphProperty.named(name),
                                    element: widget.value.element?.copyWith(
                                      area: widget.value.element!.area.copyWith(
                                        paragraph: widget
                                            .value.element!.area.paragraph
                                            .copyWith(
                                          property:
                                              text.ParagraphProperty.named(
                                                  name),
                                        ),
                                      ),
                                    ),
                                  ));
                                },
                                label: Text(AppLocalizations.of(context).style),
                                trailingIcon: widget.value.modified(document)
                                    ? const PhosphorIcon(
                                        PhosphorIconsLight.star)
                                    : null,
                              )
                            : DropdownMenu<String>(
                                key: _spanKey,
                                dropdownMenuEntries: spanSelections
                                    .map((e) => DropdownMenuEntry<String>(
                                          value: e,
                                          label: e,
                                        ))
                                    .toList(),
                                initialSelection: spanSelection,
                                onSelected: (name) {
                                  if (name == null) return;
                                  widget.onChanged(widget.value.copyWith(
                                    forcedSpanProperty: text.SpanProperty.named(
                                      name,
                                    ),
                                    element: widget.value.element?.copyWith(
                                      area: widget.value.element!.area.copyWith(
                                        paragraph: widget
                                            .value.element!.area.paragraph
                                            .applyStyle(
                                          text.SpanProperty.named(name),
                                          widget.value.selection.start,
                                          widget.value.selection.end -
                                              widget.value.selection.start,
                                        ),
                                      ),
                                    ),
                                  ));
                                },
                                label: Text(AppLocalizations.of(context).style),
                                trailingIcon: widget.value.modified(document)
                                    ? const PhosphorIcon(
                                        PhosphorIconsLight.star)
                                    : null,
                              ),
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const PhosphorIcon(PhosphorIconsLight.eraser),
                          tooltip: AppLocalizations.of(context).clearStyle,
                          isSelected: widget.value.isParagraph()
                              ? widget.value.getProperty().maybeMap(
                                  orElse: () => false, undefined: (_) => true)
                              : widget.value.paragraph
                                  ?.getSpan(widget.value.selection.start)
                                  ?.property
                                  .maybeMap(
                                      orElse: () => false,
                                      undefined: (_) => true),
                          onPressed: () async {
                            if (widget.value.isParagraph()) {
                              widget.onChanged(widget.value.copyWith(
                                forcedProperty: null,
                                element: widget.value.element?.copyWith(
                                  area: widget.value.element!.area.copyWith(
                                    paragraph: widget
                                        .value.element!.area.paragraph
                                        .copyWith(
                                      property: const text
                                          .ParagraphProperty.undefined(),
                                    ),
                                  ),
                                ),
                              ));
                            } else {
                              widget.onChanged(widget.value.copyWith(
                                forcedSpanProperty: null,
                                element: widget.value.element?.copyWith(
                                  area: widget.value.element!.area.copyWith(
                                    paragraph: widget
                                        .value.element!.area.paragraph
                                        .applyStyle(
                                      const text.SpanProperty.undefined(),
                                      widget.value.selection.start,
                                      widget.value.selection.end -
                                          widget.value.selection.start,
                                    ),
                                  ),
                                ),
                              ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
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
                        ToggleButtons(
                          isSelected: text.HorizontalAlignment.values
                              .map((e) => e == paragraph.alignment)
                              .toList(),
                          children: const [
                            PhosphorIcon(PhosphorIconsLight.textAlignLeft),
                            PhosphorIcon(PhosphorIconsLight.textAlignCenter),
                            PhosphorIcon(PhosphorIconsLight.textAlignRight),
                            PhosphorIcon(PhosphorIconsLight.textAlignJustify),
                          ],
                          onPressed: (current) {
                            final newParagraph = paragraph.copyWith(
                              alignment:
                                  text.HorizontalAlignment.values[current],
                            );
                            widget.onChanged(widget.value.copyWith(
                              forcedProperty: newParagraph,
                              element: widget.value.element?.copyWith.area
                                  .paragraph(property: newParagraph),
                            ));
                          },
                        ),
                        const SizedBox(width: 32),
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
                                  size: double.tryParse(current) ?? span.size,
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
                              color: Color(span.getColor(paragraph)),
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
                            final result = await showDialog<int>(
                              context: context,
                              builder: (_) => ColorPickerDialog(
                                defaultColor: Color(span.getColor(paragraph)),
                                bloc: context.read<DocumentBloc>(),
                              ),
                            );
                            if (result == null) return;
                            updateSpan(
                                (value) => value.copyWith(color: result));
                          },
                        ),
                        const SizedBox(width: 16),
                        ToggleButtons(
                          isSelected: [
                            span.getFontWeight(paragraph) !=
                                text.kFontWeightNormal,
                            span.getItalic(paragraph),
                            span.getUnderline(paragraph),
                          ],
                          children: [
                            GestureDetector(
                              child:
                                  const PhosphorIcon(PhosphorIconsLight.textB),
                              onLongPressEnd: (details) {
                                final RenderObject? overlay =
                                    Overlay.of(context)
                                        .context
                                        .findRenderObject();
                                final RenderBox referenceBox =
                                    context.findRenderObject() as RenderBox;
                                var tapPosition = referenceBox
                                    .globalToLocal(details.globalPosition);
                                showMenu(
                                  context: context,
                                  position: RelativeRect.fromRect(
                                      Rect.fromLTWH(tapPosition.dx,
                                          tapPosition.dy, 30, 30),
                                      Rect.fromLTWH(
                                          0,
                                          0,
                                          overlay!.paintBounds.size.width,
                                          overlay.paintBounds.size.height)),
                                  initialValue: FontWeight
                                      .values[span.getFontWeight(paragraph)],
                                  items: List.generate(FontWeight.values.length,
                                      (index) {
                                    var text = ((index + 1) * 100).toString();
                                    if (index == 3) {
                                      text =
                                          AppLocalizations.of(context).normal;
                                    } else if (index == 6) {
                                      text = AppLocalizations.of(context).bold;
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
                                        });
                                  }),
                                );
                              },
                            ),
                            const PhosphorIcon(PhosphorIconsLight.textItalic),
                            const PhosphorIcon(
                                PhosphorIconsLight.textUnderline),
                          ],
                          onPressed: (current) {
                            switch (current) {
                              case 0:
                                updateSpan(
                                  (value) => value.copyWith(
                                    fontWeight: span.fontWeight ==
                                            text.kFontWeightNormal
                                        ? text.kFontWeightBold
                                        : text.kFontWeightNormal,
                                  ),
                                );
                                break;
                              case 1:
                                updateSpan(
                                  (value) => value.copyWith(
                                    italic: !span.getItalic(paragraph),
                                  ),
                                );
                                break;
                              case 2:
                                updateSpan(
                                  (value) => value.copyWith(
                                    underline: !span.getUnderline(paragraph),
                                  ),
                                );
                                break;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
