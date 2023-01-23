import 'package:butterfly/dialogs/color_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../bloc/document_bloc.dart';
import '../../models/text.dart' as text;

class LabelToolbarView extends StatefulWidget {
  final text.TextContext value;
  final ValueChanged<text.TextContext> onChanged;

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
  late text.TextContext _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  void _changeValue(text.TextContext value) {
    setState(() => _value = value);
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoadSuccess) return Container();
    final document = state.document;
    final property = _value.getDefinedProperty(document) ??
        const text.DefinedParagraphProperty();
    final span = property.span;
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
                          icon: const Icon(PhosphorIcons.articleLight),
                          isSelected: _value.isParagraph(),
                          onPressed: _value.area == null
                              ? null
                              : () => _changeValue(_value.copyWith(
                                  forceParagraph: !_value.isParagraph())),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 200,
                          child: DropdownButtonFormField<String>(
                            items: const [
                              DropdownMenuItem(
                                child: Text('Heading 1'),
                              ),
                            ],
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              suffixText: '*',
                              border: const OutlineInputBorder(),
                              labelText: AppLocalizations.of(context).style,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      children: [
                        ToggleButtons(
                          isSelected: text.VerticalAlignment.values
                              .map((e) =>
                                  e == _value.area?.areaProperty.alignment)
                              .toList(),
                          onPressed: _value.area == null ? null : (value) {},
                          children: const [
                            Icon(PhosphorIcons.alignTopLight),
                            Icon(PhosphorIcons.alignCenterVerticalLight),
                            Icon(PhosphorIcons.alignBottomLight),
                          ],
                        ),
                        const SizedBox(width: 16),
                        ToggleButtons(
                          isSelected: text.HorizontalAlignment.values
                              .map((e) => e == property.alignment)
                              .toList(),
                          children: const [
                            Icon(PhosphorIcons.textAlignLeftLight),
                            Icon(PhosphorIcons.textAlignCenterLight),
                            Icon(PhosphorIcons.textAlignRightLight),
                            Icon(PhosphorIcons.textAlignJustifyLight),
                          ],
                          onPressed: (value) {
                            _changeValue(_value.copyWith(
                              forcedProperty: property.copyWith(
                                alignment:
                                    text.HorizontalAlignment.values[value],
                              ),
                            ));
                          },
                        ),
                        const SizedBox(width: 32),
                        SizedBox(
                          width: 200,
                          child: DropdownButtonFormField<String>(
                            items: const [
                              DropdownMenuItem(
                                child: Text('Roboto'),
                              ),
                            ],
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText:
                                  AppLocalizations.of(context).fontFamily,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
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
                            initialValue: span.size.toString(),
                            onChanged: (value) => _changeValue(
                              _value.copyWith(
                                forcedProperty: property.copyWith(
                                  span: span.copyWith(
                                    size: double.tryParse(value) ?? span.size,
                                  ),
                                ),
                              ),
                            ),
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
                              color: Color(span.color),
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
                              builder: (_) => BlocProvider.value(
                                value: context.read<DocumentBloc>(),
                                child: ColorPickerDialog(
                                  defaultColor: Color(span.color),
                                ),
                              ),
                            );
                            if (result == null) return;
                            _changeValue(_value.copyWith(
                              forcedProperty: property.copyWith(
                                span: span.copyWith(
                                  color: result,
                                ),
                              ),
                            ));
                          },
                        ),
                        const SizedBox(width: 16),
                        ToggleButtons(
                          isSelected: [
                            span.fontWeight != text.kFontWeightNormal,
                            span.italic,
                            span.underline,
                          ],
                          children: [
                            GestureDetector(
                              child: const Icon(PhosphorIcons.textBolderLight),
                              onLongPressEnd: (details) {
                                final RenderObject? overlay =
                                    Overlay.of(context)
                                        ?.context
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
                                  initialValue:
                                      FontWeight.values[span.fontWeight],
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
                                          _changeValue(_value.copyWith(
                                            forcedProperty: property.copyWith(
                                              span: span.copyWith(
                                                fontWeight: index,
                                              ),
                                            ),
                                          ));
                                        });
                                  }),
                                );
                              },
                            ),
                            const Icon(PhosphorIcons.textItalicLight),
                            const Icon(PhosphorIcons.textUnderlineLight),
                          ],
                          onPressed: (value) {
                            var next = _value;
                            switch (value) {
                              case 0:
                                next = next.copyWith(
                                  forcedProperty: property.copyWith(
                                    span: span.copyWith(
                                      fontWeight: span.fontWeight ==
                                              text.kFontWeightNormal
                                          ? text.kFontWeightBold
                                          : text.kFontWeightNormal,
                                    ),
                                  ),
                                );
                                break;
                              case 1:
                                next = next.copyWith(
                                  forcedProperty: property.copyWith(
                                    span: span.copyWith(
                                      italic: !span.italic,
                                    ),
                                  ),
                                );
                                break;
                              case 2:
                                next = next.copyWith(
                                  forcedProperty: property.copyWith(
                                    span: span.copyWith(
                                      underline: !span.underline,
                                    ),
                                  ),
                                );
                                break;
                            }

                            _changeValue(next);
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
