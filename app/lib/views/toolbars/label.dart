import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LabelToolbarView extends StatefulWidget {
  const LabelToolbarView({super.key});

  @override
  State<LabelToolbarView> createState() => _LabelToolbarViewState();
}

class _LabelToolbarViewState extends State<LabelToolbarView> {
  final ScrollController _scrollController = ScrollController();
  bool _paragraphMode = false;

  @override
  Widget build(BuildContext context) {
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
                          isSelected: _paragraphMode,
                          onPressed: () =>
                              setState(() => _paragraphMode = !_paragraphMode),
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
                            ),
                            textAlign: TextAlign.center,
                            initialValue: '12px',
                          ),
                        ),
                        const SizedBox(width: 16),
                        ToggleButtons(
                          isSelected: const [true, false, false],
                          children: [
                            GestureDetector(
                              child: const Icon(PhosphorIcons.textBolderLight),
                              onLongPress: () {},
                            ),
                            const Icon(PhosphorIcons.textItalicLight),
                            const Icon(PhosphorIcons.textUnderlineLight),
                          ],
                          onPressed: (value) {},
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
