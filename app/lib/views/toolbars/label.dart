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
  late text.TextContext? _value;

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
    final property = _value?.getDefinedProperty(document) ??
        const text.DefinedSpanProperty();
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
                          isSelected: _value?.isParagraph() ?? true,
                          onPressed: _value == null
                              ? null
                              : () => _changeValue(_value!.copyWith(
                                  forceParagraph: !_value!.isParagraph())),
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
                            onChanged: _value == null ? null : (value) {},
                            decoration: const InputDecoration(suffixText: '*'),
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
                          isSelected: const [true, false, false],
                          children: const [
                            Icon(PhosphorIcons.alignTopLight),
                            Icon(PhosphorIcons.alignCenterVerticalLight),
                            Icon(PhosphorIcons.alignBottomLight),
                          ],
                          onPressed: (value) {},
                        ),
                        const SizedBox(width: 16),
                        ToggleButtons(
                          isSelected: const [
                            true,
                            false,
                            false,
                            false,
                          ],
                          children: const [
                            Icon(PhosphorIcons.textAlignLeftLight),
                            Icon(PhosphorIcons.textAlignCenterLight),
                            Icon(PhosphorIcons.textAlignRightLight),
                            Icon(PhosphorIcons.textAlignJustifyLight),
                          ],
                          onPressed: (value) {},
                        ),
                        const SizedBox(width: 32),
                        SizedBox(
                          width: 200,
                          child: DropdownButtonFormField<String>(items: const [
                            DropdownMenuItem(
                              child: Text('Roboto'),
                            ),
                          ], onChanged: (value) {}),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).size,
                              filled: true,
                            ),
                            textAlign: TextAlign.center,
                            initialValue: property.size.toString(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ToggleButtons(
                          isSelected: [
                            property.fontWeight != text.kFontWeightNormal,
                            property.italic,
                            property.underline,
                          ],
                          children: [
                            GestureDetector(
                              child: const Icon(PhosphorIcons.textBolderLight),
                              onLongPressEnd: (details) {
                                showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(
                                    details.globalPosition.dx,
                                    details.globalPosition.dy,
                                    details.globalPosition.dx,
                                    details.globalPosition.dy,
                                  ),
                                  initialValue:
                                      FontWeight.values[property.fontWeight],
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
                                    );
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
                                next = next?.copyWith(
                                  forcedProperty: property.copyWith(
                                    fontWeight: property.fontWeight ==
                                            text.kFontWeightNormal
                                        ? text.kFontWeightBold
                                        : text.kFontWeightNormal,
                                  ),
                                );
                                break;
                              case 1:
                                next = next?.copyWith(
                                  forcedProperty: property.copyWith(
                                    italic: !property.italic,
                                  ),
                                );
                                break;
                            }

                            if (next != null) {
                              _changeValue(next);
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
